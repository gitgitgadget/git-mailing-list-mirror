Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2DE1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbeDBUfl (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:41 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35372 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbeDBUfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:04 -0400
Received: by mail-qk0-f195.google.com with SMTP id c188so16404884qkg.2
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1vSIs3ZwJ+LlqTb/3kDurSsz8D10QJ32NLvsT9jz1s=;
        b=FrWz03ZNj+/jTzjaCtpzH6hozDTALxVuDwlRk8v1e8zTSftlHnGUxTQhKJG64PJuhI
         SrXC1yOiGD59wHR95fV2YzgDBdkLfaubfLgApD0KvRMvrZiaXcokVp+YKL4I5a86aQ1s
         vOmX42YHVmEw2jpt8RdyL6fcjO3SRhWzm1TMcl+Ha64fSzrs2ESq2XIeLfLoCIQpIBMp
         M3rc6z4vPxaagUQfC8bCME0xHp8Ph1IdtenWaqzssN/iPWEXH6S8B/s0KXPBjKGZqER1
         N+82kRmj1v9MQf/2l8aOrPesZaWtnfMLIHu+IG6SVXAuQa1KrCExNNbEFsR4safaTKM8
         asyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1vSIs3ZwJ+LlqTb/3kDurSsz8D10QJ32NLvsT9jz1s=;
        b=H69bHJVr1qmf0goikvGbc4IbQ9FRk3xTnPBsOdjE7QJXe9AyYaBKsbXlZbrUW8//mV
         jqwUKoRl2BwdKhlabsY3FWr8RF2K7e9XPBRrU7GgOY5dtQjyGgcdZEhLPx1O3AhlBBa7
         q9JDIFoNPwPCT3b+z82YGiW5WNYtAlrHGK5Id6IMIix9btrNBYPslOd1bcmtM7ZfhxI3
         uDQW+R6wTI43IKXTbsMlN6XOLweO3p3s2t+kxBYvAaLF3ukoDe4hSaBvNGX0/nq/rzXn
         CGWpv/UFDzjPUgfffkLm9tbYBA2OyjZFJm1m2vgs+Hpkki/E5zIkLAmxjMpZsz5fd90y
         EivA==
X-Gm-Message-State: ALQs6tC5PB0kzhNUei26IywxXBtNi6rdHPFfqtMOxg9+liyBW+qWWnsE
        oUVcrB+PA9wKg2l92kqYlwpLaS2jegE=
X-Google-Smtp-Source: AIpwx4+s3SSOzwxO5r/ZrWnjIDRUDTUb5kGLHg5aKnowou+rRErpXDdXu9zeWbG1i0k2dLiw2LpnGw==
X-Received: by 10.55.136.129 with SMTP id k123mr14506003qkd.296.1522701303055;
        Mon, 02 Apr 2018 13:35:03 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:35:02 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 07/14] commit-graph: implement git-commit-graph write
Date:   Mon,  2 Apr 2018 16:34:20 -0400
Message-Id: <20180402203427.170177-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
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
2.17.0.14.gba1221a8ce

