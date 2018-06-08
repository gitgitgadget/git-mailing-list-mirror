Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8101F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFHN4Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:24 -0400
Received: from mail-eopbgr730113.outbound.protection.outlook.com ([40.107.73.113]:7405
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752478AbeFHN4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PxKZCpSY+1NNWViOA4p2zkKATEi9GF0GUJwWo6Q9dY=;
 b=Ei/TXLsPjiVCSFMYfvkKH1CRtB8rbO8xiQdaDDBsl1N1/mkVz+HxGwk3KXu0fnWif4QjrVIpraNkfA6xbZXJ1aJtLkEnwK5DWAfOtQy53RqtiDhZvcNEpVXSui1p881GuruEpjiSSr/Hvf4/+cWNa397cS0iSy7nzONZh3Ai/lE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:17 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 06/21] commit-graph: add 'verify' subcommand
Thread-Topic: [PATCH v6 06/21] commit-graph: add 'verify' subcommand
Thread-Index: AQHT/zB4sIZCLjOhL0WUSNl6A7s4Hw==
Date:   Fri, 8 Jun 2018 13:56:17 +0000
Message-ID: <20180608135548.216405-7-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:404:f7::33) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;7:2HqebvDTNXzuDcCfzBiWlZfls2fu6wcpS3Hjd//y94l7468nSrEVpTU3waw4eE6hZ4LbYDWqK8f9+0juLzkvsLIJPFTaP7UwXZRErnpqJZYReY3K0rMCcp48TtaeRKafRM1Ue24m+u63ookfK9/0Y3SGNak3xXFz/b9PODvnCiNU3vnbFP1ElBdU3faeiOtnwFBNuar6sx0seZ5CAGcePaPt5yHhOVa3FGXA+HvZ+rs/gum/MVE9rVVe4WT5tumV
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB097986316A7FCFDBD79E2484A17B0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(36756003)(8676002)(10290500003)(22452003)(2351001)(81166006)(1730700003)(8656006)(99286004)(5660300001)(6916009)(97736004)(14454004)(6116002)(305945005)(478600001)(5640700003)(86362001)(81156014)(476003)(316002)(54906003)(6486002)(6436002)(7736002)(2616005)(86612001)(1076002)(186003)(3660700001)(2906002)(386003)(59450400001)(76176011)(6506007)(105586002)(46003)(2900100001)(4326008)(446003)(3280700002)(25786009)(15650500001)(102836004)(106356001)(68736007)(2501003)(39060400002)(6512007)(11346002)(8936002)(10090500001)(52116002)(107886003)(5250100002)(53936002)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4VyLGiw+KXphnzdCcgnjXIuJ1IuU4qUDV1FIm6h9xCmrGC9Ia67eYIWtLtKIr7tBCDzhVPbPcGVJYYkos2jdkXBSJ6O4aYlEtLPdSTSkcAAQEcGUM0+kkp2ht4tbai/BsKsK+0HHSjY1KqhwSvsWioDqOxUfUIEq6Hp6NP+6H91gs/toTaryPt1WxcxVGbt0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1f74c64c-c975-4ea6-9180-08d5cd479b1f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f74c64c-c975-4ea6-9180-08d5cd479b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:17.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the commit-graph file becomes corrupt, we need a way to verify
that its contents match the object database. In the manner of
'git fsck' we will implement a 'git commit-graph verify' subcommand
to report all issues with the file.

Add the 'verify' subcommand to the 'commit-graph' builtin and its
documentation. The subcommand is currently a no-op except for
loading the commit-graph into memory, which may trigger run-time
errors that would be caught by normal use. Add a simple test that
ensures the command returns a zero error code.

If no commit-graph file exists, this is an acceptable state. Do
not report any errors.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  6 +++++
 builtin/commit-graph.c             | 39 ++++++++++++++++++++++++++++++
 commit-graph.c                     | 23 ++++++++++++++++++
 commit-graph.h                     |  3 +++
 t/t5318-commit-graph.sh            | 10 ++++++++
 5 files changed, 81 insertions(+)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index 4c97b555cc..a222cfab08 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph read' [--object-dir <dir>]
