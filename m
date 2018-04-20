Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACE61F42D
	for <e@80x24.org>; Fri, 20 Apr 2018 13:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755105AbeDTNxg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 09:53:36 -0400
Received: from prvmx02.microfocus.com ([130.57.1.217]:13574 "EHLO
        prvmx02.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754961AbeDTNxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 09:53:30 -0400
Received: from prvxcaht04.microfocus.com (Not Verified[137.65.248.138]) by prvmx02.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5ad9f0df0006>; Fri, 20 Apr 2018 07:53:35 -0600
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (137.65.224.21)
 by mail.microfocus.com (137.65.248.138) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Fri, 20 Apr 2018 07:53:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-microfocus-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1pWvhwAYL+93FY+MZBjrZBR0si7vNR9ducod2AxSGAU=;
 b=Li/BXw0nMj145wUdFeuuYgtAIsq+ApYADuGXQn8Rc75jLxlZvuh1vSGbjma+4jRnwxWH74G7kbF0BUYp9Yc36sTSYkjnUiM5QYDsUcp0eLdfXSHJgyFFNvCO0i9mEO3DuDIKnz70NIOaE6M6Tajc66S2Ie18G6R2Lt/6HaBJwzk=
Received: from MW2PR18MB2284.namprd18.prod.outlook.com (52.132.183.149) by
 MW2PR18MB2153.namprd18.prod.outlook.com (52.132.183.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.15; Fri, 20 Apr 2018 13:53:27 +0000
Received: from MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::1953:6149:ff4d:80b3]) by MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::1953:6149:ff4d:80b3%13]) with mapi id 15.20.0675.015; Fri, 20 Apr
 2018 13:53:27 +0000
From:   Isaac Chou <Isaac.Chou@microfocus.com>
To:     =?utf-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG] Git fast-export with import marks file omits merge commits
Thread-Topic: [BUG] Git fast-export with import marks file omits merge commits
Thread-Index: AdPYJIvNooDcI9D2T/S5TrqX2cAY8AAC/QhAAA1C7YAAEh9LQA==
Date:   Fri, 20 Apr 2018 13:53:27 +0000
Message-ID: <MW2PR18MB228432C95C18DE786957DE70E5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
References: <MW2PR18MB2284E3091991A3DB228CEBBEE5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
 <xmqq604mertl.fsf@gitster-ct.c.googlers.com>
 <CAN0heSo9bdvNNzwX5-7nHXxg9_oZrsDixzwQmx6gnEtwny2NOA@mail.gmail.com>
