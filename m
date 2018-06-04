Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0568F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeFDQwZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:25 -0400
Received: from mail-dm3nam03on0115.outbound.protection.outlook.com ([104.47.41.115]:12611
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751305AbeFDQwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehBzry1cAhc3C5ilBTboH0mNh+mEC3NX7Y1kDoTsABU=;
 b=KHYXDrknc5bti6lP8fCsPmfDCblUD/VsdrNoA7X6fdm+XsEnG17eL9U+kjl1XIB9dQDJE30T4dKPcqd7nSQB1RBMB4tHkRsQr3Ba6m8F2IiZJN6RsRqlBTauWOA30EV5BWcBO0kYmNKo7XJlRkEdNPeEf5+RXVeG16BrtG9e9bw=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1081.namprd21.prod.outlook.com (52.132.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.11; Mon, 4 Jun 2018 16:52:19 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 03/21] commit-graph: parse commit from chosen graph
Thread-Topic: [PATCH v4 03/21] commit-graph: parse commit from chosen graph
Thread-Index: AQHT/CRmQqWlI5Y9iEqKxwNbOIg97Q==
Date:   Mon, 4 Jun 2018 16:52:19 +0000
Message-ID: <20180604165200.29261-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1081;7:6RVaxKo5ZoLPob8RjHpZPLwwP9o5un/4wDM9hokzlFN70yGpiCKEhXXIwbSUNh5/pOASl5vcqfyF7wItVl9s67IdgmIHp6GCGGjQFVgQHqzF57z9XLq5KL3MQL44nhaWA13NHUMvHhOUqmog9vkLImW1lYhBP8M4Xc16mdvpGYaZSpniMliHpukkSFCiEcchfu18YcQofb9NC8VWnjFPVjVwOxcdohOJh7kwKiNQjkr1TXXdGKv7vbZk22OeCSmu;20:/tEE1tq1DaHWXZgf0nMmQsDd6gP0L5G04m1GhuJHvJJEWmlbfQJQ0wrdkamUguepNAbrCOVf4nawizfoAziDXxYkvDVmLFtDD/aYXH7th9LRLx17HU6WYXR4ECAdOkp2CduR0avEQIHI82p1V6Jkk8V+SfksKmns7rvF7grjI70=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB10817BA55D4485B99D64A258A1670@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1081;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1081;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(199004)(189003)(81156014)(486006)(8656006)(102836004)(6512007)(316002)(3280700002)(14454004)(1076002)(54906003)(186003)(107886003)(6116002)(478600001)(3660700001)(39060400002)(2616005)(386003)(2900100001)(99286004)(476003)(6506007)(10290500003)(86612001)(68736007)(11346002)(446003)(52116002)(76176011)(86362001)(2906002)(53936002)(22452003)(36756003)(25786009)(6916009)(5660300001)(5640700003)(2501003)(97736004)(2351001)(4326008)(46003)(105586002)(6436002)(106356001)(10090500001)(6486002)(81166006)(8676002)(305945005)(5250100002)(8936002)(7736002)(1730700003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LCmBcaj0B4pbSwD2I+zp9mGCOa1pK92ZxNIN2EWT0kSDVYlkuSBeN6mK2WcjFXP8w9qT108Cl+o5NFsy3vjhysrWRJkBvEM4D1g6b2290Xc5ANzQZEJh2h5Sd7nYdGirccoo+yZdlU20MNzsz6oQyDpq7kDnK4csjd9DCfjbAzHspHNJr+lgYYNiCrf5A7ve
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 89f794d6-58e9-4ccb-8390-08d5ca3b88cf
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f794d6-58e9-4ccb-8390-08d5ca3b88cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:19.5600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
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
index c09e87c3c2..472b41ec30 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -311,7 +311,7 @@ static int find_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	}
 }
=20
-int parse_commit_in_graph(struct commit *item)
+static int parse_commit_in_graph_one(struct commit_graph *g, struct commit=
 *item)
 {
 	uint32_t pos;
=20
@@ -319,9 +319,21 @@ int parse_commit_in_graph(struct commit *item)
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
2.18.0.rc1

