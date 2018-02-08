Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442001F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBHUiK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:10 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42508 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeBHUiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:04 -0500
Received: by mail-qt0-f193.google.com with SMTP id i8so7905373qtj.9
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwYZPxPFRhzzSPUA10F8XoMnPdPawhKHsk52xFqMmi4=;
        b=Cw4UjeAhloKEZ/mWEi9RQeh0PiBEqQ8WpeZs+P8AzClzS+6CgBer6fPa4si1t40owG
         057nrrFd9SsjTY3cG5ZAgjwcdtZ5HCuSHaIRQkTs7dXTg6pU7eGZvXPcVHX/iXSR/yHS
         6v9x9einfP8ajrbM75SajUEiPAmwvL8gkucyt4RwyEZMxOZlYzc7CyGHZOD54eizldhD
         cKkn7w6X7fkAxeMvRg3dTEjWZdpFDsaRooDQLfvawDkinRhg1Ew5+KpSlTjc4gu8KC00
         +j9JCXN1dUdCRlmIVlWlJ6UUEuE8xW6JcUm+NfF7rSGI4mSFMTm3Zy/b4CcwGUxWK8yv
         yhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwYZPxPFRhzzSPUA10F8XoMnPdPawhKHsk52xFqMmi4=;
        b=YLRwM3/CjBAHUpxD78afjVsRFk1zlWeSPEBjxfgpTaNXixzvoJmDyfQ3gbRy3kEOED
         nyyT3Tcpdq5egsMnr7moylsAa6bKesDKaIl/k3fZs/s4fjwggjbHPKghgBMDxcOC+52F
         oG6QnN3qYSU8e3WCEwZGPySSDVgXHel5X7Y39G9gsr0sssugMjvgnFzXEDqXoudwBfW8
         NNLr+NEskl27Iuvy/T8ngUFv6A2g7ASo8d19VqfL82wsJDOZn+2DgRcOMtpGuuHPYv+a
         jzBlLF05FZ3NiTtD07FAJqfxy0yUpUifgJMq59apPLLAqeP4ARamPxSzYbPnSvxyebTj
         aaeQ==
X-Gm-Message-State: APf1xPBx3jw/QpEj+EKTCJiuShC7nhuZrXEvAnnFEPJ8oiDhbL6606Gh
        gF9yOzKMCrqnL4xPnoThj6NwAsBy2NI=
X-Google-Smtp-Source: AH8x225CSPtPCvnOC12InJ7L/cRbO1MEB4JE6kDW0iIgbBPv+1xRHB5VnrPSA/a6qP6WIkbwWEkvIA==
X-Received: by 10.200.9.60 with SMTP id t57mr774164qth.74.1518122283549;
        Thu, 08 Feb 2018 12:38:03 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:38:02 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 11/14] commit: integrate commit graph with commit parsing
