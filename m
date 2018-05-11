Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4C11F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEKVPg (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:36 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:27712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751338AbeEKVPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3QoHO0NXi5fBQTwuy7onhrUaYRhV+CgBWnMCjWJD0M=;
 b=AUHXTMYxcIyqSQtxsjenUHD6i+8IkA/X/ZuTn8zjwvYUxIHZL+zdJ1E40xqTjBtMNCUXh7dHIc6lP0Gk6gXLXIeaR5TvrFyFXVR2+lGpY6oyo6UoEr8d2XbX89daj81R36Y1OerT7qz6pYAhAVqwbWMgTRp39qEhyzZ6vmdPc5w=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:25 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:25 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 08/12] commit-graph: verify commit contents against odb
Thread-Topic: [PATCH v2 08/12] commit-graph: verify commit contents against
 odb
Thread-Index: AQHT6W0rs8WZj5R3p0ifTASAnIPdIw==
Date:   Fri, 11 May 2018 21:15:22 +0000
Message-ID: <20180511211504.79877-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:L9W/Ld24m+PFGITsiRkHkuKt2JdLOcZat5sAgcUQfs9w6s6goPV0PZBzWzk4nub8hAXO6HO/bpMKhyI9CV8usa11N891WHRpWEM8hfKglPvE2w9GoTfYSWBps8JXLXGMVTk661Vsa3vhBCBX18eMSEo+FRcM9ux3uJoMdXh7h6WCBshB7A16h6VEDghi4ot/M75bqoKjhVH2X4AbxZedrXVV6ZdOOtXB/MJ+VgPHLb3ae7wPCPW8HY+wC358K+M8;20:j9n3t9mnitSkP2h1d+CpgHa6tRae0UaBV3Z6GHQ9VJrSS0xhNTpzOnIUYapsuwgnOjR5z+vNbXJsz1V82gUGmlVQZrZr4EHPO1hbhT3r6V7lbML86rt7DuDNXGeHym+bW1SMmxa9Z6/zv0sKkONFYLcemIIeAz9eoEuurBtpZk8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096270AE879E1642C771BE02A19F0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(5660300001)(39060400002)(316002)(305945005)(6116002)(7736002)(6506007)(52116002)(386003)(81166006)(81156014)(186003)(3660700001)(5640700003)(46003)(76176011)(54906003)(1730700003)(15650500001)(68736007)(6436002)(446003)(102836004)(3280700002)(1076002)(59450400001)(97736004)(2351001)(11346002)(22452003)(106356001)(99286004)(2616005)(476003)(2501003)(36756003)(14454004)(2906002)(8936002)(6666003)(105586002)(107886003)(4326008)(8676002)(86612001)(6486002)(486006)(25786009)(10090500001)(53936002)(478600001)(2900100001)(86362001)(6916009)(575784001)(6512007)(10290500003)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CTICSdaVN/D3QJSVv6QQTzWzdLSLsrP1eR66fju3sFm+xa4uddTZSpVehOAC417/kDfNnrK3K/gaR4O1r1mBG3WRT0mB5P7Gt7tWORC9LPk7mriYk/tB/3zQKD5jV2C0gbi6szqN47/2BUrWEMLmQkRFJJt//GI1axz0xJ5l9VdyT+StJLi68iL7AJZjqg32
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dc85491e-80fa-4ca6-11bf-08d5b7844e12
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc85491e-80fa-4ca6-11bf-08d5b7844e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:22.2460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git commit-graph verify', compare the contents of the
commits that are loaded from the commit-graph file with commits that are
loaded directly from the object database. This includes checking the
root tree object ID, commit date, and parents.

Parse the commit from the graph during the initial loop through the
object IDs to guarantee we parse from the commit-graph file.

In addition, verify the generation number calculation is correct for all
commits in the commit-graph file.

While testing, we discovered that mutating the integer value for a
parent to be outside the accepted range causes a segmentation fault. Add
a new check in insert_parent_or_die() that prevents this fault. Check
for that error during the test, both in the typical parents and in the
list of parents for octopus merges.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 100 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 t/t5318-commit-graph.sh |  64 +++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 5bb93e533c..a15ad9710d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -237,6 +237,10 @@ static struct commit_list **insert_parent_or_die(struc=
t commit_graph *g,
 {
 	struct commit *c;
 	struct object_id oid;
+
+	if (pos >=3D g->num_commits)
+		die("invalide parent position %"PRIu64, pos);
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c =3D lookup_commit(&oid);
 	if (!c)
@@ -875,6 +879,8 @@ int verify_commit_graph(struct commit_graph *g)
 		return 1;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit;
+
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
 		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
@@ -892,6 +898,10 @@ int verify_commit_graph(struct commit_graph *g)
=20
 			cur_fanout_pos++;
 		}
+
+		graph_commit =3D lookup_commit(&cur_oid);
+		if (!parse_commit_in_graph_one(g, graph_commit))
+			graph_report("failed to parse %s from commit-graph", oid_to_hex(&cur_oi=
d));
 	}
=20
 	while (cur_fanout_pos < 256) {
@@ -904,5 +914,95 @@ int verify_commit_graph(struct commit_graph *g)
 		cur_fanout_pos++;
 	}
