Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514C91F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEKVPa (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:30 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:6848
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751853AbeEKVPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9vSqnqhAZzwr0eP038Q5FzH7cmm+hf3kfNdzQasT8M=;
 b=kHCaiY3IgaZYaDPsmZGg/qArsWFW5SDL1HRCy0o3YJwM/EFe5ERcnhP3IVGwUFPhn6I2KOYcTSvbUY54Pc+9hYkUB2duyje+Nf051iQJvI6qLJr/Lg9YXYlEnuYXvL1PV7mkxrwHO7OCjHAITMpB37gqGQmXzJJliHGR8hT4H/I=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:18 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:18 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 04/12] commit-graph: parse commit from chosen graph
Thread-Topic: [PATCH v2 04/12] commit-graph: parse commit from chosen graph
Thread-Index: AQHT6W0pBZG3aYAFiEazloqxC5W50g==
Date:   Fri, 11 May 2018 21:15:18 +0000
Message-ID: <20180511211504.79877-5-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
In-Reply-To: <20180511211504.79877-1-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:UYMr2Q8i1yxdgFNLzJklm/W9db17svb16rbEm3zfWLqyjKdhYg/JG4RRToGSjtah8KYH2qKj3Fz9bm7iVljTBQXuhRdhdGtMZfpMiywG0TSJjliXSXEMddY0oYbMwW41nejquRursK7yqI56IgpihF4AvmURRZOKmfrFu2ptDHqYCsvBV18vfzzrs5hRElUnXlweU69v5ig/P0JBysVfc8Qfh4QvR4Y3UaAIUmJC/Cdo5DnzJmtOBBRRRLN5nx0N;20:vrBQBjw+IXuMbAhrD7CTbD9WnlJM6iAHkzF6mM0ofogrGnJksK0MfYvpCBAJ4eWpmO/oL5SoSW5LbELl/ou9Cxip5q5d9VWK9f2N4UvSnqOKV83vVMTSAr9OsCpgXULLB583FJYcVDhfOBv9L2srkyO9f+OWRS8qOUJs3s2ph2c=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB109108A86A59FB45C65771F0A19F0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(22452003)(39060400002)(53936002)(6116002)(305945005)(107886003)(68736007)(7736002)(46003)(2900100001)(97736004)(4326008)(3660700001)(36756003)(86362001)(3280700002)(10090500001)(8936002)(1730700003)(81156014)(6512007)(316002)(8676002)(86612001)(1076002)(25786009)(54906003)(99286004)(81166006)(106356001)(10290500003)(2616005)(5640700003)(476003)(102836004)(6346003)(446003)(486006)(5250100002)(6916009)(478600001)(6486002)(2351001)(386003)(6506007)(11346002)(76176011)(5660300001)(14454004)(6436002)(52116002)(2906002)(105586002)(186003)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 3AzmdU6ipNGf/wLxvrfxOzkQlat8jSCRTudyXNll5UCZkbPl2U4IvKLys8JpUc2DWsxT9MIOz1JET3+K9f/ajsvkNCduosuAi2hddaEriEGocgYYoL3ILlvT3S/NXH7QpowqtfcJDWYja4eZG5wAzcKN0Qr7y+FeRsurJiXbeZ7Fha74KqIoW2JVuaxc+I36
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a5efa204-fe92-4d0c-6e06-08d5b7844bb1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5efa204-fe92-4d0c-6e06-08d5b7844bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:18.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before verifying a commit-graph file against the object database, we
need to parse all commits from the given commit-graph file. Create
parse_commit_in_graph_one() to target a given struct commit_graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d2db20e49a..4dfff7e752 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -309,7 +309,7 @@ static int find_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	}
 }
=20
-int parse_commit_in_graph(struct commit *item)
+int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
 {
 	uint32_t pos;
=20
@@ -317,9 +317,21 @@ int parse_commit_in_graph(struct commit *item)
 		return 0;
 	if (item->object.parsed)
 		return 1;
+
+	if (find_commit_in_graph(item, g, &pos))
+		return fill_commit_in_graph(item, g, pos);
+
+	return 0;
+}
+
+int parse_commit_in_graph(struct commit *item)
+{
+	if (!core_commit_graph)
+		return 0;
+
 	prepare_commit_graph();
-	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
-		return fill_commit_in_graph(item, commit_graph, pos);
+	if (commit_graph)
+		return parse_commit_in_graph_one(commit_graph, item);
 	return 0;
 }
=20
--=20
2.16.2.329.gfb62395de6

