Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65B71F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeBSSyU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:54:20 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37127 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeBSSxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:38 -0500
Received: by mail-qt0-f193.google.com with SMTP id d26so13458818qtj.4
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZGMcFc0Xc5foFqcdhRF2/l6h8OzTqMLYH9CBlSnwqZ4=;
        b=t1Z5f3hCfqw6q/aOPjqCRTIec30zP94qXD2dcGsf8g2+sboN5CKq6Z/042kZlBcA2l
         F0/bgdoXoDf7u9qZCVYxNnxGSzpXckskqVbb7mYwJCcqkpw/1HCpLa1m23kyDXd5amGO
         iaiwl53DRGgPHXeklDANIPHSXag9dYmPGpLv0hthT0uH7EcIkEk3M7YNj6KA+BLjfR/u
         Pg8jFLkB5+1M5zs7HcAINnckosujELVH2x1av0ZLVy3m4AWXaVVBNEQEnriZcdD54l4k
         zO94qA7ALogSNSkG6XODPSkCG7R/gxnt1GXD+4UupmiiC4F6AxRlrI7O0izlv8bxbaO6
         AhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZGMcFc0Xc5foFqcdhRF2/l6h8OzTqMLYH9CBlSnwqZ4=;
        b=G5xkDrnuI55TaZFkRyJ0cDDcZaydAL75trG+tQ54gPMI9eylq/6FxrNA+YfQ8JboDX
         N7rOrnMkPBlQ9V+5tkauvNpY2PaBI+WG/MqMhiNstiPKIMWZWfeR2Jia1ZcOgo61lfao
         D1LG02LkxjlXklrZls+Lnd58qDs+rLcB3rSleBy8H9vz5458lG3GMctFD0FesMnjvsfi
         mhg722dVpBDt15O2cZ9vd3Jlj5lN6Ii/Mk+B8RID0qI5N7MPuusrJGgj+v8qwqyIww/I
         T9weOTzEEqIs382Em2Sl97J72N70c8KHJFvyji55zMBTgZh4edZoht1hkXkAO38IlqVE
         kULQ==
X-Gm-Message-State: APf1xPD7TfhqGVbwifwx9g1sEROocSlnSrXxXNZhdxvYdzVt67AhJcvn
        3YTxS8KwwlNsjBFAclBP+e9CYtXZLYM=
X-Google-Smtp-Source: AH8x225MQCmOp+6wswNS6+cJc/jAgVd6KglUJehhaOYIrvyTlnp1mpy1wD5xxsetLG3Q9ka7CmzpNw==
X-Received: by 10.200.51.248 with SMTP id d53mr23506014qtb.338.1519066417576;
        Mon, 19 Feb 2018 10:53:37 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:36 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 05/13] commit-graph: implement 'git-commit-graph write'
Date:   Mon, 19 Feb 2018 13:53:18 -0500
Message-Id: <1519066406-81663-6-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to write graph files. Create new test script to verify
this command succeeds without failure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  40 +++++++++++++
 builtin/commit-graph.c             |  43 +++++++++++++-
 t/t5318-commit-graph.sh            | 119 +++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100755 t/t5318-commit-graph.sh

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index e1c3078..c3f222f 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -5,6 +5,46 @@ NAME
 ----
 git-commit-graph - Write and verify Git commit graphs (.graph files)
 
+
+SYNOPSIS
+--------
+[verse]
+'git commit-graph write' <options> [--object-dir <dir>]
+
+
+DESCRIPTION
+-----------
+
+Manage the serialized commit graph file.
+
+
+OPTIONS
+-------
+--object-dir::
+	Use given directory for the location of packfiles and graph files.
+	The graph files will be in <dir>/info and the packfiles are expected
+	to be in <dir>/pack.
+
+
+COMMANDS
+--------
+'write'::
+
+Write a commit graph file based on the commits found in packfiles.
+Includes all commits from the existing commit graph file. Outputs the
+resulting filename.
+
+
+EXAMPLES
+--------
+
+* Write a commit graph file for the packed commits in your local .git folder.
++
+------------------------------------------------
+$ git commit-graph write
+------------------------------------------------
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 98110bb..a51d87b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,9 +1,18 @@
 #include "builtin.h"
 #include "config.h"
+#include "dir.h"
+#include "lockfile.h"
 #include "parse-options.h"
