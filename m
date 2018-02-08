Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4471F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeBHUiD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:03 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33915 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeBHUiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:00 -0500
Received: by mail-qt0-f196.google.com with SMTP id d14so7915155qtg.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2hSB62m8dtdO+6/oH+IWcKWR4XTY4xzCvQFrzAU+cY=;
        b=QiD+J/Wkm44xMBKzkWz2VUGypKEQsEjcIWDZfO/dR6rpvzaH+hZq8YoLs081PqMcOq
         BeZTREVx6UPVyxpMjxyrR9hNL9kx6Rm9ZtGM7TJ2lCXqiquQ8vcnqOZYMLNW2nvpEFuM
         eE+SX8yUDn7JVi0EhfaoVK1Oed/SPfiG6hI1PTwZE0/lLDBsKB5Z9fVa/h7JJdVbiMq3
         HGe39jlyPPtwW8bXgDDorBykTLTBq4H2j+jxb95zar+eTNT2mm6nMNgp+JNGR8xIoy8R
         LMRlLBPfmPpLsGSd1F79n6NJ9GEYmF3cF3qK385qRmh0HjiUVBDsoy1fbgM7/PCj547J
         wY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2hSB62m8dtdO+6/oH+IWcKWR4XTY4xzCvQFrzAU+cY=;
        b=V+Ck5iHdj+gBOqZqpGJxRkJOFL0dRZnavzCa/6GJ84j3Tbl1/JyMc9uZ4uz3iERJ7x
         48xfhcDy+ZMlZXeKMtVXYjQa0wGgQASy0CaoxtAzDOoXEgbKlsmgq986zZGajTwo/j0t
         T2O2cwo6kgmIFACsgnPkGVrk6KM7NIM+qOcSenkBvvMr9aRYyNxLqObqrv4DG9MAmvdu
         sa4q8Nzzgf56zXLqZhYGbDx3gEePAlWuBx0UsbLXcrFBGng3RCkP4WrGl4e3n1+CjG5K
         xOlSCqGwYupufePRV8mf4R8p7GRiRyLFtu/EXuz9Dm4QvhSg6g2RycQOkV4IMlMldnxl
         h1sQ==
X-Gm-Message-State: APf1xPBTsTRS9kJVZ46G9khbOuIuC7w/bvgXS5/kGT9H+Bt+cziuuRPH
        Fzh9RlWm1OVHLJ7k3oOgVDlXVzdXf7o=
X-Google-Smtp-Source: AH8x227HsETq7SzdRCtjDuJ9PZ9XVOphmHSKgYk9qJryMF5DYo6OFum0Mzmh+0gyVq1NLHlB2Cz5QQ==
X-Received: by 10.200.19.194 with SMTP id i2mr779796qtj.330.1518122279195;
        Thu, 08 Feb 2018 12:37:59 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:58 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 07/14] commit-graph: update graph-head during write
Date:   Thu,  8 Feb 2018 15:37:31 -0500
Message-Id: <1518122258-157281-8-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
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
 Documentation/git-commit-graph.txt | 11 ++++++++++-
 builtin/commit-graph.c             | 27 +++++++++++++++++++++++++--
 commit-graph.c                     |  8 ++++++++
 commit-graph.h                     |  1 +
 t/t5318-commit-graph.sh            | 25 +++++++++++++++++++------
 5 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 67e107f06a..5e32c43b27 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -33,7 +33,9 @@ COMMANDS
 Write a commit graph file based on the commits found in packfiles.
 Includes all commits from the existing commit graph file. Outputs the
 checksum hash of the written file.
-
++
+With `--update-head` option, update the graph-head file to point
+to the written graph file.
 
 'read'::
 
@@ -53,6 +55,13 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
+* Write a graph file for the packed commits in your local .git folder
+* and update graph-head.
++
+------------------------------------------------
+$ git commit-graph write --update-head
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 3ffa7ec433..776ca087e8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,12 +1,13 @@
 #include "builtin.h"
 #include "config.h"
+#include "lockfile.h"
 #include "parse-options.h"
 #include "commit-graph.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph read [--graph-hash=<hash>]"),
-	N_("git commit-graph write [--pack-dir <packdir>]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head]"),
 	NULL
 };
 
@@ -16,13 +17,14 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--pack-dir <packdir>]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *pack_dir;
 	const char *graph_hash;
+	int update_head;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -87,6 +89,22 @@ static int graph_read(int argc, const char **argv)
 	return 0;
 }
 
+static void update_head_file(const char *pack_dir, const struct object_id *graph_hash)
+{
+	int fd;
+	struct lock_file lk = LOCK_INIT;
+	char *head_fname = get_graph_head_filename(pack_dir);
+
+	fd = hold_lock_file_for_update(&lk, head_fname, LOCK_DIE_ON_ERROR);
+	FREE_AND_NULL(head_fname);
+
+	if (fd < 0)
+		die_errno("unable to open graph-head");
+
+	write_in_full(fd, oid_to_hex(graph_hash), GIT_MAX_HEXSZ);
+	commit_lock_file(&lk);
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct object_id *graph_hash;
@@ -95,6 +113,8 @@ static int graph_write(int argc, const char **argv)
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory to store the graph") },
+		OPT_BOOL('u', "update-head", &opts.update_head,
+			N_("update graph-head to written graph file")),
 		OPT_END(),
 	};
 
