Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C141F424
	for <e@80x24.org>; Mon, 18 Dec 2017 16:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935553AbdLRQFV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 11:05:21 -0500
Received: from mail-co1nam03on0112.outbound.protection.outlook.com ([104.47.40.112]:33056
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935746AbdLRQFN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 11:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HMuI3jqtzCEZdGla5nDfrV/LaUvQJOYi2aUizozFetc=;
 b=kpxuLe84jyIOZuTgxOErHhrYzY7f0CySNQKjDjYz21mnQ4uChodX6epBmcZC84wluftrGHE//b34z54CcCD5XogS8vs14cfuqJ/k1/YsX9+5IrKtPSocUyBd4Qm18Bf0eQpVtHn+MPpsUDuP8/hrFG/q0RPKbWbVjnjXshx1prw=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0173.namprd21.prod.outlook.com (10.173.52.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.366.1; Mon, 18 Dec 2017 16:05:11 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0366.001; Mon, 18 Dec 2017 16:05:11 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: RE: [PATCH] p7519: improve check for prerequisite WATCHMAN
Thread-Topic: [PATCH] p7519: improve check for prerequisite WATCHMAN
Thread-Index: AQHTdmckcmlVL5J5+0qog4PQc8tQm6NJQjiQ
Date:   Mon, 18 Dec 2017 16:05:11 +0000
Message-ID: <MWHPR21MB04782C421CE40E6FA468AFF4F40E0@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <fb8f1b3b-3668-db21-993c-087aee279936@web.de>
In-Reply-To: <fb8f1b3b-3668-db21-993c-087aee279936@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-12-18T16:04:40.2703863Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0173;6:657P1SOh0aWpgcpRBSULCGQCHYIq3wGxzhvpHaY8H5mvfiTnrnPojajp33jSBwcy90YRoMwB+s2sHNEqMw6eTP88fNZ1tt080fuTpc1MZwe6n9okYpOpcuEAo602Ypb8xecQTNEDeUw4Fy6rSYL1rBF+eBazG3MehgdjhMTyURxbGcGFzNXLJESNXVnJzVEwZZJ9BmrLAZrEi4degObu4h6y0H7Za12chfLTJz/t09AxmZEDe5Bduvl1YpgzL7pzjDleCEGN6vQK5Rsdj7oi9VaJI0xZg7mOyEttx+CqEnHbJ6n0UC3NF85VlByVnwmtmiYoIe2ChB03zuH/ISMV4ada1TosPmMxSi6P1TeP3i4=;5:8qx/GXgy4bmcyPeMlKlG+D2RtNEoeX8m/IUQAKmK+W8haMS7C568Yi9tlh0aOzXuUZnUUfsAtrlP5W84m2Zu8pf+AlP2tueofqyc8YPPlV0VoynEdpESGwDN7TUahrTCYMzBKnCniVDFrmtcqX2JJRzcea5CGOKCfbNYRoC/Msg=;24:0wKKItP1db8Ltl55w9P7LwK9Pcoa+3l3oLllZV1v1IawAncY1kH+ExTYNLIYEXvwBluHjQ8SsM+kXVXPInzPryobpj7q0S+Yh9OPM0V24iI=;7:x8GGIvk0c7TccMqIc3spzl3Jn9/oFb5/gKsNiqz+Oz6KEUrCE9sl81wcPujj4/nuP3ZIPenUTssbyeomvxl7pJoOcOv+IODCne+M2iV8OC13gKTB89DjPvqf8iviiNeB27fQPgGYQi4fFSHQJ/zIdY21kuYC8EW4txOylDrrTlSYhoJkfqCzG56nKbOxfnxjUVSjc7PTF9R4YJzHycHuJ1jCe7690dyWzwv4xVmHQ7W8P9zefqEYwdOssVU1l0l8
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 357bbd13-35de-4250-f647-08d546311e48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603307);SRVR:MWHPR21MB0173;
x-ms-traffictypediagnostic: MWHPR21MB0173:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MWHPR21MB0173FA47DB9F791CAB8486DDF40E0@MWHPR21MB0173.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(89211679590171)(9452136761055)(245156298449039)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231023)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR21MB0173;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR21MB0173;
x-forefront-prvs: 0525BB0ADF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(13464003)(189003)(199004)(51914003)(76176011)(99286004)(6506007)(478600001)(86362001)(22452003)(2906002)(8656006)(3660700001)(55016002)(25786009)(53546011)(3280700002)(8936002)(77096006)(4326008)(7696005)(229853002)(6436002)(5660300001)(72206003)(66066001)(10290500003)(316002)(68736007)(86612001)(39060400002)(54906003)(105586002)(9686003)(6246003)(74316002)(10090500001)(53936002)(305945005)(2900100001)(97736004)(8676002)(7736002)(106356001)(81156014)(81166006)(2950100002)(102836003)(6116002)(3846002)(8990500004)(59450400001)(110136005)(14454004)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0173;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357bbd13-35de-4250-f647-08d546311e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2017 16:05:11.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0173
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSZW7DqSBTY2hhcmZlIFttYWls
dG86bC5zLnJAd2ViLmRlXQ0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMTYsIDIwMTcgNzox
MiBBTQ0KPiBUbzogR2l0IExpc3QgPGdpdEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBKdW5pbyBD
IEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+OyBCZW4gUGVhcnQNCj4gPEJlbi5QZWFydEBtaWNy
b3NvZnQuY29tPjsgw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24NCj4gPGF2YXJhYkBnbWFpbC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gcDc1MTk6IGltcHJvdmUgY2hlY2sgZm9yIHByZXJlcXVp
c2l0ZSBXQVRDSE1BTg0KPiANCj4gVGhlIHJldHVybiBjb2RlIG9mIGNvbW1hbmQgLXYgd2l0aCBh
IG5vbi1leGlzdGluZyBjb21tYW5kIGlzIDEgaW4gYmFzaA0KPiBhbmQgMTI3IGluIGRhc2guICBV
c2UgdGhhdCByZXR1cm4gY29kZSBkaXJlY3RseSB0byBhbGxvdyB0aGUgc2NyaXB0IHRvIHdvcmsN
Cj4gd2l0aCBkYXNoIGFuZCB3aXRob3V0IHdhdGNobWFuIChlLmcuIG9uIERlYmlhbikuDQo+IA0K
PiBXaGlsZSBhdCBpdCBzdG9wIHJlZGlyZWN0aW5nIHRoZSBvdXRwdXQuICBzdGRlcnIgaXMgcmVk
aXJlY3RlZCB0byAvZGV2L251bGwgYnkNCj4gdGVzdF9sYXp5X3ByZXJlcSBhbHJlYWR5LCBhbmQg
c3Rkb3V0IGNhbiBhY3R1YWxseSBiZSB1c2VmdWwgLS0gdGhlIHBhdGggb2YgdGhlDQo+IGZvdW5k
IHdhdGNobWFuIGV4ZWN1dGFibGUgaXMgc2VudCB0aGVyZSwgYnV0IGl0J3Mgc2hvd24gb25seSBp
ZiB0aGUgc2NyaXB0DQo+IHdhcyBydW4gd2l0aCAtLXZlcmJvc2UuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBSZW5lIFNjaGFyZmUgPGwucy5yQHdlYi5kZT4NCj4gLS0tDQo+ICB0L3BlcmYvcDc1MTkt
ZnNtb25pdG9yLnNoIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90L3BlcmYvcDc1MTktZnNtb25pdG9y
LnNoIGIvdC9wZXJmL3A3NTE5LWZzbW9uaXRvci5zaCBpbmRleA0KPiAxNmQxYmY3MmU1Li42NWUx
NDVjMDJkIDEwMDc1NQ0KPiAtLS0gYS90L3BlcmYvcDc1MTktZnNtb25pdG9yLnNoDQo+ICsrKyBi
L3QvcGVyZi9wNzUxOS1mc21vbml0b3Iuc2gNCj4gQEAgLTQwLDggKzQwLDcgQEAgdGVzdF9sYXp5
X3ByZXJlcSBVTlRSQUNLRURfQ0FDSEUgJw0KPiAgJw0KPiANCj4gIHRlc3RfbGF6eV9wcmVyZXEg
V0FUQ0hNQU4gJw0KPiAtCXsgY29tbWFuZCAtdiB3YXRjaG1hbiA+L2Rldi9udWxsIDI+JjE7IHJl
dD0kPzsgfSAmJg0KPiAtCXRlc3QgJHJldCAtbmUgMQ0KPiArCWNvbW1hbmQgLXYgd2F0Y2htYW4N
Cj4gICcNCg0KTG9va3MgZ29vZCB0byBtZS4gIEkgdGVzdGVkIHRoaXMgb24gV2luZG93cyBhbmQg
aXQgc3RpbGwgd29ya3Mgd2l0aCBhbmQgd2l0aG91dCB3YXRjaG1hbi4gIFRoYW5rcyBmb3IgdGhl
IHVwZGF0ZSB0byBnZXQgdGhpcyB3b3JraW5nIG9uIG90aGVyIHBsYXRmb3Jtcy4NCg0KPiANCj4g
IGlmIHRlc3RfaGF2ZV9wcmVyZXEgV0FUQ0hNQU4NCj4gLS0NCj4gMi4xNS4xDQo=