In-Reply-To: <CAN0heSo9bdvNNzwX5-7nHXxg9_oZrsDixzwQmx6gnEtwny2NOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Isaac.Chou@microfocus.com; 
x-originating-ip: [74.122.108.54]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR18MB2153;7:ib7srBXsj1rIjtJJ+GR9Ux+tA2axjNmkziX2g2KVS05PquuqquXEN9kw/zC77pp5Q/Z7VEFNwtg66ov29J/TuCAjm5unJN64dIpMUyLBKILUSB/c9GEPU/4lbuksERASxn8KAWB3QG7tPTlxeSRd1bEC+Mjj+QAfQQ2NJjvr2bh4HWGZt8mn+CaVTGIS33N3SBfyHIXBTUKDSuEEZy5SIVXGrA/7EmRfOYCiQ7e8qbOTaTTHgkZDNT2eCWkwAqhy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR18MB2153;
x-ms-traffictypediagnostic: MW2PR18MB2153:
x-microsoft-antispam-prvs: <MW2PR18MB21531504265D5B8B494D0FF7E5B40@MW2PR18MB2153.namprd18.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(9452136761055)(85827821059158)(211936372134217)(153496737603132)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501394)(52105095)(93006095)(93001095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR18MB2153;BCL:0;PCL:0;RULEID:;SRVR:MW2PR18MB2153;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39380400002)(376002)(39860400002)(377424004)(13464003)(6116002)(3846002)(9686003)(55016002)(72206003)(66066001)(478600001)(53546011)(186003)(6506007)(5250100002)(3280700002)(53936002)(102836004)(74316002)(305945005)(4326008)(5660300001)(39060400002)(26005)(33656002)(8666007)(14454004)(6246003)(3660700001)(81166006)(476003)(316002)(2900100001)(8676002)(229853002)(446003)(11346002)(76176011)(86362001)(575784001)(99286004)(25786009)(2906002)(8656006)(8936002)(59450400001)(54906003)(7736002)(6436002)(110136005)(7696005)(14547495005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR18MB2153;H:MW2PR18MB2284.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microfocus.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p2HaOi+6p5ypqprOKJKctXEHd3QYjrReCmcEOk56qGifxcQiGbXzYYW0uXuLtRYnoPOO/9TyKb73O8tYTjW4XZ3qAqEG3XQ+ZcSQLvkNtw8U+3j4+OZ+76A/5AmjXDhqIm2PVX+6gxoWOoWoVpA2fnXy//5MMX61fHGhB+ZSS/oM3BJPbzQ3G8ajqyPCRTxl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 011e2fc2-0a1c-45d6-08fe-08d5a6c617b9
X-MS-Exchange-CrossTenant-Network-Message-Id: 011e2fc2-0a1c-45d6-08fe-08d5a6c617b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 13:53:27.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR18MB2153
X-OriginatorOrg: microfocus.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgTWFydGluLA0KDQpObyBwcm9ibGVtLiAgSSB3YXMgdGhpbmtpbmcgb2YgdGhlIHBlZWsvcG9w
IHBhdHRlcm4gYXMgd2VsbC4gIDopICBJZiB5b3UgZG9uJ3QgbWluZCwgY2FuIHlvdSBwbGVhc2Ug
Z28gYWhlYWQgYW5kIHN1Ym1pdCBhIHBhdGNoIGZvciB0aGlzPyAgVGhhbmtzIHNvIG11Y2guDQoN
CklzYWFjDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJ0aW4gw4VncmVu
IFttYWlsdG86bWFydGluLmFncmVuQGdtYWlsLmNvbV0gDQpTZW50OiBGcmlkYXksIEFwcmlsIDIw
LCAyMDE4IDE6MDggQU0NClRvOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+DQpD
YzogSXNhYWMgQ2hvdSA8SXNhYWMuQ2hvdUBtaWNyb2ZvY3VzLmNvbT47IEpvaGFubmVzIFNjaGlu
ZGVsaW4gPGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlPjsgSm9uYXRoYW4gVGFuIDxqb25hdGhh
bnRhbm15QGdvb2dsZS5jb20+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW0JV
R10gR2l0IGZhc3QtZXhwb3J0IHdpdGggaW1wb3J0IG1hcmtzIGZpbGUgb21pdHMgbWVyZ2UgY29t
bWl0cw0KDQpPbiAyMCBBcHJpbCAyMDE4IGF0IDAwOjQ4LCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiBJc2FhYyBDaG91IDxJc2FhYy5DaG91QG1pY3JvZm9jdXMu
Y29tPiB3cml0ZXM6DQo+DQo+PiBJIGluc3BlY3RlZCB0aGUgc291cmNlIGNvZGUgKGJ1aWx0aW4v
ZmFzdC1leHBvcnQuYykgZm9yIHRoZSANCj4+IGZhc3QtZXhwb3J0IGlzc3VlIEkgZW5jb3VudGVy
ZWQsIGFuZCBpdCBsb29rcyBsaWtlIHRoZSBtZXJnZSBjb21taXQgDQo+PiBpcyBkaXNjYXJkZWQg
dG9vIGVhcmx5IGJ5IHRoZSBjYWxsIHRvIG9iamVjdF9hcnJheV9wb3AoKSBhZnRlciBvbmx5IA0K
Pj4gb25lIG9mIHRoZSB0d28gVU5TSE9XTiBwYXJlbnRzIGlzIHByb2Nlc3NlZCBpbiB0aGUgbWV0
aG9kIA0KPj4gaGFuZGxlX3RhaWwoKS4gIFRoZSBwb3BlZCBtZXJnZSBjb21taXQgc3RpbGwgaGFz
IG9uZSBVTlNIT1dOIHBhcmVudCwgDQo+PiB0aGVyZWZvcmUgaXQgaXMgbm90IHByb2Nlc3NlZCBh
bmQgaXMgbG9zdCBpbiB0aGUgb3V0cHV0LiAgQ2FuIHNvbWVvbmUgDQo+PiBhZHZpc2UgbWUgb24g
aG93IHRvIHN1Ym1pdCBhIGNvZGUgY2hhbmdlIG9yIGJ1ZyByZXBvcnQgaW4gb3JkZXIgdG8gDQo+
PiBnZXQgdGhlIGZpeCBpbnRvIHRoZSBjb2RlIGJhc2U/DQo+DQo+IFRoZXJlIGluZGVlZCBhcmUg
c29tZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHYyLjE0IGFuZCB2Mi4xNSBhcm91bmQgdGhlIA0KPiBj
b2RlIHRoYXQgcmV0dXJucyBlYXJseSB3aGVuIGhhc191bnNob3duX3BhcmVudCgpIHNheXMgInll
cyIgWyoxKl0sIA0KPiBidXQgdGhlIGRlY2lzaW9uIHRvIHJldHVybiBlYXJseSB3aGVuIHRoZSBm
dW5jdGlvbiBzYXlzICJ5ZXMiIGhhc24ndCANCj4gY2hhbmdlZCBiZXR3ZWVuIHRoYXQgdGltZXBl
cmlvZC0tLWl0IGRhdGVzIGJhY2sgdG8gZjJkYzg0OWUgKCJBZGQgJ2dpdCANCj4gZmFzdC1leHBv
cnQnLCB0aGUgc2lzdGVyIG9mICdnaXQgZmFzdC1pbXBvcnQnIiwgMjAwNy0xMi0wMiksIGkuZS4g
dGhlIA0KPiB2ZXJ5IGJlZ2lubmluZyBvZiB0aGUgcHJvZ3JhbSdzIGxpZmUuDQo+DQo+IEknbGwg
Q0MgdGhvc2Ugd2hvIHdyb3RlIHRoZSBvcmlnaW5hbCBhbmQgYjNlOGNhODkgKCJmYXN0LWV4cG9y
dDogZG8gDQo+IG5vdCBjb3B5IGZyb20gbW9kaWZpZWQgZmlsZSIsIDIwMTctMDktMjApIGFuZCA3
MTk5MjAzOQ0KPiAoIm9iamVjdF9hcnJheTogYWRkIGFuZCB1c2UgYG9iamVjdF9hcnJheV9wb3Ao
KWAiLCAyMDE3LTA5LTIzKSwgd2hpY2ggDQo+IGFyZSB0aGUgb25seSB0d28gY29tbWl0cyB0aGF0
IHRvdWNoIHRoZSBzdXJyb3VuZGluZyBhcmVhIGR1cmluZyB0aGF0IA0KPiB0aW1lcGVyaW9kLCB0
byBhc2sgaWYgc29tZXRoaW5nIGp1bXBzIGF0IHRoZW0uDQo+DQo+IFRoYW5rcy4NCj4NCj4NCj4g
W0Zvb3Rub3Rlc10NCj4NCj4gKjEqIEFuIGV4Y2VycHQgZnJvbSAnZ2l0IGRpZmYgdjIuMTQuMCB2
Mi4xNS4wIGJ1aWx0aW4vZmFzdC1leHBvcnQuYycNCj4gICAgIHJlYWRzIGxpa2Ugc286DQo+DQo+
IGRpZmYgLS1naXQgYS9idWlsdGluL2Zhc3QtZXhwb3J0LmMgYi9idWlsdGluL2Zhc3QtZXhwb3J0
LmMgaW5kZXggDQo+IGQ0MTJjMGE4ZjMuLjJmYjYwZDZkNDggMTAwNjQ0DQo+IC0tLSBhL2J1aWx0
aW4vZmFzdC1leHBvcnQuYw0KPiArKysgYi9idWlsdGluL2Zhc3QtZXhwb3J0LmMNCj4gLi4uDQo+
IEBAIC02MzAsMTUgKzY0NSwxNSBAQCBzdGF0aWMgdm9pZCAqYW5vbnltaXplX3RhZyhjb25zdCB2
b2lkICpvbGQsIHNpemVfdCAqbGVuKQ0KPiAgICAgICAgIHJldHVybiBzdHJidWZfZGV0YWNoKCZv
dXQsIGxlbik7ICB9DQo+DQo+IC1zdGF0aWMgdm9pZCBoYW5kbGVfdGFpbChzdHJ1Y3Qgb2JqZWN0
X2FycmF5ICpjb21taXRzLCBzdHJ1Y3QgcmV2X2luZm8gDQo+ICpyZXZzKQ0KPiArc3RhdGljIHZv
aWQgaGFuZGxlX3RhaWwoc3RydWN0IG9iamVjdF9hcnJheSAqY29tbWl0cywgc3RydWN0IHJldl9p
bmZvICpyZXZzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc3RyaW5nX2xpc3Qg
KnBhdGhzX29mX2NoYW5nZWRfb2JqZWN0cykNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgY29tbWl0
ICpjb21taXQ7DQo+ICAgICAgICAgd2hpbGUgKGNvbW1pdHMtPm5yKSB7DQo+IC0gICAgICAgICAg
ICAgICBjb21taXQgPSAoc3RydWN0IGNvbW1pdCAqKWNvbW1pdHMtPm9iamVjdHNbY29tbWl0cy0+
bnIgLSAxXS5pdGVtOw0KPiArICAgICAgICAgICAgICAgY29tbWl0ID0gKHN0cnVjdCBjb21taXQg
KilvYmplY3RfYXJyYXlfcG9wKGNvbW1pdHMpOw0KPiAgICAgICAgICAgICAgICAgaWYgKGhhc191
bnNob3duX3BhcmVudChjb21taXQpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47
DQo+IC0gICAgICAgICAgICAgICBoYW5kbGVfY29tbWl0KGNvbW1pdCwgcmV2cyk7DQo+IC0gICAg
ICAgICAgICAgICBjb21taXRzLT5uci0tOw0KPiArICAgICAgICAgICAgICAgaGFuZGxlX2NvbW1p
dChjb21taXQsIHJldnMsIHBhdGhzX29mX2NoYW5nZWRfb2JqZWN0cyk7DQo+ICAgICAgICAgfQ0K
PiAgfQ0KDQpJbmRlZWQuIFRoaXMgbG9va3Mgd3JvbmcgYW5kIHRoZSBndWlsdHkgcGVyc29uIHdv
dWxkIGJlIG1lLg0KDQpJZiBteSA3MTk5MjAzOSAoIm9iamVjdF9hcnJheTogYWRkIGFuZCB1c2Ug
YG9iamVjdF9hcnJheV9wb3AoKWAiLA0KMjAxNy0wOS0yMykgd291bGQgaW5zdGVhZCBoYXZlIGRv
bmUgc29tZXRoaW5nIGxpa2Ugcy9jb21taXRzLT5uci0tLyh2b2lkKW9iamVjdF9hcnJheV9wb3Ao
Y29tbWl0cykvIGl0IHdvdWxkIG5vdCBoYXZlIHNjcmV3ZWQgdXAgYXMgbXVjaC4gSXQgY291bGQg
YWxzbyB1c2UgYSBwZWVrK3BvcC1wYXR0ZXJuLg0KDQpJc2FhYywgYXJlIHlvdSB1cCBmb3Igc3Vi
bWl0dGluZyBhIHBhdGNoPyBKdXN0IGxldCBtZSBrbm93IGlmIHlvdSBlbmNvdW50ZXIgYW55IGlz
c3Vlcy4gT3RoZXJ3aXNlLCBJIGNhbiBzdWJtaXQgYSBwYXRjaCBzaG9ydGx5IHNpbmNlIEkgd2Fz
IHRoZSBvbmUgd2hvIGRyb3BwZWQgdGhlIGJhbGwgb3JpZ2luYWxseS4NCg0KVGhhbmtzIGZvciBk
aWFnbm9zaW5nIHRoaXMuDQoNCk1hcnRpbg0K
