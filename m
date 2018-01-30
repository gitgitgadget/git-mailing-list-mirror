Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415731F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeA3VkX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:23 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46479 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeA3VkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:20 -0500
Received: by mail-qk0-f195.google.com with SMTP id l64so12133356qke.13
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UrwRyz762DyVFi58azT2eAMbRZ0SLPpvLTuBL33Qfi8=;
        b=lCjUT8k31b7zSYso63+Nhl7B+A0GVhpx3OefgPPu4egxRbHlGUdhfIvv3zoNTV5Cs5
         h6bL7R8K+hkOOybWNAjcQZctWnr44Ydk3xfG0mZpAFd1Kzc0VDkvNkTsODduwVQqJ4i2
         ybnVOuuUUXVepXwT33D1IMumpqnWqJapamGVsqtvop20tnMEg8pY13lx/dLNfWNO5Tk/
         V4xbB0QFg0DpMMGkXBIQbGbzUEfrKLC/gc2wjtlM+bc5jlSvke8BmACprC1E5o0akvFl
         TtmtjYaiJI3LBS4EuX4LgaGvXGljW8FrnhyqpB8EqhULpeynRvzZTbc7vH5jacl6GBes
         GDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UrwRyz762DyVFi58azT2eAMbRZ0SLPpvLTuBL33Qfi8=;
        b=HwQlohxXzwndGB10QxETwk0Eb6r2sR8Bh+xEn9RNvCyti0zIU/yvlCcgzF/+WyF1Ba
         FMEu8foO/2FBXcBj3koWxL7ykpLq1wztsBd7wGzxMs4DOLdAwv3IOp29bbhi4EJznmzL
         qMn45efL9ECL3vXtqihhWcMS/+JcDajT7KuwSBtTND9SbZwkQC7wK0U84KGHH74AIuMG
         ILyLd9w6faz9Opq23UPLKY8ZZu9LdjdRo+RNtM2/I7Zwb0LeGmCnks1NeMZTeGJb3/BY
         AZ0IvZV32MWkpd5cGJcXjFRurINQkaF6kMGEIbSCrqO86Z75N+odlRCDvfWZUeOPUINB
         LGXA==
X-Gm-Message-State: AKwxytcp4dOm46k6JUZ4ej/R+vAwb3/Ge2a9C4XdfzHs6eHBJr60gCK+
        ZpyqARSFdMA5fqhT6Z6IFWJuuTOt
X-Google-Smtp-Source: AH8x224bHINCNR4xS1I+Bb7tNueAkdqpZm/5cwooIE9js2jEEDKjNlyUDeym0Do3jWgm0BWyRho6Ug==
X-Received: by 10.55.103.18 with SMTP id b18mr47056862qkc.56.1517348418881;
        Tue, 30 Jan 2018 13:40:18 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:18 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 08/14] commit-graph: implement git-commit-graph --clear
Date:   Tue, 30 Jan 2018 16:39:37 -0500
Message-Id: <1517348383-112294-9-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to delete the current 'graph_head' file and the commit graph
it references. This is a good safety valve if somehow the file is
corrupted and needs to be recalculated. Since the commit graph is a
summary of contents already in the ODB, it can be regenerated.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 16 ++++++++++++++--
 builtin/commit-graph.c             | 32 +++++++++++++++++++++++++++++++-
 t/t5318-commit-graph.sh            |  7 ++++++-
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 99ced16ddc..33d6567f11 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git commit-graph' --write <options> [--pack-dir <pack_dir>]
 'git commit-graph' --read <options> [--pack-dir <pack_dir>]
+'git commit-graph' --clear [--pack-dir <pack_dir>]
 
 OPTIONS
 -------
@@ -18,16 +19,21 @@ OPTIONS
 	Use given directory for the location of packfiles, graph-head,
 	and graph files.
 
+--clear::
+	Delete the graph-head file and the graph file it references.
+	(Cannot be combined with --read or --write.)
+
 --read::
 	Read a graph file given by the graph-head file and output basic
