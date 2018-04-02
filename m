Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E561F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932490AbeDBUfP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:15 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38552 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbeDBUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:11 -0400
Received: by mail-qt0-f196.google.com with SMTP id z23so16231621qti.5
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XcP/5xGg+QyAlJwkVS+hlPISlUktoA15pl8pEDoLHG0=;
        b=cSslgLivIO0BmFO6O8v7XdGITNiKNOz/bIl6XqAqyWqVvYV8Xgr47zIUE0zMLnTKyY
         qZfS/0d7VTd0brDDDQR5aDgBVLlnQNnkVWWV/OUhx2S173ttYZ90DmRj/N/iSCnshElG
         ZynSNEAvHu/YfAAtkjP3wm8wWJCH1mSE80o/xC9A4l0HupfnKVFWuJ9qNBIDP1RT6hoP
         ddaL6CE1oxzU4X3ikmSwT4Gm74CcQBDg9R8sHK42DLZYttgPjtx/fOJrcPaEZP6z6RGF
         WQN4yRuQwlzSL4+twSKT+EwZ2vwXEEEDzxQ3t+v6wYggA6fGsY7EPlNZt22RGcV0DLgr
         7gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XcP/5xGg+QyAlJwkVS+hlPISlUktoA15pl8pEDoLHG0=;
        b=olABkTtuZdTGVhjL2XM/2WF/OzhJDWn9oi+9ANkwZko7q4xwUnP0e1T9/5kthSzDQU
         JepM5Fcyvv7Reptu6RalvM67A0TooDvf24/OzjsxTfQkn/ILWl3inYROnQbLlxnoMZKz
         H00GR9DRfIJ/o//1YLh9N3zSSkcBwsUYc5f4FimrqIV/lTGqcEKvYRixvlz7MLOVKumv
         jhaEK0Q51W+zvK64vTvsZ61EwW0Owm4lK+YxfsBAqMpClUKFgN1aYwHnsnPC9PAaLneK
         uSk2mAEEIferKWPZbQPuEl9owXlu3jm4jWzgM5WuzPPvrxIqJo/fzzcr2t0CP0uoSXsG
         SksQ==
X-Gm-Message-State: ALQs6tBoy0xzoavl6uNa1bC0nfTfJn7iwB9hRdclnT8TiPji/z67S37y
        rf/suRhyafltXvwRtP5SYz/0+9TrXTw=
X-Google-Smtp-Source: AIpwx4/UMOJ0ikGSWe4ZBiylIgdybkFmR0+I+q9hLZmCDxrSkxmUJ2oFKfXH5luMR1nti+tVhnwWiw==
X-Received: by 10.200.27.3 with SMTP id y3mr16670722qtj.161.1522701310753;
        Mon, 02 Apr 2018 13:35:10 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:35:10 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 11/14] commit: integrate commit graph with commit parsing
Date:   Mon,  2 Apr 2018 16:34:24 -0400
Message-Id: <20180402203427.170177-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach Git to inspect a commit graph file to supply the contents of a
struct commit when calling parse_commit_gently(). This implementation
satisfies all post-conditions on the struct commit, including loading
parents, the root tree, and the commit date.

If core.commitGraph is false, then do not check graph files.

In test script t5318-commit-graph.sh, add output-matching conditions on
read-only graph operations.

By loading commits from the graph instead of parsing commit buffers, we
save a lot of time on long commit walks. Here are some performance
results for a copy of the Linux repository where 'master' has 678,653
reachable commits and is behind 'origin/master' by 59,929 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  8.31s |  0.94s | -88%  |
| branch -vv                       |  1.02s |  0.14s | -86%  |
| rev-list --all                   |  5.89s |  1.07s | -81%  |
| rev-list --all --objects         | 66.15s | 58.45s | -11%  |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 alloc.c                 |   1 +
 commit-graph.c          | 141 +++++++++++++++++++++++++++++++++++++++-
 commit-graph.h          |  12 ++++
 commit.c                |   3 +
 commit.h                |   3 +
 t/t5318-commit-graph.sh |  47 +++++++++++++-
 6 files changed, 205 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadfacd..cf4f8b61e1 100644
--- a/alloc.c
+++ b/alloc.c
@@ -93,6 +93,7 @@ void *alloc_commit_node(void)
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index();
+	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
 	return c;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index ea29c5c2d8..983454785e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,7 +38,6 @@
 #define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
-
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
@@ -179,6 +178,145 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	exit(1);
 }
 
