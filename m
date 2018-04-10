Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984E91F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeDJM5C (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:57:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33700 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeDJM47 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:56:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id s10-v6so7464792plp.0
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mIuDN9JIvjV7dDQE/Iq0Pz0zzpOzXQJyrviEGmuqJqU=;
        b=bn2S4NZhfFcSdO2cE2paq5o5R1UUT7KfcLG8e2MCX6TjVfUXOyAHJVe0kj/HJw8Xth
         1AhGN+PC3w01edAjPa/j3Vc49PKvMolE/GLuZYW7oynOkuQ91dM7UFt/TuvTjZ7gfU4u
         ioMPF9gTZgvXLrHkU/oP+k+ZDpPOKft6AYzG4z9hU9B91jWmivcnM/pg2zHYClufn1cA
         Js/QofPpy2vHd7QJFvczVXjdxS4dbeBbLy+4htIVuwtalQrB2XaawuaD8dXPYW97HdYC
         Wlk8fInFYmCH+aikv/Vfa4kPtCrt5i+7TuRc3BEmgrUWUu5/eDUynph0OYWFGx0f5IvS
         pInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mIuDN9JIvjV7dDQE/Iq0Pz0zzpOzXQJyrviEGmuqJqU=;
        b=ebSmhtpMm8w6kYnMxFkvOBeZEGHwRNb3Lo7EZL/Um8pOZcS9L7nnkar31sfXNB0GgZ
         K5zqLemDxBrtIpM00qaNgifNoShrlymBN6hzQJyjL8ipzC1//47DjheOXrN6cvO0Syh1
         xVW2yT0zfU7FAlkKUW3rGFaDv77pqRAGI/FhLPy0qwTJBDgFQc4H47JBciXOD1NF710h
         ukSI8t5/T2MKXnnae83o+SnZqAi30ccxRbdccEtoQnghxVNEITrD/mGJV0dqTfgag4AZ
         7tXtzfRgEq8mJ01uGh8Yn1TGcFe2QEGLzmZFNDTY/GoLuK26rMEty8UIlMfq1t/vghoM
         YoDA==
X-Gm-Message-State: ALQs6tC9sJfOldUL4W/zHgQSzgxK60DiMn5wAN8o32uX1ffEE57FGKnc
        mE4ew7TaHa2tEI54bqB/iaJIJckb+TY=
X-Google-Smtp-Source: AIpwx48b1Kes25CdYGtaNm03v/J5E4qm7tMpQ29e9lN3rjQHHOdN7Kz9Tn3eQMiZC9l8w+sL11xiqQ==
X-Received: by 2002:a17:902:a9c4:: with SMTP id b4-v6mr293946plr.333.1523365018710;
        Tue, 10 Apr 2018 05:56:58 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:56:57 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 07/14] commit-graph: implement git-commit-graph write
Date:   Tue, 10 Apr 2018 08:56:01 -0400
Message-Id: <20180410125608.39443-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach git-commit-graph to write graph files. Create new test script to verify
this command succeeds without failure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  41 ++++++++++
 builtin/commit-graph.c             |  33 ++++++++
 t/t5318-commit-graph.sh            | 124 +++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100755 t/t5318-commit-graph.sh

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index f3b34622a8..47996e8f89 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -5,6 +5,47 @@ NAME
 ----
 git-commit-graph - Write and verify Git commit graph files
 
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
+	Use given directory for the location of packfiles and commit graph
+	file. This parameter exists to specify the location of an alternate
+	that only has the objects directory, not a full .git directory. The
+	commit graph file is expected to be at <dir>/info/commit-graph and
+	the packfiles are expected to be in <dir>/pack.
+
+
+COMMANDS
+--------
+'write'::
+
+Write a commit graph file based on the commits found in packfiles.
+Includes all commits from the existing commit graph file.
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
index b466ecd781..26b6360289 100644
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
 
@@ -11,6 +20,25 @@ static struct opts_commit_graph {
 	const char *obj_dir;
 } opts;
 
+static int graph_write(int argc, const char **argv)
+{
+	static struct option builtin_commit_graph_write_options[] = {
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			N_("dir"),
+			N_("The object directory to store the graph")),
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
+	write_commit_graph(opts.obj_dir);
+	return 0;
+}
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
@@ -31,6 +59,11 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
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
index 0000000000..d7b635bd68
--- /dev/null
+++ b/t/t5318-commit-graph.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='commit graph'
+. ./test-lib.sh
+
+test_expect_success 'setup full repo' '
+	mkdir full &&
+	cd "$TRASH_DIRECTORY/full" &&
+	git init &&
+	objdir=".git/objects"
+'
+
+test_expect_success 'write graph with no packs' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write --object-dir . &&
+	test_path_is_file info/commit-graph
+'
+
+test_expect_success 'create commits and repack' '
+	cd "$TRASH_DIRECTORY/full" &&
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i
+	done &&
+	git repack
+'
+
+test_expect_success 'write graph' '
+	cd "$TRASH_DIRECTORY/full" &&
+	graph1=$(git commit-graph write) &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'Add more commits' '
+	cd "$TRASH_DIRECTORY/full" &&
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
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'Add one more commit' '
+	cd "$TRASH_DIRECTORY/full" &&
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
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'write graph with nothing new' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'setup bare repo' '
+	cd "$TRASH_DIRECTORY" &&
+	git clone --bare --no-local full bare &&
+	cd bare &&
+	baredir="./objects"
+'
+
+test_expect_success 'write graph in bare repo' '
+	cd "$TRASH_DIRECTORY/bare" &&
+	git commit-graph write &&
+	test_path_is_file $baredir/info/commit-graph
+'
+
+test_done
-- 
2.17.0

