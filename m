Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B2F1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeAYODC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:03:02 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43952 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeAYOCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:49 -0500
Received: by mail-qt0-f193.google.com with SMTP id s3so19352799qtb.10
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hy7Fqf/sCxk1n49QHyTOuH0OO6Ac6EpYD1GvDNuhmyc=;
        b=VmloFcqHq9nr289Vo14jKRKhizt1czrKIS7Vlfi7Mo33uHqLL/ey/KMJid0bcukjYA
         Wr9naJ9oRxc9M/FR6isvCXrvigoEfG4eb8vAyY8eh66Gyd/GGHS/6A0RXfMzCoZAEMMt
         +eqxE5YEw/Dm+maDoJBXMlQz4neQfI6zPt8NdKE4Hjf1Q7foYnSyTZ90rKGIjxCZL5k1
         3F1mvRqxzFP5/yHmAnAsSuGFFO4erep2Zh8KZ0QKFceYoFpdI6qf1N89ez0rW0kE3m7L
         vyl+qabchXygCz3j151lz+mPn2Lsc7scZSbSGOOY5mW5FauxvWGrOfSyuaV9kOF5CwE9
         lg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hy7Fqf/sCxk1n49QHyTOuH0OO6Ac6EpYD1GvDNuhmyc=;
        b=Ss8A29KLx92eDeoBG/5/cqHfl+TKBxwKANAev+jNGKHBQZ9QDJ4R7VmqjCLAKW2U6t
         qK12UEdFdkAeVgI0rJZv5TZKfQ3avCld8lZBfPvrloEWU/a/Zn0mDaIeM/d7gIZEIgH1
         qKv5lbEaXCIC9VuYMuHqXAezYCwy7iIN0LK732mHNqeuA/nU2suBeaakZSDNBTtlq0FP
         CFUozcCBaSDjynm/e8yslXSixW+Z3wr0ezLGLs9rCUxSQVc0URhBiNyUPYBz51pMYf0Q
         UnvMQ8Un2WjS4CE5kB73fOqC7qoSH/TfQtyxmaF/UvwhBoWShg2yuAa/u5GiT4lsSJGh
         AG+Q==
X-Gm-Message-State: AKwxytekH7s1LiKC4mexhZJQonKMdYDMZPpsC3/Q7xHpvXPnk5/iyMKf
        admVLg7+kqloUSEYFwdEBYK11qg2
X-Google-Smtp-Source: AH8x225zVOhhA7zPpvZCQTJ453dwiTlSS7lhqSopzDGjx4bDglsMMXBYZ8bf2iLdTGJuw7nm8D9A+g==
X-Received: by 10.55.98.211 with SMTP id w202mr14381106qkb.64.1516888968036;
        Thu, 25 Jan 2018 06:02:48 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:47 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 06/14] packed-graph: implement git-graph --write
Date:   Thu, 25 Jan 2018 09:02:23 -0500
Message-Id: <20180125140231.65604-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-graph to write graph files. Create new test script to verify
this command succeeds without failure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-graph.txt | 26 ++++++++++++++
 builtin/graph.c             | 37 ++++++++++++++++++--
 t/t5319-graph.sh            | 83 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100755 t/t5319-graph.sh

diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
index de5a3c07e6..be6bc38814 100644
--- a/Documentation/git-graph.txt
+++ b/Documentation/git-graph.txt
@@ -5,3 +5,29 @@ NAME
 ----
 git-graph - Write and verify Git commit graphs (.graph files)
 
+
+SYNOPSIS
+--------
+[verse]
+'git graph' --write <options> [--pack-dir <pack_dir>]
+
+EXAMPLES
+--------
+
+* Write a graph file for the packed commits in your local .git folder.
++
+------------------------------------------------
+$ git midx --write
+------------------------------------------------
+
+CONFIGURATION
+-------------
+
+core.graph::
+	The graph command will fail if core.graph is false.
+	Also, the written graph files will be ignored by other commands
+	unless core.graph is true.
+
+GIT
+---
+Part of the linkgit:git[1] suite
\ No newline at end of file
diff --git a/builtin/graph.c b/builtin/graph.c
index a902dc8646..09f5552338 100644
--- a/builtin/graph.c
+++ b/builtin/graph.c
@@ -6,31 +6,62 @@
 #include "lockfile.h"
 #include "packfile.h"
 #include "parse-options.h"
+#include "packed-graph.h"
 
 static char const * const builtin_graph_usage[] ={
 	N_("git graph [--pack-dir <packdir>]"),
+	N_("git graph --write [--pack-dir <packdir>]"),
 	NULL
 };
 
 static struct opts_graph {
 	const char *pack_dir;
+	int write;
 } opts;
 
+static int graph_write(void)
+{
+	struct object_id *graph_id = construct_graph(opts.pack_dir);
+
+	if (graph_id)
+		printf("%s\n", oid_to_hex(graph_id));
+
+	free(graph_id);
+	return 0;
+}
+
 int cmd_graph(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_graph_options[] = {
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory to store the graph") },
+		OPT_BOOL('w', "write", &opts.write,
+			N_("write graph file")),
 		OPT_END(),
 	};
 
-	if (!core_graph)
-		die("core.graph is false");
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_graph_usage, builtin_graph_options);
 
+	git_config(git_default_config, NULL);
+	if (!core_graph)
+		die("git-graph requires core.graph=true.");
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_graph_options,
+			     builtin_graph_usage, 0);
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
 
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
new file mode 100755
index 0000000000..52e979dfd3
--- /dev/null
+++ b/t/t5319-graph.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='packed graph'
+. ./test-lib.sh
+
+test_expect_success \
+    'setup full repo' \
+    'rm -rf .git &&
+     mkdir full &&
+     cd full &&
+     git init &&
+     git config core.graph true &&
+     git config pack.threads 1 &&
+     packdir=".git/objects/pack"'
+
+test_expect_success \
+    'write graph with no packs' \
+    'git graph --write --pack-dir .'
+
+test_expect_success \
+    'create commits and repack' \
+    'for i in $(test_seq 5)
+     do
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git repack'
+
+test_expect_success \
+    'write graph' \
+    'graph1=$(git graph --write) &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph'
+
+test_expect_success \
+    'Add more commits' \
+    'git reset --hard commits/3 &&
+     for i in $(test_seq 6 10)
+     do
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git reset --hard commits/7 &&
+     for i in $(test_seq 11 15)
+     do
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git reset --hard commits/7 &&
+     git merge commits/4 &&
+     git branch merge/1 &&
+     git reset --hard commits/8 &&
+     git merge commits/11 &&
+     git branch merge/2 &&
+     git reset --hard commits/9 &&
+     git merge commits/5 commits/13 &&
+     git repack'
+
+test_expect_success \
+    'write graph with merges' \
+    'graph2=$(git graph --write) &&
+     test_path_is_file ${packdir}/graph-${graph2}.graph'
+
+test_expect_success \
+    'setup bare repo' \
+    'cd .. &&
+     git clone --bare full bare &&
+     cd bare &&
+     git config core.graph true &&
+     git config pack.threads 1 &&
+     baredir="objects/pack"'
+
+test_expect_success \
+    'write graph in bare repo' \
+    'graphbare=$(git graph --write) &&
+     test_path_is_file ${baredir}/graph-${graphbare}.graph'
+
+test_done
-- 
2.16.0

