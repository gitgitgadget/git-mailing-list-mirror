Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75521F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeBHUiB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:01 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33911 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeBHUh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:37:58 -0500
Received: by mail-qt0-f196.google.com with SMTP id d14so7915050qtg.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mvZQ1GDQjYXyLm8tKHtS+8gCe5IAJZsaRvkInsFOWGU=;
        b=ZwFUKMKel3ZmYaOBxVHTcdVpcITkrBuBsrMdWWycJEe2l8Sd5EBaOVRefF7UDZT3Jz
         2l6OnWdDyg8vF81fIjGbBAWyMmW/rPn5wjaFTrNJDZyHRWwjzCtA6uoIPi/hUsi9KaD7
         RKFx3ris2TyKlvmPYgQCmgJWBfJdy+iV3b01SOgVvrhPME+nqD6SNIwUndX1x/idX2Tb
         ZQWax6ZYd1lIqPjo5lUCp2EhAugxS8vRFICDIsmzS5tKqL9n736Ro7HoJBSc3h26VBoE
         JCy8obdpxxnd7Sr/3o4xynl2GA3UwRlpVYu/gSta0D4GWna56/mm7xZegqi9ZBGOMzbM
         QN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mvZQ1GDQjYXyLm8tKHtS+8gCe5IAJZsaRvkInsFOWGU=;
        b=gzaxM1+xT4gwVeDjgSS8Fvjouv5W1n5pPQMMzBomWoViFnT0tGGeeLkBkBBVFVgPr3
         MOQHK3Mspn5HdANNH4sxhdLGD5mlmD0U6XnyDAAgjbVQZty1PLKwnZSYSajqALeHZjP3
         cuk9Wp+WKbpNK2UCV2jHdxgIGQiddMxLK1xImYfyp56wrXWIoHgaVsoCUMJ5HiZhMrVr
         Biwd3mx4i9MZ6GDoWJgSxqeXmjFSTI4R03N+S3PUOkYx7I9XYGusKZTztpyEZW3VGR6p
         ALPbyIlmmg5dNx/yTQFxphuQ+RBlH0QM5BdLQfLv0Gx9LDTyRFAmPHXdxGCD7DKCrVrh
         JY8Q==
X-Gm-Message-State: APf1xPBYV8bHokD9yAvEf3XAs4i8hrpQXJjkNxh+GgYRXpVSCXDIRe3q
        cirwvQ/uNOE7pLH7RFTXPdhGZ3H+3xc=
X-Google-Smtp-Source: AH8x226YoOdRR686qbU1ewRqg+1PP++fLwxSrUUOk7w/Lsa5+8EUzZ4UKbF/CFmFdW3LpehrPl3utw==
X-Received: by 10.200.112.10 with SMTP id x10mr732069qtm.295.1518122277167;
        Thu, 08 Feb 2018 12:37:57 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:56 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 05/14] commit-graph: implement 'git-commit-graph write'
Date:   Thu,  8 Feb 2018 15:37:29 -0500
Message-Id: <1518122258-157281-6-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to write graph files. Create new test script to verify
this command succeeds without failure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  39 +++++++++++++
 builtin/commit-graph.c             |  43 +++++++++++++++
 t/t5318-commit-graph.sh            | 109 +++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100755 t/t5318-commit-graph.sh

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index e1c3078ca1..55dfe5c3d8 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -5,6 +5,45 @@ NAME
 ----
 git-commit-graph - Write and verify Git commit graphs (.graph files)
 
+
+SYNOPSIS
+--------
+[verse]
+'git commit-graph write' <options> [--pack-dir <pack_dir>]
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
+--pack-dir::
+	Use given directory for the location of packfiles, graph-head,
+	and graph files.
+
+
+COMMANDS
+--------
+'write'::
+
+Write a commit graph file based on the commits found in packfiles.
+Includes all commits from the existing commit graph file. Outputs the
+checksum hash of the written file.
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
index a01c5d9981..5dac033bfe 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,9 +1,16 @@
 #include "builtin.h"
 #include "config.h"
 #include "parse-options.h"
+#include "commit-graph.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
+	N_("git commit-graph write [--pack-dir <packdir>]"),
+	NULL
+};
+
+static const char * const builtin_commit_graph_write_usage[] = {
+	N_("git commit-graph write [--pack-dir <packdir>]"),
 	NULL
 };
 
@@ -11,6 +18,37 @@ static struct opts_commit_graph {
 	const char *pack_dir;
 } opts;
 
+static int graph_write(int argc, const char **argv)
+{
+	struct object_id *graph_hash;
+
+	static struct option builtin_commit_graph_write_options[] = {
+		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
+			N_("dir"),
+			N_("The pack directory to store the graph") },
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_commit_graph_write_options,
+			     builtin_commit_graph_write_usage, 0);
+
+	if (!opts.pack_dir) {
+		struct strbuf path = STRBUF_INIT;
+		strbuf_addstr(&path, get_object_directory());
+		strbuf_addstr(&path, "/pack");
+		opts.pack_dir = strbuf_detach(&path, NULL);
+	}
+
+	graph_hash = write_commit_graph(opts.pack_dir);
+
+	if (graph_hash) {
+		printf("%s\n", oid_to_hex(graph_hash));
+		FREE_AND_NULL(graph_hash);
+	}
+
+	return 0;
+}
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
@@ -31,6 +69,11 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
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
index 0000000000..b762587595
--- /dev/null
+++ b/t/t5318-commit-graph.sh
@@ -0,0 +1,109 @@
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
+	packdir=".git/objects/pack"'
+
+test_expect_success 'write graph with no packs' '
+	git commit-graph write --pack-dir .'
+
+test_expect_success 'create commits and repack' '
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i
+	done &&
+	git repack'
+
+test_expect_success 'write graph' '
+	graph1=$(git commit-graph write) &&
+	test_path_is_file $packdir/graph-$graph1.graph'
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
+	git repack'
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
+	test_path_is_file $packdir/graph-$graph2.graph'
+
+test_expect_success 'Add one more commit' '
+	test_commit 8 &&
+	git branch commits/8 &&
+	ls $packdir | grep idx >existing-idx &&
+	git repack &&
+	ls $packdir | grep idx | grep -v --file=existing-idx >new-idx'
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
+	test_path_is_file $packdir/graph-$graph3.graph'
+
+
+test_expect_success 'write graph with nothing new' '
+	graph4=$(git commit-graph write) &&
+	test_path_is_file $packdir/graph-$graph4.graph &&
+	printf $graph3 >expect &&
+	printf $graph4 >output &&
+	test_cmp expect output'
+
+test_expect_success 'setup bare repo' '
+	cd .. &&
+	git clone --bare --no-local full bare &&
+	cd bare &&
+	baredir="./objects/pack"'
+
+test_expect_success 'write graph in bare repo' '
+	graphbare=$(git commit-graph write) &&
+	test_path_is_file $baredir/graph-$graphbare.graph'
+
+test_done
+
-- 
2.15.1.45.g9b7079f

