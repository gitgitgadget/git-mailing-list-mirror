Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B991F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeFFLgx (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:53 -0400
Received: from mail-co1nam03on0126.outbound.protection.outlook.com ([104.47.40.126]:21958
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbeFFLgm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGtnpb/Hl1FgZiDjTm/uG88m3em1yB5UXKguCNt6GfQ=;
 b=mBcc0Zqnq7eAXV6HsI7MYmG2/BfqvPh6nrYzpy1OzCqLD8MYUtRL6+QVueh5xyEXVMUzh9pjT9Xr8lbGIi3SzlEKrowNspHHoVUa16fg46RFDqiipU5H9fN/h0jMJzdwgJt7mP2+hcAFY2lphkRDoydfzIJmmJp0it+q+C4U6W8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:39 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:39 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 20/21] gc: automatically write commit-graph files
Thread-Topic: [PATCH v5 20/21] gc: automatically write commit-graph files
Thread-Index: AQHT/YqiPtczRcOm3ECvxWELNN+J1A==
Date:   Wed, 6 Jun 2018 11:36:39 +0000
Message-ID: <20180606113611.87822-21-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:yw4+LOWEZIxBDbBYuakCgVcrij9BPbtjl7iqM2lde1f8Gn5YvEBwJTaQjVZawqD6Aq8XDis5JD6ttlL7aEmnTwVKUFNzCDQxgOBP2jTJADI8T+wLw/xluUTgowO2k71wSSvaigoNJvEJOzymreEumsw1aLJ1QtcBbyH+eEqGHaxl7LjW0lGtPAxEWHQdJl6+V8juHawzj51XdMCo/GtlVDBJXuWkasdB1oFOpWC41kg4+u7LGu2x4fbe31OAcJeZ
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10442FBB6F54877AE8660BF2A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cQIl6u54oHez0uMpzy7bLPuZLxacGjWuLVROkcmmVD56t+SzDgDyKrGu3L/5h2PznGBA44q0O0/raNgswNz3gf5lIXmd687ld6NFruwdlgoaMPTKdIk1bsWJQVP6MCVqWY42kF3GYiE6b7UbZ6jRWSnEHFQsHoAQeEZJaYWVbkihVbnlyhx+yojs8yVT8/wi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D1597508EE63E4EB99161512247EE70@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5c1a94e5-1fd2-46be-e59e-08d5cba1c4a7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1a94e5-1fd2-46be-e59e-08d5cba1c4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:39.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGNvbW1pdC1ncmFwaCBmaWxlIGlzIGEgdmVyeSBoZWxwZnVsIGZlYXR1cmUgZm9yIHNwZWVk
aW5nIHVwIGdpdA0Kb3BlcmF0aW9ucy4gSW4gb3JkZXIgdG8gbWFrZSBpdCBtb3JlIHVzZWZ1bCwg
bWFrZSBpdCBwb3NzaWJsZSB0bw0Kd3JpdGUgdGhlIGNvbW1pdC1ncmFwaCBmaWxlIGR1cmluZyBz
dGFuZGFyZCBnYXJiYWdlIGNvbGxlY3Rpb24NCm9wZXJhdGlvbnMuDQoNCkFkZCBhICdnYy5jb21t
aXRHcmFwaCcgY29uZmlnIHNldHRpbmcgdGhhdCB0cmlnZ2VycyB3cml0aW5nIGENCmNvbW1pdC1n
cmFwaCBmaWxlIGFmdGVyIGFueSBub24tdHJpdmlhbCAnZ2l0IGdjJyBjb21tYW5kLiBEZWZhdWx0
cyB0bw0KZmFsc2Ugd2hpbGUgdGhlIGNvbW1pdC1ncmFwaCBmZWF0dXJlIG1hdHVyZXMuIFdlIHNw
ZWNpZmljYWxseSBkbyBub3QNCndhbnQgdG8gaGF2ZSB0aGlzIG9uIGJ5IGRlZmF1bHQgdW50aWwg
dGhlIGNvbW1pdC1ncmFwaCBmZWF0dXJlIGlzIGZ1bGx5DQppbnRlZ3JhdGVkIHdpdGggaGlzdG9y
eS1tb2RpZnlpbmcgZmVhdHVyZXMgbGlrZSBzaGFsbG93IGNsb25lcy4NCg0KSGVscGVkLWJ5OiDD
hnZhciBBcm5masO2csOwIEJqYXJtYXNvbiA8YXZhcmFiQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IERlcnJpY2sgU3RvbGVlIDxkc3RvbGVlQG1pY3Jvc29mdC5jb20+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2NvbmZpZy50eHQgfCAxMCArKysrKysrKystDQogRG9jdW1lbnRhdGlvbi9naXQtZ2Mu
dHh0IHwgIDQgKysrKw0KIGJ1aWx0aW4vZ2MuYyAgICAgICAgICAgICB8ICA2ICsrKysrKw0KIHQv
dDUzMTgtY29tbWl0LWdyYXBoLnNoICB8IDE0ICsrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFu
Z2VkLCAzMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2NvbmZpZy50eHQgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQNCmluZGV4IGFi
NjQxYmY1YTkuLmYyYjVlZDE3YzggMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy50
eHQNCisrKyBiL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dA0KQEAgLTkwNiw3ICs5MDYsOCBAQCB0
aGUgYEdJVF9OT1RFU19SRUZgIGVudmlyb25tZW50IHZhcmlhYmxlLiAgU2VlIGxpbmtnaXQ6Z2l0
LW5vdGVzWzFdLg0KIA0KIGNvcmUuY29tbWl0R3JhcGg6Og0KIAlFbmFibGUgZ2l0IGNvbW1pdCBn
cmFwaCBmZWF0dXJlLiBBbGxvd3MgcmVhZGluZyBmcm9tIHRoZQ0KLQljb21taXQtZ3JhcGggZmls
ZS4NCisJY29tbWl0LWdyYXBoIGZpbGUuIFNlZSBgZ2MuY29tbWl0R3JhcGhgIGZvciBhdXRvbWF0
aWNhbGx5DQorCW1haW50YWluaW5nIHRoZSBmaWxlLg0KIA0KIGNvcmUuc3BhcnNlQ2hlY2tvdXQ6
Og0KIAlFbmFibGUgInNwYXJzZSBjaGVja291dCIgZmVhdHVyZS4gU2VlIHNlY3Rpb24gIlNwYXJz
ZSBjaGVja291dCIgaW4NCkBAIC0xNjQ3LDYgKzE2NDgsMTMgQEAgdGhpcyBjb25maWd1cmF0aW9u
IHZhcmlhYmxlIGlzIGlnbm9yZWQsIGFsbCBwYWNrcyBleGNlcHQgdGhlIGJhc2UgcGFjaw0KIHdp
bGwgYmUgcmVwYWNrZWQuIEFmdGVyIHRoaXMgdGhlIG51bWJlciBvZiBwYWNrcyBzaG91bGQgZ28g
YmVsb3cNCiBnYy5hdXRvUGFja0xpbWl0IGFuZCBnYy5iaWdQYWNrVGhyZXNob2xkIHNob3VsZCBi
ZSByZXNwZWN0ZWQgYWdhaW4uDQogDQorZ2MuY29tbWl0R3JhcGg6Og0KKwlJZiB0cnVlLCB0aGVu
IGdjIHdpbGwgcmV3cml0ZSB0aGUgY29tbWl0LWdyYXBoIGZpbGUgd2hlbg0KKwlsaW5rZ2l0Omdp
dC1nY1sxXSBpcyBydW4uIFdoZW4gdXNpbmcgbGlua2dpdDpnaXQtZ2NbMV0NCisJJy0tYXV0bycg
dGhlIGNvbW1pdC1ncmFwaCB3aWxsIGJlIHVwZGF0ZWQgaWYgaG91c2VrZWVwaW5nIGlzDQorCXJl
cXVpcmVkLiBEZWZhdWx0IGlzIGZhbHNlLiBTZWUgbGlua2dpdDpnaXQtY29tbWl0LWdyYXBoWzFd
DQorCWZvciBkZXRhaWxzLg0KKw0KIGdjLmxvZ0V4cGlyeTo6DQogCUlmIHRoZSBmaWxlIGdjLmxv
ZyBleGlzdHMsIHRoZW4gYGdpdCBnYyAtLWF1dG9gIHdvbid0IHJ1bg0KIAl1bmxlc3MgdGhhdCBm
aWxlIGlzIG1vcmUgdGhhbiAnZ2MubG9nRXhwaXJ5JyBvbGQuICBEZWZhdWx0IGlzDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtZ2MudHh0IGIvRG9jdW1lbnRhdGlvbi9naXQtZ2MudHh0
DQppbmRleCAyNGIyZGQ0NGZlLi5mNWJjOThjY2IzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlv
bi9naXQtZ2MudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2dpdC1nYy50eHQNCkBAIC0xMzYsNiAr
MTM2LDEwIEBAIFRoZSBvcHRpb25hbCBjb25maWd1cmF0aW9uIHZhcmlhYmxlIGBnYy5wYWNrUmVm
c2AgZGV0ZXJtaW5lcyBpZg0KIGl0IHdpdGhpbiBhbGwgbm9uLWJhcmUgcmVwb3Mgb3IgaXQgY2Fu
IGJlIHNldCB0byBhIGJvb2xlYW4gdmFsdWUuDQogVGhpcyBkZWZhdWx0cyB0byB0cnVlLg0KIA0K
K1RoZSBvcHRpb25hbCBjb25maWd1cmF0aW9uIHZhcmlhYmxlIGBnYy5jb21taXRHcmFwaGAgZGV0
ZXJtaW5lcyBpZg0KKydnaXQgZ2MnIHNob3VsZCBydW4gJ2dpdCBjb21taXQtZ3JhcGggd3JpdGUn
LiBUaGlzIGNhbiBiZSBzZXQgdG8gYQ0KK2Jvb2xlYW4gdmFsdWUuIFRoaXMgZGVmYXVsdHMgdG8g
ZmFsc2UuDQorDQogVGhlIG9wdGlvbmFsIGNvbmZpZ3VyYXRpb24gdmFyaWFibGUgYGdjLmFnZ3Jl
c3NpdmVXaW5kb3dgIGNvbnRyb2xzIGhvdw0KIG11Y2ggdGltZSBpcyBzcGVudCBvcHRpbWl6aW5n
IHRoZSBkZWx0YSBjb21wcmVzc2lvbiBvZiB0aGUgb2JqZWN0cyBpbg0KIHRoZSByZXBvc2l0b3J5
IHdoZW4gdGhlIC0tYWdncmVzc2l2ZSBvcHRpb24gaXMgc3BlY2lmaWVkLiAgVGhlIGxhcmdlcg0K
ZGlmZiAtLWdpdCBhL2J1aWx0aW4vZ2MuYyBiL2J1aWx0aW4vZ2MuYw0KaW5kZXggY2NmYjFjZWFl
Yi4uNGUwNmU4MzcyZCAxMDA2NDQNCi0tLSBhL2J1aWx0aW4vZ2MuYw0KKysrIGIvYnVpbHRpbi9n
Yy5jDQpAQCAtMjAsNiArMjAsNyBAQA0KICNpbmNsdWRlICJzaWdjaGFpbi5oIg0KICNpbmNsdWRl
ICJhcmd2LWFycmF5LmgiDQogI2luY2x1ZGUgImNvbW1pdC5oIg0KKyNpbmNsdWRlICJjb21taXQt
Z3JhcGguaCINCiAjaW5jbHVkZSAicGFja2ZpbGUuaCINCiAjaW5jbHVkZSAib2JqZWN0LXN0b3Jl
LmgiDQogI2luY2x1ZGUgInBhY2suaCINCkBAIC00MCw2ICs0MSw3IEBAIHN0YXRpYyBpbnQgYWdn
cmVzc2l2ZV9kZXB0aCA9IDUwOw0KIHN0YXRpYyBpbnQgYWdncmVzc2l2ZV93aW5kb3cgPSAyNTA7
DQogc3RhdGljIGludCBnY19hdXRvX3RocmVzaG9sZCA9IDY3MDA7DQogc3RhdGljIGludCBnY19h
dXRvX3BhY2tfbGltaXQgPSA1MDsNCitzdGF0aWMgaW50IGdjX2NvbW1pdF9ncmFwaCA9IDA7DQog
c3RhdGljIGludCBkZXRhY2hfYXV0byA9IDE7DQogc3RhdGljIHRpbWVzdGFtcF90IGdjX2xvZ19l
eHBpcmVfdGltZTsNCiBzdGF0aWMgY29uc3QgY2hhciAqZ2NfbG9nX2V4cGlyZSA9ICIxLmRheS5h
Z28iOw0KQEAgLTEyOSw2ICsxMzEsNyBAQCBzdGF0aWMgdm9pZCBnY19jb25maWcodm9pZCkNCiAJ
Z2l0X2NvbmZpZ19nZXRfaW50KCJnYy5hZ2dyZXNzaXZlZGVwdGgiLCAmYWdncmVzc2l2ZV9kZXB0
aCk7DQogCWdpdF9jb25maWdfZ2V0X2ludCgiZ2MuYXV0byIsICZnY19hdXRvX3RocmVzaG9sZCk7
DQogCWdpdF9jb25maWdfZ2V0X2ludCgiZ2MuYXV0b3BhY2tsaW1pdCIsICZnY19hdXRvX3BhY2tf
bGltaXQpOw0KKwlnaXRfY29uZmlnX2dldF9ib29sKCJnYy5jb21taXRncmFwaCIsICZnY19jb21t
aXRfZ3JhcGgpOw0KIAlnaXRfY29uZmlnX2dldF9ib29sKCJnYy5hdXRvZGV0YWNoIiwgJmRldGFj
aF9hdXRvKTsNCiAJZ2l0X2NvbmZpZ19nZXRfZXhwaXJ5KCJnYy5wcnVuZWV4cGlyZSIsICZwcnVu
ZV9leHBpcmUpOw0KIAlnaXRfY29uZmlnX2dldF9leHBpcnkoImdjLndvcmt0cmVlcHJ1bmVleHBp
cmUiLCAmcHJ1bmVfd29ya3RyZWVzX2V4cGlyZSk7DQpAQCAtNjQxLDYgKzY0NCw5IEBAIGludCBj
bWRfZ2MoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpwcmVmaXgpDQog
CWlmIChwYWNrX2dhcmJhZ2UubnIgPiAwKQ0KIAkJY2xlYW5fcGFja19nYXJiYWdlKCk7DQogDQor
CWlmIChnY19jb21taXRfZ3JhcGgpDQorCQl3cml0ZV9jb21taXRfZ3JhcGhfcmVhY2hhYmxlKGdl
dF9vYmplY3RfZGlyZWN0b3J5KCksIDApOw0KKw0KIAlpZiAoYXV0b19nYyAmJiB0b29fbWFueV9s
b29zZV9vYmplY3RzKCkpDQogCQl3YXJuaW5nKF8oIlRoZXJlIGFyZSB0b28gbWFueSB1bnJlYWNo
YWJsZSBsb29zZSBvYmplY3RzOyAiDQogCQkJInJ1biAnZ2l0IHBydW5lJyB0byByZW1vdmUgdGhl
bS4iKSk7DQpkaWZmIC0tZ2l0IGEvdC90NTMxOC1jb21taXQtZ3JhcGguc2ggYi90L3Q1MzE4LWNv
bW1pdC1ncmFwaC5zaA0KaW5kZXggZmZiMmVkN2M5NS4uYjI0ZThiNjY4OSAxMDA3NTUNCi0tLSBh
L3QvdDUzMTgtY29tbWl0LWdyYXBoLnNoDQorKysgYi90L3Q1MzE4LWNvbW1pdC1ncmFwaC5zaA0K
QEAgLTI0NSw2ICsyNDUsMjAgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAncGVyZm9ybSBmYXN0LWZv
cndhcmQgbWVyZ2UgaW4gZnVsbCByZXBvJyAnDQogCXRlc3RfY21wIGV4cGVjdCBvdXRwdXQNCiAn
DQogDQordGVzdF9leHBlY3Rfc3VjY2VzcyAnY2hlY2sgdGhhdCBnYyBjb21wdXRlcyBjb21taXQt
Z3JhcGgnICcNCisJY2QgIiRUUkFTSF9ESVJFQ1RPUlkvZnVsbCIgJiYNCisJZ2l0IGNvbW1pdCAt
LWFsbG93LWVtcHR5IC1tICJibGFuayIgJiYNCisJZ2l0IGNvbW1pdC1ncmFwaCB3cml0ZSAtLXJl
YWNoYWJsZSAmJg0KKwljcCAkb2JqZGlyL2luZm8vY29tbWl0LWdyYXBoIGNvbW1pdC1ncmFwaC1i
ZWZvcmUtZ2MgJiYNCisJZ2l0IHJlc2V0IC0taGFyZCBIRUFEfjEgJiYNCisJZ2l0IGNvbmZpZyBn
Yy5jb21taXRHcmFwaCB0cnVlICYmDQorCWdpdCBnYyAmJg0KKwljcCAkb2JqZGlyL2luZm8vY29t
bWl0LWdyYXBoIGNvbW1pdC1ncmFwaC1hZnRlci1nYyAmJg0KKwkhIHRlc3RfY21wIGNvbW1pdC1n
cmFwaC1iZWZvcmUtZ2MgY29tbWl0LWdyYXBoLWFmdGVyLWdjICYmDQorCWdpdCBjb21taXQtZ3Jh
cGggd3JpdGUgLS1yZWFjaGFibGUgJiYNCisJdGVzdF9jbXAgY29tbWl0LWdyYXBoLWFmdGVyLWdj
ICRvYmpkaXIvaW5mby9jb21taXQtZ3JhcGgNCisnDQorDQogIyB0aGUgdmVyaWZ5IHRlc3RzIGJl
bG93IGV4cGVjdCB0aGUgY29tbWl0LWdyYXBoIHRvIGNvbnRhaW4NCiAjIGV4YWN0bHkgdGhlIGNv
bW1pdHMgcmVhY2hhYmxlIGZyb20gdGhlIGNvbW1pdHMvOCBicmFuY2guDQogIyBJZiB0aGUgZmls
ZSBjaGFuZ2VzIHRoZSBzZXQgb2YgY29tbWl0cyBpbiB0aGUgbGlzdCwgdGhlbiB0aGUNCi0tIA0K
Mi4xOC4wLnJjMQ0KDQo=
