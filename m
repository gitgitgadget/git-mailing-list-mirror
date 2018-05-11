Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CE91F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeEKVPS (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:18 -0400
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:45388
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751012AbeEKVPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcJxniqAiSZHljdGiqjF2mMbxm/2LTYzxhhdZEvmBD8=;
 b=lMj184FsWP6CqjYQ7rlSz1BbqEBX8IjiTuO74WswMWelZoyU25TjXxq3i/1J9QtAVPanLkpoL5ieF4C223YjW06e9Up7zBaqftGjjgbj3LXHiqmSP/n/yrRgld0Qmac1ZERCnUBopz2oJczg/aZ265RS8c/KNQ29fgjJCaE8xX4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1060.namprd21.prod.outlook.com (52.132.24.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.3; Fri, 11 May 2018 21:15:14 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:14 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 00/12] Integrate commit-graph into fsck and gc
Thread-Topic: [PATCH v2 00/12] Integrate commit-graph into fsck and gc
Thread-Index: AQHT6W0mRJcyz76thE+CYS4s3bMzEw==
Date:   Fri, 11 May 2018 21:15:14 +0000
Message-ID: <20180511211504.79877-1-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com>
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:404:8e::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1060;7:cm2P+pOVzNJCmiEKiMtWEyMM5UZlPRARPJa60AR1b/0hSvWu2cpQynwHZOfIG809YY26P4gXh380EZTTb/Z7Eh02dQZmTV3sIBZp9XWqsPjL6+TJcaw9Xj5mocypBiMFqtpdWM19Ovc8zpTBHtSoiFoTbi/gaRIzYOcfMkvAvgxg8WNHDAUvI9C5HLZHMnNnAhqihSYLjOifCcNNFFYrDTKOCuRsa/P+cDqBH5Y8gSyi/e2EXeySOzNb0eUny9QH;20:PmnMW27MNUUty6ClIOrKuVY3oZ6iY02uDCswWPdeAymWvftPjH6Htu8qjlEdsfGQD3kHTgIt40xBI4QPSzG0NYGiLN8+7B08xgGPC/Dg7ZEqIkwwbxges0nyigkdpZ4twWMeEpF3FtRH2uiWGkI10hyCzaIjot3rWp87RPtMc0c=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1060;
x-ms-traffictypediagnostic: BL0PR2101MB1060:
x-microsoft-antispam-prvs: <BL0PR2101MB1060C9BAF770CA217DC0D6E8A19F0@BL0PR2101MB1060.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1060;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1060;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(2900100001)(2501003)(305945005)(68736007)(81166006)(106356001)(46003)(7736002)(3280700002)(105586002)(6486002)(107886003)(97736004)(99286004)(6116002)(25786009)(2351001)(53936002)(1730700003)(2906002)(8676002)(386003)(81156014)(10090500001)(8936002)(1076002)(36756003)(3660700001)(446003)(5250100002)(86362001)(6436002)(86612001)(5660300001)(52116002)(575784001)(10290500003)(102836004)(316002)(186003)(11346002)(2616005)(39060400002)(476003)(59450400001)(6916009)(486006)(5640700003)(6506007)(4326008)(478600001)(6512007)(14454004)(6346003)(54906003)(76176011)(22452003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1060;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: JhwMeE6dSyPs7zj076DbGhCUTmwOIVWSPJrgRueUf/DJwOBIg1aPN5UrPMXaS265Jk/ikGYKR6CAMXICRW/1iQEEMu8mVcd/BiHcwVab7s5J5XjV2ogp+pc4TPLyAAlfnsp78Nl55uSPf6e3O5bLXY2ZccWdNL4cPAeup6QNSQp7VkFobfDv3sef+KoKdJmD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <508F9FC9D4A98442B663431728ADC7F7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 276da625-af06-4016-b72b-08d5b7844927
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276da625-af06-4016-b72b-08d5b7844927
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:14.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1060
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSdtIHNlbmRpbmcgdGhpcyB2MiByZS1yb2xsIHJhdGhlciBxdWlja2x5IGFmdGVyIHRoZSBwcmV2
aW91cyB2ZXJzaW9uDQpiZWNhdXNlIE1hcnRpbiBwcm92aWRlZCBhIGZyYW1ld29yayB0byBhZGQg
dGVzdHMgdG8gdGhlICd2ZXJpZnknDQpzdWJjb21tYW5kLiBJIHRvb2sgdGhhdCBmcmFtZXdvcmsg
YW5kIGFkZGVkIHRlc3RzIGZvciB0aGUgb3RoZXIgY2hlY2tzDQpvZiB0aGUgY29tbWl0LWdyYXBo
IGRhdGEuIFRoaXMgYWxzbyBmb3VuZCBzb21lIGludGVyZXN0aW5nIHRoaW5ncyBhYm91dA0KdGhl
IGNvbW1hbmQ6DQoNCjEuIFRoZXJlIHdlcmUgc29tZSBzZWdmYXVsdHMgYmVjYXVzZSB3ZSB3ZXJl
IG5vdCBjaGVja2luZyBmb3IgYmFkIGRhdGENCiAgIGNhcmVmdWxseSBlbm91Z2guDQoNCjIuIFRv
IGF2b2lkIHNlZ2ZhdWx0cywgd2Ugd2lsbCBub3cgdGVybWluYXRlIHRoZSBjaGVjayBlYXJseSBp
ZiB3ZSBmaW5kDQogICBwcm9ibGVtcyBlYXJsaWVyIGluIHRoZSBmaWxlLCBzdWNoIGFzIGluIHRo
ZSBoZWFkZXIsIG9yIE9JRCBsb29rdXAuDQoNCjMuIFdlIHdlcmUgbm90IHdyaXRpbmcgbmV3bGlu
ZXMgYmV0d2VlbiByZXBvcnRzLiBUaGlzIG5vdyBoYXBwZW5zIGJ5DQogICBkZWZhdWx0IGluIGdy
YXBoX3JlcG9ydCgpLg0KDQpUaGUgaW50ZWdyYXRpb24gaW50byAnZmV0Y2gnIGlzIGRyb3BwZWQg
KHRoYW5rcyDDhnZhciEpLg0KDQpEZXJyaWNrIFN0b2xlZSAoMTIpOg0KICBjb21taXQtZ3JhcGg6
IGFkZCAndmVyaWZ5JyBzdWJjb21tYW5kDQogIGNvbW1pdC1ncmFwaDogdmVyaWZ5IGZpbGUgaGVh
ZGVyIGluZm9ybWF0aW9uDQogIGNvbW1pdC1ncmFwaDogdGVzdCB0aGF0ICd2ZXJpZnknIGZpbmRz
IGNvcnJ1cHRpb24NCiAgY29tbWl0LWdyYXBoOiBwYXJzZSBjb21taXQgZnJvbSBjaG9zZW4gZ3Jh
cGgNCiAgY29tbWl0LWdyYXBoOiB2ZXJpZnkgZmFub3V0IGFuZCBsb29rdXAgdGFibGUNCiAgY29t
bWl0OiBmb3JjZSBjb21taXQgdG8gcGFyc2UgZnJvbSBvYmplY3QgZGF0YWJhc2UNCiAgY29tbWl0
LWdyYXBoOiBsb2FkIGEgcm9vdCB0cmVlIGZyb20gc3BlY2lmaWMgZ3JhcGgNCiAgY29tbWl0LWdy
YXBoOiB2ZXJpZnkgY29tbWl0IGNvbnRlbnRzIGFnYWluc3Qgb2RiDQogIGZzY2s6IHZlcmlmeSBj
b21taXQtZ3JhcGgNCiAgY29tbWl0LWdyYXBoOiBhZGQgJy0tcmVhY2hhYmxlJyBvcHRpb24NCiAg
Z2M6IGF1dG9tYXRpY2FsbHkgd3JpdGUgY29tbWl0LWdyYXBoIGZpbGVzDQogIGNvbW1pdC1ncmFw
aDogdXBkYXRlIGRlc2lnbiBkb2N1bWVudA0KDQogRG9jdW1lbnRhdGlvbi9jb25maWcudHh0ICAg
ICAgICAgICAgICAgICB8ICAgNiArDQogRG9jdW1lbnRhdGlvbi9naXQtY29tbWl0LWdyYXBoLnR4
dCAgICAgICB8ICAxNCArKy0NCiBEb2N1bWVudGF0aW9uL2dpdC1mc2NrLnR4dCAgICAgICAgICAg
ICAgIHwgICAzICsNCiBEb2N1bWVudGF0aW9uL2dpdC1nYy50eHQgICAgICAgICAgICAgICAgIHwg
ICA0ICsNCiBEb2N1bWVudGF0aW9uL3RlY2huaWNhbC9jb21taXQtZ3JhcGgudHh0IHwgIDIyIC0t
LS0NCiBidWlsdGluL2NvbW1pdC1ncmFwaC5jICAgICAgICAgICAgICAgICAgIHwgIDgxICsrKysr
KysrKysrKy0NCiBidWlsdGluL2ZzY2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIx
ICsrKysNCiBidWlsdGluL2djLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICsr
DQogY29tbWl0LWdyYXBoLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE5OSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystDQogY29tbWl0LWdyYXBoLmggICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMiArDQogY29tbWl0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxMyArLQ0KIGNvbW1pdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDEgKw0KIHQvdDUzMTgtY29tbWl0LWdyYXBoLnNoICAgICAgICAgICAgICAgICAgfCAxNzMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMTMgZmlsZXMgY2hhbmdlZCwgNTA5IGluc2Vy
dGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KDQoNCmJhc2UtY29tbWl0OiAzNGZkZDQzMzM5NmVl
MGUzZWY0ZGUwMmViMjE4OWY4MjI2ZWFmZTRlDQotLSANCjIuMTYuMi4zMjkuZ2ZiNjIzOTVkZTYN
Cg0K