+/* global storage */
+struct commit_graph *commit_graph = NULL;
+
+static void prepare_commit_graph_one(const char *obj_dir)
+{
+	char *graph_name;
+
+	if (commit_graph)
+		return;
+
+	graph_name = get_commit_graph_filename(obj_dir);
+	commit_graph = load_commit_graph_one(graph_name);
+
+	FREE_AND_NULL(graph_name);
+}
+
+static int prepare_commit_graph_run_once = 0;
+static void prepare_commit_graph(void)
+{
+	struct alternate_object_database *alt;
+	char *obj_dir;
+
+	if (prepare_commit_graph_run_once)
+		return;
+	prepare_commit_graph_run_once = 1;
+
+	obj_dir = get_object_directory();
+	prepare_commit_graph_one(obj_dir);
+	prepare_alt_odb();
+	for (alt = alt_odb_list; !commit_graph && alt; alt = alt->next)
+		prepare_commit_graph_one(alt->path);
+}
+
+static void close_commit_graph(void)
+{
+	if (!commit_graph)
+		return;
+
+	if (commit_graph->graph_fd >= 0) {
+		munmap((void *)commit_graph->data, commit_graph->data_len);
+		commit_graph->data = NULL;
+		close(commit_graph->graph_fd);
+	}
+
+	FREE_AND_NULL(commit_graph);
+}
+
+static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
+{
+	return bsearch_hash(oid->hash, g->chunk_oid_fanout,
+			    g->chunk_oid_lookup, g->hash_len, pos);
+}
+
+static struct commit_list **insert_parent_or_die(struct commit_graph *g,
+						 uint64_t pos,
+						 struct commit_list **pptr)
+{
+	struct commit *c;
+	struct object_id oid;
+	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
+	c = lookup_commit(&oid);
+	if (!c)
+		die("could not find commit %s", oid_to_hex(&oid));
+	c->graph_pos = pos;
+	return &commit_list_insert(c, pptr)->next;
+}
+
+static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
+{
+	struct object_id oid;
+	uint32_t edge_value;
+	uint32_t *parent_data_ptr;
+	uint64_t date_low, date_high;
+	struct commit_list **pptr;
+	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
+
+	item->object.parsed = 1;
+	item->graph_pos = pos;
+
+	hashcpy(oid.hash, commit_data);
+	item->tree = lookup_tree(&oid);
+
+	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
+	date_low = get_be32(commit_data + g->hash_len + 12);
+	item->date = (timestamp_t)((date_high << 32) | date_low);
+
+	pptr = &item->parents;
+
+	edge_value = get_be32(commit_data + g->hash_len);
+	if (edge_value == GRAPH_PARENT_NONE)
+		return 1;
+	pptr = insert_parent_or_die(g, edge_value, pptr);
+
+	edge_value = get_be32(commit_data + g->hash_len + 4);
+	if (edge_value == GRAPH_PARENT_NONE)
+		return 1;
+	if (!(edge_value & GRAPH_OCTOPUS_EDGES_NEEDED)) {
+		pptr = insert_parent_or_die(g, edge_value, pptr);
+		return 1;
+	}
+
+	parent_data_ptr = (uint32_t*)(g->chunk_large_edges +
+			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
+	do {
+		edge_value = get_be32(parent_data_ptr);
+		pptr = insert_parent_or_die(g,
+					    edge_value & GRAPH_EDGE_LAST_MASK,
+					    pptr);
+		parent_data_ptr++;
+	} while (!(edge_value & GRAPH_LAST_EDGE));
+
+	return 1;
+}
+
+int parse_commit_in_graph(struct commit *item)
+{
+	if (!core_commit_graph)
+		return 0;
+	if (item->object.parsed)
+		return 1;
+
+	prepare_commit_graph();
+	if (commit_graph) {
+		uint32_t pos;
+		int found;
+		if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
+			pos = item->graph_pos;
+			found = 1;
+		} else {
+			found = bsearch_graph(commit_graph, &(item->object.oid), &pos);
+		}
+
+		if (found)
+			return fill_commit_in_graph(item, commit_graph, pos);
+	}
+
+	return 0;
+}
+
 static void write_graph_chunk_fanout(struct hashfile *f,
 				     struct commit **commits,
 				     int nr_commits)
@@ -530,6 +668,7 @@ void write_commit_graph(const char *obj_dir)
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
+	close_commit_graph();
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
diff --git a/commit-graph.h b/commit-graph.h
index 2528478f06..73b28beed1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,6 +5,18 @@
 
 char *get_commit_graph_filename(const char *obj_dir);
 
