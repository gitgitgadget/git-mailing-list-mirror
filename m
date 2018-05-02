Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C98B21847
	for <e@80x24.org>; Wed,  2 May 2018 18:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbeEBSo4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 14:44:56 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:10816
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750800AbeEBSoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 14:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ALXhRruR4+mOvy0JLab9kPoP00BCm+UokmDa3wLFVx4=;
 b=Vq+0BP/VY0w2wP73nDnllmPM0A0eZQopjUExWLcHqnCDjOW9QTNpMippOjg+tZWpf+pA+qV6Oz3AYXVnVymwMVP1Zv1GzUMdYNQPUFJHs0Y5luRgm4mx8IVDGNZ/yWWTOinvmxZ0YEuqUEMXR4Hgst23nfTmdsyDeNiYCPQpnAQ=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1025.namprd21.prod.outlook.com (52.132.20.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Wed, 2 May 2018 18:44:53 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.011; Wed, 2 May 2018
 18:44:53 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Duy Nguyen <pclouds@gmail.com>
CC:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH 00/13] object store: alloc
Thread-Topic: [PATCH 00/13] object store: alloc
Thread-Index: AQHT4ZQkT0wTvjJ5ek2bMhaifDxhu6Qcq1QAgAAQHeCAAAaHAIAAAJ2w
Date:   Wed, 2 May 2018 18:44:53 +0000
Message-ID: <BL0PR2101MB1106A9F695338C4E045F2AA1CE800@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <CACsJy8DKnBRDZC=oBd8nTOAVzQf3UtoLCeoGKjcMHgUmXf-KqQ@mail.gmail.com>
 <BL0PR2101MB1106C07DEE184F8DA2C7CA62CE800@BL0PR2101MB1106.namprd21.prod.outlook.com>
 <CACsJy8CR1RYYdsc5=8hz2Sx9_bOY9eb_-vwEqDo62Hex1FxBmw@mail.gmail.com>
