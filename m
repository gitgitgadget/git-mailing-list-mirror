Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD521F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeFTUlI (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:41:08 -0400
Received: from mail-eopbgr680130.outbound.protection.outlook.com ([40.107.68.130]:38232
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933100AbeFTUlH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwMkpyAjtAqMwSM7VM2/gIrovgbM3uoRK/RQ4ZzIbko=;
 b=m+1nkZ9h23faQ2fbkBgn61AiHGA3kC3x+1i/TNJdcItdH5xhiNK/S7gqhnWOW9zQcwryqPHF+bgB7DXp6CLlrSouxvRWQgiyc+UaBwGJY8IYnURKNP+0hWJdhUh2mWNU3eH/46+CRFq/LJZLUWADzNBy7epeV9zg5l0/twI5JcE=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0745.namprd21.prod.outlook.com (10.173.172.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Wed, 20 Jun 2018 20:41:05 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:41:05 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Stefan Beller <sbeller@google.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>
Subject: RE: [PATCH v3 0/7] allocate cache entries from memory pool
Thread-Topic: [PATCH v3 0/7] allocate cache entries from memory pool
Thread-Index: AQHT8qT4yabJZ/7WG0WRtFmcJ5diXaQ+UY/CgACLHlCAAjR9AIAosa0Q
Date:   Wed, 20 Jun 2018 20:41:05 +0000
Message-ID: <DM5PR21MB07803E8D2627676788659E63CE770@DM5PR21MB0780.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180523144637.153551-1-jamill@microsoft.com>
 <xmqqa7spsle1.fsf@gitster-ct.c.googlers.com>
 <BL0PR2101MB11068051AD589871D4D707CBCE6A0@BL0PR2101MB1106.namprd21.prod.outlook.com>
 <CAGZ79kbZcqzRAqip_CbEmxxhXr_UcAfO-siRgoVjqdd7XsH8sg@mail.gmail.com>
In-Reply-To: <CAGZ79kbZcqzRAqip_CbEmxxhXr_UcAfO-siRgoVjqdd7XsH8sg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-20T20:41:03.8254231Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:1555:59e3:36d5:f5fe]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0745;7:wyvsOqCP9irbWLk84cHP49qgFQDMmRziLKtONfBoW4MmRkYaB/5cT65e0Hb6y/+eIqttAGgPWlVvDrpRtf1794zg2WWfXYOqldxv8OxveciZ2xMAosMsV/7L4R3Ol3BfL7U2bMPecaxg3hXqPkK+xnMnwMkmQ2L4rc2YFr3j0a6JYGDbePI5eZln7fD931ohgDzOarhjwP0+a6FNBzX3mjZYbiiOLrWp0bc5WUfhb6vmWoFPpdJ1pPBdreX7h8fE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df7358e9-795d-4348-81f8-08d5d6ee2506
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0745;
x-ms-traffictypediagnostic: DM5PR21MB0745:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0745A0CF78F9B65D200C5C17CE770@DM5PR21MB0745.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0745;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0745;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(186003)(68736007)(106356001)(105586002)(6916009)(5660300001)(229853002)(33656002)(46003)(2900100001)(81166006)(8936002)(53936002)(8676002)(316002)(81156014)(54906003)(93886005)(305945005)(7736002)(10090500001)(8990500004)(14454004)(22452003)(74316002)(4326008)(25786009)(6246003)(478600001)(10290500003)(76176011)(7696005)(3660700001)(59450400001)(2906002)(102836004)(3280700002)(6506007)(99286004)(8656006)(446003)(55016002)(11346002)(6116002)(476003)(86612001)(86362001)(486006)(5250100002)(6436002)(9686003)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0745;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ip9BJFfeyBA8y7CeXA44AUnHUDNqVl/hO4UCzeBBtF5wxoXCXObFtc72A1fz8VqR4IeoumdFp7HuXQFWSD7whkF2+FWjDGstaES4lFtD1XdbO+7jkwAvlXWGVdVEDpto5WTU6btzIgLCT1rBuiZnjwjBo9ROqTQxLx89zqBnELefxFzRRNzibkeB4AgP3ZRsZbEggikEAT3FEFf62rM6+bOEQcNv66F3JfvT15OgzlTGpm8aQDg9gm8s89/Oqe84j2GseKs2j1Y3HnQbLcJ1ly1WrLDENDgWZpT9omz7GZhCxuAnvHULC2ilnJ9MbQov2RRhFcGRDJZcqKOjgZBdcA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7358e9-795d-4348-81f8-08d5d6ee2506
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:41:05.2885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0745
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiANCj4gPiBXZSBkZWJhdGVkIHNldmVyYWwgYXBwcm9hY2hlcyBmb3Igd2hhdCB0byBkbyBoZXJl
DQo+IA0KPiBpdCB3b3VsZCBiZSBhd2Vzb21lIGlmIHRoZSBsaXN0IGNvdWxkIHBhcnRpY2lwYXRl
IGluIHRoZSBkaXNjdXNzaW9uIGV2ZW4gaWYgb25seQ0KPiByZWFkLW9ubHkuDQoNCkEgYml0IG9m
IGRlbGF5IGluIG15IHJlc3BvbnNlIGhlcmUsIGJ1dCBJIGxpa2UgdGhlIHN1Z2dlc3Rpb24uIGhl
cmUgaXMgYSBzdW1tYXJ5IG9mDQpzb21lIGFwcHJvYWNoZXMgSSBjb25zaWRlcmVkOg0KDQoxKSBE
byBub3QgaW5jbHVkZSBhbnkgaW5mb3JtYXRpb24gYWJvdXQgd2hlcmUgdGhlIGNhY2hlX2VudHJ5
IHdhcyBhbGxvY2F0ZWQuDQogICAgIFByb3M6IE5vIGV4dHJhIG1lbW9yeSBvdmVyaGVhZA0KICAg
ICBDb25zOiBDYWxsZXIgaXMgcmVzcG9uc2libGUgZm9yIGZyZWVpbmcgdGhlIGNhY2hlIGVudHJ5
IGNvcnJlY3RseQ0KDQpUaGlzIHdhcyBvdXIgaW5pdGlhbCBhcHByb2FjaC4gV2Ugd2VyZSBob3Bp
bmcgdGhhdCBhbGwgY2FjaGUNCmVudHJpZXMgY291bGQgYmUgYWxsb2NhdGVkIGZyb20gYSBtZW1v
cnkgcG9vbCwgYW5kIHdlIHdvdWxkIG5vdA0KaGF2ZSB0byB3b3JyeSBhYm91dCBub24tcG9vbCBh
bGxvY2F0ZWQgZW50cmllcy4gVGhlcmUgYXJlIHN0aWxsIGENCmNvdXBsZSBvZiBwbGFjZXMgdGhh
dCBuZWVkICJ0ZW1wb3JhcnkiIGNhY2hlIGVudHJpZXMgYXQgdGhlDQptb21lbnQsIHNvIHdlIGNv
dWxkbid0IG1vdmUgY29tcGxldGVseSB0byBvbmx5IG1lbW9yeSBwb29sDQphbGxvY2F0ZWQgY2Fj
aGVfZW50cmllcy4gVGhpcyB3b3VsZCBoYXZlIHJlc3VsdGVkIGluIHRoZSBjb2RlDQphbGxvY2F0
aW5nIG1hbnkgInRlbXBvcmFyeSIgY2FjaGVfZW50cmllcyBmcm9tIGEgcG9vbCwgYW5kIHRoZQ0K
bWVtb3J5IHdvdWxkIG5vdCBiZSBlbGlnaWJsZSB0byBiZSByZWNsYWltZWQgdW50aWwgdGhlIGVu
dGlyZQ0KbWVtb3J5IHBvb2wgd2FzIGZyZWVkIC0gYW5kIHRoaXMgd2FzIGEgdHJhZGVvZmYgd2Ug
ZGlkbid0IHdhbnQgdG8NCm1ha2UuDQoNCjIpIEluY2x1ZGUgYW4gZXh0cmEgZmllbGQgZW5jb2Rp
bmcgd2hldGhlciB0aGUgY2FjaGVfZW50cnkgd2FzDQogICBhbGxvY2F0ZWQgZnJvbSBhIG1lbW9y
eSBwb29sDQoNCiAgICBQcm86IHRoZSBkaXNjYXJkIGZ1bmN0aW9uIGNhbiBub3cgbWFrZSBhIGRl
Y2lzaW9uIHJlZ2FyZGluZyBob3cNCiAgICAgICAgIHRvIGZyZWUgdGhlIGNhY2hlX2VudHJ5DQog
ICAgQ29uOiBlYWNoIGNhY2hlIGVudHJ5IGdyb3dzIGJ5IGFuIGV4dHJhIGludCBmaWVsZC4NCg0K
VGhlIGJpdHMgaW4gdGhlIGV4aXN0aW5nIGNlX2ZsYWdzIGZpZWxkIGFyZSBhbGwgY2xhaW1lZCwg
c28gd2UNCm5lZWQgYW4gZXh0cmEgZmllbGQgdG8gdHJhY2sgdGhpcyBiaXQgb2YgaW5mb3JtYXRp
b24uIFdlIGNvdWxkDQpjbGFpbSBqdXN0IGEgYml0IGluIHRoZSBmaWVsZCBub3csIHdoaWNoIHdv
dWxkIHJlc3VsdCBpbiB0aGUNCmNhY2hlX2VudHJ5IHN0aWxsIGdyb3dpbmcgYnkgdGhlIHNhbWUg
YW1vdW50LCBidXQgYW55IGZ1dHVyZSBiaXRzDQp3b3VsZCBub3QgcmVxdWlyZSBleHRyYSBzcGFj
ZS4gVGhpcyBwdXNoZXMgb2ZmIHRoZSB3b3JrIGZvciBhbg0KYWN0dWFsIGJpdCBmaWVsZCBvZmYg
aW50byBmdXR1cmUgd29yay4NCg0KMykgRW5jb2RlIHdoZXRoZXIgdGhlIGNhY2hlX2VudHJ5IHdh
cyBhbGxvY2F0ZWQgZnJvbSBhIG1lbW9yeQ0KICAgcG9vbCBhcyBhIGJpdCBpbiBhIGZpZWxkLg0K
DQogICAgUHJvOiBvbmx5IGEgc2luZ2xlIGJpdCBpcyByZXF1aXJlZCB0byBlbmNvZGUgdGhpcyBp
bmZvcm1hdGlvbi4NCiAgICBDb246IEFsbCB0aGUgZXhpc3RpbmdzIGJpdHMgaW4gdGhlIGV4aXN0
aW5nIGNlX2ZsYWdzIGZpZWxkIGFyZQ0KICAgICAgICAgY2xhaW1lZC4gV2UgbmVlZCB0byBhZGQg
YW4gZXh0cmEgYml0IGZpZWxkIGFuZCB0YWtlIHRoZSBzYW1lDQogICAgICAgICBtZW1vcnkgZ3Jv
d3RoLg0KDQpJIGNvbnNpZGVyZWQgdGhpcyBhcHByb2FjaCAoYW5kIGFtIHN0aWxsIG9wZW4gdG8g
aXQpLCBidXQgSSB3ZW50DQpmb3IgYSBzaW1wbGVyIGluaXRpYWwgYXBwcm9hY2ggdG8gbWFrZSBz
dXJlIHRoZSBvdmVyYWxsIGNoYW5nZSBpcw0KYWNjZXB0YWJsZS4gVGhlcmUgaXMgbm8gZGlmZmVy
ZW5jZSBpbiB0aGUgbWVtb3J5IGZvb3RwcmludCB3aXRoDQp0aGlzIGNoYW5nZSwgc28gaXQgaXMg
b25seSB0byBlbmFibGUgZnV0dXJlIGNoYW5nZXMgbW9yZSBlYXNpbHkuDQoNCjQpIEluY2x1ZGUg
cG9pbnRlciB0byB0aGUgbWVtb3J5IHBvb2wgZnJvbSB3aGljaCB0aGlzIGNhY2hlX2VudHJ5DQog
ICB3YXMgY3JlYXRlZCBmcm9tDQoNCiAgICBQcm86IENvdWxkIChwb3RlbnRpYWxseSkgZG8gc29t
ZSBleHRyYSBib29ra2VlcGluZywgc3VjaCBhcw0KICAgICAgICAgYXV0b21hdGljYWxseSBjbGVh
bmluZyB1cCB0aGUgbWVtb3J5X3Bvb2wgd2hlbiBhbGwNCiAgICAgICAgIGFsbG9jYXRlZCBjYWNo
ZV9lbnRyaWVzIGFyZSBmcmVlZC4NCiAgICBDb246IGV4dHJhIGNvbXBsZXhpdHksIGxhcmdlciBn
cm93dGggdG8gY2FjaGVfZW50cnkgc3RydWN0IHRvDQogICAgICAgICBhY2NvbW1vZGF0ZSBtZW1f
cG9vbCBwb2ludGVyDQoNCkluIHRoZSBlbmQsIHdlIGRpZG4ndCBzZWUgYSB0YW5naWJsZSBiZW5l
Zml0IHRvIHRoaXMgb3B0aW9uIGF0IHRoaXMgcG9pbnQuDQoNCkdpdmVuIHRoZSB0cmFkZW9mZnMs
IEkgd2VudCB3aXRoIG9wdGlvbiAjMiBmb3Igbm93Lg0K
