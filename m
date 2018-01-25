Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71811F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeAYODg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:03:36 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41385 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeAYOCz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:55 -0500
Received: by mail-qt0-f193.google.com with SMTP id i1so19371803qtj.8
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Qutp1uvGr7CuA4IUhhBFiaf9CfpbtdQDtFh3XbmxlA=;
        b=Qgksoiz2sTcEi0IYUs4k39pIoL4Ogs3gWiaUYt9QGP4D7y+DmZPbxa7BdXEg3JdKpy
         wptm0hH7PEkKoe2h8G3nxOWavi7n7LicJPSINII+ETD6HKcHLBvzzV4RRUUvlahXqHKQ
         Ai8Lyf74s5WU9iG6p6oOzc/6Yz9cqPGGEJwTt3FvTqJJiMJpZM+AXGVHvuTL+bkkzC3I
         E+7peIp8tQdmmKPukUMOiVAjQ2g4PUcBRmiAdJq0ED0mO5Wc8dm9EpAoBLWql+zgAPRi
         dXiBrsryRelGkfk/BNuTx26Gi3qyCWmxKOtDui3DfooSq/Wvy9CJZBn4RdRe3pDb++b5
         rmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Qutp1uvGr7CuA4IUhhBFiaf9CfpbtdQDtFh3XbmxlA=;
        b=bXSaeY3tEoPfZZtUoYj5J2ibDO79qKZNyWmPNBXUAJ82FUdtDggawd1DWM7OgvWvZl
         i6fZDu2+8cKDZvDZemLzo1wgdBICghlR53Wl/rIhg4LCGJMvCG3GbREmuLLOy2pwjx8l
         LBgPqQd/RJQLIL61Dz3M/bpwrg1BhjZ7Zzkqqn2qCubmh7Lt7CvE9y7XPTtg1ZK/7GHA
         Cn4O02qH4gmp9TUMdzK6Q53DzoRyVRn+EzpFK0QJYWnxQy5APqml2ruS6jdxM0wc42z1
         Pzm9/Cck0uT//7LfJonBve4gL9YL6aT/9i50MqmCx8JDrGRIRPv+AxYFPYPO7dYLylb9
         Xp1A==
X-Gm-Message-State: AKwxytcUR6J8aFwtpcORoKJrWQdw1INvog7aL+CS2TLmxtKm4aLMVrAs
        yQ0IGzDYgf9K9r8a4x3q2SY157l6
X-Google-Smtp-Source: AH8x2257tvyvXzc+lduD2Oe/DLxXEENQpdy2ee/oqVLdeKE6mmVNtwoFQrNy4LfZsYr7mW1+eFflQQ==
X-Received: by 10.55.155.132 with SMTP id d126mr13607970qke.220.1516888974402;
        Thu, 25 Jan 2018 06:02:54 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:53 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 11/14] commit: integrate packed graph with commit parsing
Date:   Thu, 25 Jan 2018 09:02:28 -0500
Message-Id: <20180125140231.65604-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to inspect a packed graph to supply the contents of a
struct commit when calling parse_commit_gently(). This implementation
satisfies all post-conditions on the struct commit, including loading
parents, the root tree, and the commit date. The only loosely-expected
condition is that the commit buffer is loaded into the cache. This
was checked in log-tree.c:show_log(), but the "return;" on failure
produced unexpected results (i.e. the message line was never terminated).
The new behavior of loading the buffer when needed prevents the
unexpected behavior.

If core.graph is false, then do not load the graph and behave as usual.

In test script t5319-graph.sh, add output-matching conditions on read-
only graph operations.

By loading commits from the graph instead of parsing commit buffers, we
save a lot of time on long commits walks. Here are some performance
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
 alloc.c          |   1 +
 commit.c         |  20 ++++-
 commit.h         |   2 +
 log-tree.c       |   3 +-
 packed-graph.c   | 242 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packed-graph.h   |  18 +++++
 t/t5319-graph.sh | 114 ++++++++++++++++++++++++--
 7 files changed, 387 insertions(+), 13 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadfacd..4a4dcfa2b7 100644
--- a/alloc.c
+++ b/alloc.c
@@ -93,6 +93,7 @@ void *alloc_commit_node(void)
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index();
+	c->graphId = 0xFFFFFFFF;
 	return c;
 }
 
diff --git a/commit.c b/commit.c
index cab8d4455b..253c102808 100644
--- a/commit.c
+++ b/commit.c
@@ -12,6 +12,7 @@
 #include "prio-queue.h"
 #include "sha1-lookup.h"
 #include "wt-status.h"
