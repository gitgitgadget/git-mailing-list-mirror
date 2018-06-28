Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924A11F597
	for <e@80x24.org>; Thu, 28 Jun 2018 14:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966314AbeF1OHM (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:07:12 -0400
Received: from mail-cys01nam02on0127.outbound.protection.outlook.com ([104.47.37.127]:62944
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965506AbeF1OHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypfFTp3ZbuUvem18+Qqnt0wEYXoPAVDSVzeTN1E+6AY=;
 b=iLVDP879gvUrnLfOm0cQ29FhcdIXeG6a6lgTvaItMc5y31oupjgH6WayLY3oQAm5SKQG7afjbK83++7iEClneDP8tzGhTIx61tO/vkghWp12ZjdXErXloMretNblKEjBA+EUXlZz9dp2YomUZFNUzGbzwYi/R+/XjwZiBnWg6Cw=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0859.namprd21.prod.outlook.com (10.173.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Thu, 28 Jun 2018 14:07:09 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:07:09 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Stefan Beller <sbeller@google.com>
CC:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Subject: RE: [PATCH v4 2/8] block alloc: add lifecycle APIs for cache_entry
 structs
Thread-Topic: [PATCH v4 2/8] block alloc: add lifecycle APIs for cache_entry
 structs
Thread-Index: AQHUCNO0A6Z/n+Lts0SNWA9/28CLcqRrOCQAgAqHIRA=
Date:   Thu, 28 Jun 2018 14:07:09 +0000
Message-ID: <DM5PR21MB07808CBB6B7E7AF816CC435BCE4F0@DM5PR21MB0780.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180620201557.77155-1-jamill@microsoft.com>
 <20180620201557.77155-3-jamill@microsoft.com>
 <CAGZ79katH2Kk2NDDyZjYzC9fEKS6cDdHK1Cw2JLjjSfmYOPapw@mail.gmail.com>
In-Reply-To: <CAGZ79katH2Kk2NDDyZjYzC9fEKS6cDdHK1Cw2JLjjSfmYOPapw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-28T14:07:07.4438567Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:e2c7:22eb:b533:fb94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0859;7:S4mlX0dEHF5XR/yrQg78Hs0eqSZkI+q/jixzoTLUAtT/qHv4xIJMtQHqav9c4enZ+aSI0JZdkfhdVin47RWkSbaiSJVDydWM/JkKYaE+c436vzb4cX5Yxzf/x0jTFTZ6h886bxxeBL9h2XY2sRqXYyhIKb1AfU34d3EF7D6etc2qDYmTcCLkhnVz1YxqnTVWxhTLLcJFWyI+aBkDPalIgTRtThFA68PccLh9kIo4gsMVidHKge9Mwenu/DFuKuo+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a81a2ab9-0931-4649-71d1-08d5dd007028
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0859;
x-ms-traffictypediagnostic: DM5PR21MB0859:
x-microsoft-antispam-prvs: <DM5PR21MB08597076DC64E5559B3ADCB9CE4F0@DM5PR21MB0859.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231270)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0859;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0859;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(10290500003)(46003)(106356001)(6506007)(478600001)(5250100002)(105586002)(7736002)(54906003)(305945005)(7696005)(68736007)(14454004)(22452003)(74316002)(33656002)(76176011)(93886005)(186003)(81156014)(6916009)(25786009)(2906002)(53936002)(8936002)(39060400002)(55016002)(316002)(9686003)(6246003)(81166006)(256004)(4326008)(6116002)(486006)(10090500001)(476003)(97736004)(102836004)(5660300001)(2900100001)(446003)(8990500004)(6346003)(86362001)(8676002)(6436002)(86612001)(99286004)(229853002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0859;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: RPHaGxz66Bdt1mw9Gwoh1xcxSa8xc6ta5tokleIRcKcdjGQhO+nG5NKQ9x8m+1H70RNv7Wcxyo1XBWDdtZkHzLrvJ82GVpH/8MRnjHvj3yRghyR/z1wMX+v9Iz5OwV3YtSB61JSk4Efle8r6lwfQvT8X3yF1ko94XDW52f2t/6sd0mpO1ZDkXz6FUN2aojW/vtF+Ikd+1DpBGsHQZDWvr0rjWe/GHYM9UW+SDie639q86JLrGXGe7CHuwLkISbKdNLL3cIBv3QzCkG4FR34DrCNqL1DwKyPjB9OAcfspBas/9W5D7qN8WOqnad9qxZOGwT7zH0yhQYI+mfUI/GIsHQyW4td8AXOCZxrG+bxtoac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81a2ab9-0931-4649-71d1-08d5dd007028
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:07:09.3009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0859
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBIb3cgbXVjaCB3b3JrIGlzIGl0IHRvIGNvbnZlcnQgdGhlc2UgdG8gb2JqZWN0X2lkIHdoaWxl
IGF0IGl0IGluc3RlYWQgb2YgY2hhcg0KPiAqc2hhMT8NCj4gKEkgdGhpbmsgd2UgcmVhbGx5IGRp
c2xpa2UgaW50cm9kdWNpbmcgbmV3IHNoYTEgYmFzZWQgY29kZTsgSWYgaXQgZG9lc24ndCBzb3Vu
ZA0KPiBlYXN5IG1heWJlIHdlIGNhbiBoYXZlIGEgc3RhdGljIGlubGluZSB3cmFwcGVyIGhlcmUg
dGhhdCBqdXN0IGNvbnZlcnRzIG9pZCB0bw0KPiBzaGExIGFuZCB0aGVuIGNhbGxzIHRoaXMgZnVu
Y3Rpb24/KQ0KDQpJIGhhdmUgbWFkZSB0aGlzIGNoYW5nZSBpbiBteSBsYXRlc3QgcGF0Y2ggc2Vy
aWVzIHdpdGggMGFjNDhmM2FmNyAoInJlYWQtY2FjaGU6IG1ha2VfY2FjaGVfZW50cnkgc2hvdWxk
IHRha2Ugb2JqZWN0X2lkIHN0cnVjdCIsIDIwMTgtMDYtMjIpDQoNCj4gDQo+IElzIGl0IHBvc3Np
YmxlIHRvIGxpbmUgYnJlYWsgdGhlc2UgZnVuY3Rpb25zIChjLmYuIHJlZnMuaCB3aGljaCBJIHRo
aW5rIGhhcyBvbmUgb2YgdGhlDQo+IGJlc3Qgc3R5bGVzIGluIHRoZSBnaXQgcHJvamVjdC4gSXQg
aGFzIGxvbmcgcGFyYW1ldGVyIGxpc3RzLCBidXQgc3RpbGwgbWFuYWdlcyB0byBzdGF5DQo+IGJl
bG93IGEgcmVhc29uYWJsZSBsaW5lIGxlbmd0aCkgPw0KPiANCj4gPiArZXh0ZXJuIHN0cnVjdCBj
YWNoZV9lbnRyeSAqbWFrZV9lbXB0eV9jYWNoZV9lbnRyeShzdHJ1Y3QgaW5kZXhfc3RhdGUNCj4g
PiArKmlzdGF0ZSwgc2l6ZV90IG5hbWVfbGVuKTsNCj4gDQoNCkkgaGF2ZSBmb3JtYXR0ZWQgdGhl
IGZ1bmN0aW9uIGRlY2xhcmF0aW9ucyB0byBicmVhayB0aGVtIHVwDQoNCj4gPiArDQo+ID4gKy8q
DQo+ID4gKyAqIENyZWF0ZSBhIGNhY2hlX2VudHJ5IHRoYXQgaXMgbm90IGludGVuZGVkIHRvIGJl
IGFkZGVkIHRvIGFuIGluZGV4Lg0KPiA+ICsgKiBDYWxsZXIgaXMgcmVzcG9uc2libGUgZm9yIGRp
c2NhcmRpbmcgdGhlIGNhY2hlX2VudHJ5DQo+ID4gKyAqIHdpdGggYGRpc2NhcmRfY2FjaGVfZW50
cnlgLg0KPiA+ICsgKi8NCj4gPiArZXh0ZXJuIHN0cnVjdCBjYWNoZV9lbnRyeSAqbWFrZV90cmFu
c2llbnRfY2FjaGVfZW50cnkodW5zaWduZWQgaW50DQo+ID4gK21vZGUsIGNvbnN0IHVuc2lnbmVk
IGNoYXIgKnNoYTEsIGNvbnN0IGNoYXIgKnBhdGgsIGludCBzdGFnZSk7IGV4dGVybg0KPiA+ICtz
dHJ1Y3QgY2FjaGVfZW50cnkgKm1ha2VfZW1wdHlfdHJhbnNpZW50X2NhY2hlX2VudHJ5KHNpemVf
dA0KPiA+ICtuYW1lX2xlbik7DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBEaXNjYXJkIGNhY2hl
IGVudHJ5Lg0KPiA+ICsgKi8NCj4gPiArdm9pZCBkaXNjYXJkX2NhY2hlX2VudHJ5KHN0cnVjdCBj
YWNoZV9lbnRyeSAqY2UpOw0KPiANCj4gUGxlYXNlIGJlIGNvbnNpc3RlbnQgaW4gdGhlIHVzZSBv
ZiB0aGUgZXh0ZXJuIGtleXdvcmQgYW5kIG9taXQgdGhlbSBhdCBhbGwgdGltZXMNCj4gaGVyZSBh
bmQgYWJvdmUuDQoNClRoZSBoZWFkZXIgZmlsZSBpcyBhIGJpdCBpbmNvbnNpc3RlbnQgb3ZlcmFs
bCwgYnV0IEkgc3dpdGNoZWQgbXkgZGVjbGFyYXRpb25zIHRvIG5vdCB1c2UgdGhlIGV4dGVybiBr
ZXl3b3JkLg0KDQoNCg0K