@@ -111,6 +131,9 @@ static int graph_write(int argc, const char **argv)
 
 	graph_hash = write_commit_graph(opts.pack_dir);
 
+	if (opts.update_head)
+		update_head_file(opts.pack_dir, graph_hash);
+
 	if (graph_hash) {
 		printf("%s\n", oid_to_hex(graph_hash));
 		FREE_AND_NULL(graph_hash);
diff --git a/commit-graph.c b/commit-graph.c
index 9a337cea4d..9789fe37f9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,6 +38,14 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
+char *get_graph_head_filename(const char *pack_dir)
+{
+	struct strbuf fname = STRBUF_INIT;
+	strbuf_addstr(&fname, pack_dir);
+	strbuf_addstr(&fname, "/graph-head");
+	return strbuf_detach(&fname, 0);
+}
+
 char* get_commit_graph_filename_hash(const char *pack_dir,
 				     struct object_id *hash)
 {
diff --git a/commit-graph.h b/commit-graph.h
index c1608976b3..726b8aa0f4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "commit.h"
 
+extern char *get_graph_head_filename(const char *pack_dir);
 extern char* get_commit_graph_filename_hash(const char *pack_dir,
 					    struct object_id *hash);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ad1d0e621d..21352d5a3c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -11,7 +11,8 @@ test_expect_success 'setup full repo' '
 	packdir=".git/objects/pack"'
 
 test_expect_success 'write graph with no packs' '
-	git commit-graph write --pack-dir .'
+	git commit-graph write --pack-dir . &&
+	test_path_is_missing graph-head'
 
 test_expect_success 'create commits and repack' '
 	for i in $(test_seq 3)
@@ -32,6 +33,7 @@ graph_read_expect() {
 
 test_expect_success 'write graph' '
 	graph1=$(git commit-graph write) &&
+	test_path_is_missing graph-head &&
 	test_path_is_file $packdir/graph-$graph1.graph &&
 	git commit-graph read --graph-hash=$graph1 >output &&
 	graph_read_expect "3" "$packdir" &&
@@ -73,8 +75,11 @@ test_expect_success 'Add more commits' '
 
 
 test_expect_success 'write graph with merges' '
-	graph2=$(git commit-graph write)&&
+	graph2=$(git commit-graph write --update-head)&&
 	test_path_is_file $packdir/graph-$graph2.graph &&
+	test_path_is_file $packdir/graph-head &&
+	printf $graph2 >expect &&
+	test_cmp expect $packdir/graph-head &&
 	git commit-graph read --graph-hash=$graph2 >output &&
 	graph_read_expect "10" "$packdir" &&
 	test_cmp expect output'
@@ -99,19 +104,24 @@ test_expect_success 'Add one more commit' '
 # 1
 
 test_expect_success 'write graph with new commit' '
-	graph3=$(git commit-graph write) &&
-	test_path_is_file $packdir/graph-$graph3.graph &&
+	graph3=$(git commit-graph write --update-head) &&
 	test_path_is_file $packdir/graph-$graph3.graph &&
+        test_path_is_file $packdir/graph-head &&
+        printf $graph3 >expect &&
+        test_cmp expect $packdir/graph-head &&
 	git commit-graph read --graph-hash=$graph3 >output &&
 	graph_read_expect "11" "$packdir" &&
 	test_cmp expect output'
 
 test_expect_success 'write graph with nothing new' '
-	graph4=$(git commit-graph write) &&
+	graph4=$(git commit-graph write --update-head) &&
 	test_path_is_file $packdir/graph-$graph4.graph &&
 	printf $graph3 >expect &&
 	printf $graph4 >output &&
 	test_cmp expect output &&
+        test_path_is_file $packdir/graph-head &&
+        printf $graph4 >expect &&
+        test_cmp expect $packdir/graph-head &&
 	git commit-graph read --graph-hash=$graph4 >output &&
 	graph_read_expect "11" "$packdir" &&
 	test_cmp expect output'
@@ -123,8 +133,11 @@ test_expect_success 'setup bare repo' '
 	baredir="./objects/pack"'
 
 test_expect_success 'write graph in bare repo' '
-	graphbare=$(git commit-graph write) &&
+	graphbare=$(git commit-graph write --update-head) &&
 	test_path_is_file $baredir/graph-$graphbare.graph &&
+        test_path_is_file $baredir/graph-head &&
+        printf $graphbare >expect &&
+        test_cmp expect $baredir/graph-head &&
 	git commit-graph read --graph-hash=$graphbare >output &&
 	graph_read_expect "11" "$baredir" &&
 	test_cmp expect output'
-- 
2.15.1.45.g9b7079f

