Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48AF1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeFFLgi (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:38 -0400
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:12016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751975AbeFFLga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1uRKE9s0a8Zjs3V9MkVkAbcHV6JoT/VR95qTCypFgE=;
 b=a/qff3o2yU9pf6oNrJrcZp1a7BHvKJX0MTt7oP8N/stYcAUkhUr2tz7rf87jXuw3gPn2xH+iNbf+9ZYcWX4Vc4EKGiYT3OEzYkQQHwsZV4I9v1TEfGByLMeOvoB22gg5UoJb8ZhsXM2WbQCl1G5lpigdVlCNCdLmImigni0liMc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:27 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:27 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 06/21] commit-graph: add 'verify' subcommand
Thread-Topic: [PATCH v5 06/21] commit-graph: add 'verify' subcommand
Thread-Index: AQHT/YqboYzdveMZx0KMQ7IGQjGFgA==
Date:   Wed, 6 Jun 2018 11:36:27 +0000
Message-ID: <20180606113611.87822-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:4JFP9WKY/GYelmczYwOMJ3u9g3mKA2RjOiy/m26jWIOusef9huu2fp6r/8DUYVy4GV9LG/QjxD2HpgLhAwoi0s5pBGUV2hf4Y6KuTAmYUYKL1V9iHrw4ACdCBztyaPkHGx9H7CW5uQIHf87IOBEVnxxJEyLRSUSXdvX7Tfa49sExfpwMLXXqLP4DgN1ZZEphU5w0BVaHc2LGKokOUPD14rnZjJgPR/4MZ7ZmVAmVH2SPzf1GD3LRFSBulKCL0OYD
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1044F2271697CD111E1C8652A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(575784001)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AaPQMOjbGbyEQX8qQvL/dt4Ufz4wEkDzNKX+aqxYxQRNl7Lpbw2VEbSo7Hj3BRbiFJVSbHZXKAyd1L4gZh7hjPu2LL2IJh4xcE4D74Nv6RA5umP06MdQMTf+FKEWPxh/m7plXk1L6R2sjgZ1m4eljX0hERg2yq7pFBTquYvpg6q/dwQ2n5Il/P3TqFoNJzMY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 322c8279-bff2-41a5-518e-08d5cba1bd75
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322c8279-bff2-41a5-518e-08d5cba1bd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:27.5501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
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
 builtin/commit-graph.c             | 38 ++++++++++++++++++++++++++++++
 commit-graph.c                     | 23 ++++++++++++++++++
 commit-graph.h                     |  2 ++
 t/t5318-commit-graph.sh            | 10 ++++++++
 5 files changed, 79 insertions(+)

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
index f0875b8bf3..3079cde6f9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,10 +8,16 @@
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
@@ -29,6 +35,36 @@ static struct opts_commit_graph {
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
+	return verify_commit_graph(graph);
+}
+
 static int graph_read(int argc, const char **argv)
 {
 	struct commit_graph *graph =3D NULL;
@@ -165,6 +201,8 @@ int cmd_commit_graph(int argc, const char **argv, const=
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
index 9e228d3bb5..432920ad2a 100644
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
+int verify_commit_graph(struct commit_graph *g)
+{
+	if (!g) {
+		graph_report("no commit-graph file loaded");
+		return 1;
+	}
+
+	return verify_commit_graph_error;
+}
diff --git a/commit-graph.h b/commit-graph.h
index 96cccb10f3..71a39c5a57 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -53,4 +53,6 @@ void write_commit_graph(const char *obj_dir,
 			int nr_commits,
 			int append);
=20
+int verify_commit_graph(struct commit_graph *g);
+
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 59d0be2877..0830ef9fdd 100755
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