+/*
+ * Given a commit struct, try to fill the commit struct info, including:
+ *  1. tree object
+ *  2. date
+ *  3. parents.
+ *
+ * Returns 1 if and only if the commit was found in the packed graph.
+ *
+ * See parse_commit_buffer() for the fallback after this call.
+ */
+int parse_commit_in_graph(struct commit *item);
+
 struct commit_graph {
 	int graph_fd;
 
diff --git a/commit.c b/commit.c
index 00c99c7272..3e39c86abf 100644
--- a/commit.c
+++ b/commit.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "commit-graph.h"
 #include "pkt-line.h"
 #include "utf8.h"
 #include "diff.h"
@@ -383,6 +384,8 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
+	if (parse_commit_in_graph(item))
+		return 0;
 	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
diff --git a/commit.h b/commit.h
index 0fb8271665..e57ae4b583 100644
--- a/commit.h
+++ b/commit.h
@@ -9,6 +9,8 @@
 #include "string-list.h"
 #include "pretty.h"
 
+#define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
+
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
@@ -21,6 +23,7 @@ struct commit {
 	timestamp_t date;
 	struct commit_list *parents;
 	struct tree *tree;
+	uint32_t graph_pos;
 };
 
 extern int save_commit_buffer;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2f44f91193..51de9cc455 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -7,6 +7,7 @@ test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
 	git init &&
+	git config core.commitGraph true &&
 	objdir=".git/objects"
 '
 
@@ -26,6 +27,29 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
+graph_git_two_modes() {
+	git -c core.graph=true $1 >output
+	git -c core.graph=false $1 >expect
+	test_cmp output expect
+}
+
+graph_git_behavior() {
+	MSG=$1
+	DIR=$2
+	BRANCH=$3
+	COMPARE=$4
+	test_expect_success "check normal git operations: $MSG" '
+		cd "$TRASH_DIRECTORY/$DIR" &&
+		graph_git_two_modes "log --oneline $BRANCH" &&
+		graph_git_two_modes "log --topo-order $BRANCH" &&
+		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
+		graph_git_two_modes "branch -vv" &&
+		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+	'
+}
+
+graph_git_behavior 'no graph' full commits/3 commits/1
+
 graph_read_expect() {
 	OPTIONAL=""
 	NUM_CHUNKS=3
@@ -50,6 +74,8 @@ test_expect_success 'write graph' '
 	graph_read_expect "3"
 '
 
+graph_git_behavior 'graph exists' full commits/3 commits/1
+
 test_expect_success 'Add more commits' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git reset --hard commits/1 &&
@@ -86,7 +112,6 @@ test_expect_success 'Add more commits' '
 # |___/____/
 # 1
 
-
 test_expect_success 'write graph with merges' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
@@ -94,6 +119,10 @@ test_expect_success 'write graph with merges' '
 	graph_read_expect "10" "large_edges"
 '
 
+graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
+graph_git_behavior 'merge 1 vs 3' full merge/1 merge/3
+graph_git_behavior 'merge 2 vs 3' full merge/2 merge/3
+
 test_expect_success 'Add one more commit' '
 	cd "$TRASH_DIRECTORY/full" &&
 	test_commit 8 &&
@@ -115,6 +144,9 @@ test_expect_success 'Add one more commit' '
 # |___/____/
 # 1
 
+graph_git_behavior 'mixed mode, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'mixed mode, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'write graph with new commit' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
@@ -122,6 +154,9 @@ test_expect_success 'write graph with new commit' '
 	graph_read_expect "11" "large_edges"
 '
 
+graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'full graph, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'write graph with nothing new' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
@@ -129,13 +164,20 @@ test_expect_success 'write graph with nothing new' '
 	graph_read_expect "11" "large_edges"
 '
 
+graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'cleared graph, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
 	cd bare &&
+	git config core.commitGraph true &&
 	baredir="./objects"
 '
 
+graph_git_behavior 'bare repo, commit 8 vs merge 1' bare commits/8 merge/1
+graph_git_behavior 'bare repo, commit 8 vs merge 2' bare commits/8 merge/2
+
 test_expect_success 'write graph in bare repo' '
 	cd "$TRASH_DIRECTORY/bare" &&
 	git commit-graph write &&
@@ -143,4 +185,7 @@ test_expect_success 'write graph in bare repo' '
 	graph_read_expect "11" "large_edges"
 '
 
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare commits/8 merge/2
+
 test_done
-- 
2.17.0.14.gba1221a8ce

