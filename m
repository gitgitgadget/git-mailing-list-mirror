Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757451F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeGRQDE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:03:04 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:65376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730342AbeGRQDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZNvfc2vHAQ+pqHqL3A6nDu2EQd1avHHYPcC7E5E4no=;
 b=nrcbi2aV6yObiBYR6xJY/pFk+Vy5qa+EHkwvQbDJ/VadEfsnZa8zURioBMpHWoqoeabZEthLLUBAzd6IUa4LuV9rMOL8tv/XPbBl2dL3e0nX75q7hUgzrH0q7kV62gYRwfZL2DQtb/JdrmdGicq3osgosGSHZ2AhoYxdxZo3XcU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Wed, 18 Jul 2018 15:22:58 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 15:22:58 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] DO-NOT-MERGE: write and read commit-graph always
Thread-Topic: [PATCH] DO-NOT-MERGE: write and read commit-graph always
Thread-Index: AQHUHqs18dMzT8Q4Vk+DSSMZvDFRvQ==
Date:   Wed, 18 Jul 2018 15:22:58 +0000
Message-ID: <20180718152244.45513-1-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:0:52::24) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;6:ifXp5iz9fGLxdMkDxS8IxHa4ru4SqAMbeL9yzmlpbgtI5rgDrUQw9DXAgdg7/qINEhibOl0vma6SsvTg484mnJVpp0+GGndmcqaa9bvkPkl0nGiS1P+0/w3GQKUsr7c+hzHYiLShI8lUFxfblax8svqJO2oaoW+DQIdao8m4rHVdJVkbYxvQmgUiqnD6tBfy2xCZPKT6GNAhxY1MgAM/GDNpbClRpl7hKsoZrJf3sjDZ0QQNCYniRc8b2+3+bzfxDaZrNhvypMye5jOFSvvIMKJ4I0zVNlZdeFGyr2GChQeF2nrWpqkXd7xk/b0iMjwXZNIzKXneN42MIxeVL55IVp8Weyi88Oj7HQpF5ylnxTohBRwYgtSYX3a0c6y8HwJM1oWbiR3YEuixWghTBQqgmguWjdxNVM7s56lO61Kon49e673qv9KgLw4xabksHAuz5+pApUE6twD4AoUzLIp+YQ==;5:iIIFZWBCC9FI3TW6qKdWYjd5rLdtWcwkr5BJQAKTqs9L9YAgXe2EZKvjSxFIy/mK78LxkNFtulOpOfTFHjPHM0LuwZEXQ3pdtp+5wzUJhnRuYNCsEEzJLyEarX7CfZtZ9BdY+nhIvj0bawml6jVi8wAAs7gE6c4i4BJZbtL+P4o=;7:/seyyKa+pClSyErK7Fm1unYSyMOE3cYPOrYPjKH0xVBsJg9pZYHlQRgc4OGKmawoCvgOtIBuKY+EB8z+BwMEwUEOSTiFVj2e2f939UAGsBxI1QdcfVvDdK+nwj9cS/sLo9Wwn2fo34RUG9n82pZwg1nOqwgnSHwh0wM8w8L5liQYY/IKxR0xzCe/vm+i7QetYcUNS/3YqUAGEhDgJ3fEuz0ZXENC8EWQz2SXGllxAbId3cPZjorLKa0a0LJ0P/Hp
x-ms-office365-filtering-correlation-id: 010e5961-d3de-4f00-f827-08d5ecc2574e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600064)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09793034143D49E15B8A25B9A1530@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(25786009)(2900100001)(386003)(6916009)(6506007)(316002)(22452003)(10290500003)(68736007)(53936002)(5660300001)(102836004)(478600001)(6116002)(76176011)(1076002)(99286004)(575784001)(86362001)(86612001)(8936002)(2501003)(7736002)(446003)(2906002)(105586002)(305945005)(14444005)(486006)(36756003)(8676002)(1730700003)(81156014)(5250100002)(5640700003)(46003)(107886003)(52116002)(6486002)(6436002)(256004)(81166006)(1857600001)(2351001)(10090500001)(14454004)(4326008)(97736004)(476003)(11346002)(2616005)(6512007)(106356001)(186003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QFwmoCyzE5Tj8hC44GHuETLfskyW3JcPcYxkTdpVPtZl4CZRrueQsbkhT/6nUHWTZfthXPjZWxbXCFciClP6b10hbGyi8GTisRalDezrAJ9Nh3Mu64GjnOOjtbVlJE9A969cw9bRZEIpgT90vtc4SPEiH+w4nsRCiZe2Luy6Fz2CQXTwATk/fQFObhlTLpkgQfm7rCGQtvaLYRp3o4tXuCFaI0yvcZajauNsIuRZOib9NdjHUfcwTuLSnvVmoGc/+RJyCitSoHju9iJnYkQGVMLNnnmZIzfRS88/eETB6USrOBRTAMsAKAawesATfPpPixT4+UscNN5rRGzWDQX2chiY9NDllWoA14XvQ0sa2SE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010e5961-d3de-4f00-f827-08d5ecc2574e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 15:22:58.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is not intended to be merged, but is only to create a test
environment to see what works with the commit-graph feature and what
does not. The tests that fail are primarily related to corrupting the
object store to remove a commit from visibility and testing that
rev-list fails -- except it doesn't when there is a commit-graph that
prevents parsing from the object database. The following tests will fail
with this commit, but are not "real" bugs:

t0410-partial-clone.sh, Test 9
t5307-pack-missing-commit.sh, Tests 3-4
t6011-rev-list-with-bad-commit.sh, Test 4

The following test fails because the repo has ambiguous merge-bases, and
the commit-graph changes the walk order so we select a different one.
This alters the resulting merge from the expected result.

t6024-recursive-merge.sh, Test 4

The tests above are made to pass by deleting the commit-graph file
before the necessary steps.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c                    |  2 ++
 builtin/gc.c                        |  3 +--
 commit-graph.c                      | 11 -----------
 t/t0410-partial-clone.sh            |  1 +
 t/t5307-pack-missing-commit.sh      |  2 ++
 t/t6011-rev-list-with-bad-commit.sh |  1 +
 t/t6024-recursive-merge.sh          |  1 +
 7 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 158e3f843a..acc31252a9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -33,6 +33,7 @@
 #include "sequencer.h"
 #include "mailmap.h"
 #include "help.h"
+#include "commit-graph.h"
=20
 static const char * const builtin_commit_usage[] =3D {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1652,6 +1653,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
=20
 	rerere(0);
+	write_commit_graph_reachable(get_object_directory(), 1);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
diff --git a/builtin/gc.c b/builtin/gc.c
index e103f0f85d..60ab773087 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -41,7 +41,7 @@ static int aggressive_depth =3D 50;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
-static int gc_write_commit_graph;
+static int gc_write_commit_graph =3D 1;
 static int detach_auto =3D 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire =3D "1.day.ago";
@@ -131,7 +131,6 @@ static void gc_config(void)
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
-	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
diff --git a/commit-graph.c b/commit-graph.c
index 237d4e7d1b..ed0d27c12e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -227,22 +227,11 @@ static int prepare_commit_graph(struct repository *r)
 {
 	struct alternate_object_database *alt;
 	char *obj_dir;
-	int config_value;
=20
 	if (r->objects->commit_graph_attempted)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted =3D 1;
=20
-	if (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
-	    !config_value)
-		/*
-		 * This repository is not configured to use commit graphs, so
-		 * do not load one. (But report commit_graph_attempted anyway
-		 * so that commit graph loading is not attempted again for this
-		 * repository.)
-		 */
-		return 0;
-
 	if (!commit_graph_compatible(r))
 		return 0;
=20
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4984ca583d..c235672b03 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -181,6 +181,7 @@ test_expect_success 'rev-list stops traversal at missin=
g and promised commit' '
=20
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
+	rm -rf repo/.git/objects/info/commit-graph &&
 	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
 	grep $(git -C repo rev-parse bar) out &&
 	! grep $FOO out
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.s=
h
index ae52a1882d..0bb54ae227 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -24,10 +24,12 @@ test_expect_success 'check corruption' '
 '
=20
 test_expect_success 'rev-list notices corruption (1)' '
+	rm -rf .git/objects/info/commit-graph &&
 	test_must_fail git rev-list HEAD
 '
=20
 test_expect_success 'rev-list notices corruption (2)' '
+	rm -rf .git/objects/info/commit-graph &&
 	test_must_fail git rev-list --objects HEAD
 '
=20
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-ba=
d-commit.sh
index e51eb41f4b..9c9cc4d540 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -43,6 +43,7 @@ test_expect_success 'corrupt second commit object' \
=20
 test_expect_success 'rev-list should fail' \
    '
+   rm -rf .git/objects/info/commit-graph &&
    test_must_fail git rev-list --all > /dev/null
    '
=20
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 3f59e58dfb..cec10983cd 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -61,6 +61,7 @@ GIT_AUTHOR_DATE=3D"2006-12-12 23:00:08" git commit -m F
 '
=20
 test_expect_success "combined merge conflicts" "
+	rm -rf .git/objects/info/commit-graph &&
 	test_must_fail git merge -m final G
 "
=20
--=20
2.18.0.118.gd4f65b8d14

