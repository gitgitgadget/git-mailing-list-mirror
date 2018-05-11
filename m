Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500EC1F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeEKVPk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:40 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:27712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751853AbeEKVPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH59xiu2+qjoEuQN2LyAwyz5tpAXgoZqU5/hqiz77RU=;
 b=DZU1x8nX0z8U1267lrmf1O5bqKr3ZSH6RrGcq/+P3xv+L9PIsy6/IxtlghE2VjMKEKQQwzB162QntderMiRZ3QNBZ8JerezAPhaIZH2KemRx3emm/qNKaab6mRAXuRaNLTWEhTK0DnoKQDoZpdfzl2F4PASWWqA1rG/wF+kE2hU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:32 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:32 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 09/12] fsck: verify commit-graph
Thread-Topic: [PATCH v2 09/12] fsck: verify commit-graph
Thread-Index: AQHT6W0svXI4+hG7jkmQUTnZDRmWyQ==
Date:   Fri, 11 May 2018 21:15:23 +0000
Message-ID: <20180511211504.79877-10-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:JIVPbVrtikwIBCP1DdaZFJfHG4Fi5b8L7itmBt9urjtHP9krypcXK/NdbkYkyDInMWP4eDmmDDPSL1G0/Z+rzIVFg7A7gp+qXm6/K/1Ait9OOV1qymt3/JT3V12xbh43uluM1A/8AIkvgfn9WHlWTpa6RJXn8x0fjmGOy86klm+su+777T92/vb4aYJy+w1sCb2qi/Xbbh68qGT1b1P0aHSvK11OjZ/qP/o2gNMMO1azsHose8Q6403xNSRhpb6H;20:t7n9CLrKqtdQVnvW42XIHebb1IkqKoCEL4eW/2uJ+/1EuQa5JCOP7wqJFeBbsg5hzWtw2SwPov4xHQYG7pRVcwW6dzbbfrDEpM3N6PObwD1tZMxpuYB4mj/I9ip2Iqxs58w+w2wABeRlqKoa8y9H9NDWy1LQ7mqoou0ZyNQkV1E=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096216A67A1B1A01840D85F6A19F0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(5660300001)(39060400002)(316002)(305945005)(6116002)(7736002)(6506007)(52116002)(386003)(81166006)(81156014)(186003)(3660700001)(5640700003)(46003)(76176011)(54906003)(1730700003)(15650500001)(68736007)(6436002)(446003)(102836004)(3280700002)(1076002)(59450400001)(97736004)(2351001)(11346002)(22452003)(106356001)(99286004)(2616005)(476003)(2501003)(36756003)(14454004)(2906002)(8936002)(6666003)(105586002)(107886003)(4326008)(8676002)(86612001)(6486002)(486006)(25786009)(10090500001)(53936002)(478600001)(2900100001)(86362001)(6916009)(6512007)(10290500003)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sDvVKbrmvrxeslr+MmmyoZe4VAmUzJBHW3NUvQS092gPHD3DysEER13pruSYAhb2WeFjDRbVgQk4bE5vK1bol4s7Sbg++4JmcA0LDdbnEMS92Siu4595BKGcc6IvHA+XrB90Z2CaXZoDgc3lr5eY5eU0f7S0cBDtp5mjkZSwAJqrKQP5MnXu4hEOfqSIbv1k
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c7fbac70-67a6-4c5b-11a8-08d5b7844eab
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fbac70-67a6-4c5b-11a8-08d5b7844eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:23.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If core.commitGraph is true, verify the contents of the commit-graph
during 'git fsck' using the 'git commit-graph verify' subcommand. Run
this check on all alternates, as well.

We use a new process for two reasons:

1. The subcommand decouples the details of loading and verifying a
   commit-graph file from the other fsck details.

2. The commit-graph verification requires the commits to be loaded
   in a specific order to guarantee we parse from the commit-graph
   file for some objects and from the object database for others.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-fsck.txt |  3 +++
 builtin/fsck.c             | 21 +++++++++++++++++++++
 t/t5318-commit-graph.sh    | 21 ++++++++++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b9f060e3b2..ab9a93fb9b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -110,6 +110,9 @@ Any corrupt objects you will have to find in backups or=
 other archives
 (i.e., you can just remove them and do an 'rsync' with some other site in
 the hopes that somebody else has the object you have corrupted).
=20
+If core.commitGraph is true, the commit-graph file will also be inspected
+using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
+
 Extracted Diagnostics
 ---------------------
=20
diff --git a/builtin/fsck.c b/builtin/fsck.c
index ef78c6c00c..a6d5045b77 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -16,6 +16,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "run-command.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -45,6 +46,7 @@ static int name_objects;
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
 #define ERROR_REFS 010
+#define ERROR_COMMIT_GRAPH 020
=20
 static const char *describe_object(struct object *obj)
 {
@@ -815,5 +817,24 @@ int cmd_fsck(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	check_connectivity();
+
+	if (core_commit_graph) {
+		struct child_process commit_graph_verify =3D CHILD_PROCESS_INIT;
+		const char *verify_argv[] =3D { "commit-graph", "verify", NULL, NULL, NU=
LL, NULL };
+		commit_graph_verify.argv =3D verify_argv;
+		commit_graph_verify.git_cmd =3D 1;
+
+		if (run_command(&commit_graph_verify))
+			errors_found |=3D ERROR_COMMIT_GRAPH;
+
+		prepare_alt_odb();
+		for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
+			verify_argv[2] =3D "--object-dir";
+			verify_argv[3] =3D alt->path;
+			if (run_command(&commit_graph_verify))
+				errors_found |=3D ERROR_COMMIT_GRAPH;
+		}
+	}
+
 	return errors_found;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5ab268a024..91c8406d97 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -205,6 +205,16 @@ test_expect_success 'build graph from commits with app=
end' '
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merg=
e/1
 graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merg=
e/2
=20
+test_expect_success 'build graph using --reachable' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write --reachable &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "11" "large_edges"
+'
+
+graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merg=
e/1
+graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merg=
e/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
@@ -335,7 +345,7 @@ test_expect_success 'detect OID not in object database'=
 '
 	cd "$TRASH_DIRECTORY/full" &&
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	corrupt_data $objdir/info/commit-graph 1134 "\01" &&
+	corrupt_data $objdir/info/commit-graph 1134 "\00" &&
 	test_must_fail git commit-graph verify 2>err &&
 	grep -v "^\+" err > verify-errors &&
 	test_line_count =3D 3 verify-errors &&
@@ -348,7 +358,7 @@ test_expect_success 'detect incorrect tree OID' '
 	cd "$TRASH_DIRECTORY/full" &&
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	corrupt_data $objdir/info/commit-graph 1312 "\01" &&
+	corrupt_data $objdir/info/commit-graph 1312 "\00" &&
 	test_must_fail git commit-graph verify 2>err &&
 	grep -v "^\+" err > verify-errors &&
 	test_line_count =3D 1 verify-errors &&
@@ -382,10 +392,15 @@ test_expect_success 'detect incorrect commit date and=
 generation number' '
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
 	corrupt_data $objdir/info/commit-graph 1340 "\01" &&
-	corrupt_data $objdir/info/commit-graph 1344 "\01" &&
+	corrupt_data $objdir/info/commit-graph 1344 "\00" &&
 	test_must_fail git commit-graph verify 2>err &&
 	grep "incorrect generation" err &&
 	grep "commit date" err
 '
=20
+test_expect_success 'git fsck (checks commit-graph)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

