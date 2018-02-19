Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D291F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeBSSxv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:51 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38738 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbeBSSxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:47 -0500
Received: by mail-qk0-f196.google.com with SMTP id s198so13469593qke.5
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LpyQTQY1CD3yjii/UtM8YqVqO8i1bYJKJzvEYQnNsj8=;
        b=DHH9wnXXpJA7crTqd65J+OLMala66/y8C3IkHLoBHr1r99KP5EdlScQ9Cx1nYqVowk
         bKcWIrmpVB3LfH61TD8IHvYsg90sm/zRvOhVpoDbSbYhEzsWsHZdUn/+udNpZ16ASOvI
         b9ueJ3Q0MARolJUWFv+KqNqlVNnqoTtpUcXl3wOW8QdgH6EfPKB9+bcHn2ppFC0ltZgp
         S26+7ujtmCpueysbx/sdPh/V2mgfz09LkQh3q20J70MVZZLFmgGzpFsI4bfjNrQYvDOz
         Pfbm9lejS7GKIsMFALTtZ+rB1aYaJleYNDnDphUEX3LO/iDi6phXO6JZp/Dfa82i7yDR
         9p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LpyQTQY1CD3yjii/UtM8YqVqO8i1bYJKJzvEYQnNsj8=;
        b=ajnTftIdf6dxD1kQVtqjv0VRi95NUSMAakUcSqiyREiX7aOlwEFk96axLfxV4ldtrl
         /jXylkzQGUB0bplpH5G1KxK3Ttje1o0tDZ/bT6WX9G0XJMCAvug7yiKg4REWu9qkiPt+
         CFow7lMAWe/irPBEnDLdNdDAZGMG4C7YweBvDvS7Xs1JuGt1HW60OAFB8H93QJ6EHAZo
         t1JwP/0R3YQK4rWk5twbjVl6efK0S/KP1FrpFNMF3blI32euICOb327yEG5C8xrq6c0z
         DmZm5GmBA2OBYRVEIYn2KRUJ6ZpZ0yBe/nYEWbw4PdHQ4uQBlzXjUO6MUAdi+ftQNVx7
         46Bg==
X-Gm-Message-State: APf1xPDjRPLZZCAOC+1hOnOyiX4fPyrfWiI6GZDVigiS0XBdkjWtufPs
        EiafIfRqlEEW5/GazRZn3u6z5DJ4/iY=
X-Google-Smtp-Source: AH8x226+1PcVGIMbzJVSy6l3p9nA885+V9pVYOQkDM3w/fYi4+TpzHamCk7W3WQuPFwgVYzUo0fq0w==
X-Received: by 10.55.87.198 with SMTP id l189mr25301502qkb.325.1519066425902;
        Mon, 19 Feb 2018 10:53:45 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:45 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 11/13] commit: integrate commit graph with commit parsing
Date:   Mon, 19 Feb 2018 13:53:24 -0500
Message-Id: <1519066406-81663-12-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to inspect a commit graph file to supply the contents of a
struct commit when calling parse_commit_gently(). This implementation
satisfies all post-conditions on the struct commit, including loading
parents, the root tree, and the commit date. The only loosely-expected
condition is that the commit buffer is loaded into the cache. This
was checked in log-tree.c:show_log(), but the "return;" on failure
produced unexpected results (i.e. the message line was never terminated).
The new behavior of loading the buffer when needed prevents the
unexpected behavior.

If core.commitGraph is false, then do not check graph files.

In test script t5318-commit-graph.sh, add output-matching conditions on
read-only graph operations.

