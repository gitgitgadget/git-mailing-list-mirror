Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874631F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFHN4u (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:50 -0400
Received: from mail-eopbgr730133.outbound.protection.outlook.com ([40.107.73.133]:45030
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752478AbeFHN4d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWGYSl097QIO3066yR+3BkzT7I7S06t1ArK00ylmxZY=;
 b=Rn+g7RiZSnSbw6Lof6uHdcILzeBY/1KgrU5ZSyY8nhbxoRvOPp5kVr8GF9tpExtO34rOhFp50QXvo9oJ7TUk5qJhw3ofZcqVS9o/Vjo+Ct5XR7GD3v5IOb5Ao0nbmS8G3Y/RGkADy1O+4AI6q4pD43CEvE9w3KgXmXYwalxOSt0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1121.namprd21.prod.outlook.com (52.132.18.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:29 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:29 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 19/21] commit-graph: add '--reachable' option
Thread-Topic: [PATCH v6 19/21] commit-graph: add '--reachable' option
Thread-Index: AQHT/zB/YdltSQdybEe8qtpd8UtNXA==
Date:   Fri, 8 Jun 2018 13:56:28 +0000
Message-ID: <20180608135548.216405-20-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1121;7:Jbl9f+COEm3LPG+Fm/OagODPc1M5TJJCQ1z6R0hjhFLeSxgHQ8AO+ieXCP3LZr/CXjZYKr9BZL8eUctrsVprT9EKS1yVMPuEiG9UhxtQwS0nf9NcmIkdRc8+EVZbu4dYygXflWy9nseomNT/BT5YFn5LeNaIhYTdYEX/K3DE5QWpc2ZkbXrDm6+cIqVxsX7k0YoLAcqdkvMIaTNTC13ff0uiUCQ7Fq7FleU2wCS0lJZeFMQW3alDARVBvB1oBYh8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1121;
x-ms-traffictypediagnostic: BL0PR2101MB1121:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1121955587D2C430536D8656A17B0@BL0PR2101MB1121.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1121;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1121;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(2900100001)(1076002)(4326008)(2906002)(86362001)(575784001)(6116002)(1730700003)(8936002)(14454004)(25786009)(3660700001)(105586002)(6506007)(386003)(59450400001)(10090500001)(478600001)(107886003)(6512007)(68736007)(86612001)(76176011)(305945005)(8676002)(81156014)(39060400002)(3280700002)(53936002)(186003)(46003)(6916009)(6486002)(446003)(5250100002)(11346002)(6436002)(5640700003)(2501003)(99286004)(8656006)(316002)(22452003)(106356001)(54906003)(102836004)(36756003)(2351001)(5660300001)(7736002)(97736004)(10290500003)(81166006)(52116002)(476003)(486006)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1121;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fhvOmrepu5HIrRS4mIv5vqm3nz7jnneBMNw8/zI6fW6P3bt7QupChtpNOFOF1o1sEejpjWBuJGRQqLpy586p5itlu72uGeQUynjn8kEFxNUDPswTUQnND68yoT4HXRurrjqHdRy6ZjdQse82L5Sav+y5MN+LmtvirjFsi8Y9fHBJuG71aAtp71Y+KMtYbulw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b363caeb-9b4c-49f3-cd48-08d5cd47a1e6
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b363caeb-9b4c-49f3-cd48-08d5cd47a1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:28.9475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1121
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing commit-graph files, it can be convenient to ask for all
reachable commits (starting at the ref set) in the resulting file. This
is particularly helpful when writing to stdin is complicated, such as a
future integration with 'git gc'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  8 ++++++--
 builtin/commit-graph.c             | 16 ++++++++++++----
 commit-graph.c                     | 18 ++++++++++++++++++
 commit-graph.h                     |  1 +
 t/t5318-commit-graph.sh            | 10 ++++++++++
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index a222cfab08..dececb79d7 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -38,12 +38,16 @@ Write a commit graph file based on the commits found in=
 packfiles.
 +
 With the `--stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
-with --stdin-commits.)
+with `--stdin-commits` or `--reachable`.)
 +
 With the `--stdin-commits` option, generate the new commit graph by
 walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
---stdin-packs.)
+`--stdin-packs` or `--reachable`.)
++
+With the `--reachable` option, generate the new commit graph by walking
+commits starting at all refs. (Cannot be combined with `--stdin-commits`
+or `--stdin-packs`.)
 +
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ea28bc311a..c7d0db5ab4 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] =
=3D {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachabl=
e|--stdin-packs|--stdin-commits]"),
 	NULL
 };
=20
@@ -25,12 +25,13 @@ static const char * const builtin_commit_graph_read_usa=
ge[] =3D {
 };
=20
 static const char * const builtin_commit_graph_write_usage[] =3D {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachabl=
e|--stdin-packs|--stdin-commits]"),
 	NULL
 };
=20
 static struct opts_commit_graph {
 	const char *obj_dir;
+	int reachable;
 	int stdin_packs;
 	int stdin_commits;
 	int append;
@@ -127,6 +128,8 @@ static int graph_write(int argc, const char **argv)
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
+		OPT_BOOL(0, "reachable", &opts.reachable,
+			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
@@ -140,11 +143,16 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
=20
-	if (opts.stdin_packs && opts.stdin_commits)
-		die(_("cannot use both --stdin-commits and --stdin-packs"));
+	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
+		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs=
"));
 	if (!opts.obj_dir)
 		opts.obj_dir =3D get_object_directory();
=20
+	if (opts.reachable) {
+		write_commit_graph_reachable(opts.obj_dir, opts.append);
+		return 0;
+	}
+
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf =3D STRBUF_INIT;
diff --git a/commit-graph.c b/commit-graph.c
index a06e7e9549..adf54e3fe7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -7,6 +7,7 @@
 #include "packfile.h"
 #include "commit.h"
 #include "object.h"
+#include "refs.h"
 #include "revision.h"
 #include "sha1-lookup.h"
 #include "commit-graph.h"
@@ -656,6 +657,23 @@ static void compute_generation_numbers(struct packed_c=
ommit_list* commits)
 	}
 }
=20
+static int add_ref_to_list(const char *refname,
+			   const struct object_id *oid,
+			   int flags, void *cb_data)
+{
+	struct string_list *list =3D (struct string_list*)cb_data;
+	string_list_append(list, oid_to_hex(oid));
+	return 0;
+}
+
+void write_commit_graph_reachable(const char *obj_dir, int append)
+{
+	struct string_list list;
+	string_list_init(&list, 1);
+	for_each_ref(add_ref_to_list, &list);
+	write_commit_graph(obj_dir, NULL, &list, append);
+}
+
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
 			struct string_list *commit_hex,
diff --git a/commit-graph.h b/commit-graph.h
index a79b854470..506cb45fb1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,6 +48,7 @@ struct commit_graph {
=20
 struct commit_graph *load_commit_graph_one(const char *graph_file);
=20
+void write_commit_graph_reachable(const char *obj_dir, int append);
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
 			struct string_list *commit_hex,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 0da5a51552..06ecbb3f4a 100755
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
--=20
2.18.0.rc1

