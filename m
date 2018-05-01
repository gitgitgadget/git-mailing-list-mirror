Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC45B215F4
	for <e@80x24.org>; Tue,  1 May 2018 15:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755236AbeEAPnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 11:43:23 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:36577
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750787AbeEAPnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 11:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=najQWvWOib721BGkAIiy0Fn14ExTHktRDM4tUDMnVgU=;
 b=R59thFZ0xjZooBUJYPpHIhAfy+bhrdmuHFkiv9zD8qeuLk3KwFdos6AdBOlMuS+q94TOn6lVwjMIKm9RlNZnQzGVrdPWztIqKfhygv0LzUHtVbMiIItyVw3XyDsZMD+2ab0uwN8eZGwnXRqJcd+W3zCyVpwjiNb+FP7OAV43FlM=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1041.namprd21.prod.outlook.com (52.132.23.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 15:43:20 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 15:43:20 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Stefan Beller <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Subject: RE: [PATCH v2 3/5] mem-pool: fill out functionality
Thread-Topic: [PATCH v2 3/5] mem-pool: fill out functionality
Thread-Index: AQHT4JhXgM+PkPx06Uufvuo1NfMsXaQZ1v2AgAEnS1A=
Date:   Tue, 1 May 2018 15:43:19 +0000
Message-ID: <BL0PR2101MB1106AC4280E98A83A1A9BB6DCE810@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180430153122.243976-1-jamill@microsoft.com>
 <20180430153122.243976-4-jamill@microsoft.com>
 <CAGZ79katqnSvQzqiXdQ_SjGWUUF19_kwFBrq+Z9Vihv7xR792w@mail.gmail.com>
In-Reply-To: <CAGZ79katqnSvQzqiXdQ_SjGWUUF19_kwFBrq+Z9Vihv7xR792w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-01T15:43:17.8018360Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:d592:63ea:b39a:600a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:AhsqehGivpY/8jS24pOSappjbjKa2T4vgjhsZSWTGFJ7IvqAtVdAr/Zh9PuUwnm/DZ99YOSLJ2Q0VfSbW/C3SE/q/myNeJUa6NgTODf2dD7pqCNiZtfAQk5p4AoLyT9IQS+nsNXMBY3Ih1freqOmV38/96xoh+vYX+BGGV5JaApciZPg6oNsJn8iZW4j1rL5ZHeTA3+/qtr/oiZQZZm5aivOhcymOWLBBmjitfmDbwDFCm7GWXfKCJTc1hOUqBCh;20:++tWH3spp2Oq0qqntBvl0i5Zot03PW6mchAZcSw+25XdXjMzQs6jRLdFjxeyfz4Oil6IIMjfjoJKVeAWK3a8jTOTNcriDb5C9wbKPTNtyUlasgDRPd4lw/KQ2tXLCfLXkDPvxABz6ytUpOLfSleL/qBJLALVNXw4rQEN7QOqr1U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10419F7B0C8C7969471F2CE3CE810@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(211936372134217)(153496737603132)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(13464003)(199004)(189003)(55016002)(345774005)(68736007)(316002)(6246003)(53936002)(39060400002)(5250100002)(9686003)(97736004)(2906002)(22452003)(25786009)(10090500001)(3280700002)(3660700001)(478600001)(8676002)(33656002)(10290500003)(8936002)(81156014)(81166006)(4326008)(5660300001)(7736002)(8990500004)(74316002)(305945005)(8656006)(446003)(11346002)(46003)(6436002)(86362001)(2900100001)(53546011)(106356001)(99286004)(186003)(54906003)(105586002)(229853002)(14454004)(486006)(6916009)(93886005)(476003)(6506007)(102836004)(6116002)(76176011)(7696005)(59450400001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AWZtoqyq/hSUGP6FmxTCkFcA2pwCbgqdEf603lJFAlZdJL1h8ZSnVN8lUOls8fLxHM3tVeoy+Al6NVYHulafoyBeoDP/dT5rObMbp1n7cFohZ/p3YMmRa9mal8ygDnBcpknRDVvPkRvH30KzYWhWgDPppbgtVR7wW6hTXtyFPeUc+yZvnqV21IElj1PA4YdG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aa35fdc1-a58e-4069-9977-08d5af7a43ca
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa35fdc1-a58e-4069-9977-08d5af7a43ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 15:43:19.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciB0YWtpbmcgYSBsb29rIC0gSSB0aGluayB0aGVzZSBhcmUgZ29vZCBxdWVz
dGlvbnMuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBmdXJ0aGVyIHF1ZXN0aW9ucy4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gQmVsbGVyIDxz
YmVsbGVyQGdvb2dsZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMzAsIDIwMTggNTo0MiBQ
TQ0KPiBUbzogSmFtZXNvbiBNaWxsZXIgPGphbWlsbEBtaWNyb3NvZnQuY29tPg0KPiBDYzogZ2l0
QHZnZXIua2VybmVsLm9yZzsgZ2l0c3RlckBwb2JveC5jb207IHBjbG91ZHNAZ21haWwuY29tOw0K
PiBqb25hdGhhbnRhbm15QGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVd
IG1lbS1wb29sOiBmaWxsIG91dCBmdW5jdGlvbmFsaXR5DQo+IA0KPiBPbiBNb24sIEFwciAzMCwg
MjAxOCBhdCA4OjMxIEFNLCBKYW1lc29uIE1pbGxlciA8amFtaWxsQG1pY3Jvc29mdC5jb20+DQo+
IHdyb3RlOg0KPiA+IEFkZHMgdGhlIGZvbGxvd2luZyBmdW5jdGlvbmFsaXR5IHRvIG1lbW9yeSBw
b29sczoNCj4gPg0KPiA+ICAtIExpZmVjeWNsZSBtYW5hZ2VtZW50IGZ1bmN0aW9ucyAoaW5pdCwg
ZGlzY2FyZCkNCj4gPg0KPiA+ICAtIFRlc3Qgd2hldGhlciBhIG1lbW9yeSBsb2NhdGlvbiBpcyBw
YXJ0IG9mIHRoZSBtYW5hZ2VkIHBvb2wNCj4gPg0KPiA+ICAtIEZ1bmN0aW9uIHRvIGNvbWJpbmUg
MiBwb29scw0KPiA+DQo+ID4gVGhpcyBhbHNvIGFkZHMgbG9naWMgdG8gdHJhY2sgYWxsIG1lbW9y
eSBhbGxvY2F0aW9ucyBtYWRlIGJ5IGEgbWVtb3J5DQo+ID4gcG9vbC4NCj4gPg0KPiA+IFRoZXNl
IGZ1bmN0aW9ucyB3aWxsIGJlIHVzZWQgaW4gYSBmdXR1cmUgY29tbWl0IGluIHRoaXMgY29tbWl0
IHNlcmllcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWVzb24gTWlsbGVyIDxqYW1pbGxA
bWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgbWVtLXBvb2wuYyB8IDExNA0KPiA+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0N
Cj4gPiAgbWVtLXBvb2wuaCB8ICAzMiArKysrKysrKysrKysrKysrKw0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvbWVtLXBvb2wuaCBiL21lbS1wb29sLmgNCj4gPiBpbmRleCA4MjlhZDU4ZWNmLi4zNGRm
NGZhNzA5IDEwMDY0NA0KPiA+IC0tLSBhL21lbS1wb29sLmgNCj4gPiArKysgYi9tZW0tcG9vbC5o
DQo+ID4gQEAgLTE5LDggKzE5LDI3IEBAIHN0cnVjdCBtZW1fcG9vbCB7DQo+ID4NCj4gPiAgICAg
ICAgIC8qIFRoZSB0b3RhbCBhbW91bnQgb2YgbWVtb3J5IGFsbG9jYXRlZCBieSB0aGUgcG9vbC4g
Ki8NCj4gPiAgICAgICAgIHNpemVfdCBwb29sX2FsbG9jOw0KPiA+ICsNCj4gPiArICAgICAgIC8q
DQo+ID4gKyAgICAgICAgKiBBcnJheSBvZiBwb2ludGVycyB0byAiY3VzdG9tIHNpemUiIG1lbW9y
eSBhbGxvY2F0aW9ucy4NCj4gPiArICAgICAgICAqIFRoaXMgaXMgdXNlZCBmb3IgImxhcmdlIiBt
ZW1vcnkgYWxsb2NhdGlvbnMuDQo+ID4gKyAgICAgICAgKiBUaGUgKl9lbmQgdmFyaWFibGVzIGFy
ZSB1c2VkIHRvIHRyYWNrIHRoZSByYW5nZSBvZiBtZW1vcnkNCj4gPiArICAgICAgICAqIGFsbG9j
YXRlZC4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgdm9pZCAqKmN1c3RvbSwgKipjdXN0
b21fZW5kOw0KPiA+ICsgICAgICAgaW50IG5yLCBucl9lbmQsIGFsbG9jLCBhbGxvY19lbmQ7DQo+
ID4gIH07DQo+IA0KPiBXaGF0IGlzIHRoZSBkZXNpZ24gZ29hbCBvZiB0aGlzIG1lbSBwb29sPw0K
PiBXaGF0IGlzIGl0IHJlYWxseSBnb29kIGF0LCB3aGljaCBwYXR0ZXJucyBvZiB1c2Ugc2hvdWxk
IHdlIGF2b2lkPw0KPiANCg0KVGhpcyBtZW1vcnkgcG9vbCBpcyBkZXNpZ25lZCB0byBwcm92aWRl
IG1hbnkgc21hbGwgKHNtYWxsDQpjb21wYXJlZCB0byB0aGUgbWVtb3J5IHBvb2wgYmxvY2sgc2l6
ZSkgY2h1bmtzIG9mIG1lbW9yeSBmcm9tIGENCmxhcmdlciBibG9jayBvZiBhbGxvY2F0ZWQgbWVt
b3J5LiBUaGlzIHJlZHVjZXMgdGhlIG92ZXJoZWFkIG9mDQpwZXJmb3JtaW5nIG1hbnkgc21hbGwg
bWVtb3J5IGFsbG9jYXRpb25zIGZyb20gdGhlIGhlYXAuIEluIHRoZQ0KaWRlYWwgY2FzZSwgd2Ug
a25vdyB0aGUgdG90YWwgYW1vdW50IG9mIG1lbW9yeSByZXF1aXJlZCwgYW5kIHRoZQ0KcG9vbCBj
YW4gbWFrZSBhIHNpbmdsZSBhbGxvY2F0aW9uIHRvIHNhdGlzZnkgdGhhdCByZXF1aXJlbWVudCwN
CmFuZCBoYW5kIGl0IG91dCBpbiBjaHVua3MgdG8gY29uc3VtZXJzLg0KDQpXZSBzaG91bGQgYXZv
aWQgbWFraW5nIG1hbnkgbGFyZ2UgbWVtb3J5IHJlcXVlc3RzIChsYXJnZSBjb21wYXJlZA0KdG8g
dGhlIG1lbW9yeSBwb29sIGJsb2NrIHNpemUpLCBhcyB0aGVzZSByZXF1ZXN0cyB3aWxsIGJlDQpm
dWxmaWxsZWQgZnJvbSBpbmRpdmlkdWFsIG1lbW9yeSBhbGxvY2F0aW9ucyAoaS5lLiB0aGUgImN1
c3RvbSINCmFsbG9jYXRpb25zKS4gV2hpbGUgdGhlcmUgaXMgbm90IGEgY29ycmVjdG5lc3MgaXNz
dWUgaGVyZSwgaXQNCndpbGwgbm90IHBlcmZvcm0gYXMgd2VsbCB3aGVuIHJlcXVlc3RzIGFyZSBm
dWxmaWxsZWQgZnJvbSB0aGUNCmludGVybmFsIG1lbW9yeSBibG9ja3MuDQoNCj4gSXQgbG9va3Mg
bGlrZSBpbnRlcm5hbGx5IHRoZSBtZW0tcG9vbCBjYW4gZWl0aGVyIHVzZSBtcF9ibG9ja3MgdGhh
dCBhcmUgc3RvcmVkIGFzDQo+IGEgbGlua2VkIGxpc3QsIG9yIGl0IGNhbiBoYXZlIGN1c3RvbSBh
bGxvY2F0aW9ucyBzdG9yZWQgaW4gYW4gYXJyYXkuDQo+IA0KPiBJcyB0aGUgbGlua2VkIGxpc3Qg
b3IgdGhlIGN1c3RvbSBwYXJ0IHNvcnRlZCBieSBzb21lIGtleT8NCj4gRG9lcyBpdCBuZWVkIHRv
IGJlIHNvcnRlZD8NCj4gDQo+IEkgYW0gY3VycmVudGx5IGxvb2tpbmcgYXQgYWxsb2MuYywgd2hp
Y2ggaXMgcmVhbGx5IGdvb2QgZm9yIGFsbG9jYXRpbmcgbWVtb3J5IGZvcg0KPiBlcXVhbGx5IHNp
emVkIHBhcnRzLCBpLmUuIGl0IGlzIHZlcnkgZWZmaWNpZW50IGF0IHByb3ZpZGluZyBtZW1vcnkg
Zm9yIGZpeGVkIHNpemVkDQo+IHN0cnVjdHMuIEFuZCBvbiB0b3Agb2YgdGhhdCBpdCBpcyBub3Qg
dHJhY2tpbmcgYW55IG1lbW9yeSBhcyBpdCByZWxpZXMgb24gcHJvZ3JhbQ0KPiB0ZXJtaW5hdGlv
biBmb3IgY2xlYW51cC4NCg0KVGhlIGxpbmtlZCBsaXN0IGlzIG9yZGVyZWQgaW4gdGhlIG9yZGVy
IHRoZSBibG9ja3Mgd2VyZSBhbGxvY2F0ZWQNCmluLiBUaGUgbGFzdCBhbGxvY2F0ZWQgYmxvY2sg
d2lsbCBiZSB0aGUgaGVhZCBvZiB0aGUgbGlua2VkDQpsaXN0LiBUaGlzIG1lYW5zIHRoYXQgbW9z
dCBtZW1vcnkgcmVxdWVzdHMgc2hvdWxkIGJlIGZ1bGZpbGxlZCBieQ0KdGhlIGhlYWQgYmxvY2ss
IHJlZHVjaW5nIHRoZSBuZWVkIHRvIGl0ZXJhdGUgdGhyb3VnaCB0aGUgbGlzdCB0bw0KZmluZCBh
dmFpbGFibGUgbWVtb3J5Lg0KDQpUaGUgY3VzdG9tIG1lbW9yeSBibG9ja3MgYXJlIGluIHRoZWly
IG93biBsaXN0IGJlY2F1c2UgdGhleSB3aWxsDQpuZXZlciBjb250YWluIGFueSBmcmVlIG1lbW9y
eS4gVGhlcmUgaXMgbm8gbmVlZCB0byBpbmNsdWRlIHRoZXNlDQphbGxvY2F0aW9ucyBpbiB0aGUg
bGlzdCBvZiBibG9ja3MgdGhhdCBjb3VsZCBwb3RlbnRpYWxseSBoYXZlDQpmcmVlIG1lbW9yeS4N
Cg0KSSBleHBlY3QgdGhpcyBjb2RlIHdvdWxkIGJlIGVmZmljaWVudCBhdCBhbGxvY2F0aW5nIG1h
bnkgZXF1YWwNCnNpemVkIHBhcnRzLCBhcyBsb25nIGFzIHRob3NlIHBhcnRzIGFyZSBjb21wYXJp
dGl2ZWx5IHNtYWxsDQpjb21wYXJlZCB0byB0aGUgYmxvY2sgc2l6ZS4gSW4gdGhpcyBjYXNlLCB5
b3Ugd291bGQgbmV2ZXINCmFsbG9jYXRlICJjdXN0b20iIGJsb2NrcywgYW5kIHRoZSBvdmVyd2hl
bG1pbmcgbWFqb3JpdHkgb2YNCmFsbG9jYXRpb25zIHdvdWxkIGNvbWUgZnJvbSB0aGUgaGVhZCBi
bG9jay4gSWYgeW91IGtub3cgdGhlIHRvdGFsDQphbW91bnQgb2YgbWVtb3J5IHlvdSB3aWxsIG5l
ZWQsIHRoZW4geW91IGNhbiBzaXplIHRoZSBtZW1vcnkgcG9vbA0Kc28gYWxsIGFsbG9jYXRpb25z
IGNvbWUgZnJvbSB0aGUgaGVhZCBibG9jay4NCg0KPiANCj4gVGhpcyBtZW1vcnkgcG9vbCBzZWVt
cyB0byBiZSBvcHRpbWl6ZWQgZm9yIGFsbG9jYXRpb25zIG9mIHZhcnlpbmcgc2l6ZXMsIHNvbWUN
Cj4gb2YgdGhlbSBodWdlICh0byBiZSBzdG9yZWQgaW4gdGhlIGN1c3RvbQ0KPiBwYXJ0KSBhbmQg
bW9zdCBvZiB0aGVtIHJhdGhlciBzbWFsbCBhcyB0aGV5IGdvIGludG8gdGhlIG1wX2Jsb2Nrcz8N
Cg0KSSB3b3VsZCBzYXkgdGhpcyBtZW1vcnkgcG9vbCBpcyBvcHRpbWl6ZWQgZm9yIGFsbG9jYXRp
b25zIG9mDQp2YXJ5aW5nIHNpemVzIChhbHRob3VnaCBpdCBzaG91bGQgYmUgcHJldHR5IGVmZmlj
aWVudCB3aGVuIHRoZQ0KYWxsb2NhdGlvbnMgYXJlIG9mIHRoZSBzYW1lIHNpemUpLCBidXQgY2Fu
IGhhbmRsZSB0aGUgZWRnZSBjYXNlDQp3aGVuIHRoZXJlIGhhcHBlbnMgdG8gYmUgYSBuZWVkIGZv
ciBhICJodWdlIGFsbG9jYXRpb24iLg0KPiANCj4gVGhhbmtzLA0KPiBTdGVmYW4NCg==