In-Reply-To: <CACsJy8CR1RYYdsc5=8hz2Sx9_bOY9eb_-vwEqDo62Hex1FxBmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-02T18:44:51.8401092Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:b2ec:da36:1ccf:fa06]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1025;7:IZr7Sg7sqH2Dg7iW90r/Z+2AC0HwwNXK52QtQJ7VOmm7hqZAaFWA5/xiWYLEZ7lcSUqBfrLAQIvu1MDbJdkGKRS+x1OCFIVnnmDXtHSVv0hV+0C2awvLNnLw5ucP3aDXrWsmcEMWeyGZoDmW3eTKLloCmHrR5psq8CcsOyKuPTgBsoiUGoH5eHRyD9AOVwV3bPtYiipQr3elGuT6efbQqMHK7RWopsT0Qmjw0Phph6GvZ9W8izLMzmEfsVX7ojkN;20:WEQDdL9w2Aivuj14r82bnZ1VLqS6YYx/jqmBjiApR7PUVDrDhyxc12FOhIVCVPQfzez6GdaxUfmC3oApiEuFBVQoxfgQ2OVVuLxY5q/5NHy1ooJJUG3XVBaJr8AwioVUGHxa+bUvcop/wh8gGLdTATvzIiVqMWkNtmTAZ+PnLm8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1025;
x-ms-traffictypediagnostic: BL0PR2101MB1025:
x-microsoft-antispam-prvs: <BL0PR2101MB102571433D6E77359E949566CE800@BL0PR2101MB1025.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1025;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1025;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(376002)(39860400002)(13464003)(51444003)(189003)(199004)(3660700001)(97736004)(2906002)(486006)(6436002)(9686003)(345774005)(25786009)(68736007)(2900100001)(106356001)(53936002)(55016002)(8936002)(7696005)(8990500004)(76176011)(81156014)(81166006)(86612001)(8676002)(10090500001)(6116002)(6346003)(6506007)(86362001)(53546011)(105586002)(102836004)(22452003)(99286004)(186003)(93886005)(54906003)(316002)(74316002)(6916009)(305945005)(476003)(10290500003)(14454004)(46003)(478600001)(4326008)(33656002)(7736002)(39060400002)(6246003)(229853002)(5250100002)(1411001)(446003)(11346002)(3280700002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1025;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: Kxl2TXTwQO3fKCT0/X3Q9bqszqkKzVHN6Imu0tUWUrOajyoXJYCUMylycIX5G+KSckzyipwzUrOIBfLS7HCmNJCdwcpnjCtJT24h9R5E6t3NT2l4H2wUKBnFNGw1Zbhn6TQsANnEjA9407ntM0zhbelSozyU1vR80YOlW0eDp0+BkQKQWBV9D5fQMi9y3Juu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 59875561-8def-4c71-9683-08d5b05ccb2f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59875561-8def-4c71-9683-08d5b05ccb2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 18:44:53.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1025
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHV5IE5ndXllbiA8cGNs
b3Vkc0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIsIDIwMTggMjoyMyBQTQ0K
PiBUbzogSmFtZXNvbiBNaWxsZXIgPGphbWlsbEBtaWNyb3NvZnQuY29tPg0KPiBDYzogU3RlZmFu
IEJlbGxlciA8c2JlbGxlckBnb29nbGUuY29tPjsgR2l0IE1haWxpbmcgTGlzdCA8Z2l0QHZnZXIu
a2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xM10gb2JqZWN0IHN0b3JlOiBh
bGxvYw0KPiANCj4gT24gV2VkLCBNYXkgMiwgMjAxOCBhdCA4OjA3IFBNLCBKYW1lc29uIE1pbGxl
ciA8amFtaWxsQG1pY3Jvc29mdC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRHV5IE5ndXllbiA8cGNsb3Vkc0BnbWFp
bC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIsIDIwMTggMTowMiBQTQ0KPiA+PiBU
bzogU3RlZmFuIEJlbGxlciA8c2JlbGxlckBnb29nbGUuY29tPg0KPiA+PiBDYzogR2l0IE1haWxp
bmcgTGlzdCA8Z2l0QHZnZXIua2VybmVsLm9yZz47IEphbWVzb24gTWlsbGVyDQo+ID4+IDxqYW1p
bGxAbWljcm9zb2Z0LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xM10gb2JqZWN0
IHN0b3JlOiBhbGxvYw0KPiA+Pg0KPiA+PiBPbiBUdWUsIE1heSAxLCAyMDE4IGF0IDExOjMzIFBN
LCBTdGVmYW4gQmVsbGVyIDxzYmVsbGVyQGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+PiA+IEkg
YWxzbyBkZWJhdGVkIGlmIGl0IGlzIHdvcnRoIGNvbnZlcnRpbmcgYWxsb2MuYyB2aWEgdGhpcyBw
YXRjaA0KPiA+PiA+IHNlcmllcyBvciBpZiBpdCBtaWdodCBtYWtlIG1vcmUgc2Vuc2UgdG8gdXNl
IHRoZSBuZXcgbWVtLXBvb2wgYnkNCj4gSmFtZXNvblsxXS4NCj4gPj4gPg0KPiA+PiA+IEkgdmFn
dWVseSB3b25kZXIgYWJvdXQgdGhlIHBlcmZvcm1hbmNlIGltcGFjdCwgYXMgdGhlIG9iamVjdA0K
PiA+PiA+IGFsbG9jYXRpb24gY29kZSBzZWVtZWQgdG8gYmUgcmVsZXZhbnQgaW4gdGhlIHBhc3Qu
DQo+ID4+DQo+ID4+IElmIEkgcmVtZW1iZXIgY29ycmVjdGx5LCBhbGxvYy5jIHdhcyBhZGRlZCBi
ZWNhdXNlIG1hbGxvYygpIGhhcyB0b28NCj4gPj4gaGlnaCBvdmVyaGVhZCBwZXIgYWxsb2NhdGlv
biAoYW5kIHdlIGNyZWF0ZSBsaWtlIG1pbGxpb25zIG9mIHRoZW0pLg0KPiA+PiBBcyBsb25nIGFz
IHlvdSBrZWVwIGFsbG9jYXRpb24gb3ZlcmhlYWQgbG93LCBpdCBzaG91bGQgYmUgb2suIE5vdGUN
Cj4gPj4gdGhhdCB3ZSBhbGxvY2F0ZSBhIGxvdCBtb3JlIHRoYW4gdGhlIG1lbS1wb29sJ3MgbWFp
biB0YXJnZXQgKGNhY2hlDQo+ID4+IGVudHJpZXMgaWYgSSByZW1lbWJlciBjb3JyZWN0bHkpLiBX
ZSBtYXkgaGF2ZSBhIGNvdXBsZSB0aG91c2FuZHMNCj4gPj4gY2FjaGUgZW50cmllcy4gIFdlIGFs
cmVhZHkgZGVhbCB3aXRoIGEgY291cGxlIG1pbGxpb24gb2Ygc3RydWN0IG9iamVjdC4NCj4gPg0K
PiA+IFRoZSB3b3JrIHRvIG1vdmUgY2FjaGUgZW50cnkgYWxsb2NhdGlvbiBvbnRvIGEgbWVtb3J5
IHBvb2wgd2FzDQo+ID4gbW90aXZhdGVkIGJ5IHRoZSBmYWN0IHRoYXQgd2UgYXJlIGxvb2tpbmcg
YXQgaW5kZXhlcyB3aXRoIG1pbGxpb25zIG9mDQo+ID4gZW50cmllcy4gSWYgdGhlcmUgaXMgc2Nh
bGluZyBjb25jZXJuIHdpdGggdGhlIGN1cnJlbnQgdmVyc2lvbiBvZg0KPiA+IG1lbS1wb29sLCB3
ZSB3b3VsZCBsaWtlIHRvIGFkZHJlc3MgaXQgdGhlcmUgYXMgd2VsbC4gT3IgaWYgdGhlcmUgaXMN
Cj4gaW1wcm92ZW1lbnRzIHRoYXQgY2FuIGJlIHNoYXJlZCwgdGhhdCB3b3VsZCBiZSBuaWNlIGFz
IHdlbGwuDQo+IA0KPiBJIHRoaW5rIHRoZSB0d28gaGF2ZSBxdWl0ZSBkaWZmZXJlbnQgY2hhcmFj
dGVyaXN0aWNzLiBhbGxvYy5jIGNvZGUgaXMgZHJpdmVuIGJ5DQo+IG92ZXJoZWFkLiBzdHJ1Y3Qg
YmxvYiBpcyBvbmx5IDI0IGJ5dGVzIGVhY2ggYW5kIGFib3V0IDEvMyB0aGUgcmVwbyBpcyBibG9i
cywgYW5kDQo+IGVhY2ggbWFsbG9jIGhhcyAxNiBieXRlcyBvdmVyaGVhZCBvciBzbyBpZiBJIHJl
bWVtYmVyIGNvcnJlY3RseS4gc3RydWN0DQo+IGNhY2hlX2VudHJ5IGF0IG1pbmltdW0gaW4gODgg
Ynl0ZXMgc28gcmVsYXRpdmUgb3ZlcmhlYWQgaXMgbm90IHRoYXQgYSBiaWcgZGVhbA0KPiAoYnV0
IHN1cmUgcmVkdWNpbmcgaXQgaXMgc3RpbGwgdmVyeSBuaWNlKS4NCj4gDQo+IG1lbS1wb29sIGlz
IGFib3V0IGFsbG9jYXRpb24gc3BlZWQsIGJ1dCBJIHRoaW5rIHRoYXQncyBub3QgYSBjb25jZXJu
IGZvciBhbGxvYy5jDQo+IGJlY2F1c2Ugd2hlbiB3ZSBkbyBmdWxsIHJldiB3YWxrLCBJIHRoaW5r
IEkvTyBpcyBhbHdheXMgdGhlIGJvdHRsZW5lY2sgKG1heWJlDQo+IG9iamVjdCBsb29rdXAgYXMg
d2VsbCkuIEkgZG9uJ3Qgc2VlIGEgZ29vZCB3YXkgdG8gaGF2ZSB0aGUgb25lIG1lbW9yeSBhbGxv
Y2F0b3INCj4gdGhhdCBzYXRpc2Z5aWVzIGJvdGggdG8gYmUgaG9uZXN0LiBJZiB5b3UgY291bGQg
YWxsb2NhdGUgZml4ZWQtc2l6ZSBjYWNoZSBlbnRyaWVzDQo+IG1vc3Qgb2YgdGhlIHRpbWUgKGUu
Zy4NCj4gbGFyZ2VyIGVudHJpZXMgd2lsbCBiZSBhbGxvY2F0ZWQgdXNpbmcgbWFsbG9jIG9yIHNv
bWV0aGluZywgYW5kIHNob3VsZCBiZSBhIHNtYWxsDQo+IG51bWJlciksIHRoZW4gcGVyaGFwcyB3
ZSBjYW4gdW5pZnkuIE9yIGlmIG1lbS1wb29sIGNhbiBoYXZlIGFuIG9wdGlvbiB0bw0KPiBhbGxv
Y2F0ZWQgZml4ZWQgc2l6ZSBwaWVjZXMgd2l0aCBubyBvdmVyaGVhZCwgdGhhdCB3b3VsZCBiZSBn
cmVhdCAoc29ycnkgSSBzdGlsbA0KPiBoYXZlIG5vdCByZWFkIHRoYXQgbWVtLXBvb2wgc2VyaWVz
IHlldCkNCj4gLS0NCj4gRHV5DQoNClRoYW5rIHlvdSBmb3IgdGhlIGV4dHJhIGRldGFpbHMgLSB0
aGUgZXh0cmEgY29udGV4dCB3YXMgaGVscGZ1bCAtDQplc3BlY2lhbGx5IHRoZSBtb3RpdmF0aW9u
cyBmb3IgZWFjaCBvZiB0aGUgYXJlYXMuIEkgYWdyZWUgd2l0aA0KeW91ciBnZW5lcmFsIGFuYWx5
c2lzLCBidXQgd2l0aCB0aGUgZXh0cmEgcG9pbnQgdGhhdCB0aGUgbWVtb3J5DQpwb29sIGRvZXMg
YWxsb2NhdGUgbWVtb3J5ICh2YXJpYWJsZSBzaXplZCkgd2l0aG91dCBhbnkgb3ZlcmhlYWQsDQpl
eGNlcHQgZm9yIHBvc3NpYmxlIGFsaWdubWVudCBjb25zaWRlcmF0aW9ucyBhbmQgZGlmZmVyZW5j
ZXMgaW4NCmJvb2trZWVwaW5nIHRoZSBsYXJnZXIgImJsb2NrcyIgb2YgbWVtb3J5IGZyb20gd2hp
Y2ggc21hbGwNCmFsbG9jYXRpb25zIGFyZSBtYWRlIGZyb20gLSBidXQgSSBkb24ndCB0aGluayB0
aGlzIHdvdWxkIGJlDQplbm91Z2ggdG8gaGF2ZSBhIG1lYW5pbmdmdWwgb3ZlcmFsbCBpbXBhY3Qu
DQoNClRoZSBtZW0tcG9vbCBvbmx5IHRyYWNrcyB0aGUgcG9pbnRlciB0byB0aGUgbmV4dCBhdmFp
bGFibGUgYml0IG9mDQptZW1vcnksIGFuZCB0aGUgZW5kIG9mIHRoZSBhdmFpbGFibGUgbWVtb3J5
IHJhbmdlLiBJdCBoYXMgYQ0Kc2ltaWxhciBjb25zdHJhaW50IGluIHRoYXQgaW5kaXZpZHVhbCBh
bGxvY2F0aW9ucyBjYW5ub3QgYmUgZnJlZWQNCi0geW91IGhhdmUgdG8gZnJlZSB0aGUgd2hvbGUg
YmxvY2suDQoNCkl0IG1heSBiZSB0aGF0IHRoZSByZXF1aXJlbWVudHMgYXJlIGRpZmZlcmVudCBl
bm91Z2ggKG9yIHRoZQ0KZ2FpbnMgd29ydGggaXQpIHRvIGhhdmUgYW5vdGhlciBkZWRpY2F0ZWQg
cG9vbGluZyBhbGxvY2F0b3IsIGJ1dA0KSSB0aGluayB0aGUgY3VycmVudCBkZXNpZ24gb2YgdGhl
IG1lbW9yeSBwb29sIHdvdWxkIHNhdGlzZnkgYm90aA0KY29uc3VtZXJzLCBldmVuIGlmIHRoZSBt
ZW1vcnkgY29uc2lkZXJhdGlvbnMgYXJlIGEgYmlnZ2VyDQptb3RpdmF0aW9uIGZvciBibG9iIHN0
cnVjdHMuIEkgd291bGQgYmUgaW50ZXJlc3RlZCBpbiB5b3VyDQp0aG91Z2h0cyBpZiB5b3UgZ2V0
IHRoZSBvcHBvcnR1bml0eSB0byByZWFkIHRoZSBtZW0tcG9vbCBzZXJpZXMuDQo=
