Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FAA1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeIJVY0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 17:24:26 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:24001
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728052AbeIJVYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 17:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOXh5XhVajiT1JzqRe277GWeuBQHoiyLGEb0Xq0T2XA=;
 b=dgPvaElzbPohG6XQtJ1A69473UKzR+1G4DfsK+AGKnUrMpBY/3t+0A+smsmdWkNfce0xpbfQtkDUifpkpcJsfxfUQwbeu/mdFy/8v3+D6RzzBYItckH4TKtwWfV6udWWuo3MOU51MUesZEGCtie0ql5qGlGKtI9xQIrbCAJdxl0=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1018.namprd21.prod.outlook.com (52.132.146.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 16:29:29 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.006; Mon, 10 Sep 2018
 16:29:29 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] git-mv: allow submodules and fsmonitor to work together
Thread-Topic: [PATCH v1] git-mv: allow submodules and fsmonitor to work
 together
Thread-Index: AQHUSSNyk65u9mRVSEGSeG1QcB0VKw==
Date:   Mon, 10 Sep 2018 16:29:29 +0000
Message-ID: <20180910162911.31920-1-benpeart@microsoft.com>
References: <85d96d65-2e74-7877-80ab-f74fdb81d500@gmail.com>
In-Reply-To: <85d96d65-2e74-7877-80ab-f74fdb81d500@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: SN6PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:805:a2::35) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;6:gxH3NWxmVmGR5phJpkGjjMEhoZLUgUblFIpv9OL4XrgvYB12x2e217j0aus8r+sCWPBT9B7RZh3shPHjlTl1tzPf6QAZ0ADXM/qFwc/HVV9UOiLDg09Q5hQN4AXpvl4KuThFJLZ9hQOAH1AT3UqKFKPnRu/dkYS4JrsWTDK2yZxF1RSSEeUD/DPHymyNPQ2/Mp96qnkh+StQTiR4q6QEm+4p6VhGwubdId8y9kkJj/KgmlWlaXHzUoz2vbspeds+H+fGJZKyIpIb7E+xQ+ZZW+5WHixVeTgdNYGo/DVa8xQhDALG6r1R99BSu/n9gx+57SF6WGbiJLizfxivi/JJ4XutO2BUiPM3TQdtzAMPTQUEErjJX1165ajMqW2XFZ22IP5bdMSPqG/JPjsVNcs9z8I6pHinlkCo5xUrPHRvD8+I8P8441rhzKBp/aAo/pjd1Zlh35tcPjqPf8TXfPu0ug==;5:sSheM2Zp2rOh5Ko0l51hF/3VcextPTB8O2a+ssQ9JyXmF8pgyYy9y1vjSu/kXU4YtMjo3oHOfl6spfCDtHTXh7iOunfeY6zqoxPbJR1l9aaQFiCjDkWGqrWuYGrxylF7CJh+fH5em0F0JP8EyaFB269/x1SyfoHW147zvLNxiJk=;7:i2vkmjURLQXR72aotprvH5+nmK0QWhv8mZmAaBT010VY7gH98sfSdAHiShxOBxo4rBlJF0PVMmxuDRZYS+VcIdVBt3RarnRlhnXacI812PPXGvUm3WRhaBq+i1VbBCvxCSPY9tz/jx1dAPX/l4aZlZXa9Vh/aB2TXJOigd5XM5wm6A+8Hn4rE2mPqZmoS9wGBjOdF/56ZaMr4o7N+VbPIoWCD5SEd2GxoAFEZ3MtpRFmHEesZixsW4ThdDXmV9Ke
x-ms-office365-filtering-correlation-id: 338938af-e88a-419c-6aa7-08d6173a94a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB10186F322DEAD2A6501BBAA7F4050@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991033);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(25786009)(446003)(107886003)(4326008)(11346002)(2501003)(10290500003)(14444005)(68736007)(6916009)(256004)(1361003)(8936002)(39060400002)(54906003)(5250100002)(66066001)(2900100001)(50226002)(22452003)(14454004)(486006)(2351001)(106356001)(105586002)(316002)(72206003)(2616005)(478600001)(1411001)(5660300001)(5640700003)(966005)(6306002)(6436002)(6486002)(53936002)(476003)(97736004)(1076002)(26005)(6512007)(76176011)(7736002)(186003)(52116002)(305945005)(8676002)(102836004)(1730700003)(81156014)(81166006)(6506007)(386003)(6116002)(6346003)(3846002)(86612001)(2906002)(10090500001)(99286004)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: cC4u4MSTUxcqRfhiNPHJvdcqKUO08in4LaVEL62U7Kb/WEJIwCTn6IBcZu7feeWn3zmxfeo8jVe0ZLx33C9kak9kxGPbbQAY1cVHWrEdGZZAB6GjCnoLTQbmJD+NE8OuLj6XMnYpVSyPBVL4VhB+u3JrUgEGTQNxWyB1e2g+PVyfwR5jy3wkyyoy5ZOP0T9IkfGR+2t0pEAdKRZjThKmLfp1PX15sp2aNlCMEbb9bi08s1MCqBx8TyDLYVRHvKDrmNZm9y0rNLMu3oZ3aMKKDkVvVWhbrZGVmMhjiPbL6Ngz9y948k/d9KLiyw9O9J4E8mRqKp3EQ8vLXu2ftGVjp1T6s+udpP9KLgA925V18mI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2FEA683950AA34098A6F803A359D912@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338938af-e88a-419c-6aa7-08d6173a94a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 16:29:29.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SXQgd2FzIHJlcG9ydGVkIHRoYXQNCg0KICAgR0lUX0ZTTU9OSVRPUl9URVNUPSRQV0QvdDc1MTkv
ZnNtb25pdG9yLWFsbCAuL3Q3NDExLXN1Ym1vZHVsZS1jb25maWcuc2gNCg0KYnJlYWtzIGFzIHRo
ZSBmc21vbml0b3IgZGF0YSBpcyBvdXQgb2Ygc3luYyB3aXRoIHRoZSBzdGF0ZSBvZiB0aGUgLmdp
dG1vZHVsZXMNCmZpbGUuIFVwZGF0ZSBpc19zdGFnaW5nX2dpdG1vZHVsZXNfb2soKSBzbyB0aGF0
IGl0IG5vIGxvbmdlciB0ZWxscw0KaWVfbWF0Y2hfc3RhdCgpIHRvIGlnbm9yZSByZWZyZXNoaW5n
IHRoZSBmc21vbml0b3IgZGF0YS4NCg0KUmVwb3J0ZWQtYnk6IMOGdmFyIEFybmZqw7Zyw7AgQmph
cm1hc29uIDxhdmFyYWJAZ21haWwuY29tPg0KSGVscGVkLWJ5OiBTdGVmYW4gQmVsbGVyIDxzYmVs
bGVyQGdvb2dsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBCZW4gUGVhcnQgPGJlbnBlYXJ0QG1pY3Jv
c29mdC5jb20+DQotLS0NCg0KTm90ZXM6DQogICAgQmFzZSBSZWY6IHYyLjE5LjAtcmMyDQogICAg
V2ViLURpZmY6IGh0dHBzOi8vZ2l0aHViLmNvbS9iZW5wZWFydC9naXQvY29tbWl0L2VkMzBlMWE4
ODUNCiAgICBDaGVja291dDogZ2l0IGZldGNoIGh0dHBzOi8vZ2l0aHViLmNvbS9iZW5wZWFydC9n
aXQgZnNtb25pdG9yLXQ3NDExLXYxICYmIGdpdCBjaGVja291dCBlZDMwZTFhODg1DQoNCiBzdWJt
b2R1bGUuYyB8IDMgKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc3VibW9kdWxlLmMgYi9zdWJtb2R1bGUuYw0KaW5kZXgg
NTBjYmY1ZjEzZS4uMWU3MTk0YWYyOCAxMDA2NDQNCi0tLSBhL3N1Ym1vZHVsZS5jDQorKysgYi9z
dWJtb2R1bGUuYw0KQEAgLTY1LDggKzY1LDcgQEAgaW50IGlzX3N0YWdpbmdfZ2l0bW9kdWxlc19v
ayhzdHJ1Y3QgaW5kZXhfc3RhdGUgKmlzdGF0ZSkNCiAJaWYgKChwb3MgPj0gMCkgJiYgKHBvcyA8
IGlzdGF0ZS0+Y2FjaGVfbnIpKSB7DQogCQlzdHJ1Y3Qgc3RhdCBzdDsNCiAJCWlmIChsc3RhdChH
SVRNT0RVTEVTX0ZJTEUsICZzdCkgPT0gMCAmJg0KLQkJICAgIGllX21hdGNoX3N0YXQoaXN0YXRl
LCBpc3RhdGUtPmNhY2hlW3Bvc10sICZzdCwNCi0JCQkJICBDRV9NQVRDSF9JR05PUkVfRlNNT05J
VE9SKSAmIERBVEFfQ0hBTkdFRCkNCisJCSAgICBpZV9tYXRjaF9zdGF0KGlzdGF0ZSwgaXN0YXRl
LT5jYWNoZVtwb3NdLCAmc3QsIDApICYgREFUQV9DSEFOR0VEKQ0KIAkJCXJldHVybiAwOw0KIAl9
DQogDQoNCmJhc2UtY29tbWl0OiBjMDUwNDhkNDM5MjVhYjhlZGNiMzY2NjM3NTJjMmI0NTQxOTEx
MjMxDQotLSANCjIuMTguMC53aW5kb3dzLjENCg0K
