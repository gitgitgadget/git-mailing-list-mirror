Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD6C1F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031064AbeEXQZs (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:25:48 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28256
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030874AbeEXQZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvgl0nBrJ+ZjDF9+fk+XfmpO6FS3GnEJVONvqcQNxt0=;
 b=d6HGTKMXQtE5QOT361q2wabeA8PWiW7rw7MI6k/AfzGS2jFOzVp1JDnBB6petDelYX6bLgZ+czKl3XJaarF2jb+anjd7IsXAOcUyUKwiMKqfi4o7cedz2usPC0x7f2fDpDoCpKxESMd7CYyGiuvNUsxZFYrFfyDYHRMDzYZ/Ajo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0882.namprd21.prod.outlook.com (52.132.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:38 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 06/20] commit-graph: add 'verify' subcommand
Thread-Topic: [PATCH v3 06/20] commit-graph: add 'verify' subcommand
Thread-Index: AQHT83vZXQbXzt7rPUKUS1Iltf6IXg==
Date:   Thu, 24 May 2018 16:25:37 +0000
Message-ID: <20180524162504.158394-7-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0882;7:H08y9/yxVcib1GrGXhHj2tqj9D+xN15YENhZKjxOOnC7LkboLWriL2Rnn3gFNz/RNlGFWbejji+TdRPc/Sim9AI8Ze44FSza7ahDxn6pAWwtlI9IyiizQwqOki9faenjVO+SQPkch9pF2up11/QdaIjiSRXcTuJ+LdYtR50jTIL79OFDNRbSsXdcgmmgx/E6pej9HIA+701+GC2yirWOrLUdTGo7OKdCFUnHdLAfif6l4OVwRH/bvMcBZf0CdPRv;20:Ot/IVnEQl0O3s/fJVEcH+vGuSLr0GolDJQslY9XuQ2ymHc4jDBgup+WX5Xl2IQlL34irW/JW5WRLLTycuAZfXIGuqOmplQwWPAtTbGCkKIwk2BceTAfz9URhXX4iHKiajLvClnWTzCw6GTxJGnH3fmlAbWSMaUcKMp1fWYdkOIQ=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0882;
x-ms-traffictypediagnostic: BL0PR2101MB0882:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB08827B95A0FBE62BBC43FD38A16A0@BL0PR2101MB0882.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0882;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0882;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(36756003)(6116002)(107886003)(1076002)(6486002)(5250100002)(2501003)(6916009)(5660300001)(97736004)(316002)(99286004)(10090500001)(8656006)(6512007)(53936002)(54906003)(39060400002)(22452003)(4326008)(8676002)(2906002)(102836004)(2900100001)(1730700003)(81166006)(81156014)(2351001)(386003)(6506007)(3280700002)(476003)(2616005)(5640700003)(486006)(52116002)(14454004)(46003)(6436002)(25786009)(11346002)(86362001)(86612001)(446003)(305945005)(186003)(10290500003)(105586002)(7736002)(3660700001)(68736007)(76176011)(8936002)(59450400001)(106356001)(478600001)(15650500001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0882;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vO3NevLCVO/RupI+u5/lOkyt8u7dDT68BioO6wznWA/SlN4nV0FVzy2/ZOrVvW5r5iUtLdmcqvrG/PLoU5VplmIfLNuyh537I53c1O683ghbbIkzyiKH+emyxGSySKe/wtejqTDa27YnHHQYuUIB08Sn0xp3yQvgWXBm4Mz8pZ+idA4fE41kPHDCZ9VBWCYu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1331736f-3c41-4e8d-032b-08d5c192fb82
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1331736f-3c41-4e8d-032b-08d5c192fb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:37.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0882
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  6 ++++++
 builtin/commit-graph.c             | 38 ++++++++++++++++++++++++++++++++++=
++++
 commit-graph.c                     | 26 ++++++++++++++++++++++++++
 commit-graph.h                     |  2 ++
 t/t5318-commit-graph.sh            | 10 ++++++++++
 5 files changed, 82 insertions(+)

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
index f0875b8bf3..0433dd6e20 100644
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
+	struct commit_graph *graph =3D 0;
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
@@ -163,6 +199,8 @@ int cmd_commit_graph(int argc, const char **argv, const=
 char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	if (argc > 0) {
+		if (!strcmp(argv[0], "verify"))
+			return graph_verify(argc, argv);
 		if (!strcmp(argv[0], "read"))
 			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "write"))
diff --git a/commit-graph.c b/commit-graph.c
index 25893ec096..55b41664ee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -836,3 +836,29 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc =3D 0;
 	oids.nr =3D 0;
 }
+
+static int verify_commit_graph_error;
+
+static void graph_report(const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf sb =3D STRBUF_INIT;
+	verify_commit_graph_error =3D 1;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+
+	fprintf(stderr, "%s\n", sb.buf);
+	strbuf_release(&sb);
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
2.16.2.329.gfb62395de6

