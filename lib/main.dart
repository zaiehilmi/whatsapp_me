import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Link',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: WhatsAppLink(),
    );
  }
}

// ignore: must_be_immutable
class WhatsAppLink extends StatelessWidget {
  final TextEditingController _kodNegara = TextEditingController(text: '60');
  final TextEditingController _noTelefon = TextEditingController(text: '');
  final TextEditingController _mesej = TextEditingController(text: '');

  WhatsAppLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                'WA.ME',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
//? box tengah
              Center(
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: CupertinoColors.systemGrey4,
                  ),
//* dalam box tengah
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <SizedBox>[
                            SizedBox(
                              width: 70,
                              height: 45,
                              child: CupertinoTextField(
                                padding: const EdgeInsets.all(13),
                                keyboardType: TextInputType.phone,
                                controller: _kodNegara,
                              ),
                            ),
                            // const Spacer(),
                            SizedBox(
                              width: 210,
                              height: 45,
                              child: CupertinoTextField(
                                padding: const EdgeInsets.all(13),
                                controller: _noTelefon,
                                keyboardType: TextInputType.phone,
                                placeholder: 'No Telefon',
                                placeholderStyle: const TextStyle(
                                  color: CupertinoColors.systemPink,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: CupertinoTextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _mesej,
                            placeholder: 'mesej',
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <CupertinoButton>[
                            CupertinoButton(
                              color: CupertinoColors.systemFill,
                              minSize: 10,
                              padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                              child: const Text(
                                'Pautan',
                                style: TextStyle(
                                  color: CupertinoColors.activeBlue,
                                ),
                              ),
                              onPressed: () {
                                String temp = '${_kodNegara.text}${_noTelefon.text}';
                                final _url = 'https://wa.me/$temp?text=${_mesej.text}';
                                Clipboard.setData(ClipboardData(text: _url));
                              },
                            ),
                            CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              minSize: 10,
                              padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                              child: const Text('Hantar'),
                              onPressed: () async {
                                String temp = '${_kodNegara.text}${_noTelefon.text}';
                                final _url = 'https://wa.me/$temp?text=${_mesej.text}';

                                await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                              },
                            ),
                          ],
                        ),
                        // const Spacer(),
                        // CupertinoButton(
                        //     color: CupertinoColors.activeOrange,
                        //     minSize: 10,
                        //     padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                        //     child: const Text('Test://'),
                        //     onPressed: () async {
                        //       String temp = '${_kodNegara.text}${_noTelefon.text}';
                        //       final _url = "whatsapp://send?phone=$temp&text=${_mesej.text}";

                        //       await canLaunch(_url) ? await launch(_url) : throw 'Tiada WhatsApp';
                        //     })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