By loading commits from the graph instead of parsing commit buffers, we
save a lot of time on long commit walks. Here are some performance
results for a copy of the Linux repository where 'master' has 704,766
reachable commits and is behind 'origin/master' by 19,610 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
| branch -vv                       |  0.42s |  0.27s | -35%  |
| rev-list --all                   |  6.4s  |  1.0s  | -84%  |
| rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 alloc.c                 |   1 +
 commit-graph.c          | 148 ++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h          |  18 +++++-
 commit.c                |   3 +
 commit.h                |   3 +
 log-tree.c              |   3 +-
 t/t5318-commit-graph.sh |  45 ++++++++++++++-
 7 files changed, 216 insertions(+), 5 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadf..cf4f8b6 100644
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
index 00bd73a..ea07b47 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,6 +38,9 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
+/* global storage */
+struct commit_graph *commit_graph = NULL;
+
 char *get_graph_latest_filename(const char *obj_dir)
 {
 	struct strbuf fname = STRBUF_INIT;
@@ -184,6 +187,150 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	return graph;
 }
 
+static void prepare_commit_graph_one(const char *obj_dir)
+{
+	struct strbuf graph_file = STRBUF_INIT;
+	char *graph_name;
+
+	if (commit_graph)
+		return;
+
+	graph_name = get_graph_latest_contents(obj_dir);
+
+	if (!graph_name)
+		return;
+
+	strbuf_addf(&graph_file, "%s/info/%s", obj_dir, graph_name);
+
+	commit_graph = load_commit_graph_one(graph_file.buf);
+
+	FREE_AND_NULL(graph_name);
+	strbuf_release(&graph_file);
+}
+
+static int prepare_commit_graph_run_once = 0;
+void prepare_commit_graph(void)
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
+	uint32_t new_parent_pos;
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
+	date_high = ntohl(*(uint32_t*)(commit_data + g->hash_len + 8)) & 0x3;
+	date_low = ntohl(*(uint32_t*)(commit_data + g->hash_len + 12));
+	item->date = (timestamp_t)((date_high << 32) | date_low);
+
+	pptr = &item->parents;
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hash_len));
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return 1;
+	pptr = insert_parent_or_die(g, new_parent_pos, pptr);
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hash_len + 4));
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return 1;
+	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED)) {
+		pptr = insert_parent_or_die(g, new_parent_pos, pptr);
+		return 1;
+	}
+
+	parent_data_ptr = (uint32_t*)(g->chunk_large_edges +
+			  4 * (uint64_t)(new_parent_pos & GRAPH_EDGE_LAST_MASK));
+	do {
+		new_parent_pos = ntohl(*parent_data_ptr);
+		pptr = insert_parent_or_die(g,
+					    new_parent_pos & GRAPH_EDGE_LAST_MASK,
+					    pptr);
+		parent_data_ptr++;
+	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
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
 static void write_graph_chunk_fanout(struct sha1file *f,
 				     struct commit **commits,
 				     int nr_commits)
@@ -525,6 +672,7 @@ char *write_commit_graph(const char *obj_dir)
 	graph_name = strbuf_detach(&graph_file, NULL);
 	strbuf_addf(&graph_file, "%s/info/%s", obj_dir, graph_name);
 
+	close_commit_graph();
 	if (rename(tmp_file.buf, graph_file.buf))
 		die("failed to rename %s to %s", tmp_file.buf, graph_file.buf);
 
diff --git a/commit-graph.h b/commit-graph.h
index 56215ad..4818838 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -6,7 +6,19 @@
 extern char *get_graph_latest_filename(const char *obj_dir);
 extern char *get_graph_latest_contents(const char *obj_dir);
 
-struct commit_graph {
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
+extern int parse_commit_in_graph(struct commit *item);
+
+extern struct commit_graph {
 	int graph_fd;
 
 	const unsigned char *data;
@@ -21,10 +33,12 @@ struct commit_graph {
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_large_edges;
-};
+} *commit_graph;
 
 extern struct commit_graph *load_commit_graph_one(const char *graph_file);
 
+extern void prepare_commit_graph(void);
+
 extern char *write_commit_graph(const char *obj_dir);
 
 #endif
diff --git a/commit.c b/commit.c
index cab8d44..a8b464d 100644
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
@@ -385,6 +386,8 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
+	if (parse_commit_in_graph(item))
+		return 0;
 	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
diff --git a/commit.h b/commit.h
index 99a3fea..57963d8 100644
--- a/commit.h
+++ b/commit.h
@@ -8,6 +8,8 @@
 #include "gpg-interface.h"
 #include "string-list.h"
 
+#define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
+
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
@@ -20,6 +22,7 @@ struct commit {
 	timestamp_t date;
 	struct commit_list *parents;
 	struct tree *tree;
+	uint32_t graph_pos;
 };
 
 extern int save_commit_buffer;
diff --git a/log-tree.c b/log-tree.c
index 580b3a9..14735d4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -647,8 +647,7 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!get_cached_commit_buffer(commit, NULL))
-		return;
+	get_commit_buffer(commit, NULL);
 
 	if (opt->show_notes) {
 		int raw;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 1d5ec7d..8c6b510 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -8,6 +8,7 @@ test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd full &&
 	git init &&
+	git config core.commitGraph true &&
 	objdir=".git/objects"
 '
 
@@ -25,6 +26,27 @@ test_expect_success 'create commits and repack' '
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
+	BRANCH=$2
+	COMPARE=$3
+	test_expect_success "check normal git operations: $MSG" '
+		graph_git_two_modes "log --oneline $BRANCH" &&
+		graph_git_two_modes "log --topo-order $BRANCH" &&
+		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
+		graph_git_two_modes "branch -vv" &&
+		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+	'
+}
+
+graph_git_behavior 'no graph' commits/3 commits/1
+
 graph_read_expect() {
 	OPTIONAL=""
 	NUM_CHUNKS=3
@@ -49,6 +71,8 @@ test_expect_success 'write graph' '
 	test_cmp expect output
 '
 
+graph_git_behavior 'graph exists, no head' commits/3 commits/1
+
 test_expect_success 'Add more commits' '
 	git reset --hard commits/1 &&
 	for i in $(test_seq 4 5)
@@ -84,7 +108,6 @@ test_expect_success 'Add more commits' '
 # |___/____/
 # 1
 
-
 test_expect_success 'write graph with merges' '
 	graph2=$(git commit-graph write --set-latest)&&
 	test_path_is_file $objdir/info/$graph2 &&
@@ -96,6 +119,10 @@ test_expect_success 'write graph with merges' '
 	test_cmp expect output
 '
 
+graph_git_behavior 'merge 1 vs 2' merge/1 merge/2
+graph_git_behavior 'merge 1 vs 3' merge/1 merge/3
+graph_git_behavior 'merge 2 vs 3' merge/2 merge/3
+
 test_expect_success 'Add one more commit' '
 	test_commit 8 &&
 	git branch commits/8 &&
@@ -116,6 +143,9 @@ test_expect_success 'Add one more commit' '
 # |___/____/
 # 1
 
+graph_git_behavior 'mixed mode, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'mixed mode, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'write graph with new commit' '
 	graph3=$(git commit-graph write --set-latest --delete-expired) &&
 	test_path_is_file $objdir/info/$graph3 &&
@@ -129,6 +159,9 @@ test_expect_success 'write graph with new commit' '
 	test_cmp expect output
 '
 
+graph_git_behavior 'full graph, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'full graph, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'write graph with nothing new' '
 	graph4=$(git commit-graph write --set-latest --delete-expired) &&
 	test_path_is_file $objdir/info/$graph4 &&
@@ -144,13 +177,20 @@ test_expect_success 'write graph with nothing new' '
 	test_cmp expect output
 '
 
+graph_git_behavior 'cleared graph, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'cleared graph, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd .. &&
 	git clone --bare --no-local full bare &&
 	cd bare &&
+	git config core.commitGraph true &&
 	baredir="./objects"
 '
 
+graph_git_behavior 'bare repo, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'bare repo, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'write graph in bare repo' '
 	graphbare=$(git commit-graph write --set-latest) &&
 	test_path_is_file $baredir/info/$graphbare &&
@@ -162,5 +202,8 @@ test_expect_success 'write graph in bare repo' '
 	test_cmp expect output
 '
 
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' commits/8 merge/2
+
 test_done
 
-- 
2.7.4

