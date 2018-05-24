Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B10C1F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033642AbeEXQ0n (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:43 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033620AbeEXQ0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p/8f/zEU9KMrJ/uiQxCCWodhfEx7TmjUIjrY4Iwnyk=;
 b=YQtsylDFiH4X8tHrCetK8xrUClvzNYrukttnBlBsMZFBx7D3r1y5wfp0KzgIhnghSNs7dX9rktfouCv66T0P6Ns4vYqgaWMBaUM+xtefCYMxHOZU/JnPDh83kwcm+Nn5Pzdc4P4RI/aBi5FZ3A1T70Bukvzi3mle/OTKrbxOWBw=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:26:06 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:26:06 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 18/20] commit-graph: add '--reachable' option
Thread-Topic: [PATCH v3 18/20] commit-graph: add '--reachable' option
Thread-Index: AQHT83vqylLax5yxxEKrafUXaUQTqQ==
Date:   Thu, 24 May 2018 16:26:06 +0000
Message-ID: <20180524162504.158394-19-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:REvKAVy4wvrn2Kc/Q7KWJM8570nM1UjW8T8FVtLg9grIUw8MsthzRokVDPk2TySK4nXRLzYxUQpATb1VceEKTBfnDOCgfQhKPZSHO8iOVk6mlD0Qv2mXoUK+iGg3R4JHqESoZdeK3B4ItKx2DCgAbdBLeAVOMfKZ/kAFSY9NBu9XvAPBYuDm/UVhAG1uwSDIZ/pJAnC7rUjKkIO7zHXJYJt3sJjgHMgFwi5+mgQG5zeBf7sk1ZDvMU9zKv81jgNE;20:TjxjQuvnq6ycOpIASyMpfcsw0EKZj9i6j6n6IXet9juHsWauOqH3NM4qjvyWqr7R1aPLaxip00uomh5KgMo7H4/stbjp1pN3dxGHjBHPvDjUr4Fh5cF84C/qzBI0gx6Dre2eojy94QcGhS5Z8bvTcxrHwY6PYvm4HxOxSovj0aU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB109197712F14C46B04D69AE9A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nN/q+ixe6Ylhvvc//4tF5h8PuOHzof1pUc3xf/tNwe1KegMJNpqcCk/8dqh0jdY62RzPae6ThNn7sS9l5U0xjQ0xqaDj0rvySdWglXY5BasL/4hjVsKFsOla7fz76z6r58UheGHUA+K/yQYTay734pIG5RFQ9O/8Hrk+pk8EnS4iOejnE5mvrea3UL+UU2NF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 164b89b1-6b99-413e-b486-08d5c1930c98
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164b89b1-6b99-413e-b486-08d5c1930c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:26:06.5305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing commit-graph files, it can be convenient to ask for all
reachable commits (starting at the ref set) in the resulting file. This
is particularly helpful when writing to stdin is complicated, such as a
future integration with 'git gc' which will call
write_commit_graph_reachable() after performing cleanup of the object
database.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  8 ++++++--
 builtin/commit-graph.c             | 16 ++++++++++++----
 commit-graph.c                     | 32 ++++++++++++++++++++++++++++++++
 commit-graph.h                     |  1 +
 t/t5318-commit-graph.sh            | 10 ++++++++++
 5 files changed, 61 insertions(+), 6 deletions(-)

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
index 0433dd6e20..20ce6437ae 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,7 @@ static char const * const builtin_commit_graph_usage[] =3D =
{
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
@@ -24,12 +24,13 @@ static const char * const builtin_commit_graph_read_usa=
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
@@ -130,6 +131,8 @@ static int graph_write(int argc, const char **argv)
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
+		OPT_BOOL(0, "reachable", &opts.reachable,
+			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
@@ -143,11 +146,16 @@ static int graph_write(int argc, const char **argv)
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
 	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf =3D STRBUF_INIT;
 		lines_nr =3D 0;
diff --git a/commit-graph.c b/commit-graph.c
index a33600c584..057d734926 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -6,6 +6,7 @@
 #include "packfile.h"
 #include "commit.h"
 #include "object.h"
+#include "refs.h"
 #include "revision.h"
 #include "sha1-lookup.h"
 #include "commit-graph.h"
@@ -651,6 +652,37 @@ static void compute_generation_numbers(struct packed_c=
ommit_list* commits)
 	}
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
+void write_commit_graph_reachable(const char *obj_dir, int append)
+{
+	struct hex_list list;
+	list.hex_nr =3D 0;
+	list.hex_alloc =3D 128;
+	ALLOC_ARRAY(list.hex_strs, list.hex_alloc);
+
+	for_each_ref(add_ref_to_list, &list);
+
+	write_commit_graph(obj_dir, NULL, 0, (const char **)list.hex_strs, list.h=
ex_nr, append);
+}
+
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
diff --git a/commit-graph.h b/commit-graph.h
index 71a39c5a57..9a06a5f188 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -46,6 +46,7 @@ struct commit_graph {
=20
 struct commit_graph *load_commit_graph_one(const char *graph_file);
=20
+void write_commit_graph_reachable(const char *obj_dir, int append);
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4941937163..a659620332 100755
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
2.16.2.329.gfb62395de6

