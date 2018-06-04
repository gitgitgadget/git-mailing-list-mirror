Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C451F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeFDQxG (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:53:06 -0400
Received: from mail-co1nam03on0098.outbound.protection.outlook.com ([104.47.40.98]:45074
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751481AbeFDQxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUnuEhi+otbb9FmhFnv3kZGi9fR4XB8Tu2iZ4IlwT2Y=;
 b=OCcQHAwUAjWGuDo/fbiSURMekuLFT7DVQ4Uwmy9DXJXczFpbBFhZ1Q9BKRxHZY3eM75jE1uGCVYYuCMVRap+s3UowAO/55kjepc2NeCKnbiQTlU7gi6bHiYZ5cx0I/bUr33fu0/eeEe7zFHv2SJL0n95y/ZbjSn9Ip/T0c/9354=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:53:02 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:53:02 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 20/21] gc: automatically write commit-graph files
Thread-Topic: [PATCH v4 20/21] gc: automatically write commit-graph files
Thread-Index: AQHT/CR/Idge04XxPEqYAi/xMMGFSA==
Date:   Mon, 4 Jun 2018 16:53:01 +0000
Message-ID: <20180604165200.29261-21-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:KKkZn5ZT2Y0KGGUMroV29TwhO7LHT6sPxCNKE6jCPa+W3xFFGb3g1aRQvNvRw9xWdLdrpaBLgn66oyW+XzJCiYJ9VwwYBtdHbvfBfAiAahbDoIEI/XO1XoH9iceNDG5KOvcARlqi0ZXDixh/lPzKAs/FQ4zUkC8g33C0gttwAuiTv1qMFoFsrN5jUXYEGx1YTy63l/f5xXwLI+J5C0ZqdCSqzVxJ0PHrIob37OuSEIReYSrTSXIG0wbeHMqZzuFC;20:CiOgrdxmVujkx7kcaY3CTtRyD8CUZanzSEcHII00QuRmqOJ5fHGsN+G3Tj7rmu56iKpPibeJq+4SgjVgKTrgvHkK0ooRJkXhSJDlYhYGjb+olIwIIzz7JuUMVHxozHrh+ona10X860B2SF8ZclETOnFXQh6zRUf0958bV4AsTgU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB112938F7397873D647C1F6F7A1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(1496009)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(6486002)(486006)(446003)(46003)(476003)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kt7zTtoh8HvyJeCEUjU9o1Au0Rg6cs0aruCkK3eLnjq9NA6ns3ChG6tuvuJK8LsCh3kJgl+Lg/E+pTzK6lgOP/xGmP58RxptF0r7rFgm+UOFAtuttFsnwpN9gP/A6x1tqi9LMoxz48962UHeQLH05pE9rktRhj85VsXog4C9ZpnBElvQxTpa3QNfDTnk5N3u
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <203C7EA3A14CA84F8BA0558805579ACC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2e022f4a-70ab-4fed-41aa-08d5ca3ba216
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e022f4a-70ab-4fed-41aa-08d5ca3ba216
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:53:01.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
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
bWVudGF0aW9uL2NvbmZpZy50eHQgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQNCmluZGV4IDEx
ZjAyNzE5NGUuLmQyZWIzYzhlOWIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy50
eHQNCisrKyBiL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dA0KQEAgLTkwMCw3ICs5MDAsOCBAQCB0
aGUgYEdJVF9OT1RFU19SRUZgIGVudmlyb25tZW50IHZhcmlhYmxlLiAgU2VlIGxpbmtnaXQ6Z2l0
LW5vdGVzWzFdLg0KIA0KIGNvcmUuY29tbWl0R3JhcGg6Og0KIAlFbmFibGUgZ2l0IGNvbW1pdCBn
cmFwaCBmZWF0dXJlLiBBbGxvd3MgcmVhZGluZyBmcm9tIHRoZQ0KLQljb21taXQtZ3JhcGggZmls
ZS4NCisJY29tbWl0LWdyYXBoIGZpbGUuIFNlZSBgZ2MuY29tbWl0R3JhcGhgIGZvciBhdXRvbWF0
aWNhbGx5DQorCW1haW50YWluaW5nIHRoZSBmaWxlLg0KIA0KIGNvcmUuc3BhcnNlQ2hlY2tvdXQ6
Og0KIAlFbmFibGUgInNwYXJzZSBjaGVja291dCIgZmVhdHVyZS4gU2VlIHNlY3Rpb24gIlNwYXJz
ZSBjaGVja291dCIgaW4NCkBAIC0xNTUzLDYgKzE1NTQsMTMgQEAgZ2MuYXV0b0RldGFjaDo6DQog
CU1ha2UgYGdpdCBnYyAtLWF1dG9gIHJldHVybiBpbW1lZGlhdGVseSBhbmQgcnVuIGluIGJhY2tn
cm91bmQNCiAJaWYgdGhlIHN5c3RlbSBzdXBwb3J0cyBpdC4gRGVmYXVsdCBpcyB0cnVlLg0KIA0K
K2djLmNvbW1pdEdyYXBoOjoNCisJSWYgdHJ1ZSwgdGhlbiBnYyB3aWxsIHJld3JpdGUgdGhlIGNv
bW1pdC1ncmFwaCBmaWxlIHdoZW4NCisJbGlua2dpdDpnaXQtZ2NbMV0gaXMgcnVuLiBXaGVuIHVz
aW5nIGxpbmtnaXQ6Z2l0LWdjWzFdDQorCSctLWF1dG8nIHRoZSBjb21taXQtZ3JhcGggd2lsbCBi
ZSB1cGRhdGVkIGlmIGhvdXNla2VlcGluZyBpcw0KKwlyZXF1aXJlZC4gRGVmYXVsdCBpcyBmYWxz
ZS4gU2VlIGxpbmtnaXQ6Z2l0LWNvbW1pdC1ncmFwaFsxXQ0KKwlmb3IgZGV0YWlscy4NCisNCiBn
Yy5sb2dFeHBpcnk6Og0KIAlJZiB0aGUgZmlsZSBnYy5sb2cgZXhpc3RzLCB0aGVuIGBnaXQgZ2Mg
LS1hdXRvYCB3b24ndCBydW4NCiAJdW5sZXNzIHRoYXQgZmlsZSBpcyBtb3JlIHRoYW4gJ2djLmxv
Z0V4cGlyeScgb2xkLiAgRGVmYXVsdCBpcw0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ2l0
LWdjLnR4dCBiL0RvY3VtZW50YXRpb24vZ2l0LWdjLnR4dA0KaW5kZXggNTcxYjVhN2UzYy4uYTY1
MjZiMzU5MiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LWdjLnR4dA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9naXQtZ2MudHh0DQpAQCAtMTE5LDYgKzExOSwxMCBAQCBUaGUgb3B0aW9uYWwg
Y29uZmlndXJhdGlvbiB2YXJpYWJsZSBgZ2MucGFja1JlZnNgIGRldGVybWluZXMgaWYNCiBpdCB3
aXRoaW4gYWxsIG5vbi1iYXJlIHJlcG9zIG9yIGl0IGNhbiBiZSBzZXQgdG8gYSBib29sZWFuIHZh
bHVlLg0KIFRoaXMgZGVmYXVsdHMgdG8gdHJ1ZS4NCiANCitUaGUgb3B0aW9uYWwgY29uZmlndXJh
dGlvbiB2YXJpYWJsZSBgZ2MuY29tbWl0R3JhcGhgIGRldGVybWluZXMgaWYNCisnZ2l0IGdjJyBz
aG91bGQgcnVuICdnaXQgY29tbWl0LWdyYXBoIHdyaXRlJy4gVGhpcyBjYW4gYmUgc2V0IHRvIGEN
Citib29sZWFuIHZhbHVlLiBUaGlzIGRlZmF1bHRzIHRvIGZhbHNlLg0KKw0KIFRoZSBvcHRpb25h
bCBjb25maWd1cmF0aW9uIHZhcmlhYmxlIGBnYy5hZ2dyZXNzaXZlV2luZG93YCBjb250cm9scyBo
b3cNCiBtdWNoIHRpbWUgaXMgc3BlbnQgb3B0aW1pemluZyB0aGUgZGVsdGEgY29tcHJlc3Npb24g
b2YgdGhlIG9iamVjdHMgaW4NCiB0aGUgcmVwb3NpdG9yeSB3aGVuIHRoZSAtLWFnZ3Jlc3NpdmUg
b3B0aW9uIGlzIHNwZWNpZmllZC4gIFRoZSBsYXJnZXINCmRpZmYgLS1naXQgYS9idWlsdGluL2dj
LmMgYi9idWlsdGluL2djLmMNCmluZGV4IDc3ZmE3MjBiZDAuLmVmZDIxNGE1OWYgMTAwNjQ0DQot
LS0gYS9idWlsdGluL2djLmMNCisrKyBiL2J1aWx0aW4vZ2MuYw0KQEAgLTIwLDYgKzIwLDcgQEAN
CiAjaW5jbHVkZSAiYXJndi1hcnJheS5oIg0KICNpbmNsdWRlICJjb21taXQuaCINCiAjaW5jbHVk
ZSAicGFja2ZpbGUuaCINCisjaW5jbHVkZSAiY29tbWl0LWdyYXBoLmgiDQogDQogI2RlZmluZSBG
QUlMRURfUlVOICJmYWlsZWQgdG8gcnVuICVzIg0KIA0KQEAgLTM0LDYgKzM1LDcgQEAgc3RhdGlj
IGludCBhZ2dyZXNzaXZlX2RlcHRoID0gNTA7DQogc3RhdGljIGludCBhZ2dyZXNzaXZlX3dpbmRv
dyA9IDI1MDsNCiBzdGF0aWMgaW50IGdjX2F1dG9fdGhyZXNob2xkID0gNjcwMDsNCiBzdGF0aWMg
aW50IGdjX2F1dG9fcGFja19saW1pdCA9IDUwOw0KK3N0YXRpYyBpbnQgZ2NfY29tbWl0X2dyYXBo
ID0gMDsNCiBzdGF0aWMgaW50IGRldGFjaF9hdXRvID0gMTsNCiBzdGF0aWMgdGltZXN0YW1wX3Qg
Z2NfbG9nX2V4cGlyZV90aW1lOw0KIHN0YXRpYyBjb25zdCBjaGFyICpnY19sb2dfZXhwaXJlID0g
IjEuZGF5LmFnbyI7DQpAQCAtMTIxLDYgKzEyMyw3IEBAIHN0YXRpYyB2b2lkIGdjX2NvbmZpZyh2
b2lkKQ0KIAlnaXRfY29uZmlnX2dldF9pbnQoImdjLmFnZ3Jlc3NpdmVkZXB0aCIsICZhZ2dyZXNz
aXZlX2RlcHRoKTsNCiAJZ2l0X2NvbmZpZ19nZXRfaW50KCJnYy5hdXRvIiwgJmdjX2F1dG9fdGhy
ZXNob2xkKTsNCiAJZ2l0X2NvbmZpZ19nZXRfaW50KCJnYy5hdXRvcGFja2xpbWl0IiwgJmdjX2F1
dG9fcGFja19saW1pdCk7DQorCWdpdF9jb25maWdfZ2V0X2Jvb2woImdjLmNvbW1pdGdyYXBoIiwg
JmdjX2NvbW1pdF9ncmFwaCk7DQogCWdpdF9jb25maWdfZ2V0X2Jvb2woImdjLmF1dG9kZXRhY2gi
LCAmZGV0YWNoX2F1dG8pOw0KIAlnaXRfY29uZmlnX2dldF9leHBpcnkoImdjLnBydW5lZXhwaXJl
IiwgJnBydW5lX2V4cGlyZSk7DQogCWdpdF9jb25maWdfZ2V0X2V4cGlyeSgiZ2Mud29ya3RyZWVw
cnVuZWV4cGlyZSIsICZwcnVuZV93b3JrdHJlZXNfZXhwaXJlKTsNCkBAIC00ODAsNiArNDgzLDkg
QEAgaW50IGNtZF9nYyhpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnBy
ZWZpeCkNCiAJaWYgKHBhY2tfZ2FyYmFnZS5uciA+IDApDQogCQljbGVhbl9wYWNrX2dhcmJhZ2Uo
KTsNCiANCisJaWYgKGdjX2NvbW1pdF9ncmFwaCkNCisJCXdyaXRlX2NvbW1pdF9ncmFwaF9yZWFj
aGFibGUoZ2V0X29iamVjdF9kaXJlY3RvcnkoKSwgMCk7DQorDQogCWlmIChhdXRvX2djICYmIHRv
b19tYW55X2xvb3NlX29iamVjdHMoKSkNCiAJCXdhcm5pbmcoXygiVGhlcmUgYXJlIHRvbyBtYW55
IHVucmVhY2hhYmxlIGxvb3NlIG9iamVjdHM7ICINCiAJCQkicnVuICdnaXQgcHJ1bmUnIHRvIHJl
bW92ZSB0aGVtLiIpKTsNCmRpZmYgLS1naXQgYS90L3Q1MzE4LWNvbW1pdC1ncmFwaC5zaCBiL3Qv
dDUzMTgtY29tbWl0LWdyYXBoLnNoDQppbmRleCBmZmIyZWQ3Yzk1Li5iMjRlOGI2Njg5IDEwMDc1
NQ0KLS0tIGEvdC90NTMxOC1jb21taXQtZ3JhcGguc2gNCisrKyBiL3QvdDUzMTgtY29tbWl0LWdy
YXBoLnNoDQpAQCAtMjQ1LDYgKzI0NSwyMCBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzICdwZXJmb3Jt
IGZhc3QtZm9yd2FyZCBtZXJnZSBpbiBmdWxsIHJlcG8nICcNCiAJdGVzdF9jbXAgZXhwZWN0IG91
dHB1dA0KICcNCiANCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdjaGVjayB0aGF0IGdjIGNvbXB1dGVz
IGNvbW1pdC1ncmFwaCcgJw0KKwljZCAiJFRSQVNIX0RJUkVDVE9SWS9mdWxsIiAmJg0KKwlnaXQg
Y29tbWl0IC0tYWxsb3ctZW1wdHkgLW0gImJsYW5rIiAmJg0KKwlnaXQgY29tbWl0LWdyYXBoIHdy
aXRlIC0tcmVhY2hhYmxlICYmDQorCWNwICRvYmpkaXIvaW5mby9jb21taXQtZ3JhcGggY29tbWl0
LWdyYXBoLWJlZm9yZS1nYyAmJg0KKwlnaXQgcmVzZXQgLS1oYXJkIEhFQUR+MSAmJg0KKwlnaXQg
Y29uZmlnIGdjLmNvbW1pdEdyYXBoIHRydWUgJiYNCisJZ2l0IGdjICYmDQorCWNwICRvYmpkaXIv
aW5mby9jb21taXQtZ3JhcGggY29tbWl0LWdyYXBoLWFmdGVyLWdjICYmDQorCSEgdGVzdF9jbXAg
Y29tbWl0LWdyYXBoLWJlZm9yZS1nYyBjb21taXQtZ3JhcGgtYWZ0ZXItZ2MgJiYNCisJZ2l0IGNv
bW1pdC1ncmFwaCB3cml0ZSAtLXJlYWNoYWJsZSAmJg0KKwl0ZXN0X2NtcCBjb21taXQtZ3JhcGgt
YWZ0ZXItZ2MgJG9iamRpci9pbmZvL2NvbW1pdC1ncmFwaA0KKycNCisNCiAjIHRoZSB2ZXJpZnkg
dGVzdHMgYmVsb3cgZXhwZWN0IHRoZSBjb21taXQtZ3JhcGggdG8gY29udGFpbg0KICMgZXhhY3Rs
eSB0aGUgY29tbWl0cyByZWFjaGFibGUgZnJvbSB0aGUgY29tbWl0cy84IGJyYW5jaC4NCiAjIElm
IHRoZSBmaWxlIGNoYW5nZXMgdGhlIHNldCBvZiBjb21taXRzIGluIHRoZSBsaXN0LCB0aGVuIHRo
ZQ0KLS0gDQoyLjE4LjAucmMxDQoNCg==