-	details about the graph file. (Cannot be combined with --write.)
+	details about the graph file. (Cannot be combined with --clear
+	or --write.)
 
 --graph-id::
 	When used with --read, consider the graph file graph-<oid>.graph.
 
 --write::
 	Write a new graph file to the pack directory. (Cannot be combined
-	with --read.)
+	with --clear or --read.)
 
 --update-head::
 	When used with --write, update the graph-head file to point to
@@ -61,6 +67,12 @@ $ git commit-graph --write --update-head
 $ git commit-graph --read --graph-hash=<hash>
 ------------------------------------------------
 
+* Delete <dir>/graph-head and the file it references.
++
+------------------------------------------------
+$ git commit-graph --clear --pack-dir=<dir>
+------------------------------------------------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d73cbc907d..4970dec133 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,6 +10,7 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
+	N_("git commit-graph --clear [--pack-dir <packdir>]"),
 	N_("git commit-graph --read [--graph-hash=<hash>]"),
 	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head]"),
 	NULL
@@ -17,6 +18,7 @@ static char const * const builtin_commit_graph_usage[] = {
 
 static struct opts_commit_graph {
 	const char *pack_dir;
+	int clear;
 	int read;
 	const char *graph_hash;
 	int write;
@@ -25,6 +27,30 @@ static struct opts_commit_graph {
 	struct object_id old_graph_hash;
 } opts;
 
+static int graph_clear(void)
+{
+	struct strbuf head_path = STRBUF_INIT;
+	char *old_path;
+
+	if (!opts.has_existing)
+		return 0;
+
+	strbuf_addstr(&head_path, opts.pack_dir);
+	strbuf_addstr(&head_path, "/");
+	strbuf_addstr(&head_path, "graph-head");
+	if (remove_path(head_path.buf))
+		die("failed to remove path %s", head_path.buf);
+	strbuf_release(&head_path);
+
+	old_path = get_commit_graph_filename_hash(opts.pack_dir,
+						  &opts.old_graph_hash);
+	if (remove_path(old_path))
+		die("failed to remove path %s", old_path);
+	free(old_path);
+
+	return 0;
+}
+
 static int graph_read(void)
 {
 	struct object_id graph_hash;
@@ -105,6 +131,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory to store the graph") },
+		OPT_BOOL('c', "clear", &opts.clear,
+			N_("clear graph file and graph-head")),
 		OPT_BOOL('r', "read", &opts.read,
 			N_("read graph file")),
 		OPT_BOOL('w', "write", &opts.write,
@@ -126,7 +154,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     builtin_commit_graph_options,
 			     builtin_commit_graph_usage, 0);
 
-	if (opts.write + opts.read > 1)
+	if (opts.write + opts.read + opts.clear > 1)
 		usage_with_options(builtin_commit_graph_usage,
 				   builtin_commit_graph_options);
 
@@ -139,6 +167,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 
 	opts.has_existing = !!get_graph_head_hash(opts.pack_dir, &opts.old_graph_hash);
 
+	if (opts.clear)
+		return graph_clear();
 	if (opts.read)
 		return graph_read();
 	if (opts.write)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d1a23bcdaf..6e3b62b754 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -101,6 +101,11 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
 
+test_expect_success 'clear graph' \
+    'git commit-graph --clear &&
+     test_path_is_missing ${packdir}/graph-${graph2}.graph &&
+     test_path_is_missing ${packdir}/graph-head'
+
 test_expect_success 'setup bare repo' \
     'cd .. &&
      git clone --bare full bare &&
@@ -110,7 +115,7 @@ test_expect_success 'setup bare repo' \
      baredir="./objects/pack"'
 
 test_expect_success 'write graph in bare repo' \
-    'graphbare=$(git commit-graph --write) &&
+    'graphbare=$(git commit-graph --write --update-head) &&
      test_path_is_file ${baredir}/graph-${graphbare}.graph &&
      test_path_is_file ${baredir}/graph-head &&
      echo ${graphbare} >expect &&
-- 
2.16.0.15.g9c3cf44.dirty