Date:   Thu,  8 Feb 2018 15:37:35 -0500
Message-Id: <1518122258-157281-12-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
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
 commit-graph.c          | 202 ++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h          |  21 ++++-
 commit.c                |   3 +
 commit.h                |   3 +
 log-tree.c              |   3 +-
 t/t5318-commit-graph.sh |  44 ++++++++++-
 7 files changed, 272 insertions(+), 5 deletions(-)

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
index 95b813c2c7..aff67c458e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,6 +38,9 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
+/* global storage */
+struct commit_graph *commit_graph = NULL;
+
 char *get_graph_head_filename(const char *pack_dir)
 {
 	struct strbuf fname = STRBUF_INIT;
@@ -229,6 +232,205 @@ struct commit_graph *load_commit_graph_one(const char *graph_file, const char *p
 	return graph;
 }
 
+static void prepare_commit_graph_one(const char *obj_dir)
+{
+	char *graph_file;
+	struct object_id oid;
+	struct strbuf pack_dir = STRBUF_INIT;
+	strbuf_addstr(&pack_dir, obj_dir);
+	strbuf_add(&pack_dir, "/pack", 5);
+
+	if (!get_graph_head_hash(pack_dir.buf, &oid))
+		return;
+
+	graph_file = get_commit_graph_filename_hash(pack_dir.buf, &oid);
+
+	commit_graph = load_commit_graph_one(graph_file, pack_dir.buf);
+	strbuf_release(&pack_dir);
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
+static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
+{
+	int result = bsearch_hash(oid->hash, g->chunk_oid_fanout,
+				  g->chunk_oid_lookup, g->hash_len);
+
+	if (result >= 0) {
+		*pos = result;
+		return 1;
+	} else {
+		*pos = -result - 1;
+		return 0;
+	}
+}
+
+struct object_id *get_nth_commit_oid(struct commit_graph *g,
+				     uint32_t n,
+				     struct object_id *oid)
+{
+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * n);
+	return oid;
+}
+
+static struct commit_list **insert_parent_or_die(struct commit_graph *g,
+					   int pos,
+					   struct commit_list **pptr)
+{
+	struct commit *c;
+	struct object_id oid;
+	get_nth_commit_oid(g, pos, &oid);
+	c = lookup_commit(&oid);
+	if (!c)
+		die("could not find commit %s", oid_to_hex(&oid));
+	c->graph_pos = pos;
+	return &commit_list_insert(c, pptr)->next;
+}
+
+static int check_commit_parents(struct commit *item, struct commit_graph *g,
+				uint32_t pos, const unsigned char *commit_data)
+{
+	uint32_t new_parent_pos;
+	uint32_t *parent_data_ptr;
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hash_len));
+
+	if (new_parent_pos == GRAPH_PARENT_MISSING)
+		return 0;
+
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return 1;
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hash_len + 4));
+
+	if (new_parent_pos == GRAPH_PARENT_MISSING)
+		return 0;
+	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED))
+		return 1;
+
+	new_parent_pos = new_parent_pos ^ GRAPH_LARGE_EDGES_NEEDED;
+
+	if (new_parent_pos == GRAPH_PARENT_MISSING)
+		return 0;
+
+	parent_data_ptr = (uint32_t*)(g->chunk_large_edges + 4 * new_parent_pos);
+	do {
+		new_parent_pos = ntohl(*parent_data_ptr);
+
+		if ((new_parent_pos & GRAPH_EDGE_LAST_MASK) == GRAPH_PARENT_MISSING)
+			return 0;
+
+		parent_data_ptr++;
+	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
+
+	return 1;
+}
+
+static int full_parse_commit(struct commit *item, struct commit_graph *g,
+			     uint32_t pos, const unsigned char *commit_data)
+{
+	struct object_id oid;
+	uint32_t new_parent_pos;
+	uint32_t *parent_data_ptr;
+	uint64_t date_low, date_high;
+	struct commit_list **pptr;
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
+			  4 * (new_parent_pos ^ GRAPH_LARGE_EDGES_NEEDED));
+	do {
+		new_parent_pos = ntohl(*parent_data_ptr);
+		pptr = insert_parent_or_die(g, new_parent_pos, pptr);
+		parent_data_ptr++;
+	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
+
+	return 1;
+}
+
+static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
+{
+	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
+
+	if (!check_commit_parents(item, g, pos, commit_data))
+		return 0;
+
+	return full_parse_commit(item, g, pos, commit_data);
+}
+
+/*
+ * Given a commit struct, try to fill the commit struct info, including:
+ *  1. tree object
+ *  2. date
+ *  3. parents.
+ *
+ * Returns 1 if and only if the commit was found in the commit graph.
+ *
+ * See parse_commit_buffer() for the fallback after this call.
+ */
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
diff --git a/commit-graph.h b/commit-graph.h
index 75427cd5f6..7c4c9c38ab 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,13 +4,25 @@
 #include "git-compat-util.h"
 #include "commit.h"
 
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
 extern char *get_graph_head_filename(const char *pack_dir);
 extern struct object_id *get_graph_head_hash(const char *pack_dir,
 					     struct object_id *hash);
 extern char* get_commit_graph_filename_hash(const char *pack_dir,
 					    struct object_id *hash);
 
