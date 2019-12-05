Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B21C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CCE24648
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ksysllc.onmicrosoft.com header.i=@ksysllc.onmicrosoft.com header.b="kghFEs3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfLEPDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:03:00 -0500
Received: from mail-eopbgr1300041.outbound.protection.outlook.com ([40.107.130.41]:10560
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729099AbfLEPDA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 10:03:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf8UZVWQvncnXYnCK3yhP3exRuhNcKQGfgdgOUY3CuF94+l2Xyp8UVlp5wV+z25uYSj6JxSeuV6qg7j/j0wgc9wRyMt8IT+O05SaWEk/6Pvy5HuFYK2zt6rPN8Mm/kLAYjtB1A2c7fuP1sPTahjxkfl2C6dLHFI/MTKqZsCK6vmsMH8JsTgQPRH2VunM61zEIP/Y/bNK9RW5ET8qy2mV+OjfGwf3BNMG+UCbCz4KWAMRfduU5eq3dPzfmAHpQFDIWx3+lBzf2p1GNodXUiLY23MYXhzhShomW41Ia/ElTkAv0JtE5QM/WzGfjQYDeR8e1oq+6j9t5iZqdqC8uuVK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDd6stELXWOzSsY4alAQH+pUpYv9YJhwzEYBwMmT9VE=;
 b=AMqUuh5aeu0gVDICaNaW4AbDja9fdPwiDf/cZOrUK0+Mb/MNxjWLG5c55zGWIX7vs2JtCVnpOk9bH83M03AHzhJ2wDupKgP8zKjzps1khWGkBErMeX7GQKyDzu4add89mCHJIL2Sw0j/mi0z1PNX6Is44ATG6zmyyPkjoxDP9ll3sP/3s4feTKlnyUnnspjxXNqScR/0wEqSjBk4O0HgnwUlaCKds8oL8IJviYxQ2QptPC9S4p+XUfU1B2Tl69LrzocRUoHasPL3AN89IHPW+7Iu3/+9z5SCpBp+M72GDz4mfOoz+CyXkqni22+VCoodQKtMXEmnCCxZ9C0Or6b7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ksysllc.co.jp; dmarc=pass action=none
 header.from=ksysllc.co.jp; dkim=pass header.d=ksysllc.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ksysllc.onmicrosoft.com; s=selector2-ksysllc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDd6stELXWOzSsY4alAQH+pUpYv9YJhwzEYBwMmT9VE=;
 b=kghFEs3kmnUnBtWGTHQINvMD1ehoE5X8NppjHyLxYxR8GUklt7Cvq9SXXw6gBmg2M7dsUHmklBOzh+MgrXtV0Cf+Ncxsr24OCwJ9GpzBVqi9eDPEux6j78QMSAlrfmHdpT8QL/ieCntc7QvA661L1sn7qa1Ev1ji/hiViCq2+n0=
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com (20.177.100.73) by
 TY2PR01MB4890.jpnprd01.prod.outlook.com (20.179.171.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 5 Dec 2019 15:02:15 +0000
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f]) by TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:02:15 +0000
From:   =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] gitk branch name encoding utf-8 probrem
Thread-Topic: [PATCH] gitk branch name encoding utf-8 probrem
Thread-Index: AdWq0cuhgH7WTTbHQwq0du7Qsjt4IQAIHpWAACI8mhA=
Date:   Thu, 5 Dec 2019 15:02:15 +0000
Message-ID: <TY2PR01MB2427631CC07116A662AF3D38CA5C0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
References: <TY2PR01MB24271C32E2FD9FD8C27CA8C2CA5D0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
 <20191204222921.GB195537@google.com>
