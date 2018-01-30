Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D1B1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeA3Vkr (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:47 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45943 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeA3VkS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:18 -0500
Received: by mail-qk0-f195.google.com with SMTP id z12so12108715qkf.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOC1NyqWqBdXHXBuyPwahtH5DEoLTkCfxQt4xKUIyA0=;
        b=W2N7Q5lFk1LXsZz1XnaqApi7RsqrBH7V2zRfd8fskRC7yhjaCv6d/VHndVvURAicYt
         KJWBaze+Q4P8D1LudubgdutuXjJccDPE86hERdnl790GWDSdyX1VEjU16Q72bGgISinJ
         Y1xpBRgR5v9hFjg0HtjhQ4FvDwLt3yTb923JImABj4UgDlmDIYpx2MCw176RxgxG/h+N
         +wnmIJDCxirFdahK0rti2Tt3EFbV2wIZcQiXnFuQo8edPV2QcKfmHJ5kquXQ/AEJRcF/
         fBGkf5+Fwo2dgifVVIwvuMxZ63TMPWf4xYN73BMOw7p8cArX6h3hqRXrcZMVjFUyT11B
         g+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOC1NyqWqBdXHXBuyPwahtH5DEoLTkCfxQt4xKUIyA0=;
        b=dAp/SqkMkHNNu1gLQeSFAr8Mh+E8pGhvhmLUSvcdliLN5UCHtEqFQRm22WpIV8VceJ
         XhP2f5OvLWHez+udd3mEbp3uFpz0d9zj1Oqb/KKdBSuJOqBYBMvnXzQEeP5RrMQW5AeG
         u2nmcbKqo9hev28Og9cRtp3/L9X9l0ezi3LawKA3D3BwYgllBEfa8XUBR0dc2LJKZnSw
         RVHvQilALyl1OR23j+JxQzLB51qxe52hmjtR95NLzkW9pJQI9M5S7Bw3wZonTPCYNmN8
         uzJVCy/GFHFYptRzIwqAiKmLxcVw1KZEMAOBP67w7awGrSzE567R8OXfWbEBsqL0q7ds
         YpzA==
X-Gm-Message-State: AKwxytc0EUgnDLnFnySPz41Nad/VFfMSqHou0uedS6mDHpf2gqz7O3ME
        xbs7oy33SWB9tc1ru7+pTwUak8L/
X-Google-Smtp-Source: AH8x2242ofmzZdDEnUyDYSv0+lWEpW9JELmU3VwcwWFXzWJvk+OJ/OZB7V3CtDHUpMca1isoic/apw==
X-Received: by 10.55.42.5 with SMTP id q5mr453885qkh.206.1517348417852;
        Tue, 30 Jan 2018 13:40:17 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:17 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 07/14] commit-graph: implement git-commit-graph --update-head
Date:   Tue, 30 Jan 2018 16:39:36 -0500
Message-Id: <1517348383-112294-8-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to have multiple commit graph files in a pack directory,
but only one is important at a time. Use a 'graph_head' file to point
to the important file. Teach git-commit-graph to write 'graph_head' upon
writing a new commit graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 34 ++++++++++++++++++++++++++++++++++
 builtin/commit-graph.c             | 38 +++++++++++++++++++++++++++++++++++---
 commit-graph.c                     | 25 +++++++++++++++++++++++++
 commit-graph.h                     |  2 ++
 t/t5318-commit-graph.sh            | 12 ++++++++++--
 5 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 09aeaf6c82..99ced16ddc 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -12,15 +12,49 @@ SYNOPSIS
 'git commit-graph' --write <options> [--pack-dir <pack_dir>]
 'git commit-graph' --read <options> [--pack-dir <pack_dir>]
 
+OPTIONS
+-------
+--pack-dir::
+	Use given directory for the location of packfiles, graph-head,
+	and graph files.
+
+--read::
+	Read a graph file given by the graph-head file and output basic
+	details about the graph file. (Cannot be combined with --write.)
+
+--graph-id::
+	When used with --read, consider the graph file graph-<oid>.graph.
+
+--write::
+	Write a new graph file to the pack directory. (Cannot be combined
+	with --read.)
+
+--update-head::
+	When used with --write, update the graph-head file to point to
+	the written graph file.
+
 EXAMPLES
 --------
 
+* Output the hash of the graph file pointed to by <dir>/graph-head.
++
+------------------------------------------------
+$ git commit-graph --pack-dir=<dir>
+------------------------------------------------
+
 * Write a commit graph file for the packed commits in your local .git folder.
 +
 ------------------------------------------------
 $ git commit-graph --write
 ------------------------------------------------
 
+* Write a graph file for the packed commits in your local .git folder,
+* and update graph-head.
++
+------------------------------------------------
+$ git commit-graph --write --update-head
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 218740b1f8..d73cbc907d 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -11,7 +11,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph --read [--graph-hash=<hash>]"),
-	N_("git commit-graph --write [--pack-dir <packdir>]"),
+	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head]"),
 	NULL
 };
 
@@ -20,6 +20,9 @@ static struct opts_commit_graph {
 	int read;
 	const char *graph_hash;
 	int write;
+	int update_head;
+	int has_existing;
+	struct object_id old_graph_hash;
 } opts;
 
 static int graph_read(void)
@@ -30,8 +33,8 @@ static int graph_read(void)
 
 	if (opts.graph_hash && strlen(opts.graph_hash) == GIT_MAX_HEXSZ)
 		get_oid_hex(opts.graph_hash, &graph_hash);
