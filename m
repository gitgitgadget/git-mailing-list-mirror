Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A031F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeA3VkZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:25 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34771 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbeA3VkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:23 -0500
Received: by mail-qk0-f196.google.com with SMTP id b76so12125297qkc.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jpLo4GDHVE3rEek7C5zxkUdJwJTmlPMf/xEcDuHFV+0=;
        b=b+p/XtDr5kiboiFjQrny+CuOLUK+WnzJ8hYcZUXBCCYUuzxo+usRqm6sKaEV3GM5no
         biA4NPK5DKbetSoB2cybeLBWxgfCr3CehV4HHJQkSNBX0Mk+AKvj4RLX5eMwRjDMN0CH
         ST9Tt8i8Z7cw9QhtDT52dY0bSUYTpKjh/zKAMIAVhJh9T61gFaxE1c1nzDSyTHUMPjAD
         iy0PRAshXx9HQX//hj0v1RPbpFtyGQYHC9Xv1gU1kFUAY6lZE3C/Wljk4vA3gz/gMQrD
         YrimMoyA8TDd2ZF+EbgunzA0reLBuCGrnHi/yoJc709aH3FdGlvKB8OgeViPA0HdoDtz
         03Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jpLo4GDHVE3rEek7C5zxkUdJwJTmlPMf/xEcDuHFV+0=;
        b=aTiyB0zRPiMAgQI3hSdQYiTQ+eO1SqZZtFOQwojRt0KqULifPWPNvh5wesWUG/MSvp
         Gv8HEDarxFtZpdpQDkPkbF/cd+QqV8mNxlAwbEKvCBJlZpM7p+bYu99hb+rFD4j2dK5P
         b5c9tIZa7hPQJH6r5UZeXVyu9N1lGYnEBusbb8BTFlYdWXy4vMWiJdNCnoX7oJ8D3MDP
         teZonuX1qNv5tVSTqiTqAB37jC3QHPfLyrjQUq1XoC3A/L19xJcWONzZftq5i6VlxSLw
         JbcRcAsS8D7w+7/hGZZZy9rQOy9EQzbf4kb1KQmnrDnivmo0cfIWJGxSvqbtkvwpUSst
         wdgQ==
X-Gm-Message-State: AKwxytcP9CDAVG8soUN1PBivHkDlsW2WNBACXokkmP3NHH6dfudLayQr
        drNg8ZTHgbEmEhzRoD1fvwsGONwh
X-Google-Smtp-Source: AH8x227fotUD62j+fPOQuipF18yMZ5a+IoBYX3O0eD85mZowF1lFa64n2qaCvrLIfC8XimHz3n32cA==
X-Received: by 10.55.160.14 with SMTP id j14mr41480291qke.305.1517348422013;
        Tue, 30 Jan 2018 13:40:22 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:21 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 11/14] commit: integrate commit graph with commit parsing
Date:   Tue, 30 Jan 2018 16:39:40 -0500
Message-Id: <1517348383-112294-12-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
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

If core.commitgraph is false, then do not check graph files.

In test script t5319-commit-graph.sh, add output-matching conditions on
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
 commit-graph.c          | 237 ++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h          |  20 +++-
 commit.c                |  10 +-
 commit.h                |   4 +
 log-tree.c              |   3 +-
 t/t5318-commit-graph.sh |  47 ++++++++++
 7 files changed, 318 insertions(+), 4 deletions(-)

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
index 764e016ddb..fc816533c6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -35,6 +35,9 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + sizeof(struct commit_graph_header))
 