In-Reply-To: <20191204222921.GB195537@google.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kato-k@ksysllc.co.jp; 
x-originating-ip: [123.223.66.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aa1a0ab-8b39-4163-169d-08d779941d81
x-ms-traffictypediagnostic: TY2PR01MB4890:
x-microsoft-antispam-prvs: <TY2PR01MB48906D7D7586C5D80A235027CA5C0@TY2PR01MB4890.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39830400003)(346002)(366004)(136003)(396003)(13464003)(189003)(199004)(71190400001)(186003)(508600001)(71200400001)(7696005)(8936002)(966005)(14454004)(76116006)(66556008)(33656002)(26005)(5660300002)(53546011)(6506007)(64756008)(66946007)(14444005)(66446008)(99286004)(52536014)(9686003)(102836004)(66476007)(81156014)(74316002)(85182001)(76176011)(11346002)(1730700003)(55016002)(5640700003)(2906002)(305945005)(81166006)(86362001)(8676002)(6916009)(25786009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB4890;H:TY2PR01MB2427.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ksysllc.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMFBmahMVOmVXNK2qhuc4dMflem1BeWALfbKNg/RHMwEi6UO3sq4wb/gqk2ZSe332yHBP5CNodsqrf/10FfIjZE+OhAM7fCUOX5gh6pA6rW7JTVHxG6DODi4wkes8EMO3dgGWUK1mO8O/m78vcBHENWsjjhb3JoIna58Z+gknQ7O3HabDGbqYVy8/vuibj/xQ9nVfZk/4jro/629RpkXt+uxE3A+hVm58BeN1vuI+Ld7T0WDrB01j0KtRty9edci8RMXNmut/JEOi3qTSr99ELNRKXOtgSNxSu3bwCgicqxEQUf4Q75YhoM5xeXq+OaEmVH8D5NvwppLLU8ZDd6Y1Wxu+4t6TLnDvSWE6wmBCmEtyB4YBxILkoCMprCdD9fo3HXk04KiMAfg9qkrX0yEMWl0F2/+BV0Zgf0ujxg7dvNQudzgowfnd9cEZmWng6cHyLQ3web2aiajKuPNklrijloSsWYwQKHjaDXoJuU7dn2sMoICqm3+idcblU/eKAFyfTNhFgoCiYBiHi9HQlmCQxmL/jS4hlFWs0sbvDY+Uqs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ksysllc.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa1a0ab-8b39-4163-169d-08d779941d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:02:15.2305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e2e801e1-1bfd-4c29-8e88-a6b5a79038d8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJu2XA/1mv5k7oezyWSBBwlFujs5ADXfWNHCxswxD6DkfPTnb5Jue/Zs3/XXzgKz0tVB1ErtZPTu7zmK5wInSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4890
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpmaXggYnJhbmNoIG5hbWUgZW5jb2RpbmcgZXJyb3Igb24gZ2l0ay4NCg0KZ2l0IGNoZWNrb3V0
IC1iICfmvKLlrZcnDQpnaXRrIHNob3cgYnJhbmNoIG5hbWUgYnJva2VuIGxpa2UgdGhpcyAn6LKN
772i6J+EJw0KZml4IHRoaXMgcHJvYmxlbS4NCg0KU2lnbmVkLW9mZi1ieTogS2F6dWhpcm8gS2F0
byA8a2F0by1rQGtzeXNsbGMuY28uanA+DQotLS0NCiBnaXRrIHwgNCArKysrDQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZ2l0ayBiL2dpdGsNCmluZGV4
IGFiZTQ4MDUuLjNmNjFhNWIgMTAwNzU1DQotLS0gYS9naXRrDQorKysgYi9naXRrDQpAQCAtMTc4
MCwxMSArMTc4MCwxNSBAQCBwcm9jIHJlYWRyZWZzIHt9IHsNCiAgICAgZ2xvYmFsIG90aGVycmVm
aWRzIGlkb3RoZXJyZWZzIG1haW5oZWFkIG1haW5oZWFkaWQNCiAgICAgZ2xvYmFsIHNlbGVjdGhl
YWQgc2VsZWN0aGVhZGlkDQogICAgIGdsb2JhbCBoaWRlcmVtb3Rlcw0KKyAgICBnbG9iYWwgdGNs
ZW5jb2RpbmcNCiANCiAgICAgZm9yZWFjaCB2IHt0YWdpZHMgaWR0YWdzIGhlYWRpZHMgaWRoZWFk
cyBvdGhlcnJlZmlkcyBpZG90aGVycmVmc30gew0KIAl1bnNldCAtbm9jb21wbGFpbiAkdg0KICAg
ICB9DQogICAgIHNldCByZWZkIFtvcGVuIFtsaXN0IHwgZ2l0IHNob3ctcmVmIC1kXSByXQ0KKyAg
ICBpZiB7JHRjbGVuY29kaW5nICE9IHt9fSB7DQorCWZjb25maWd1cmUgJHJlZmQgLWVuY29kaW5n
ICR0Y2xlbmNvZGluZw0KKyAgICB9DQogICAgIHdoaWxlIHtbZ2V0cyAkcmVmZCBsaW5lXSA+PSAw
fSB7DQogCWlmIHtbc3RyaW5nIGluZGV4ICRsaW5lIDQwXSBuZSAiICJ9IGNvbnRpbnVlDQogCXNl
dCBpZCBbc3RyaW5nIHJhbmdlICRsaW5lIDAgMzldDQotLQ0KDQpTZWUgdGhpcyBwdWxsIHJlcXVl
c3QNCmh0dHBzOi8vZ2l0aHViLmNvbS9ra2F0bzIzMy9naXRrL3B1bGwvNA0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSm9uYXRoYW4gTmllZGVyIDxqcm5pZWRlckBnbWFpbC5j
b20+IA0KU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDUsIDIwMTkgNzoyOSBBTQ0KVG86IOWKoOiX
pOS4gOWNmiA8a2F0by1rQGtzeXNsbGMuY28uanA+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZzsg
UGF1bCBNYWNrZXJyYXMgPHBhdWx1c0BvemxhYnMub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
Z2l0ayBicmFuY2ggbmFtZSBlbmNvZGluZyB1dGYtOCBwcm9icmVtDQoNCihjYy1pbmcgUGF1bCwg
Z2l0ayBleHBlcnQpDQpIaSENCg0K5Yqg6Jek5LiA5Y2aIHdyb3RlOg0KDQo+IEhlcmUgaXMgYSBw
YXRjaCB0byBnaXRrIGJyYW5jaCBuYW1lIHV0Zi04IHByb2JyZW0uDQoNClRoYW5rcyBmb3IgcmVw
b3J0aW5nIGl0LiAgQ2FuIHlvdSBwcm92aWRlIGEgc2hvcnQgc3VtbWFyeSBoZXJlIG9mDQp0aGUg
cHJvYmxlbSB0aGF0IHdlIGNhbiB1c2UgZm9yIGEgc2VsZi1jb250YWluZWQgZGVzY3JpcHRpb24g
aW4gdGhlDQpjb21taXQgbG9nPyAgU2VlDQpodHRwczovL3d3dy5rZXJuZWwub3JnL3B1Yi9zb2Z0
d2FyZS9zY20vZ2l0L2RvY3MvU3VibWl0dGluZ1BhdGNoZXMuaHRtbCNkZXNjcmliZS1jaGFuZ2Vz
DQpmb3IgbW9yZSBvbiB0aGlzIHN1YmplY3QuDQoNCk1heSB3ZSBhbHNvIGhhdmUgeW91ciBzaWdu
LW9mZj8gIFNlZQ0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9wdWIvc29mdHdhcmUvc2NtL2dpdC9k
b2NzL1N1Ym1pdHRpbmdQYXRjaGVzLmh0bWwjc2lnbi1vZmYNCmZvciB3aGF0IHRoaXMgbWVhbnMu
DQoNClRoYW5rcyBhbmQgaG9wZSB0aGF0IGhlbHBzLA0KSm9uYXRoYW4NCg0KPiBTZWUgaXNzdWUN
Cj4gaHR0cHM6Ly9naXRodWIuY29tL2trYXRvMjMzL2dpdGsvaXNzdWVzLzENCj4gYW5kIGZpeCBp
dCANCj4gaHR0cHM6Ly9naXRodWIuY29tL2trYXRvMjMzL2dpdGsvcHVsbC8yDQo+IA0KPiANCj4g
LS0tDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZ2l0ayBiL2dpdGsNCj4gaW5kZXggYWJlNDgwNS4uM2Y2
MWE1YiAxMDA3NTUNCj4gLS0tIGEvZ2l0aw0KPiArKysgYi9naXRrDQo+IEBAIC0xNzgwLDExICsx
NzgwLDE1IEBAIHByb2MgcmVhZHJlZnMge30gew0KPiAgICAgIGdsb2JhbCBvdGhlcnJlZmlkcyBp
ZG90aGVycmVmcyBtYWluaGVhZCBtYWluaGVhZGlkDQo+ICAgICAgZ2xvYmFsIHNlbGVjdGhlYWQg
c2VsZWN0aGVhZGlkDQo+ICAgICAgZ2xvYmFsIGhpZGVyZW1vdGVzDQo+ICsgICAgZ2xvYmFsIHRj
bGVuY29kaW5nDQo+IA0KPiAgICAgIGZvcmVhY2ggdiB7dGFnaWRzIGlkdGFncyBoZWFkaWRzIGlk
aGVhZHMgb3RoZXJyZWZpZHMgaWRvdGhlcnJlZnN9IHsNCj4gICAgICAgICB1bnNldCAtbm9jb21w
bGFpbiAkdg0KPiAgICAgIH0NCj4gICAgICBzZXQgcmVmZCBbb3BlbiBbbGlzdCB8IGdpdCBzaG93
LXJlZiAtZF0gcl0NCj4gKyAgICBpZiB7JHRjbGVuY29kaW5nICE9IHt9fSB7DQo+ICsgICAgICAg
ZmNvbmZpZ3VyZSAkcmVmZCAtZW5jb2RpbmcgJHRjbGVuY29kaW5nDQo+ICsgICAgfQ0KPiAgICAg
IHdoaWxlIHtbZ2V0cyAkcmVmZCBsaW5lXSA+PSAwfSB7DQo+ICAgICAgICAgaWYge1tzdHJpbmcg
aW5kZXggJGxpbmUgNDBdIG5lICIgIn0gY29udGludWUNCj4gICAgICAgICBzZXQgaWQgW3N0cmlu
ZyByYW5nZSAkbGluZSAwIDM5XQ0K