+'git commit-graph verify' [--object-dir <dir>]
 'git commit-graph write' <options> [--object-dir <dir>]
=20
=20
@@ -52,6 +53,11 @@ existing commit-graph file.
 Read a graph file given by the commit-graph file and output basic
 details about the graph file. Used for debugging purposes.
=20
+'verify'::
+
+Read the commit-graph file and verify its contents against the object
+database. Used to check for corrupted data.
+
=20
 EXAMPLES
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f0875b8bf3..9d108f43a9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -3,15 +3,22 @@
 #include "dir.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "commit-graph.h"
=20
 static char const * const builtin_commit_graph_usage[] =3D {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
+	N_("git commit-graph verify [--object-dir <objdir>]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
 	NULL
 };
=20
+static const char * const builtin_commit_graph_verify_usage[] =3D {
+	N_("git commit-graph verify [--object-dir <objdir>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_read_usage[] =3D {
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	NULL
@@ -29,6 +36,36 @@ static struct opts_commit_graph {
 	int append;
 } opts;
=20
+
+static int graph_verify(int argc, const char **argv)
+{
+	struct commit_graph *graph =3D NULL;
+	char *graph_name;
+
+	static struct option builtin_commit_graph_verify_options[] =3D {
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			   N_("dir"),
+			   N_("The object directory to store the graph")),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, NULL,
+			     builtin_commit_graph_verify_options,
+			     builtin_commit_graph_verify_usage, 0);
+
+	if (!opts.obj_dir)
+		opts.obj_dir =3D get_object_directory();
+
+	graph_name =3D get_commit_graph_filename(opts.obj_dir);
+	graph =3D load_commit_graph_one(graph_name);
+	FREE_AND_NULL(graph_name);
+
+	if (!graph)
+		return 0;
+
+	return verify_commit_graph(the_repository, graph);
+}
+
 static int graph_read(int argc, const char **argv)
 {
 	struct commit_graph *graph =3D NULL;
@@ -165,6 +202,8 @@ int cmd_commit_graph(int argc, const char **argv, const=
 char *prefix)
 	if (argc > 0) {
 		if (!strcmp(argv[0], "read"))
 			return graph_read(argc, argv);
+		if (!strcmp(argv[0], "verify"))
+			return graph_verify(argc, argv);
 		if (!strcmp(argv[0], "write"))
 			return graph_write(argc, argv);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 9e228d3bb5..22ef696e18 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -827,3 +827,26 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc =3D 0;
 	oids.nr =3D 0;
 }
+
+static int verify_commit_graph_error;
+
+static void graph_report(const char *fmt, ...)
+{
+	va_list ap;
+	verify_commit_graph_error =3D 1;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
+int verify_commit_graph(struct repository *r, struct commit_graph *g)
+{
+	if (!g) {
+		graph_report("no commit-graph file loaded");
+		return 1;
+	}
+
+	return verify_commit_graph_error;
+}
diff --git a/commit-graph.h b/commit-graph.h
index 96cccb10f3..4359812fb4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -2,6 +2,7 @@
 #define COMMIT_GRAPH_H
=20
 #include "git-compat-util.h"
+#include "repository.h"
=20
 char *get_commit_graph_filename(const char *obj_dir);
=20
@@ -53,4 +54,6 @@ void write_commit_graph(const char *obj_dir,
 			int nr_commits,
 			int append);
=20
+int verify_commit_graph(struct repository *r, struct commit_graph *g);
+
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 77d85aefe7..6ca451dfd2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -11,6 +11,11 @@ test_expect_success 'setup full repo' '
 	objdir=3D".git/objects"
 '
=20
+test_expect_success 'verify graph with no graph file' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify
+'
+
 test_expect_success 'write graph with no packs' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --object-dir . &&
@@ -230,4 +235,9 @@ test_expect_success 'perform fast-forward merge in full=
 repo' '
 	test_cmp expect output
 '
=20
+test_expect_success 'git commit-graph verify' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify >output
+'
+
 test_done
--=20
2.18.0.rc1

