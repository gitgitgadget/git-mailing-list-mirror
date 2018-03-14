Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560921F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCNTaU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:30:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37659 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCNT2D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:03 -0400
Received: by mail-qt0-f194.google.com with SMTP id a23so4725269qtm.4
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HnHFbftm++n4JkTeJVU8PIjxiGbJFNAfgO6FWUMAfxw=;
        b=TM3KMRP8UKuiLVrZB42IUEQlWdWqK8MKGZhA9EJTxkKK4c2+3Ud9EyXjHCuuOI3sFF
         uI6RRgBuPJhQcdv0fCG2sJH7D/v0+2vqQmsYqjmBjnUTQABQkSUmZ3peYOvqu0QKJxuT
         RhWGwAsYLJBZ1HAK+AvVw7l/7LWMpVbFTqCuCbnIrUBqaH8yJ0yWr8zv7K/3I07B0SP8
         BoKW9Pbcgoj0bHIjLQvq+11kN7gkK13xCD8VPrArt08CBysT5TNZdWwbr7/dQsagXl7P
         gdBah1elb/uLcj1zg0wEyvNI5scXf5y0Cpk227FJtNvlRtvV04VVZYa0n1vbJfddHbmb
         hQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HnHFbftm++n4JkTeJVU8PIjxiGbJFNAfgO6FWUMAfxw=;
        b=rGJ43/uksoLmJVMbb8vDUQ9+tdlVC2Bbip2qfCCXuy7eMa+ZWfurSmVmJ0WBT/XNy+
         OsAoJDvsD9eNmlkpz/mt/sEP4ZXxMC9AQT9FRT8MCcxHcmXf/cnmXc/kPplWluIzdpky
         qAkrWjMFsMDYLJJLATZviiVXsPIiDijMkt7yON9PjvumpL0y6mXb9eQ2/CF0oWrwRiHX
         Q4DpxzVSzhDPBbXEV6pT8qnU1SNdL4ITAMtYnqTiPZsoJ7W2flpfOTP9EI+Y6HW5Aaaf
         ndPdO7Uyp81SAPhwOMaIbSHx3K2l8lECm0UwhuW2bxoUZI6usJPWa+dRemVa87SA4vdC
         CwaQ==
X-Gm-Message-State: AElRT7FtI/2O35nbJE7zSEPdqx/gUK68AR0llJe/yyWq0ZqMtMkXTiNF
        Q+ne4FfgsM+WHBupKtLvapsGLI4Z/Qc=
X-Google-Smtp-Source: AG47ELvQ6jF7OSW5kfn9nhOKsuyZan5BovKVfPRpJ5Zf2XWYXXAIgTM2fDhWHYkHdA20Sf1jEqxhug==
X-Received: by 10.200.14.205 with SMTP id w13mr8741895qti.284.1521055681939;
        Wed, 14 Mar 2018 12:28:01 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:28:01 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 07/14] commit-graph: implement 'git-commit-graph write'
Date:   Wed, 14 Mar 2018 15:27:29 -0400
Message-Id: <20180314192736.70602-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

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
index 5913340fad..e688843808 100644
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
index 8ff7336527..a9d61f649a 100644
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
index 0000000000..43707ce5bb
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
+        cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write --object-dir . &&
+	test_path_is_file info/commit-graph
+'
+
+test_expect_success 'create commits and repack' '
+        cd "$TRASH_DIRECTORY/full" &&
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i
+	done &&
+	git repack
+'
+
+test_expect_success 'write graph' '
+        cd "$TRASH_DIRECTORY/full" &&
+	graph1=$(git commit-graph write) &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'Add more commits' '
+        cd "$TRASH_DIRECTORY/full" &&
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
+        cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'Add one more commit' '
+        cd "$TRASH_DIRECTORY/full" &&
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
+        cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'write graph with nothing new' '
+        cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write &&
+	test_path_is_file $objdir/info/commit-graph
+'
+
+test_expect_success 'setup bare repo' '
+        cd "$TRASH_DIRECTORY" &&
+	git clone --bare --no-local full bare &&
+	cd bare &&
+	baredir="./objects"
+'
+
+test_expect_success 'write graph in bare repo' '
+        cd "$TRASH_DIRECTORY/bare" &&
+	git commit-graph write &&
+	test_path_is_file $baredir/info/commit-graph
+'
+
+test_done
+
-- 
2.14.1

