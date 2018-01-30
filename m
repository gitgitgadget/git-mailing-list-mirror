Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C702E1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeA3Vks (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:48 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45939 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeA3VkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:16 -0500
Received: by mail-qk0-f195.google.com with SMTP id z12so12108596qkf.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PRCcsRlriRacvA+SILmdAWTigiXH146WjiMQkdaDBeI=;
        b=oNPaPsxgUh093S/7wsyf1RLPY7d+Iab5DPULeEW/mSXt+HnHMYalO6MjwnCLO3GTFl
         FfCW7pb8Qni/vgoB1A7trOU0iVCReTRkBHDjnN5QbVxVj1DRs8Pd58eYL/cAt0+0QeOf
         uayNpdKhCSQUhqlx3JnDunnfNeqc33y/J7rAMJJStqu3dqI7P8YpRsVA8tCxOUclx5D2
         nVoFojqciWF2fRu+Lv91JY6J2X6KUK3yZK4yJnoQH6/AcaVmi9jOMGJuWr+dNpv9wfdf
         CsF/nBdB7Iaej6HqyGIkf/87qAPeKVUHHp8WPNGs5LSXn6FVBS7+wiiNdwb1Ya/yaupx
         PqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PRCcsRlriRacvA+SILmdAWTigiXH146WjiMQkdaDBeI=;
        b=n+n5xVatyvREmAxn/BijsQc09PZrPuq4l4KKofup9G/M7hi5EELLjyWw8GeGEeZARw
         9bI6SodD89p80GuyYN11toZR13tvdQBSbun0lVhFz5X2yKyAoRyldUDJuZ9kVR1D5kQW
         UhCvz/fNuwjSAY0vBrV69cXm/R0D6BVGGfk7ZPeqI9+lcFjExfqVwuMs3Q+vod63x04q
         L4gLV/LmWwUxbQBMTb3wpl+dbvAHAMCDWajkTDZCk9jE1uaVCQ+4pZHz7Id3VWocNFBz
         EYK0lkj00WQgKj/SkYBeV765QTB6TiKI2cVYkFYEjyQZn3wOY//dOzCQcB4yhykv99p+
         vVWg==
X-Gm-Message-State: AKwxytfoh+AcPnPhiKRJk+XqfRw3Eh8IpjDzHAuUpr3N9CEVDwfLWR8g
        mtkaMajHRjGDTdpN9Fv/O533Rap0
X-Google-Smtp-Source: AH8x2254x/dU1FHRhxzJC3oLJ9DDCuOfTGA1kqkJMMsHApB5+vGjGjGcHNXKM2fvYOEutxacfgdBww==
X-Received: by 10.55.24.138 with SMTP id 10mr44144599qky.358.1517348415847;
        Tue, 30 Jan 2018 13:40:15 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:15 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
Date:   Tue, 30 Jan 2018 16:39:34 -0500
Message-Id: <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to write graph files. Create new test script to verify
this command succeeds without failure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 18 +++++++
 builtin/commit-graph.c             | 30 ++++++++++++
 t/t5318-commit-graph.sh            | 96 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100755 t/t5318-commit-graph.sh

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index c8ea548dfb..3f3790d9a8 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -5,3 +5,21 @@ NAME
 ----
 git-commit-graph - Write and verify Git commit graphs (.graph files)
 
+
+SYNOPSIS
+--------
+[verse]
+'git commit-graph' --write <options> [--pack-dir <pack_dir>]
+
+EXAMPLES
+--------
+
+* Write a commit graph file for the packed commits in your local .git folder.
++
+------------------------------------------------
+$ git commit-graph --write
+------------------------------------------------
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 2104550d25..7affd512f1 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,22 +6,38 @@
 #include "lockfile.h"
 #include "packfile.h"
 #include "parse-options.h"
+#include "commit-graph.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
+	N_("git commit-graph --write [--pack-dir <packdir>]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *pack_dir;
+	int write;
 } opts;
 
+static int graph_write(void)
+{
+	struct object_id *graph_hash = construct_commit_graph(opts.pack_dir);
+
+	if (graph_hash)
+		printf("%s\n", oid_to_hex(graph_hash));
+
+	free(graph_hash);
+	return 0;
+}
+
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_commit_graph_options[] = {
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory to store the graph") },
+		OPT_BOOL('w', "write", &opts.write,
+			N_("write commit graph file")),
 		OPT_END(),
 	};
 
@@ -29,5 +45,19 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_graph_usage,
 				   builtin_commit_graph_options);
 
+	argc = parse_options(argc, argv, prefix,
+			     builtin_commit_graph_options,
+			     builtin_commit_graph_usage, 0);
+
+	if (!opts.pack_dir) {
+		struct strbuf path = STRBUF_INIT;
+		strbuf_addstr(&path, get_object_directory());
+		strbuf_addstr(&path, "/pack");
+		opts.pack_dir = strbuf_detach(&path, NULL);
+	}
+
+	if (opts.write)
+		return graph_write();
+
 	return 0;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
new file mode 100755
index 0000000000..6bcd1cc264
--- /dev/null
+++ b/t/t5318-commit-graph.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='commit graph'
+. ./test-lib.sh
+
+test_expect_success 'setup full repo' \
+    'rm -rf .git &&
+     mkdir full &&
+     cd full &&
+     git init &&
+     git config core.commitgraph true &&
+     git config pack.threads 1 &&
+     packdir=".git/objects/pack"'
+
+test_expect_success 'write graph with no packs' \
+    'git commit-graph --write --pack-dir .'
+
+test_expect_success 'create commits and repack' \
+    'for i in $(test_seq 5)
+     do
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git repack'
+
+test_expect_success 'write graph' \
+    'graph1=$(git commit-graph --write) &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph'
+
+t_expect_success 'Add more commits' \
+    'git reset --hard commits/3 &&
+     for i in $(test_seq 6 10)
+     do
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git reset --hard commits/3 &&
+     for i in $(test_seq 11 15)
+     do
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git reset --hard commits/7 &&
+     git merge commits/11 &&
+     git branch merge/1 &&
+     git reset --hard commits/8 &&
+     git merge commits/12 &&
+     git branch merge/2 &&
+     git reset --hard commits/5 &&
+     git merge commits/10 commits/15 &&
+     git branch merge/3 &&
+     git repack'
+
+# Current graph structure:
+#
+#      M3
+#     / |\_____
+#    / 10      15
+#   /   |      |
+#  /    9 M2   14
+# |     |/  \  |
+# |     8 M1 | 13
+# |     |/ | \_|
+# 5     7  |   12
+# |     |   \__|
+# 4     6      11
+# |____/______/
+# 3
+# |
+# 2
+# |
+# 1
+
+test_expect_success 'write graph with merges' \
+    'graph2=$(git commit-graph --write) &&
+     test_path_is_file ${packdir}/graph-${graph2}.graph'
+
+test_expect_success 'setup bare repo' \
+    'cd .. &&
+     git clone --bare full bare &&
+     cd bare &&
+     git config core.graph true &&
+     git config pack.threads 1 &&
+     baredir="objects/pack"'
+
+test_expect_success 'write graph in bare repo' \
+    'graphbare=$(git commit-graph --write) &&
+     test_path_is_file ${baredir}/graph-${graphbare}.graph'
+
+test_done
-- 
2.16.0.15.g9c3cf44.dirty