=20
+	if (verify_commit_graph_error)
+		return 1;
+
+	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit, *odb_commit;
+		struct commit_list *graph_parents, *odb_parents;
+		int num_parents =3D 0;
+
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		graph_commit =3D lookup_commit(&cur_oid);
+		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_commit=
_node());
+		if (parse_commit_internal(odb_commit, 0, 0)) {
+			graph_report("failed to parse %s from object database", oid_to_hex(&cur=
_oid));
+			continue;
+		}
+
+		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+			   get_commit_tree_oid(odb_commit)))
+			graph_report("root tree object ID for commit %s in commit-graph is %s !=
=3D %s",
+				     oid_to_hex(&cur_oid),
+				     oid_to_hex(get_commit_tree_oid(graph_commit)),
+				     oid_to_hex(get_commit_tree_oid(odb_commit)));
+
+		if (graph_commit->date !=3D odb_commit->date)
+			graph_report("commit date for commit %s in commit-graph is %"PRItime" !=
=3D %"PRItime"",
+				     oid_to_hex(&cur_oid),
+				     graph_commit->date,
+				     odb_commit->date);
+
+
+		graph_parents =3D graph_commit->parents;
+		odb_parents =3D odb_commit->parents;
+
+		while (graph_parents) {
+			num_parents++;
+
+			if (odb_parents =3D=3D NULL)
+				graph_report("commit-graph parent list for commit %s is too long (%d)"=
,
+					     oid_to_hex(&cur_oid),
+					     num_parents);
+
+			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object=
.oid))
+				graph_report("commit-graph parent for %s is %s !=3D %s",
+					     oid_to_hex(&cur_oid),
+					     oid_to_hex(&graph_parents->item->object.oid),
+					     oid_to_hex(&odb_parents->item->object.oid));
+
+			graph_parents =3D graph_parents->next;
+			odb_parents =3D odb_parents->next;
+		}
+
+		if (odb_parents !=3D NULL)
+			graph_report("commit-graph parent list for commit %s terminates early",
+				     oid_to_hex(&cur_oid));
+
+		if (graph_commit->generation) {
+			uint32_t max_generation =3D 0;
+			graph_parents =3D graph_commit->parents;
+
+			while (graph_parents) {
+				if (graph_parents->item->generation =3D=3D GENERATION_NUMBER_ZERO ||
+				    graph_parents->item->generation =3D=3D GENERATION_NUMBER_INFINITY)
+					graph_report("commit-graph has valid generation for %s but not its pa=
rent, %s",
+						     oid_to_hex(&cur_oid),
+						     oid_to_hex(&graph_parents->item->object.oid));
+				if (graph_parents->item->generation > max_generation)
+					max_generation =3D graph_parents->item->generation;
+				graph_parents =3D graph_parents->next;
+			}
+
+			if (max_generation =3D=3D GENERATION_NUMBER_MAX)
+				max_generation--;
+
+			if (graph_commit->generation !=3D max_generation + 1)
+				graph_report("commit-graph has incorrect generation for %s",
+					     oid_to_hex(&cur_oid));
+		} else {
+			graph_parents =3D graph_commit->parents;
+
+			while (graph_parents) {
+				if (graph_parents->item->generation)
+					graph_report("commit-graph has generation ZERO for %s but not its par=
ent, %s",
+						     oid_to_hex(&cur_oid),
+						     oid_to_hex(&graph_parents->item->object.oid));
+				graph_parents =3D graph_parents->next;
+			}
+		}
+	}
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6fb306b0da..5ab268a024 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -235,8 +235,15 @@ test_expect_success 'perform fast-forward merge in ful=
l repo' '
 	test_cmp expect output
 '
=20
+# the verify tests below expect the commit-graph to contain all
+# commits from the 'full' repo to be in the commit-graph file.
+# If the file changes the set of commits in the list, then the
+# offsets into the binary file will result in different edits
+# and the tests will likely break.
+
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
+	git show-ref -s | git commit-graph write --stdin-commits &&
 	git commit-graph verify >output
 '
=20
@@ -324,4 +331,61 @@ test_expect_success 'detect incorrect OID order' '
 	grep "incorrect oid order" err
 '
=20
+test_expect_success 'detect OID not in object database' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 1134 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep -v "^\+" err > verify-errors &&
+	test_line_count =3D 3 verify-errors &&
+	grep "Could not read" verify-errors &&
+	grep "parent" verify-errors &&
+	grep "from object database" verify-errors
+'
+
+test_expect_success 'detect incorrect tree OID' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 1312 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep -v "^\+" err > verify-errors &&
+	test_line_count =3D 1 verify-errors &&
+	grep "root tree object ID for commit " verify-errors
+'
+
+test_expect_success 'detect incorrect parent id' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 1332 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep -v "^\+" err > verify-errors &&
+	test_line_count =3D 1 verify-errors &&
+	grep "parent " verify-errors
+'
+
+test_expect_success 'detect incorrect parent id in large edges' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 1712 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep -v "^\+" err > verify-errors &&
+	test_line_count =3D 1 verify-errors &&
+	grep "parent " verify-errors
+'
+
+test_expect_success 'detect incorrect commit date and generation number' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 1340 "\01" &&
+	corrupt_data $objdir/info/commit-graph 1344 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep "incorrect generation" err &&
+	grep "commit date" err
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

