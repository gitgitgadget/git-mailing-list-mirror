Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4B31F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966764AbeEJRec (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:32 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966735AbeEJReQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=t5bgTxLOZdP5WKOh9VLk2dscwLDVmYilkGyfeBqbDI8=;
 b=PPg/FgkpIsOuy8J/HFWCr3JMU470XXumaZ+djn/dwZko/05ifAd0+e/tH6OjsGCNtge3Ht/nLQ7UEveP9I1fvOuQFowlT7wwNtixu7pJLaN9JGRkGM6Bi9gIHSz93Fi3DQFctL8TckeZpRi4PYtQy2Pa6i16upuYDlOsgQtGbsk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:13 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:13 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 09/12] commit-graph: add '--reachable' option
Thread-Topic: [PATCH 09/12] commit-graph: add '--reachable' option
Thread-Index: AQHT6IUc0l4uB34UBUGnlsRZTLIkJg==
Date:   Thu, 10 May 2018 17:34:13 +0000
Message-ID: <20180510173345.40577-10-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:404:79::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:DYV5tUuxYBzqj4w++5GfmCYHFeFuIPbGAxgrA/RgTla3ZtmRqFAqxnN6bnq3t9LgpegFlqA6Or7ilWisPEk9WIdSDss/gC1Ag4shF7oNCCVo4vY5069brA2F84WIsU36OyT3nCp6VfgaVbhr4hTXpqS1pfQh4sLXCvQ9bL6RtVsC0hQrns+lilg6Sv0cDHyrnl88iMcZ26JZHxrzanEEoVLKUwYrFUgvEyFErUOiIwGEsIxTwE3Xytr3Yyholphj;20:UHit1vraXm0FXjdzW/1M5MDjXronJNTCnGu3X3xuZU8gH25Z6+5/sp+9C5szIbtXkHo+osFE8uxdqhckVWkjxrNqG51q7iO4JDodKKI9aR1GRhKu+2SbHy2vJoOKuqTFDJ8/0dYNE2yUq0nQOK/R3UerBb7BPqpQLOm8K0lC7CA=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09627D617FF97A51EBE7391EA1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3fqrKtME4cG6Dyamdv3UwpHktPnA7MnLIenfq2ORWjbjO/EG0g6wQc4OdcRHHpYPqPohDIU0jd3fAAzYfxWdBxkTkqZ//1EtnVIjMzxrk7ffFB1tKjZklO9s+zuNWHd/+nrF5Unw1DYn7nFDO8IAGGRqLXU1fzL5U8zFW3JxweoEjEWDDiZdvPxvDdynBDVo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1b226206-fb27-49bd-da47-08d5b69c3ee6
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b226206-fb27-49bd-da47-08d5b69c3ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:13.4947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
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
 Documentation/git-commit-graph.txt |  8 ++++++--
 builtin/commit-graph.c             | 41 ++++++++++++++++++++++++++++++++++=
----
 t/t5318-commit-graph.sh            | 10 ++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index 1daefa7fb1..fbab3feba1 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -38,12 +38,16 @@ Write a commit graph file based on the commits found in=
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
index f5d891f2b8..4c9328cdf2 100644
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
 	N_("git commit-graph verify [--object-dir <objdir>]"),
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
index 9680e6e6e0..82f95eb11f 100755
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

