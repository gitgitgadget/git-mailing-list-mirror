Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAC81F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeFFLgm (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:42 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:10314
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751885AbeFFLgg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS0tlbcdhTGlMkCIU1xx4w+0cxZkYNo87+RRCp67PY0=;
 b=iFic01HWTcVDdQ73AC/MJNu0mwP7XxM52dMVaf9jmuJq905s+/sm7//k2ZiqqBpm1AE26Y+SLD1K41F9ffBTAgXQE9olUu+feDhq7rrI9WLIxNIAy3ALdo1lW2cyPupXiOwMXeM1zS72mjHtwWivU93OXeYoPRxTt/tW7KMWo2s=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:34 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:34 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 13/21] commit-graph: verify generation number
Thread-Topic: [PATCH v5 13/21] commit-graph: verify generation number
Thread-Index: AQHT/YqeIOzuZWpr9kOuCsBidBCBjA==
Date:   Wed, 6 Jun 2018 11:36:33 +0000
Message-ID: <20180606113611.87822-14-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:9QhS6skykK+WkOxEIvUPfkU5jMbe9nnfiMO4ZWI/w9vmCRAuMxQ/b4E1AUA4VfWQEVNyg4YuyvFnxgjJoWTHBjivg5cQf3tIB/GBn96oWfXY8EQ23Mixvs+8wg6GF4XtBjJ8hbEVG11hIKrD5cJ4x0MKRqmaHlRlvxy6N+dFFSvDgWwuRREQEFO0xLlbHNQpi5mysf9dLNggduMpUQpthWia4lEKN2l4IOVkHQj+mAhL9HHOSGdi7egwo1txGu7N
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB104465B959061E0A08148BB2A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6lb/9GC/+/HMBVq5K5BMhO5ME/2WqhQmeWbF2RMD23lLAU097AFvv0S34dcWPi0MbY3uXcS+yMEzJlRoN1GXeUx1r/IWjZ+jV/mplKtUYB+3nFo9Ji7DevUmvPMbxzOphs++hKTC0Mrn4t912m2q3Yy4/6BEQ8gjsQywUCoACuT4oBjYewJy9/mUXKp0Q7uH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 69c845dc-9b25-4f80-2226-08d5cba1c139
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c845dc-9b25-4f80-2226-08d5cba1c139
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:33.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While iterating through the commit parents, perform the generation
number calculation and compare against the value stored in the
commit-graph.

The tests demonstrate that having a different set of parents affects
the generation number calculation, and this value propagates to
descendants. Hence, we drop the single-line condition on the output.

Since Git will ship with the commit-graph feature without generation
numbers, we need to accept commit-graphs with all generation numbers
equal to zero. In this case, ignore the generation number calculation.

However, verify that we should never have a mix of zero and non-zero
generation numbers. Create a test that sets one commit to generation
zero and all following commits report a failure as they have non-zero
generation in a file that contains generation number zero.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 34 ++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index fcebd0925c..b97fa05ec9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -845,10 +845,14 @@ static void graph_report(const char *fmt, ...)
 	va_end(ap);
 }
=20
+#define GENERATION_ZERO_EXISTS 1
+#define GENERATION_NUMBER_EXISTS 2
+
 int verify_commit_graph(struct commit_graph *g)
 {
 	uint32_t i, cur_fanout_pos =3D 0;
 	struct object_id prev_oid, cur_oid;
+	int generation_zero =3D 0;
=20
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -910,6 +914,7 @@ int verify_commit_graph(struct commit_graph *g)
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
+		uint32_t max_generation =3D 0;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
@@ -944,6 +949,9 @@ int verify_commit_graph(struct commit_graph *g)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
=20
+			if (graph_parents->item->generation > max_generation)
+				max_generation =3D graph_parents->item->generation;
+
 			graph_parents =3D graph_parents->next;
 			odb_parents =3D odb_parents->next;
 		}
@@ -951,6 +959,32 @@ int verify_commit_graph(struct commit_graph *g)
 		if (odb_parents !=3D NULL)
 			graph_report("commit-graph parent list for commit %s terminates early",
 				     oid_to_hex(&cur_oid));
+
+		if (!graph_commit->generation) {
+			if (generation_zero =3D=3D GENERATION_NUMBER_EXISTS)
+				graph_report("commit-graph has generation number zero for commit %s, b=
ut non-zero elsewhere",
+					     oid_to_hex(&cur_oid));
+			generation_zero =3D GENERATION_ZERO_EXISTS;
+		} else if (generation_zero =3D=3D GENERATION_ZERO_EXISTS)
+			graph_report("commit-graph has non-zero generation number for commit %s=
, but zero elsewhere",
+				     oid_to_hex(&cur_oid));
+
+		if (generation_zero =3D=3D GENERATION_ZERO_EXISTS)
+			continue;
+
+		/*
+		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
+		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
+		 * extra logic in the following condition.
+		 */
+		if (max_generation =3D=3D GENERATION_NUMBER_MAX)
+			max_generation--;
+
+		if (graph_commit->generation !=3D max_generation + 1)
+			graph_report("commit-graph generation for commit %s is %u !=3D %u",
+				     oid_to_hex(&cur_oid),
+				     graph_commit->generation,
+				     max_generation + 1);
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ec0964112a..a6ea1341dc 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -272,6 +272,7 @@ GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
 GRAPH_BYTE_COMMIT_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
+GRAPH_BYTE_COMMIT_GENERATION=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + =
11))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -366,4 +367,14 @@ test_expect_success 'detect wrong parent' '
 		"commit-graph parent for"
 '
=20
+test_expect_success 'detect incorrect generation number' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\070" \
+		"generation for commit"
+'
+
+test_expect_success 'detect incorrect generation number' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
+		"non-zero generation number"
+'
+
 test_done
--=20
2.18.0.rc1