-struct commit_graph {
+extern struct commit_graph {
 	int graph_fd;
 
 	const unsigned char *data;
@@ -28,10 +40,15 @@ struct commit_graph {
 
 	/* something like ".git/objects/pack" */
 	char pack_dir[FLEX_ARRAY]; /* more */
-};
+} *commit_graph;
 
 extern struct commit_graph *load_commit_graph_one(const char *graph_file,
 						  const char *pack_dir);
+extern void prepare_commit_graph(void);
+
+extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
+					    uint32_t n,
+					    struct object_id *oid);
 
 extern struct object_id *write_commit_graph(const char *pack_dir);
 
diff --git a/commit.c b/commit.c
index cab8d4455b..a8b464d901 100644
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
index 99a3fea68d..57963d86c3 100644
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
index 580b3a98a0..14735d412b 100644
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
index 10dfb6c5cf..1e3fe59d70 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -8,6 +8,7 @@ test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd full &&
 	git init &&
+	git config core.commitGraph true &&
 	packdir=".git/objects/pack"'
 
 test_expect_success 'write graph with no packs' '
@@ -22,6 +23,26 @@ test_expect_success 'create commits and repack' '
 	done &&
 	git repack'
 
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
+		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"'
+}
+
+graph_git_behavior 'no graph' commits/3 commits/1
+
 graph_read_expect() {
 	cat >expect <<- EOF
 	header: 43475048 01 01 14 04
@@ -39,6 +60,8 @@ test_expect_success 'write graph' '
 	graph_read_expect "3" "$packdir" &&
 	test_cmp expect output'
 
+graph_git_behavior 'graph exists, no head' commits/3 commits/1
+
 test_expect_success 'Add more commits' '
 	git reset --hard commits/1 &&
 	for i in $(test_seq 4 5)
@@ -73,7 +96,6 @@ test_expect_success 'Add more commits' '
 # |___/____/
 # 1
 
-
 test_expect_success 'write graph with merges' '
 	graph2=$(git commit-graph write --update-head)&&
 	test_path_is_file $packdir/graph-$graph2.graph &&
@@ -84,6 +106,10 @@ test_expect_success 'write graph with merges' '
 	graph_read_expect "10" "$packdir" &&
 	test_cmp expect output'
 
+graph_git_behavior 'merge 1 vs 2' merge/1 merge/2
+graph_git_behavior 'merge 1 vs 3' merge/1 merge/3
+graph_git_behavior 'merge 2 vs 3' merge/2 merge/3
+
 test_expect_success 'Add one more commit' '
 	test_commit 8 &&
 	git branch commits/8 &&
@@ -103,6 +129,9 @@ test_expect_success 'Add one more commit' '
 # |___/____/
 # 1
 
+graph_git_behavior 'mixed mode, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'mixed mode, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'write graph with new commit' '
 	graph3=$(git commit-graph write --update-head --delete-expired) &&
 	test_path_is_file $packdir/graph-$graph3.graph &&
@@ -115,6 +144,9 @@ test_expect_success 'write graph with new commit' '
 	graph_read_expect "11" "$packdir" &&
 	test_cmp expect output'
 
+graph_git_behavior 'full graph, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'full graph, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'write graph with nothing new' '
 	graph4=$(git commit-graph write --update-head --delete-expired) &&
 	test_path_is_file $packdir/graph-$graph4.graph &&
@@ -134,12 +166,19 @@ test_expect_success 'clear graph' '
 	test_path_is_missing $packdir/graph-$graph4.graph &&
 	test_path_is_missing $packdir/graph-head'
 
+graph_git_behavior 'cleared graph, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'cleared graph, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd .. &&
 	git clone --bare --no-local full bare &&
 	cd bare &&
+	git config core.commitGraph true &&
 	baredir="./objects/pack"'
 
+graph_git_behavior 'bare repo, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'bare repo, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'write graph in bare repo' '
 	graphbare=$(git commit-graph write --update-head) &&
 	test_path_is_file $baredir/graph-$graphbare.graph &&
@@ -150,5 +189,8 @@ test_expect_success 'write graph in bare repo' '
 	graph_read_expect "11" "$baredir" &&
 	test_cmp expect output'
 
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' commits/8 merge/2
+
 test_done
 
-- 
2.15.1.45.g9b7079f

