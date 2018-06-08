Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E370B1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeFHN50 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:57:26 -0400
Received: from mail-eopbgr730113.outbound.protection.outlook.com ([40.107.73.113]:7405
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752608AbeFHN4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=san8W9nZUGOzph6eVJ75903bAnT7nqcj1UAbX++4EWs=;
 b=ecoHi34Bfa5CFDtbugD3FCScX8YLRNbANkcAce+WKlrGFHIoJy+E2IRv8/8WzPNDugj5Wt7o/gOlxNE8u/Y8xEX+y9TF2FCgGE/ojUg6y491mpUklsXSZlThhtZs3MRw4P2HHX5QBhf4ejFCdU5NtY8kf19hCJMCoKMIBrLgoV8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:18 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:18 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 07/21] commit-graph: verify catches corrupt signature
Thread-Topic: [PATCH v6 07/21] commit-graph: verify catches corrupt signature
Thread-Index: AQHT/zB5TMRj0Sf59kWLEgdMKO9DVA==
Date:   Fri, 8 Jun 2018 13:56:18 +0000
Message-ID: <20180608135548.216405-8-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:404:f7::33) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;7:NqsPEPAB5PQU1qN5HvphBakRTT8i5pHodWlwkdjaMlekkfcGU5Fux1cO2aoONOw+N4vk8Pz60iHInsAy8GOMHEe2Gpjhs4d4lRbCX9t4IwuDzbDux4gc4SJxyJfbD7ZgDWewmWGdQzDPrViqolkg6zOMw+J6nvGCSZBzPtwe9ESOjn9FkUl+tj8GS8H4qpCBhgqDewFyOzKcfop8P1Vfpjl/GsvBJVHhcXvtYPGELApJOlN/VUB9pUNj3jpI7g5n
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0979B0B056E349BC21BE68CDA17B0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(36756003)(8676002)(10290500003)(22452003)(2351001)(81166006)(1730700003)(8656006)(99286004)(5660300001)(6916009)(97736004)(14454004)(6116002)(305945005)(478600001)(5640700003)(86362001)(81156014)(476003)(316002)(54906003)(6486002)(6436002)(7736002)(2616005)(86612001)(1076002)(186003)(3660700001)(2906002)(386003)(59450400001)(76176011)(6506007)(105586002)(46003)(2900100001)(4326008)(446003)(3280700002)(25786009)(15650500001)(102836004)(106356001)(68736007)(2501003)(39060400002)(6512007)(11346002)(8936002)(10090500001)(52116002)(107886003)(5250100002)(53936002)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FJY+4ADUp523VCsaqfZIp2SrOH0qCUBM2KlXZsLdBRPAtAl4WsyBnj5gCPw5Pe/dOKN4/ZfVQApXjEAiiLqUZzpHrkLH+4ijuGxwDkc1xDZEfrsZNbuKpLhEkoyerQLj6ur+LNUS4X8MWX1mHTWvt5Rupl3/ghaukG6PqqvX64j+VTDK4+xtVHwcJcSqgj5p
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <975A7880474B144C9E63F8EB0CDFD6A3@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fae3a1f6-4479-40a5-338b-08d5cd479bac
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae3a1f6-4479-40a5-338b-08d5cd479bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:18.5382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhpcyBpcyB0aGUgZmlyc3Qgb2Ygc2V2ZXJhbCBjb21taXRzIHRoYXQgYWRkIGEgdGVzdCB0byBj
aGVjayB0aGF0DQonZ2l0IGNvbW1pdC1ncmFwaCB2ZXJpZnknIGNhdGNoZXMgY29ycnVwdGlvbiBp
biB0aGUgY29tbWl0LWdyYXBoDQpmaWxlLiBUaGUgZmlyc3QgdGVzdCBjaGVja3MgdGhhdCB0aGUg
Y29tbWFuZCBjYXRjaGVzIGFuIGVycm9yIGluDQp0aGUgZmlsZSBzaWduYXR1cmUuIFRoaXMgaXMg
YSBjaGVjayB0aGF0IGV4aXN0cyBpbiB0aGUgZXhpc3RpbmcNCmNvbW1pdC1ncmFwaCByZWFkaW5n
IGNvZGUuDQoNCkFkZCBhIGhlbHBlciBtZXRob2QgJ2NvcnJ1cHRfZ3JhcGhfYW5kX3ZlcmlmeScg
dG8gdGhlIHRlc3Qgc2NyaXB0DQp0NTMxOC1jb21taXQtZ3JhcGguc2guIFRoaXMgaGVscGVyIGNv
cnJ1cHRzIHRoZSBjb21taXQtZ3JhcGggZmlsZQ0KYXQgYSBjZXJ0YWluIGxvY2F0aW9uLCBydW5z
ICdnaXQgY29tbWl0LWdyYXBoIHZlcmlmeScsIGFuZCByZXBvcnRzDQp0aGUgb3V0cHV0IHRvIHRo
ZSAnZXJyJyBmaWxlLiBUaGlzIGRhdGEgaXMgZmlsdGVyZWQgdG8gcmVtb3ZlIHRoZQ0KbGluZXMg
YWRkZWQgYnkgJ3Rlc3RfbXVzdF9mYWlsJyB3aGVuIHRoZSB0ZXN0IGlzIHJ1biB2ZXJib3NlbHku
DQpUaGVuLCB0aGUgb3V0cHV0IGlzIGNoZWNrZWQgdG8gY29udGFpbiBhIHNwZWNpZmljIGVycm9y
IG1lc3NhZ2UuDQoNCk1vc3QgbWVzc2FnZXMgZnJvbSAnZ2l0IGNvbW1pdC1ncmFwaCB2ZXJpZnkn
IHdpbGwgbm90IGJlIG1hcmtlZA0KZm9yIHRyYW5zbGF0aW9uLiBUaGVyZSB3aWxsIGJlIG9uZSBl
eGNlcHRpb246IHRoZSBtZXNzYWdlIHRoYXQNCnJlcG9ydHMgYW4gaW52YWxpZCBjaGVja3N1bSB3
aWxsIGJlIG1hcmtlZCBmb3IgdHJhbnNsYXRpb24sIGFzIHRoYXQNCmlzIHRoZSBvbmx5IG1lc3Nh
Z2UgdGhhdCBpcyBpbnRlbmRlZCBmb3IgYSB0eXBpY2FsIHVzZXIuDQoNCkhlbHBlZC1ieTogU3pl
ZGVyIEfDoWJvciA8c3plZGVyLmRldkBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBEZXJyaWNr
IFN0b2xlZSA8ZHN0b2xlZUBtaWNyb3NvZnQuY29tPg0KLS0tDQogdC90NTMxOC1jb21taXQtZ3Jh
cGguc2ggfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS90L3Q1MzE4LWNv
bW1pdC1ncmFwaC5zaCBiL3QvdDUzMTgtY29tbWl0LWdyYXBoLnNoDQppbmRleCA2Y2E0NTFkZmQy
Li44Zjk2ZTI2MzZjIDEwMDc1NQ0KLS0tIGEvdC90NTMxOC1jb21taXQtZ3JhcGguc2gNCisrKyBi
L3QvdDUzMTgtY29tbWl0LWdyYXBoLnNoDQpAQCAtMjM1LDkgKzIzNSw1MiBAQCB0ZXN0X2V4cGVj
dF9zdWNjZXNzICdwZXJmb3JtIGZhc3QtZm9yd2FyZCBtZXJnZSBpbiBmdWxsIHJlcG8nICcNCiAJ
dGVzdF9jbXAgZXhwZWN0IG91dHB1dA0KICcNCiANCisjIHRoZSB2ZXJpZnkgdGVzdHMgYmVsb3cg
ZXhwZWN0IHRoZSBjb21taXQtZ3JhcGggdG8gY29udGFpbg0KKyMgZXhhY3RseSB0aGUgY29tbWl0
cyByZWFjaGFibGUgZnJvbSB0aGUgY29tbWl0cy84IGJyYW5jaC4NCisjIElmIHRoZSBmaWxlIGNo
YW5nZXMgdGhlIHNldCBvZiBjb21taXRzIGluIHRoZSBsaXN0LCB0aGVuIHRoZQ0KKyMgb2Zmc2V0
cyBpbnRvIHRoZSBiaW5hcnkgZmlsZSB3aWxsIHJlc3VsdCBpbiBkaWZmZXJlbnQgZWRpdHMNCisj
IGFuZCB0aGUgdGVzdHMgd2lsbCBsaWtlbHkgYnJlYWsuDQorDQogdGVzdF9leHBlY3Rfc3VjY2Vz
cyAnZ2l0IGNvbW1pdC1ncmFwaCB2ZXJpZnknICcNCiAJY2QgIiRUUkFTSF9ESVJFQ1RPUlkvZnVs
bCIgJiYNCisJZ2l0IHJldi1wYXJzZSBjb21taXRzLzggfCBnaXQgY29tbWl0LWdyYXBoIHdyaXRl
IC0tc3RkaW4tY29tbWl0cyAmJg0KIAlnaXQgY29tbWl0LWdyYXBoIHZlcmlmeSA+b3V0cHV0DQog
Jw0KIA0KK0dSQVBIX0JZVEVfVkVSU0lPTj00DQorR1JBUEhfQllURV9IQVNIPTUNCisNCisjIHVz
YWdlOiBjb3JydXB0X2dyYXBoX2FuZF92ZXJpZnkgPHBvc2l0aW9uPiA8ZGF0YT4gPHN0cmluZz4N
CisjIE1hbmlwdWxhdGVzIHRoZSBjb21taXQtZ3JhcGggZmlsZSBhdCB0aGUgcG9zaXRpb24NCisj
IGJ5IGluc2VydGluZyB0aGUgZGF0YSwgdGhlbiBydW5zICdnaXQgY29tbWl0LWdyYXBoIHZlcmlm
eScNCisjIGFuZCBwbGFjZXMgdGhlIG91dHB1dCBpbiB0aGUgZmlsZSAnZXJyJy4gVGVzdCAnZXJy
JyBmb3INCisjIHRoZSBnaXZlbiBzdHJpbmcuDQorY29ycnVwdF9ncmFwaF9hbmRfdmVyaWZ5KCkg
ew0KKwlwb3M9JDENCisJZGF0YT0iJHsyOi1cMH0iDQorCWdyZXBzdHI9JDMNCisJY2QgIiRUUkFT
SF9ESVJFQ1RPUlkvZnVsbCIgJiYNCisJdGVzdF93aGVuX2ZpbmlzaGVkIG12IGNvbW1pdC1ncmFw
aC1iYWNrdXAgJG9iamRpci9pbmZvL2NvbW1pdC1ncmFwaCAmJg0KKwljcCAkb2JqZGlyL2luZm8v
Y29tbWl0LWdyYXBoIGNvbW1pdC1ncmFwaC1iYWNrdXAgJiYNCisJcHJpbnRmICIkZGF0YSIgfCBk
ZCBvZj0iJG9iamRpci9pbmZvL2NvbW1pdC1ncmFwaCIgYnM9MSBzZWVrPSIkcG9zIiBjb252PW5v
dHJ1bmMgJiYNCisJdGVzdF9tdXN0X2ZhaWwgZ2l0IGNvbW1pdC1ncmFwaCB2ZXJpZnkgMj50ZXN0
X2VyciAmJg0KKwlncmVwIC12ICJeKyIgdGVzdF9lcnIgPmVycg0KKwl0ZXN0X2kxOG5ncmVwICIk
Z3JlcHN0ciIgZXJyDQorfQ0KKw0KK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2RldGVjdCBiYWQgc2ln
bmF0dXJlJyAnDQorCWNvcnJ1cHRfZ3JhcGhfYW5kX3ZlcmlmeSAwICJcMCIgXA0KKwkJImdyYXBo
IHNpZ25hdHVyZSINCisnDQorDQordGVzdF9leHBlY3Rfc3VjY2VzcyAnZGV0ZWN0IGJhZCB2ZXJz
aW9uJyAnDQorCWNvcnJ1cHRfZ3JhcGhfYW5kX3ZlcmlmeSAkR1JBUEhfQllURV9WRVJTSU9OICJc
MDIiIFwNCisJCSJncmFwaCB2ZXJzaW9uIg0KKycNCisNCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdk
ZXRlY3QgYmFkIGhhc2ggdmVyc2lvbicgJw0KKwljb3JydXB0X2dyYXBoX2FuZF92ZXJpZnkgJEdS
QVBIX0JZVEVfSEFTSCAiXDAyIiBcDQorCQkiaGFzaCB2ZXJzaW9uIg0KKycNCisNCiB0ZXN0X2Rv
bmUNCi0tIA0KMi4xOC4wLnJjMQ0KDQo=
