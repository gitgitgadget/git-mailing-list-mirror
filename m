Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394C21F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDQSKv (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:10:51 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:13488
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752786AbeDQSKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BAWK5uWvpLHvxaI+U5pdYTIOzKtLDQ0LtJrs+4Rb1iM=;
 b=lmQwUZ1lNIlLz4SHDjlzitLP3R7rrHSpd3forTDiIfAVaUIFGLcvxomm/QJjTAclx0N6kSnDy2HP4qp4q3/T4OCgi/FxrEyw9FhteLHwM9AtnYveOQ/D8MpWV6zne4LpFqFe/gWMXCLDeKcY14bp07KXMMBdoFVSSTjdkqqMdnU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:45 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:45 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 10/12] commit-graph: add '--reachable' option
Thread-Topic: [RFC PATCH 10/12] commit-graph: add '--reachable' option
Thread-Index: AQHT1ndnCq5iZGrK/UWguhInO+W8Jg==
Date:   Tue, 17 Apr 2018 18:10:44 +0000
Message-ID: <20180417181028.198397-11-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:7YdrGFjAQ51M1Y2QOoVo2ouJ+09E0mtc+tLKWkvxKUsKtZ4uypntGTYCEjk56zZpfk4+oukJYFigOt367/HDfNdNY0mu5ikq8nQ77Ch/zCrsTLHFiUrdrXQCOdtJL9Gz44dmDgbmCpk63YonJCeoUbrFl7GITzE891TQdiliKzKE77q0kD1IdA5TulDydROj0N/q+qoZiRD6ITFvVwbSlXTlbQDLBHKMfHttHhN0DgyaWMdSoqb8q2cwQ7MqgDcI;20:JXctsPjhat/v4PwTMhUK10z3m8jdG+cOL2eT41g+q/moXtDXLOwlFpjA0gJKXcnWvYbVmNdSDNqkgFseTtvoem4iqTg0gOkrNriuu5uTRZqgsVAa0ImQ9mIG/kmofJacdmz+Ha1iOyYYM7QIzJGHxPbI8fJLo2cdmUJSEjZh8R0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0994D62601B4CBF18C273867A1B70@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(199004)(189003)(6506007)(386003)(102836004)(486006)(52116002)(316002)(106356001)(76176011)(54906003)(68736007)(7736002)(22452003)(2616005)(53936002)(46003)(99286004)(11346002)(476003)(305945005)(2501003)(186003)(86612001)(5250100002)(86362001)(6436002)(446003)(6116002)(6512007)(10090500001)(5640700003)(10290500003)(14454004)(25786009)(2351001)(4326008)(97736004)(2906002)(107886003)(5660300001)(478600001)(1076002)(2900100001)(8676002)(36756003)(8936002)(6916009)(81166006)(1730700003)(81156014)(105586002)(3280700002)(3660700001)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CRybNTnoWGq3C9KHpOWENwKucT7/8MkSk8dcj4KLsqhba0PhfsKcQ8WtjNapZpcKb98i8qBIj1sM3W6CkgvASb5vZ/TeWlffbgkPLpSb7KrwbMV5TGEgn8nwfDU3eevqy2d0866EOtKePUdZ/X/TcS+BX0UDovGnmBqiZ0G7nepDwt2Y4pM8NUVVjGwUrzlq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2476b180-81fd-44d8-bd63-08d5a48e8989
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2476b180-81fd-44d8-bd63-08d5a48e8989
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:44.6612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing commit-graph files, it can be convenient to ask for all
reachable commits (starting at the ref set) in the resulting file. This
is particularly helpful when writing to stdin is complicated, such as a
future integration with 'git gc' which will call
'git commit-graph write --reachable' after performing cleanup of the
object database.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  8 ++++--
 builtin/commit-graph.c             | 41 +++++++++++++++++++++++++++---
 t/t5318-commit-graph.sh            | 10 ++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index 93c7841ba2..1b14d40590 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -37,12 +37,16 @@ Write a commit graph file based on the commits found in=
 packfiles.
 +
 With the `--stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
-with --stdin-commits.)
+with --stdin-commits or --reachable.)
 +
 With the `--stdin-commits` option, generate the new commit graph by
 walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
---stdin-packs.)
+--stdin-packs or --reachable.)
++
+With the `--reachable` option, generate the new commit graph by walking
+commits starting at all refs. (Cannot be combined with --stdin-commits
+or --stind-packs.)
 +
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 77c1a04932..a89285ada8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -3,13 +3,14 @@
 #include "dir.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "refs.h"
 #include "commit-graph.h"
=20
 static char const * const builtin_commit_graph_usage[] =3D {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph check [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachabl=
e|--stdin-packs|--stdin-commits]"),
 	NULL
 };
=20
@@ -24,12 +25,13 @@ static const char * const builtin_commit_graph_read_usa=
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
@@ -113,6 +115,25 @@ static int graph_read(int argc, const char **argv)
 	return 0;
 }
=20
+struct hex_list {
+	char **hex_strs;
+	int hex_nr;
+	int hex_alloc;
+};
+
+static int add_ref_to_list(const char *refname,
+			   const struct object_id *oid,
+			   int flags, void *cb_data)
+{
+	struct hex_list *list =3D (struct hex_list*)cb_data;
+
+	ALLOC_GROW(list->hex_strs, list->hex_nr + 1, list->hex_alloc);
+	list->hex_strs[list->hex_nr] =3D xcalloc(GIT_MAX_HEXSZ + 1, 1);
+	strcpy(list->hex_strs[list->hex_nr], oid_to_hex(oid));
+	list->hex_nr++;
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	const char **pack_indexes =3D NULL;
@@ -127,6 +148,8 @@ static int graph_write(int argc, const char **argv)
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
+		OPT_BOOL(0, "reachable", &opts.reachable,
+			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
@@ -140,8 +163,8 @@ static int graph_write(int argc, const char **argv)
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
@@ -164,6 +187,16 @@ static int graph_write(int argc, const char **argv)
 			commit_hex =3D lines;
 			commits_nr =3D lines_nr;
 		}
+	} else if (opts.reachable) {
+		struct hex_list list;
+		list.hex_nr =3D 0;
+		list.hex_alloc =3D 128;
+		ALLOC_ARRAY(list.hex_strs, list.hex_alloc);
+
+		for_each_ref(add_ref_to_list, &list);
+
+		commit_hex =3D (const char **)list.hex_strs;
+		commits_nr =3D list.hex_nr;
 	}
=20
 	write_commit_graph(opts.obj_dir,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e91053271a..ccadd22f57 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -200,6 +200,16 @@ test_expect_success 'build graph from commits with app=
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
2.17.0.39.g685157f7fb

