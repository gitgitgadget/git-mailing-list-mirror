Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20A11F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCNT2V (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:21 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42222 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeCNT2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:08 -0400
Received: by mail-qk0-f194.google.com with SMTP id b198so4751318qkg.9
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ilby2fZfx7mvSfFxsa0soJyvhrItAFr/XzLTcmA7Udo=;
        b=MYNk9g3aMTBvUE78N6bagee3YWnKVKp66N3D12GcTwaDvRTgnX6bl2fMoNsQXT93MW
         cJFQBswLZ71OVQV/RMkUysXfaida2fBNM554DRiVHFFRXHuqxu2OV9YtkTWOY3OVyBM4
         mi4SjL0BZU0kMXERQzoSvvJy9K2FZpclnNRROEL3HJJ4I9w34sglXwm7EMv21YSxopZ3
         e7VpJXFAdHDfE76EtFZ4EHnq2FBOvZNrdtx6zIDr+mBVciTgcU2QwF4E6mee1WPxDfUk
         nqIM1NuWj/lgYZIXImul2fFrty8Bx7pjuAjppS8eREzUaaB9fxCYjYjIRyZDmk0dPtVZ
         zHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ilby2fZfx7mvSfFxsa0soJyvhrItAFr/XzLTcmA7Udo=;
        b=OBnwGPQDOGwPx5zPGnwYKoxwaRmfiwW6x4CK5MYnHyL3P0lkOtRH9G6sX8qUWRwPEv
         SLt0M2gW4jXiUE/uxHU8bLsocGLNBigOUPs1uthFt4F5qCO9FpIga5pxMYuI6s3+zWTc
         vcp7rR6cypWa/qdaW4emHr6ZMyhIxGICsMmEzNWQvKkKuVYACZbr9gbFxkQ/TUQ4IX/z
         CKC7VywEye+W2WvNhPEjY0ajed+yFfdhk8957w8mfRjTcHWr6whbGXJq4J+zcaj4aspj
         g4adKAtI782GsQQDSnq8PMMUSzCvOARJIEfNF1W+fcftvQrSClQlImwIu86XXP07/gCY
         r2dA==
X-Gm-Message-State: AElRT7HQPX4aufMvv6nYbjFqi9RIc/gRApCxXDfDz1H92l+RUVqWhQcz
        JDCOjNJcGUclADsHZLd4zX1CwUJoDt4=
X-Google-Smtp-Source: AG47ELuV0gqiLRDT9DUdqCWh4ned6AKiz+qM+7eLuWFZFW0HJdVGMqR/yCZ+8r3j0mN8A0kwzZB08w==
X-Received: by 10.55.158.137 with SMTP id h131mr3520134qke.330.1521055686912;
        Wed, 14 Mar 2018 12:28:06 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:28:06 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 11/14] commit: integrate commit graph with commit parsing
Date:   Wed, 14 Mar 2018 15:27:33 -0400
Message-Id: <20180314192736.70602-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
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
 commit-graph.c          | 141 +++++++++++++++++++++++++++++++++++++++++++++++-
 commit-graph.h          |  12 +++++
 commit.c                |   3 ++
 commit.h                |   3 ++
 t/t5318-commit-graph.sh |  47 +++++++++++++++-
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
index fc7b4fa622..98e2b89b94 100644
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
@@ -510,6 +648,7 @@ void write_commit_graph(const char *obj_dir)
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
+	close_commit_graph();
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
diff --git a/commit-graph.h b/commit-graph.h
index 8b4b0f9f04..b223b9b078 100644
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
index 03b75882a0..7bcc1b2874 100755
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
2.14.1

