Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EBA1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeFFLh0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:37:26 -0400
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:12016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751991AbeFFLge (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A5N7RhwKWX9nGyKAoF0ioNxwlzl2nEgjdlYeWoBKkY=;
 b=JEZn90JRHDFHc3VbcIkFHiQJ5+3301pxMYS3IPg4gTLXOjre41RLa9jxRENLJrENp/zEkGiD3cAplS+6M10sWCiZvdVrr7YcH8fayQqq58nfKcqIFmloX+KKvq2J4MZaiM5mKHqKxycypheA7u8shD6Ere0wZTZelvffTVw/CwM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:32 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:32 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 11/21] commit-graph: verify root tree OIDs
Thread-Topic: [PATCH v5 11/21] commit-graph: verify root tree OIDs
Thread-Index: AQHT/Yqdp1kjXgZ83EuDF7ZhRk5K+Q==
Date:   Wed, 6 Jun 2018 11:36:32 +0000
Message-ID: <20180606113611.87822-12-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:XVIE5G7B28XDabBSy0nFFu7Iu5nYQA1XtPMAKX2Ue+crzmeN2/s7Scv2BCtbiwh8axTQVCTGNic2f4cL70RQMYVnnTmd36Az51/uzGdlIgahN2LBklXY2UWIPtVAdq34H+O7oelI8F3dpLOCpA47YB7ztD0i5RRdEYNnYJ8USpsKZpObEwKN45p2B16mxlpBs4fh+3Cxrd8nD+RjUMOdlN2syAZafFx6PqpqRPyIwnZGVXlIh+RAKeKlrNKuqr7Y
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1044779DAB44E7BA8F542C8BA1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(575784001)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K/I5xkvLtXUKdhZFpLES+eshSF8DD1uVylfv8vCOMGB8Kiuu2prFrtaQlb7h2+LA9g6Jfdfx3roUu1U3O/ctIbmAt+CKbbK4hr9Dwx1KsvJI/7GCt5KY84rR5Ybt7TCtvLtc4a+wHmL1qKpztUhKFJbAcsHh8RokJEAs0YhnFtUvdoLQqlT3Rmy3cZczKfsl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 65dac413-9610-4752-f0cc-08d5cba1c034
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dac413-9610-4752-f0cc-08d5cba1c034
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:32.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'verify' subcommand must compare the commit content parsed from the
commit-graph against the content in the object database. Use
lookup_commit() and parse_commit_in_graph_one() to parse the commits
from the graph and compare against a commit that is loaded separately
and parsed directly from the object database.

Add checks for the root tree OID.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 17 ++++++++++++++++-
 t/t5318-commit-graph.sh |  7 +++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 893cc2f346..d7e408a99d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -865,6 +865,8 @@ int verify_commit_graph(struct commit_graph *g)
 		return verify_commit_graph_error;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit;
+
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
 		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
@@ -882,6 +884,11 @@ int verify_commit_graph(struct commit_graph *g)
=20
 			cur_fanout_pos++;
 		}
+
+		graph_commit =3D lookup_commit(&cur_oid);
+		if (!parse_commit_in_graph_one(g, graph_commit))
+			graph_report("failed to parse %s from commit-graph",
+				     oid_to_hex(&cur_oid));
 	}
=20
 	while (cur_fanout_pos < 256) {
@@ -898,16 +905,24 @@ int verify_commit_graph(struct commit_graph *g)
 		return verify_commit_graph_error;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
-		struct commit *odb_commit;
+		struct commit *graph_commit, *odb_commit;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
+		graph_commit =3D lookup_commit(&cur_oid);
 		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_commit=
_node());
 		if (parse_commit_internal(odb_commit, 0, 0)) {
 			graph_report("failed to parse %s from object database",
 				     oid_to_hex(&cur_oid));
 			continue;
 		}
+
+		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+			   get_commit_tree_oid(odb_commit)))
+			graph_report("root tree OID for commit %s in commit-graph is %s !=3D %s=
",
+				     oid_to_hex(&cur_oid),
+				     oid_to_hex(get_commit_tree_oid(graph_commit)),
+				     oid_to_hex(get_commit_tree_oid(odb_commit)));
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index cf60e48496..c0c1248eda 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -267,6 +267,8 @@ GRAPH_BYTE_FANOUT2=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 255=
))
 GRAPH_OID_LOOKUP_OFFSET=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8=
))
 GRAPH_BYTE_OID_LOOKUP_MISSING=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \*=
 4 + 10))
+GRAPH_COMMIT_DATA_OFFSET=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* $NUM=
_COMMITS))
+GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -341,4 +343,9 @@ test_expect_success 'detect OID not in object database'=
 '
 		"from object database"
 '
=20
+test_expect_success 'detect incorrect tree OID' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_TREE "\01" \
+		"root tree OID for commit"
+'
+
 test_done
--=20
2.18.0.rc1

