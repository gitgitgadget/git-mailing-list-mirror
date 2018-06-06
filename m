Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2901F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeFFLgf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:35 -0400
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:12016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751885AbeFFLga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM+Q8TcZq5hK22+uRfrFzc0R2CKkQqYf4TpK5iOfF1o=;
 b=bGO3oiUdhqxN8HcNrMJD4NaiPlRNGqfSFkFWkE13QaUTUXHpM0yulHLyRUQAhpIyAJprxFA7W4S25Wi1itIhI6fBUhirH+njsatwJwifdy8LobProlcKoiPGPFIm+i1Ex9o2wZzrdl855Gs6GQzalHtxvaOEE/nxUTLFvJsGaww=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:28 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:28 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 07/21] commit-graph: verify catches corrupt signature
Thread-Topic: [PATCH v5 07/21] commit-graph: verify catches corrupt signature
Thread-Index: AQHT/Yqbxlvp3eVCaUySZshHNGb25g==
Date:   Wed, 6 Jun 2018 11:36:28 +0000
Message-ID: <20180606113611.87822-8-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
In-Reply-To: <20180606113611.87822-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:403:1::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:niUY70BE+sObjDn9gZCaut2W14oNRqn0frVbMYD3PUcT3n7gNR7VATJ7S9P51Pj5WGFVn2iMkcgEHbLkomT+kv9MZA7Scdc5ZsNT8UzOo0p1V5IKCR9eJpjPIZIohh/YMSquOD4zI0b2dZTn86Iutp0hwHeUs6zpGuEdRrWDRYQbMmwSB6jEC1BTI6InZ6rMEBDkXgjVJvER02oAgocLHOhsTruXrHWLvumosfSbwRRvHZUW7+ejdlmNIo0k0ZA6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB104417B83DB4F72CB99557CBA1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(575784001)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e7xlGKjKHL0qi4yNjtwWEPK0/5TpTlsxKjO14lvlqMu6/Xc1nxZFuVNFBrOz6mxg4gxmpw9BjiroS3F6lnyKkda4Whmz3X7Lyz8BA/s2Chd9X/Z8ezAtK3vToBcRlbGgvjYVpnRgyrDnRBxbwDbmi5poI+flgcZ10ZlVc+G769KF3tbUKBRQMgJwoXk4A4i1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E505FD661F07B489472D38A6ED8E517@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d94fe385-11cf-4a10-c3fc-08d5cba1bdf1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94fe385-11cf-4a10-c3fc-08d5cba1bdf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:28.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
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
bW1pdC1ncmFwaC5zaCBiL3QvdDUzMTgtY29tbWl0LWdyYXBoLnNoDQppbmRleCAwODMwZWY5ZmRk
Li5jMGMxZmYwOWI5IDEwMDc1NQ0KLS0tIGEvdC90NTMxOC1jb21taXQtZ3JhcGguc2gNCisrKyBi
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