+#include "packed-graph.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -374,7 +375,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	return 0;
 }
 
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int check_packed)
 {
 	enum object_type type;
 	void *buffer;
@@ -383,19 +384,27 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 
 	if (!item)
 		return -1;
+
+	// If we already parsed, but got it from the graph, then keep going!
 	if (item->object.parsed)
 		return 0;
+
+	if (check_packed && parse_packed_commit(item))
+		return 0;
+
 	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
-			     oid_to_hex(&item->object.oid));
+			oid_to_hex(&item->object.oid));
 	if (type != OBJ_COMMIT) {
 		free(buffer);
 		return error("Object %s not a commit",
-			     oid_to_hex(&item->object.oid));
+			oid_to_hex(&item->object.oid));
 	}
+
 	ret = parse_commit_buffer(item, buffer, size);
+
 	if (save_commit_buffer && !ret) {
 		set_commit_buffer(item, buffer, size);
 		return 0;
@@ -404,6 +413,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
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
index 8c68ca1a5a..02f5f2a182 100644
--- a/commit.h
+++ b/commit.h
@@ -21,6 +21,7 @@ struct commit {
 	timestamp_t date;
 	struct commit_list *parents;
 	struct tree *tree;
+	uint32_t graphId;
 };
 
 extern int save_commit_buffer;
@@ -60,6 +61,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
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
diff --git a/packed-graph.c b/packed-graph.c
index 5723f163ae..343b231973 100644
--- a/packed-graph.c
+++ b/packed-graph.c
@@ -34,6 +34,8 @@
 #define GRAPH_CHUNKLOOKUP_SIZE (5 * 12)
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + sizeof(struct packed_graph_header))
+/* global storage */
+struct packed_graph *packed_graph = 0;
 
 struct object_id *get_graph_head_oid(const char *pack_dir, struct object_id *oid)
 {
@@ -209,6 +211,225 @@ struct packed_graph *load_packed_graph_one(const char *graph_file, const char *p
 	return graph;
 }
 
+static void prepare_packed_graph_one(const char *obj_dir)
+{
+	char *graph_file;
+	struct object_id oid;
+	struct strbuf pack_dir = STRBUF_INIT;
+	strbuf_addstr(&pack_dir, obj_dir);
+	strbuf_add(&pack_dir, "/pack", 5);
+
+	if (!get_graph_head_oid(pack_dir.buf, &oid))
+		return;
+
+	graph_file = get_graph_filename_oid(pack_dir.buf, &oid);
+
+	packed_graph = load_packed_graph_one(graph_file, pack_dir.buf);
+	strbuf_release(&pack_dir);
+}
+
+static int prepare_packed_graph_run_once = 0;
+void prepare_packed_graph(void)
+{
+	struct alternate_object_database *alt;
+	char *obj_dir;
+
+	if (prepare_packed_graph_run_once)
+		return;
+	prepare_packed_graph_run_once = 1;
+
+	obj_dir = get_object_directory();
+	prepare_packed_graph_one(obj_dir);
+	prepare_alt_odb();
+	for (alt = alt_odb_list; !packed_graph && alt; alt = alt->next)
+		prepare_packed_graph_one(alt->path);
+}
+
+static int bsearch_graph(struct packed_graph *g, struct object_id *oid, uint32_t *pos)
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
+struct object_id *get_nth_commit_oid(struct packed_graph *g,
+					    uint32_t n,
+					    struct object_id *oid)
+{
+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hdr->hash_len * n);
+	return oid;
+}
+
+static int full_parse_commit(struct commit *item, struct packed_graph *g,
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
+	item->graphId = pos;
+
+	hashcpy(oid.hash, commit_data);
+	item->tree = lookup_tree(&oid);
+
+	date_high = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 8));
+	date_low = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 12));
+	item->date = (timestamp_t)((date_high << 32) | date_low);
+
+	pptr = &item->parents;
+
+	// First Parent
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len));
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return 1;
+	get_nth_commit_oid(g, new_parent_pos, &oid);
+	new_parent = lookup_commit(&oid);
+	if (new_parent) {
+		new_parent->graphId = new_parent_pos;
+		pptr = &commit_list_insert(new_parent, pptr)->next;
+	} else {
+		die("could not find commit %s", oid_to_hex(&oid));
+	}
+
+	// Second Parent
+	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 4));
+	if (new_parent_pos == GRAPH_PARENT_NONE)
+		return 1;
+	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED)) {
+		get_nth_commit_oid(g, new_parent_pos, &oid);
+		new_parent = lookup_commit(&oid);
+		if (new_parent) {
+			new_parent->graphId = new_parent_pos;
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
+			new_parent->graphId = new_parent_pos & GRAPH_EDGE_LAST_MASK;
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
+static int fill_packed_commit(struct commit *item, struct packed_graph *g, uint32_t pos)
+{
+	uint32_t new_parent_pos;
+	uint32_t *parent_data_ptr;
+	const unsigned char *commit_data = g->chunk_commit_data + (g->hdr->hash_len + 16) * pos;
+
+	// Determine if we have ALL of our edges, otherwise we will return as unparsed.
+
+	// Check constant-width parents first.
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
+ * Returns 1 iff the commit was found in the packed graph.
+ *
+ * See parse_commit_buffer() for the fallback after this call.
+ */
+int parse_packed_commit(struct commit *item)
+{
+	if (!core_graph)
+		return 0;
+	if (item->object.parsed)
+		return 1;
+
+	prepare_packed_graph();
+	if (packed_graph) {
+		uint32_t pos;
+		int found;
+		if (item->graphId != 0xFFFFFFFF) {
+			pos = item->graphId;
+			found = 1;
+		} else {
+			found = bsearch_graph(packed_graph, &(item->object.oid), &pos);
+		}
+
+		if (found)
+			return fill_packed_commit(item, packed_graph, pos);
+	}
+
+	return parse_commit_internal(item, 0, 0);
+}
+
 static void write_graph_chunk_fanout(
 	struct sha1file *f,
 	struct commit **commits, int nr_commits)
@@ -439,9 +660,24 @@ struct object_id *construct_graph(const char *pack_dir)
 	if (!core_graph)
 		return 0;
 
+	prepare_packed_graph();
+
 	oids.num = 0;
 	oids.size = 1024;
+
+	if (packed_graph && oids.size < packed_graph->num_commits)
+		oids.size = packed_graph->num_commits;
+
 	ALLOC_ARRAY(oids.list, oids.size);
+
+	if (packed_graph) {
+		for (i = 0; i < packed_graph->num_commits; i++) {
+			oids.list[i] = malloc(sizeof(struct object_id));
+			get_nth_commit_oid(packed_graph, i, oids.list[i]);
+		}
+		oids.num = packed_graph->num_commits;
+	}
+
 	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 	QSORT(oids.list, oids.num, commit_compare);
 
@@ -530,6 +766,11 @@ struct object_id *construct_graph(const char *pack_dir)
 	hashcpy(f_oid->hash, final_hash);
 	fname = get_graph_filename_oid(pack_dir, f_oid);
 
+	if (packed_graph) {
+		close_graph(packed_graph);
+		FREE_AND_NULL(packed_graph);
+	}
+
 	if (rename(graph_name, fname))
 		die("failed to rename %s to %s", graph_name, fname);
 
@@ -539,3 +780,4 @@ struct object_id *construct_graph(const char *pack_dir)
 
 	return f_oid;
 }
+
diff --git a/packed-graph.h b/packed-graph.h
index ad561863c8..6010ce3e53 100644
--- a/packed-graph.h
+++ b/packed-graph.h
@@ -4,6 +4,18 @@
 #include "git-compat-util.h"
 #include "commit.h"
 
+/**
+ * Given a commit struct, try to fill the commit struct info, including:
+ *  1. tree object
+ *  2. date
+ *  3. parents.
+ *
+ * Returns 1 iff the commit was found in the packed graph.
+ *
+ * See parse_commit_buffer() for the fallback after this call.
+ */
+extern int parse_packed_commit(struct commit *item);
+
 extern struct object_id *get_graph_head_oid(const char *pack_dir, struct object_id *oid);
 extern char* get_graph_filename_oid(const char *pack_dir,
 				    struct object_id *oid);
@@ -40,7 +52,13 @@ extern struct packed_graph {
 extern int close_graph(struct packed_graph *g);
 
 extern struct packed_graph *load_packed_graph_one(const char *graph_file, const char *pack_dir);
+extern void prepare_packed_graph(void);
+
+extern struct object_id *get_nth_commit_oid(struct packed_graph *g,
+					    uint32_t n,
+					    struct object_id *oid);
 
 extern struct object_id *construct_graph(const char *pack_dir);
+extern int close_graph(struct packed_graph *g);
 
 #endif
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index a70c7bbb02..4552795179 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -26,6 +26,23 @@ test_expect_success 'create commits and repack' \
      done &&
      git repack'
 
+_graph_git_two_modes() {
+    git -c core.graph=true $1 >output
+    git -c core.graph=false $1 >expect
+    cmp output expect
+}
+
+_graph_git_behavior() {
+    test_expect_success 'check normal git operations' \
+        '_graph_git_two_modes "log --oneline master" &&
+         _graph_git_two_modes "log --topo-order master" &&
+         _graph_git_two_modes "log --graph $1 $2" &&
+         _graph_git_two_modes "branch -vv" &&
+         _graph_git_two_modes "merge-base -a $1 $2"'
+}
+
+_graph_git_behavior commits/3 commits/4
+
 _graph_read_expect() {
     cat >expect <<- EOF
 header: 43475048 01 01 14 04
@@ -43,6 +60,8 @@ test_expect_success 'write graph' \
      _graph_read_expect "5" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior commits/3 commits/4
+
 test_expect_success 'Add more commits' \
     'git reset --hard commits/3 &&
      for i in $(test_seq 6 10)
@@ -52,7 +71,7 @@ test_expect_success 'Add more commits' \
         git commit -m "commit $i" &&
         git branch commits/$i
      done &&
-     git reset --hard commits/7 &&
+     git reset --hard commits/3 &&
      for i in $(test_seq 11 15)
      do
         echo $i >$i.txt &&
@@ -61,15 +80,40 @@ test_expect_success 'Add more commits' \
         git branch commits/$i
      done &&
      git reset --hard commits/7 &&
-     git merge commits/4 &&
+     git merge commits/11 &&
      git branch merge/1 &&
      git reset --hard commits/8 &&
-     git merge commits/11 &&
+     git merge commits/12 &&
      git branch merge/2 &&
-     git reset --hard commits/9 &&
-     git merge commits/5 commits/13 &&
+     git reset --hard commits/5 &&
+     git merge commits/10 commits/15 &&
+     git branch merge/3 &&
      git repack'
 
+# Current graph structure:
+#
+#      M3
+#     / |\_____
+#    / 10      15
+#   /   |      |
+#  /    9 M2   14
+# |     |/  \ \|
+# |     8 M1 | 13
+# |     |/ | \_|
+# 5     7  |   12
+# |     |   \__|
+# 4     6      11
+# |____/______/
+# 3
+# |
+# 2
+# |
+# 1
+
+_graph_git_behavior merge/1 merge/2
+_graph_git_behavior merge/1 merge/3
+_graph_git_behavior merge/2 merge/3
+
 test_expect_success 'write graph with merges' \
     'graph2=$(git graph --write --update-head) &&
      test_path_is_file ${packdir}/graph-${graph2}.graph &&
@@ -80,15 +124,54 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior merge/1 merge/2
+_graph_git_behavior merge/1 merge/3
+_graph_git_behavior merge/2 merge/3
+
 test_expect_success 'Add more commits' \
-    'git reset --hard commits/3 &&
-     for i in $(test_seq 16 20)
+    'for i in $(test_seq 16 20)
      do
-        git commit --allow-empty -m "commit $i" &&
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
         git branch commits/$i
      done &&
      git repack'
 
+# Current graph structure:
+#
+#      20
+#       |
+#      19
+#       |
+#      18
+#       |
+#      17
+#       |
+#      16
+#       |
+#      M3
+#     / |\_____
+#    / 10      15
+#   /   |      |
+#  /    9 M2   14
+# |     |/  \ \|
+# |     8 M1 | 13
+# |     |/ | \_|
+# 5     7  |   12
+# |     |   \__|
+# 4     6      11
+# |____/______/
+# 3
+# |
+# 2
+# |
+# 1
+
+# Test behavior while in mixed mode
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'write graph with merges' \
     'graph3=$(git graph --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/graph-${graph3}.graph &&
@@ -101,6 +184,9 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "23" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'write graph with nothing new' \
     'graph4=$(git graph --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/graph-${graph4}.graph &&
@@ -112,12 +198,18 @@ test_expect_success 'write graph with nothing new' \
      _graph_read_expect "23" "${packdir}" &&
      cmp expect output'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'clear graph' \
     'git graph --clear &&
      test_path_is_missing ${packdir}/graph-${graph3}.graph &&
      test_path_is_file ${packdir}/graph-${graph1}.graph &&
      test_path_is_missing ${packdir}/graph-head'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'setup bare repo' \
     'cd .. &&
      git clone --bare full bare &&
@@ -126,6 +218,9 @@ test_expect_success 'setup bare repo' \
      git config pack.threads 1 &&
      baredir="./objects/pack"'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'write graph in bare repo' \
     'graphbare=$(git graph --write --update-head) &&
      test_path_is_file ${baredir}/graph-${graphbare}.graph &&
@@ -136,4 +231,7 @@ test_expect_success 'write graph in bare repo' \
      _graph_read_expect "23" "${baredir}" &&
      cmp expect output'
 
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_done
-- 
2.16.0