+#include "commit-graph.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
+	N_("git commit-graph write [--object-dir <objdir>]"),
+	NULL
+};
+
+static const char * const builtin_commit_graph_write_usage[] = {
+	N_("git commit-graph write [--object-dir <objdir>]"),
 	NULL
 };
 
@@ -11,11 +20,38 @@ static struct opts_commit_graph {
 	const char *obj_dir;
 } opts;
 
+static int graph_write(int argc, const char **argv)
+{
+	char *graph_name;
+
+	static struct option builtin_commit_graph_write_options[] = {
+		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
+			N_("dir"),
+			N_("The object directory to store the graph") },
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_commit_graph_write_options,
+			     builtin_commit_graph_write_usage, 0);
+
+	if (!opts.obj_dir)
+		opts.obj_dir = get_object_directory();
+
+	graph_name = write_commit_graph(opts.obj_dir);
+
+	if (graph_name) {
+		printf("%s\n", graph_name);
+		FREE_AND_NULL(graph_name);
+	}
+
+	return 0;
+}
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_commit_graph_options[] = {
-		{ OPTION_STRING, 'p', "object-dir", &opts.obj_dir,
+		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph") },
 		OPT_END(),
@@ -31,6 +67,11 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     builtin_commit_graph_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (argc > 0) {
+		if (!strcmp(argv[0], "write"))
+			return graph_write(argc, argv);
+	}
+
 	usage_with_options(builtin_commit_graph_usage,
 			   builtin_commit_graph_options);
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
new file mode 100755
index 0000000..6a5e93c
--- /dev/null
+++ b/t/t5318-commit-graph.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description='commit graph'
+. ./test-lib.sh
+
+test_expect_success 'setup full repo' '
+	rm -rf .git &&
+	mkdir full &&
+	cd full &&
+	git init &&
+	objdir=".git/objects"
+'
+
+test_expect_success 'write graph with no packs' '
+	git commit-graph write --object-dir .
+'
+
+test_expect_success 'create commits and repack' '
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i
+	done &&
+	git repack
+'
+
+test_expect_success 'write graph' '
+	graph1=$(git commit-graph write) &&
+	test_path_is_file $objdir/info/$graph1
+'
+
+test_expect_success 'Add more commits' '
+	git reset --hard commits/1 &&
+	for i in $(test_seq 4 5)
+	do
+		test_commit $i &&
+		git branch commits/$i
+	done &&
+	git reset --hard commits/2 &&
+	for i in $(test_seq 6 7)
+	do
+		test_commit $i &&
+		git branch commits/$i
+	done &&
+	git reset --hard commits/2 &&
+	git merge commits/4 &&
+	git branch merge/1 &&
+	git reset --hard commits/4 &&
+	git merge commits/6 &&
+	git branch merge/2 &&
+	git reset --hard commits/3 &&
+	git merge commits/5 commits/7 &&
+	git branch merge/3 &&
+	git repack
+'
+
+# Current graph structure:
+#
+#   __M3___
+#  /   |   \
+# 3 M1 5 M2 7
+# |/  \|/  \|
+# 2    4    6
+# |___/____/
+# 1
+
+
+test_expect_success 'write graph with merges' '
+	graph2=$(git commit-graph write)&&
+	test_path_is_file $objdir/info/$graph2
+'
+
+test_expect_success 'Add one more commit' '
+	test_commit 8 &&
+	git branch commits/8 &&
+	ls $objdir/pack | grep idx >existing-idx &&
+	git repack &&
+	ls $objdir/pack| grep idx | grep -v --file=existing-idx >new-idx
+'
+
+# Current graph structure:
+#
+#      8
+#      |
+#   __M3___
+#  /   |   \
+# 3 M1 5 M2 7
+# |/  \|/  \|
+# 2    4    6
+# |___/____/
+# 1
+
+test_expect_success 'write graph with new commit' '
+	graph3=$(git commit-graph write) &&
+	test_path_is_file $objdir/info/$graph3
+'
+
+test_expect_success 'write graph with nothing new' '
+	graph4=$(git commit-graph write) &&
+	test_path_is_file $objdir/info/$graph4 &&
+	printf $graph3 >expect &&
+	printf $graph4 >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'setup bare repo' '
+	cd .. &&
+	git clone --bare --no-local full bare &&
+	cd bare &&
+	baredir="./objects"
+'
+
+test_expect_success 'write graph in bare repo' '
+	graphbare=$(git commit-graph write) &&
+	test_path_is_file $baredir/info/$graphbare
+'
+
+test_done
+
-- 
2.7.4