-	else
-		die("no graph hash specified");
+	else if (!get_graph_head_hash(opts.pack_dir, &graph_hash))
+		die("no graph-head exists");
 
 	graph_file = get_commit_graph_filename_hash(opts.pack_dir, &graph_hash);
 	graph = load_commit_graph_one(graph_file, opts.pack_dir);
@@ -62,10 +65,33 @@ static int graph_read(void)
 	return 0;
 }
 
+static void update_head_file(const char *pack_dir, const struct object_id *graph_hash)
+{
+	struct strbuf head_path = STRBUF_INIT;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
+
+	strbuf_addstr(&head_path, pack_dir);
+	strbuf_addstr(&head_path, "/");
+	strbuf_addstr(&head_path, "graph-head");
+
+	fd = hold_lock_file_for_update(&lk, head_path.buf, LOCK_DIE_ON_ERROR);
+	strbuf_release(&head_path);
+
+	if (fd < 0)
+		die_errno("unable to open graph-head");
+
+	write_in_full(fd, oid_to_hex(graph_hash), GIT_MAX_HEXSZ);
+	commit_lock_file(&lk);
+}
+
 static int graph_write(void)
 {
 	struct object_id *graph_hash = construct_commit_graph(opts.pack_dir);
 
+	if (opts.update_head)
+		update_head_file(opts.pack_dir, graph_hash);
+
 	if (graph_hash)
 		printf("%s\n", oid_to_hex(graph_hash));
 
@@ -83,6 +109,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			N_("read graph file")),
 		OPT_BOOL('w', "write", &opts.write,
 			N_("write commit graph file")),
+		OPT_BOOL('u', "update-head", &opts.update_head,
+			N_("update graph-head to written graph file")),
 		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
 			N_("hash"),
 			N_("A hash for a specific graph file in the pack-dir."),
@@ -109,10 +137,14 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		opts.pack_dir = strbuf_detach(&path, NULL);
 	}
 
+	opts.has_existing = !!get_graph_head_hash(opts.pack_dir, &opts.old_graph_hash);
+
 	if (opts.read)
 		return graph_read();
 	if (opts.write)
 		return graph_write();
 
+	if (opts.has_existing)
+		printf("%s\n", oid_to_hex(&opts.old_graph_hash));
 	return 0;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 622a650259..764e016ddb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -35,6 +35,31 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + sizeof(struct commit_graph_header))
 
+struct object_id *get_graph_head_hash(const char *pack_dir, struct object_id *hash)
+{
+	struct strbuf head_filename = STRBUF_INIT;
+	char hex[GIT_MAX_HEXSZ + 1];
+	FILE *f;
+
+	strbuf_addstr(&head_filename, pack_dir);
+	strbuf_addstr(&head_filename, "/graph-head");
+
+	f = fopen(head_filename.buf, "r");
+	strbuf_release(&head_filename);
+
+	if (!f)
+		return 0;
+
+	if (!fgets(hex, sizeof(hex), f))
+		die("failed to read graph-head");
+
+	fclose(f);
+
+	if (get_oid_hex(hex, hash))
+		return 0;
+	return hash;
+}
+
 char* get_commit_graph_filename_hash(const char *pack_dir,
 				     struct object_id *hash)
 {
diff --git a/commit-graph.h b/commit-graph.h
index e046ae575c..43eb0aec84 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,8 @@
 #include "git-compat-util.h"
 #include "commit.h"
 
+extern struct object_id *get_graph_head_hash(const char *pack_dir,
+					     struct object_id *hash);
 extern char* get_commit_graph_filename_hash(const char *pack_dir,
 					    struct object_id *hash);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index da565624e3..d1a23bcdaf 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -13,7 +13,8 @@ test_expect_success 'setup full repo' \
      packdir=".git/objects/pack"'
 
 test_expect_success 'write graph with no packs' \
-    'git commit-graph --write --pack-dir .'
+    'git commit-graph --write --pack-dir . &&
+     test_path_is_missing graph-head'
 
 test_expect_success 'create commits and repack' \
     'for i in $(test_seq 5)
@@ -37,6 +38,7 @@ EOF
 test_expect_success 'write graph' \
     'graph1=$(git commit-graph --write) &&
      test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_missing ${packdir}/graph-head &&
      git commit-graph --read --graph-hash=${graph1} >output &&
      _graph_read_expect "5" "${packdir}" &&
      cmp expect output'
@@ -90,8 +92,11 @@ test_expect_success 'Add more commits' \
 # 1
 
 test_expect_success 'write graph with merges' \
-    'graph2=$(git commit-graph --write) &&
+    'graph2=$(git commit-graph --write --update-head) &&
      test_path_is_file ${packdir}/graph-${graph2}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph2} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
      git commit-graph --read --graph-hash=${graph2} >output &&
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
@@ -107,6 +112,9 @@ test_expect_success 'setup bare repo' \
 test_expect_success 'write graph in bare repo' \
     'graphbare=$(git commit-graph --write) &&
      test_path_is_file ${baredir}/graph-${graphbare}.graph &&
+     test_path_is_file ${baredir}/graph-head &&
+     echo ${graphbare} >expect &&
+     cmp -n 40 expect ${baredir}/graph-head &&
      git commit-graph --read --graph-hash=${graphbare} >output &&
      _graph_read_expect "18" "${baredir}" &&
      cmp expect output'
-- 
2.16.0.15.g9c3cf44.dirty

