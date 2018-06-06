Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C60D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeFFLgX (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:23 -0400
Received: from mail-by2nam01on0105.outbound.protection.outlook.com ([104.47.34.105]:53888
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751828AbeFFLgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCBWESZJrLpSW+rV7KMkcj7k1aYj0jbh8s2c30+7K3I=;
 b=Bk9+ZB85lI38HDqxDt6vWFEmR6io5jtM8ceRPQrbgia70AEV14HgVmb8JlylVrsvIuM+MfLN6STMK+QcKq4A6kovl5hsb2f+LbtcS4ns9eYwwDQzMKVqby6Cm488TNvQfqZxxmP+1diAR80GbxR0qhe8U4AOCWHPHRYb8kS6/tY=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1075.namprd21.prod.outlook.com (52.132.24.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:20 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:20 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 00/21] Integrate commit-graph into 'fsck' and 'gc'
Thread-Topic: [PATCH v5 00/21] Integrate commit-graph into 'fsck' and 'gc'
Thread-Index: AQHT/YqWQGp5VfH5UUe1Vwh3iDUQ1g==
Date:   Wed, 6 Jun 2018 11:36:20 +0000
Message-ID: <20180606113611.87822-1-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1075;7:8zlsCqUfVErW6E9YM6wJqcIcNwXSTegFUozZmLuvlOhXicnLNG6Cxbsz/68rsMkDKIMZ1mB10jQ3NZdZFMB5zA8n9ZaKV53EVFrQKSfvJ+CuE15GoUROF5jW3h4ZK8KJZ6aQPkCM3CCML/JJEPS6zPcVJQnLQxeHYTxj2jYW0USf+z1jxrv1YO5BNM8nyf22Kd3aM4jndav94ru0aXOgEgP3JOZTUqnuhi9KIEsBb3SExbezVLSiEncfPBaUb6it
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1075;
x-ms-traffictypediagnostic: BL0PR2101MB1075:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1075B584ADC6292CFDFF548BA1650@BL0PR2101MB1075.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1075;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(376002)(396003)(189003)(199004)(99286004)(476003)(22452003)(14454004)(8936002)(6916009)(97736004)(2351001)(5660300001)(486006)(6116002)(81166006)(86362001)(478600001)(8656006)(1730700003)(81156014)(54906003)(6436002)(446003)(86612001)(2616005)(5640700003)(10290500003)(8676002)(1076002)(11346002)(316002)(6486002)(186003)(4326008)(3280700002)(305945005)(25786009)(53936002)(59450400001)(105586002)(10090500001)(106356001)(2900100001)(7736002)(3660700001)(46003)(2906002)(6506007)(39060400002)(68736007)(386003)(36756003)(76176011)(102836004)(52116002)(107886003)(2501003)(6512007)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1075;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sYi4OlnTeYcEkDM8Py52f3HHyWm4pm5qkJWGrbi7m6YlsKn74+suoq2mm6nIzyGrvND6W4vAiljUvEm5wM1prQTljsWEd0tAE5CO989j0ScGWApt4TR97lqdrsvJxbDOEJNR+tSwubf57V2jO3OEH+FiXstAM3Pwqayk4KmEnLNOdy3pQUpDSsuP6bbo0qeR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <709BCEC0D09B0B4B8ACC30E1B6142514@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0c88ec5b-921e-407d-b251-08d5cba1b8fe
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c88ec5b-921e-407d-b251-08d5cba1b8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:20.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1075
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLCDDhnZhciwgZm9yIHBvaW50aW5nIG91dCB0aGF0IEkgZm9yZ290IHRvIHJlYmFzZSBv
bnRvICduZXh0Jy4NCg0KVGhlcmUgd2VyZSBhIGZldyBjb2xsaXNpb25zIHdpdGggdGhlIG9iamVj
dC1zdG9yZSByZWZhY3RvcmluZy4gSnVuaW8NCmV2ZW4gcG9pbnRlZCB0aGVtIG91dCwgc28gSSdt
IHNvcnJ5IHRvIGZvcmdldCB0aGF0LiBJIGFsc28gZGlkIGEgdGVzdA0KbWVyZ2Ugd2l0aCAncHUn
IGFuZCBpdCBzZWVtcyB0aGUgb25seSBjb25mbGljdHMgYXJlIHdpdGggdGhlIGVhcmxpZXINCnZl
cnNpb24gb2YgdGhpcyBwYXRjaC4NCg0KVGhhbmtzLA0KLVN0b2xlZQ0KDQpEZXJyaWNrIFN0b2xl
ZSAoMjEpOg0KICBjb21taXQtZ3JhcGg6IFVOTEVBSyBiZWZvcmUgZGllKCkNCiAgY29tbWl0LWdy
YXBoOiBmaXggR1JBUEhfTUlOX1NJWkUNCiAgY29tbWl0LWdyYXBoOiBwYXJzZSBjb21taXQgZnJv
bSBjaG9zZW4gZ3JhcGgNCiAgY29tbWl0OiBmb3JjZSBjb21taXQgdG8gcGFyc2UgZnJvbSBvYmpl
Y3QgZGF0YWJhc2UNCiAgY29tbWl0LWdyYXBoOiBsb2FkIGEgcm9vdCB0cmVlIGZyb20gc3BlY2lm
aWMgZ3JhcGgNCiAgY29tbWl0LWdyYXBoOiBhZGQgJ3ZlcmlmeScgc3ViY29tbWFuZA0KICBjb21t
aXQtZ3JhcGg6IHZlcmlmeSBjYXRjaGVzIGNvcnJ1cHQgc2lnbmF0dXJlDQogIGNvbW1pdC1ncmFw
aDogdmVyaWZ5IHJlcXVpcmVkIGNodW5rcyBhcmUgcHJlc2VudA0KICBjb21taXQtZ3JhcGg6IHZl
cmlmeSBjb3JydXB0IE9JRCBmYW5vdXQgYW5kIGxvb2t1cA0KICBjb21taXQtZ3JhcGg6IHZlcmlm
eSBvYmplY3RzIGV4aXN0DQogIGNvbW1pdC1ncmFwaDogdmVyaWZ5IHJvb3QgdHJlZSBPSURzDQog
IGNvbW1pdC1ncmFwaDogdmVyaWZ5IHBhcmVudCBsaXN0DQogIGNvbW1pdC1ncmFwaDogdmVyaWZ5
IGdlbmVyYXRpb24gbnVtYmVyDQogIGNvbW1pdC1ncmFwaDogdmVyaWZ5IGNvbW1pdCBkYXRlDQog
IGNvbW1pdC1ncmFwaDogdGVzdCBmb3IgY29ycnVwdGVkIG9jdG9wdXMgZWRnZQ0KICBjb21taXQt
Z3JhcGg6IHZlcmlmeSBjb250ZW50cyBtYXRjaCBjaGVja3N1bQ0KICBmc2NrOiB2ZXJpZnkgY29t
bWl0LWdyYXBoDQogIGNvbW1pdC1ncmFwaDogdXNlIHN0cmluZy1saXN0IEFQSSBmb3IgaW5wdXQN
CiAgY29tbWl0LWdyYXBoOiBhZGQgJy0tcmVhY2hhYmxlJyBvcHRpb24NCiAgZ2M6IGF1dG9tYXRp
Y2FsbHkgd3JpdGUgY29tbWl0LWdyYXBoIGZpbGVzDQogIGNvbW1pdC1ncmFwaDogdXBkYXRlIGRl
c2lnbiBkb2N1bWVudA0KDQogRG9jdW1lbnRhdGlvbi9jb25maWcudHh0ICAgICAgICAgICAgICAg
ICB8ICAxMCArLQ0KIERvY3VtZW50YXRpb24vZ2l0LWNvbW1pdC1ncmFwaC50eHQgICAgICAgfCAg
MTQgKy0NCiBEb2N1bWVudGF0aW9uL2dpdC1mc2NrLnR4dCAgICAgICAgICAgICAgIHwgICAzICsN
CiBEb2N1bWVudGF0aW9uL2dpdC1nYy50eHQgICAgICAgICAgICAgICAgIHwgICA0ICsNCiBEb2N1
bWVudGF0aW9uL3RlY2huaWNhbC9jb21taXQtZ3JhcGgudHh0IHwgIDIyIC0tDQogYnVpbHRpbi9j
b21taXQtZ3JhcGguYyAgICAgICAgICAgICAgICAgICB8ICA5OCArKysrKystLS0NCiBidWlsdGlu
L2ZzY2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIxICsrDQogYnVpbHRpbi9nYy5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArDQogY29tbWl0LWdyYXBoLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDI0OCArKysrKysrKysrKysrKysrKysrKystLQ0KIGNv
bW1pdC1ncmFwaC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCiBjb21taXQu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICstDQogY29tbWl0LmggICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogdC90NTMxOC1jb21taXQtZ3Jh
cGguc2ggICAgICAgICAgICAgICAgICB8IDIwMSArKysrKysrKysrKysrKysrKysNCiAxMyBmaWxl
cyBjaGFuZ2VkLCA1NjkgaW5zZXJ0aW9ucygrKSwgNzggZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4x
OC4wLnJjMQ0KDQo=