+/* global storage */
+struct commit_graph *commit_graph = 0;
+
 struct object_id *get_graph_head_hash(const char *pack_dir, struct object_id *hash)
 {
 	struct strbuf head_filename = STRBUF_INIT;
@@ -209,6 +212,220 @@ struct commit_graph *load_commit_graph_one(const char *graph_file, const char *p
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
+	uint32_t last, first = 0;
+
+	if (oid->hash[0])
+		first = ntohl(*(uint32_t*)(g->chunk_oid_fanout + 4 * (oid->hash[0] - 1)));
+	last = ntohl(*(uint32_t*)(g->chunk_oid_fanout + 4 * oid->hash[0]));
+
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		const unsigned char *current;
+		int cmp;
+
+		current = g->chunk_oid_lookup + g->hdr->hash_len * mid;
+		cmp = hashcmp(oid->hash, current);
+		if (!cmp) {
+			*pos = mid;
+			return 1;
+		}
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	*pos = first;
+	return 0;
+}
+
+struct object_id *get_nth_commit_oid(struct commit_graph *g,
+				     uint32_t n,
+				     struct object_id *oid)
+{
+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hdr->hash_len * n);
+	return oid;
+}
+
+static int full_parse_commit(struct commit *item, struct commit_graph *g,
+			     uint32_t pos, const unsigned char *commit_data)
+{
+	struct object_id oid;
+	struct commit *new_parent;
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
+	date_high = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 8)) & 0x3;
+	date_low = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 12));
+	item->date = (timestamp_t)((date_high << 32) | date_low);
+
+	pptr = &item->parents;
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len));
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return 1;
+	get_nth_commit_oid(g, new_parent_pos, &oid);
+	new_parent = lookup_commit(&oid);
+	if (new_parent) {
+		new_parent->graph_pos = new_parent_pos;
+		pptr = &commit_list_insert(new_parent, pptr)->next;
+	} else {
+		die("could not find commit %s", oid_to_hex(&oid));
+	}
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 4));
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return 1;
+	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED)) {
+		get_nth_commit_oid(g, new_parent_pos, &oid);
+		new_parent = lookup_commit(&oid);
+		if (new_parent) {
+			new_parent->graph_pos = new_parent_pos;
+			pptr = &commit_list_insert(new_parent, pptr)->next;
+		} else
+			die("could not find commit %s", oid_to_hex(&oid));
+		return 1;
+	}
+
+	parent_data_ptr = (uint32_t*)(g->chunk_large_edges + 4 * (new_parent_pos ^ GRAPH_LARGE_EDGES_NEEDED));
+	do {
+		new_parent_pos = ntohl(*parent_data_ptr);
+
+		get_nth_commit_oid(g, new_parent_pos & GRAPH_EDGE_LAST_MASK, &oid);
+		new_parent = lookup_commit(&oid);
+		if (new_parent) {
+			new_parent->graph_pos = new_parent_pos & GRAPH_EDGE_LAST_MASK;
+			pptr = &commit_list_insert(new_parent, pptr)->next;
+		} else
+			die("could not find commit %s", oid_to_hex(&oid));
+		parent_data_ptr++;
+	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
+
+	return 1;
+}
+
+/**
+ * Fill 'item' to contain all information that would be parsed by parse_commit_buffer.
+ */
+static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
+{
+	uint32_t new_parent_pos;
+	uint32_t *parent_data_ptr;
+	const unsigned char *commit_data = g->chunk_commit_data + (g->hdr->hash_len + 16) * pos;
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len));
+
+	if (new_parent_pos == GRAPH_PARENT_MISSING)
+		return 0;
+
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return full_parse_commit(item, g, pos, commit_data);
+
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 4));
+
+	if (new_parent_pos == GRAPH_PARENT_MISSING)
+		return 0;
+	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED))
+		return full_parse_commit(item, g, pos, commit_data);
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
+	return full_parse_commit(item, g, pos, commit_data);
+}
+
+/**
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
+	if (!core_commitgraph)
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
@@ -439,9 +656,24 @@ struct object_id *construct_commit_graph(const char *pack_dir)
 	char *fname;
 	struct commit_list *parent;
 
+	prepare_commit_graph();
+
 	oids.num = 0;
 	oids.size = 1024;
+
+	if (commit_graph && oids.size < commit_graph->num_commits)
+		oids.size = commit_graph->num_commits;
+
 	ALLOC_ARRAY(oids.list, oids.size);
+
+	if (commit_graph) {
+		for (i = 0; i < commit_graph->num_commits; i++) {
+			oids.list[i] = malloc(sizeof(struct object_id));
+			get_nth_commit_oid(commit_graph, i, oids.list[i]);
+		}
+		oids.num = commit_graph->num_commits;
+	}
+
 	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 	QSORT(oids.list, oids.num, commit_compare);
 
@@ -525,6 +757,11 @@ struct object_id *construct_commit_graph(const char *pack_dir)
 	hashcpy(f_hash->hash, final_hash);
 	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
 
+	if (commit_graph) {
+		close_commit_graph(commit_graph);
+		FREE_AND_NULL(commit_graph);
+	}
+
 	if (rename(graph_name, fname))
 		die("failed to rename %s to %s", graph_name, fname);
 
diff --git a/commit-graph.h b/commit-graph.h
index 43eb0aec84..05ddbbe165 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,18 @@
 #include "git-compat-util.h"
 #include "commit.h"
 
+/**
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
 extern struct object_id *get_graph_head_hash(const char *pack_dir,
 					     struct object_id *hash);
 extern char* get_commit_graph_filename_hash(const char *pack_dir,
@@ -40,7 +52,13 @@ extern struct commit_graph {
 
 extern int close_commit_graph(struct commit_graph *g);
 
-extern struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir);
+extern struct commit_graph *load_commit_graph_one(const char *graph_file,
+						  const char *pack_dir);
+extern void prepare_commit_graph(void);
+
+extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
+					    uint32_t n,
+					    struct object_id *oid);
 
 extern struct object_id *construct_commit_graph(const char *pack_dir);
 
diff --git a/commit.c b/commit.c
index cab8d4455b..4437798e84 100644
--- a/commit.c
+++ b/commit.c
@@ -12,6 +12,7 @@
 #include "prio-queue.h"
 #include "sha1-lookup.h"
 #include "wt-status.h"
+#include "commit-graph.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -374,7 +375,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	return 0;
 }
 
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int check_packed)
 {
 	enum object_type type;
 	void *buffer;
@@ -385,6 +386,8 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
+	if (check_packed && parse_commit_in_graph(item))
+		return 0;
 	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
@@ -404,6 +407,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 	return ret;
 }
 
+int parse_commit_gently(struct commit *item, int quiet_on_missing)
+{
+	return parse_commit_internal(item, quiet_on_missing, 1);
+}
+
 void parse_commit_or_die(struct commit *item)
 {
 	if (parse_commit(item))
diff --git a/commit.h b/commit.h
index 8c68ca1a5a..fc8880d187 100644
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
@@ -60,6 +63,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
+extern int parse_commit_internal(struct commit *item, int quiet_on_missing, int check_packed);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
diff --git a/log-tree.c b/log-tree.c
index fca29d4799..156aed4541 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -659,8 +659,7 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!get_cached_commit_buffer(commit, NULL))
-		return;
+	get_commit_buffer(commit, NULL);
 
 	if (opt->show_notes) {
 		int raw;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b56a6d4217..93b0d4f51b 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -26,6 +26,24 @@ test_expect_success 'create commits and repack' \
      done &&
      git repack'
 
+_graph_git_two_modes() {
+    git -c core.commitgraph=true $1 >output
+    git -c core.commitgraph=false $1 >expect
+    cmp output expect
+}
+
+_graph_git_behavior() {
+    BRANCH=$1
+    COMPARE=$2
+    test_expect_success 'check normal git operations' \
+        '_graph_git_two_modes "log --oneline ${BRANCH}" &&
+         _graph_git_two_modes "log --topo-order ${BRANCH}" &&
+         _graph_git_two_modes "branch -vv" &&
+         _graph_git_two_modes "merge-base -a ${BRANCH} ${COMPARE}"'
+}
+
+_graph_git_behavior "commits/3" "commits/4"
+
 _graph_read_expect() {
     cat >expect <<- EOF
 header: 43475048 01 01 14 04
@@ -43,6 +61,8 @@ test_expect_success 'write graph' \
      _graph_read_expect "5" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior "commits/3" "commits/4"
+
 test_expect_success 'Add more commits' \
     'git reset --hard commits/3 &&
      for i in $(test_seq 6 10)
@@ -91,6 +111,10 @@ test_expect_success 'Add more commits' \
 # |
 # 1
 
+_graph_git_behavior "merge/1" "merge/2"
+_graph_git_behavior "merge/1" "merge/3"
+_graph_git_behavior "merge/2" "merge/3"
+
 test_expect_success 'write graph with merges' \
     'graph2=$(git commit-graph --write --update-head) &&
      test_path_is_file ${packdir}/graph-${graph2}.graph &&
@@ -101,6 +125,10 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior merge/1 merge/2
+_graph_git_behavior merge/1 merge/3
+_graph_git_behavior merge/2 merge/3
+
 test_expect_success 'Add more commits' \
     'for i in $(test_seq 16 20)
      do
@@ -141,6 +169,10 @@ test_expect_success 'Add more commits' \
 # |
 # 1
 
+# Test behavior while in mixed mode
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'write graph with merges' \
     'graph3=$(git commit-graph --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/graph-${graph3}.graph &&
@@ -153,6 +185,9 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "23" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'write graph with nothing new' \
     'graph4=$(git commit-graph --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/graph-${graph4}.graph &&
@@ -164,12 +199,18 @@ test_expect_success 'write graph with nothing new' \
      _graph_read_expect "23" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'clear graph' \
     'git commit-graph --clear &&
      test_path_is_missing ${packdir}/graph-${graph2}.graph &&
      test_path_is_file ${packdir}/graph-${graph1}.graph &&
      test_path_is_missing ${packdir}/graph-head'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'setup bare repo' \
     'cd .. &&
      git clone --bare full bare &&
@@ -178,6 +219,9 @@ test_expect_success 'setup bare repo' \
      git config pack.threads 1 &&
      baredir="./objects/pack"'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'write graph in bare repo' \
     'graphbare=$(git commit-graph --write --update-head) &&
      test_path_is_file ${baredir}/graph-${graphbare}.graph &&
@@ -188,4 +232,7 @@ test_expect_success 'write graph in bare repo' \
      _graph_read_expect "23" "${baredir}" &&
      cmp expect output'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_done
-- 
2.16.0.15.g9c3cf44.dirty

