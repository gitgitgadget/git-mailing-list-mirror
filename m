Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E3C1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeFFLhj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:37:39 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:22720
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751912AbeFFLg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX+swzDctrL0y1U7LX6CaICybm842OAodyTZeopB6FU=;
 b=TVxm+NUOWwULgMq6OUURN0tVwUL2GOUu7MtxtiES8oyB9wQqsZPGV6TV/TgxfdaiWVCKeOW3gtMbRUNPGZB1gAyQREa3w/5RMpFIYhTnFc5cDR5UdPkrq6/ppBo64WN86lRD9pbshszkIGnmIYnwpdfM0d4HQflqkm9fBAtcxRM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1075.namprd21.prod.outlook.com (52.132.24.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:24 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:24 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 02/21] commit-graph: fix GRAPH_MIN_SIZE
Thread-Topic: [PATCH v5 02/21] commit-graph: fix GRAPH_MIN_SIZE
Thread-Index: AQHT/YqYBE0gRic+NE+EgR3DYnbpbA==
Date:   Wed, 6 Jun 2018 11:36:24 +0000
Message-ID: <20180606113611.87822-3-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1075;7:PJdblfNKDuYp8MfxoxTQEh/BAfAtn1htmG4u+uKlBkr83tIEHquAEKWuET+P6sMWTHLW8u7utkMrO/oVlTPSQ0C1TfMm1T5a81qF2kHJ12M/pAkf/8ThygqBHndsSqrse6/7lQ+igs8HkMOt8JnZ79X6VdsUmmA9ZAJD/Po7aDK0fnCypixlykRjaqLd1W6f8hGTIzZwKWBls9nR7k8Vov9hz9uCr1bF8uFoz1PSmeN3hTEc1Zb/bPigVeBBU7pS
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1075;
x-ms-traffictypediagnostic: BL0PR2101MB1075:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10759E6CD95934934DFE4C75A1650@BL0PR2101MB1075.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1075;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(376002)(396003)(189003)(199004)(99286004)(476003)(22452003)(14454004)(8936002)(6916009)(97736004)(2351001)(5660300001)(486006)(6116002)(81166006)(86362001)(478600001)(8656006)(1730700003)(81156014)(54906003)(6436002)(446003)(86612001)(2616005)(5640700003)(10290500003)(8676002)(1076002)(11346002)(316002)(6486002)(186003)(4326008)(3280700002)(305945005)(25786009)(53936002)(105586002)(10090500001)(106356001)(2900100001)(7736002)(3660700001)(46003)(2906002)(6506007)(39060400002)(68736007)(386003)(36756003)(76176011)(102836004)(52116002)(107886003)(2501003)(6512007)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1075;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LDL59YD9BwADYpPKolr6+Ld+96/4OHKfy9Lln3lXNirUFIu1LqJ/fq41t5wfN+gR+nmrOHXQ4PMtd3zngQpPg3GxcIIMf4/El8cQRbs2nIa3tqEqkbeOkYmrwhXDHR/cY+ygmS3TKxthsbZNMf1BIdLgD5dCUGBMh6/Xs5RplM32Ec91K4UjsEFHRZ21LbnL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 435c8a53-2ca3-4249-53b6-08d5cba1bb61
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435c8a53-2ca3-4249-53b6-08d5cba1bb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:24.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1075
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GRAPH_MIN_SIZE macro should be the smallest size of a parsable
commit-graph file. However, the minimum number of chunks was wrong.
It is possible to write a commit-graph file with zero commits, and
that violates this macro's value.

Rewrite the macro, and use extra macros to better explain the magic
constants.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b63a1fc85e..f83f6d2373 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -35,10 +35,11 @@
=20
 #define GRAPH_LAST_EDGE 0x80000000
=20
+#define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
-#define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + =
\
-			GRAPH_OID_LEN + 8)
+#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
+			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
=20
 char *get_commit_graph_filename(const char *obj_dir)
 {
--=20
2.18.0.rc1

