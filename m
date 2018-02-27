Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6FA1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeB0Cd0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:26 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37199 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeB0CdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:21 -0500
Received: by mail-qt0-f194.google.com with SMTP id r16so12476202qtm.4
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hMw2AU/IIiNPDaVJ+0aHvrL063RWrqlq1FseMOq9+H0=;
        b=jeUv9m65Je9/gyWiqxdLikRSjZFemVv5gclh6hp16YS/6L8teDfcJpi55QnoTua2oX
         c+70LVupC6Q0OxWodwMm1iZimbLCzbTqKz7IENEgRXazGU4O33Mw1TtDq6PDW9DvEtQE
         sJ5I8o8x++blonLD4FYHuU0sEj2ipPxss6HsGSWve82t1GjeS0TvC0Nh3wAok8EPzlpA
         nBOj1HVWeaB+RkL1XlwC5tLf2af5dE4hNlpbcT230Ah6kwAtdnRRplAJyBfTN2kNfKbM
         +82UkIr4OZgXsah2N4dygQWD4f/LGlNaE8GS/eDDeGKyBf/AtLnmNM30rAoaH5OL6smq
         dJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hMw2AU/IIiNPDaVJ+0aHvrL063RWrqlq1FseMOq9+H0=;
        b=G55D4Kzye7voXHLW0A0K4J5EO9UT9bc1M0jTT2y968HLOm3++xBxsYFHdPtKhVFIui
         ae4u5KNMOqRVWUFyiy6KRNWwH0AXeh5ntNFmlP9VUvftueO+TA55TXLMbkMKWWthcubj
         soQSYsYA9/FNNI+HZjgEy14vl1+UPeaiyE5Imdg7+8odcxPC6B/5WN3xr2phSNTO+s8I
         kPTjWmiD/uOqKiSqAHxzEb1o/qmrExglkSe8hvgbJ9aQrilap/ATtDSHs28tMDKOixRy
         WkedrodUR7ZXCDGr22yDlLDYCvGOGi05xdVFMwJ6fyrybiJyov6y9kUNLF/n2iK+SND/
         ycSQ==
X-Gm-Message-State: APf1xPAUVEasxy9yAROYJVmQHsZFSpgj9QS/FCPt6DYtJhrLprIS7ikM
        5TOjiSW7t5G0pbdMZfsknUMRP8zKHZ4=
X-Google-Smtp-Source: AG47ELvZ1u/MPVEt5KvPM82IEbfy9KeQ1CYi/idsk7bk7QUMX6oAmGT/62T0o6GEhRmRYzth8QKgpw==
X-Received: by 10.237.36.55 with SMTP id r52mr21039020qtc.268.1519698800562;
        Mon, 26 Feb 2018 18:33:20 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:20 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 06/13] commit-graph: implement 'git-commit-graph write'
Date:   Mon, 26 Feb 2018 21:33:00 -0500
Message-Id: <1519698787-190494-7-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to write graph files. Create new test script to verify
this command succeeds without failure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  39 ++++++++++++
 builtin/commit-graph.c             |  33 ++++++++++
 t/t5318-commit-graph.sh            | 125 +++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100755 t/t5318-commit-graph.sh

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 5913340..e688843 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -5,6 +5,45 @@ NAME
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
+	file. The commit graph file is expected to be at <dir>/info/commit-graph
+	and the packfiles are expected to be in <dir>/pack.
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
index 8ff7336..a9d61f6 100644
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
index 0000000..7524d2a
--- /dev/null
+++ b/t/t5318-commit-graph.sh
@@ -0,0 +1,125 @@
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
+
-- 
2.7.4

