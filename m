Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A1A1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeB0Cdo (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:44 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39348 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbeB0Cd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:26 -0500
Received: by mail-qt0-f196.google.com with SMTP id f4so21403454qtj.6
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F5mOSFBmQBJ57CVUzZPeDJNW9fy8jR+ok5hDU6j8fjU=;
        b=LUO7l+itF3UT3XSzUqE/Z0xZxC6oEJBMDrOBpQfGZzW0fd2f7I2cRNXG8YfJeBKQ/U
         15X1iZBjrHJrKJmP4DfDdGBK+7CgkTXUqO8H7r+LK2vcj8qW31Q5PfJMMP9AaSRPgxHe
         RKDjvBrz0EWaG8HoCQILmXFpmlRRIjv3dr4VMzKTzx1X/xDnG8d3CJCXX7fma43TtzVa
         UVAIvW8XcfbkaiwKii9eLiDL+uCG4EltLzF5PP9IoE62myyEW0cQqJKPyMPnJTNOX7sw
         Jw8GhMD0XQALU2dM7B7ub2kRp2SEJP6aqUgpvogarsYdN6N1ZsLvQu9xu4LSQLgdzSRU
         REcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F5mOSFBmQBJ57CVUzZPeDJNW9fy8jR+ok5hDU6j8fjU=;
        b=ATB5HMimSeAUh5Gp0mzTEN1RP+3VtzUpstgpn6C9X5rEtUGjSY4k97gMPmRyu9+duU
         ArmeQQoIMZoHm+I5Mn7jOpGChQrsGbUEfHMqWWREt0Qu+d7n1gJiP2JrAs1u11DLSTmW
         3/dCWpDVEZUMRgETAfsH49ANpG1OT4ClJ9Noeh+56gxh5RvpZvp6ZNvy4f5aPADa+Ber
         95zU8Lgbs+eUweKMDBV9wrn424eUz53H7HqyDDwjyoLNJvUdJopofHf+M1qygQRKtHvy
         Qp6ZTae2V5GUaFIx31/fL8ThbQoi7gkr5UuI/JNk/TnKrxelEXOn4KqBWC2TdQtBsIJj
         Kaeg==
X-Gm-Message-State: APf1xPB9BDXSKVATNEUbU2LK6nGxVVHSxlJDMf6kjqmX2ZGqdngfL1pH
        qYPshFb5VQfrb84jxfhzlXdEjnxu6dE=
X-Google-Smtp-Source: AG47ELv+XLzJNWPITkJ5lzG3NLYAn26OD/2NrREkudO/Q/8XfXM8O7w2dwlkjwh/MbDL5AtZHJNDXg==
X-Received: by 10.237.57.197 with SMTP id m63mr20981225qte.249.1519698805160;
        Mon, 26 Feb 2018 18:33:25 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:24 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 10/13] commit: integrate commit graph with commit parsing
Date:   Mon, 26 Feb 2018 21:33:04 -0500
Message-Id: <1519698787-190494-11-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to inspect a commit graph file to supply the contents of a
struct commit when calling parse_commit_gently(). This implementation
satisfies all post-conditions on the struct commit, including loading
parents, the root tree, and the commit date.

If core.commitGraph is false, then do not check graph files.

In test script t5318-commit-graph.sh, add output-matching conditions on
read-only graph operations.

By loading commits from the graph instead of parsing commit buffers, we
save a lot of time on long commit walks. Here are some performance
results for a copy of the Linux repository where 'master' has 664,185
reachable commits and is behind 'origin/master' by 60,191 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  6.56s |  0.66s | -89%  |
| branch -vv                       |  1.35s |  0.32s | -76%  |
| rev-list --all                   |  6.7s  |  0.83s | -87%  |
| rev-list --all --objects         | 33.0s  | 27.5s  | -16%  |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 alloc.c                 |   1 +
 commit-graph.c          | 141 +++++++++++++++++++++++++++++++++++++++++++++++-
 commit-graph.h          |  12 +++++
 commit.c                |   3 ++
 commit.h                |   3 ++
 t/t5318-commit-graph.sh |  47 +++++++++++++++-
 6 files changed, 205 insertions(+), 2 deletions(-)

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
index 01aa23d..184b8da 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,7 +38,6 @@
 #define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
-
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
@@ -182,6 +181,145 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
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
+	date_high = ntohl(*(uint32_t*)(commit_data + g->hash_len + 8)) & 0x3;
+	date_low = ntohl(*(uint32_t*)(commit_data + g->hash_len + 12));
+	item->date = (timestamp_t)((date_high << 32) | date_low);
+
+	pptr = &item->parents;
+
+	edge_value = ntohl(*(uint32_t*)(commit_data + g->hash_len));
+	if (edge_value == GRAPH_PARENT_NONE)
+		return 1;
+	pptr = insert_parent_or_die(g, edge_value, pptr);
+
+	edge_value = ntohl(*(uint32_t*)(commit_data + g->hash_len + 4));
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
+		edge_value = ntohl(*parent_data_ptr);
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
@@ -511,6 +649,7 @@ void write_commit_graph(const char *obj_dir)
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
+	close_commit_graph();
 	hashclose(f, final_hash, CSUM_CLOSE | CSUM_FSYNC | CSUM_KEEP_OPEN);
 	commit_lock_file(&lk);
 
diff --git a/commit-graph.h b/commit-graph.h
index 8b4b0f9..b223b9b 100644
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
index e8a49b9..eb61729 100644
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
index 0fb8271..e57ae4b 100644
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
index 0085e23..9a0cd71 100755
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
@@ -143,5 +185,8 @@ test_expect_success 'write graph in bare repo' '
 	graph_read_expect "11" "large_edges"
 '
 
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare commits/8 merge/2
+
 test_done
 
-- 
2.7.4

