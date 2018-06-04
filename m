Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBB01F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeFDQww (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:52 -0400
Received: from mail-co1nam03on0100.outbound.protection.outlook.com ([104.47.40.100]:45329
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751554AbeFDQwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG94JwFI0w/iH3qkDKtYzgcQxpzBPzkESu7K9SfvT/Y=;
 b=dypj/SwAGwlF7vU+p5JngEmGIsbJNQBBzkKHcW5ultCAJJobMw0ywTzi3f4hvJRlWjhMpodtjQzrT7/gX/niP1nejm8BL5zUU34BYHypuTYIj+fTZynt9/VyY8ScWbG2wK3mFtVhCrwUB64yC5Uc/nyeCKy9xk++gxus9OEZ7G8=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:43 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:43 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 13/21] commit-graph: verify generation number
Thread-Topic: [PATCH v4 13/21] commit-graph: verify generation number
Thread-Index: AQHT/CR0LVnqOnQirEG5dMAIoeaTKA==
Date:   Mon, 4 Jun 2018 16:52:43 +0000
Message-ID: <20180604165200.29261-14-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:7SEhAbQQ1iCjbXXW4jUDqPifJTAWmaWzCUrJitCEQAocprKlYjZzHxsiIYbLgw4+IdWoyKNxRu2lxUZ4vzBBey4toMrD9mHRy9VUhKEtetVdbbF4p3zroBhzCKzcgxGRwHAsdggY/Wc0A0w0gcm9fAqShPuNx7OMtC4/eAkJgSzkz4C5Lsz+7YsbTbB5sgEYWhXQa/YWMH9GD30awfQIH78Eb8SFBNEG8JyXzWJvrkJv6K0dhMDOHk+9EN4+6qoH;20:OQFy7JVhQAn22X//YWvbC4IUWpPJup1Ai7/x6cK0kkupdVnVZWDUqPZR876ILheiaVRQ2vFiYhyRmubCyiJCUuVJaNbpmPsGWS5n0J4AtdEZG833d4RHTQ6LTsV45PNlDJ7CxBAdBOCD5JucAxyYh2z1ZVqBba9d86L8qnSaK9A=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1129B37B1E663B238417A38AA1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(15650500001)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q6fR4e+mE+rt90AZgf+pvQrxd2rUdJb01mPBpso8xiqqWYk4WG78l/AZdn/y1ZuOHLR153AiqTbY127gv0JCz8Refcd48r29wklxklwni1m+XzfYMPdU/VKgSxdzL1WnL3i6+wUY4T/sjyycbulK32Ag0hw7TCmd0Zajv64k3afT29pdmDdaAhwCZGtbjigK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c733b299-4576-4506-31ef-08d5ca3b9727
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c733b299-4576-4506-31ef-08d5ca3b9727
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:43.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
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
index d2a86e329e..5faecae2a7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -842,10 +842,14 @@ static void graph_report(const char *fmt, ...)
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
@@ -907,6 +911,7 @@ int verify_commit_graph(struct commit_graph *g)
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
+		uint32_t max_generation =3D 0;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
@@ -941,6 +946,9 @@ int verify_commit_graph(struct commit_graph *g)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
=20
+			if (graph_parents->item->generation > max_generation)
+				max_generation =3D graph_parents->item->generation;
+
 			graph_parents =3D graph_parents->next;
 			odb_parents =3D odb_parents->next;
 		}
@@ -948,6 +956,32 @@ int verify_commit_graph(struct commit_graph *g)
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

