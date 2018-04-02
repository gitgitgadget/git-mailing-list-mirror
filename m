Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4FC1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbeDBUfF (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34852 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932424AbeDBUfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:02 -0400
Received: by mail-qt0-f195.google.com with SMTP id s2so16936068qti.2
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MxAVnmeCITQM5EGE+dNz8IU9ONLUO2kOZUK5vuhseKw=;
        b=OG5MKyd/VwyxCsEGJYRyAOxa+cqrYs/+Mbg5BOqH2Nrt7O5VlgrogxVeDZxhZBD9u1
         E+ork5N4st8Gj+c3hdqDzbcQwbPU+antdgnHajjAEHigo2c3SuS0W9xFpGyXpSSmxg28
         tkKVn1YFggua7ZiaOcuE291snKuMmNmCUktR9jsbKsqemoZxgL5+crkwnqZsojslGrJM
         5zOz214Nkby92tLNKLrujTamZU4XioCRuWz7SWvsseOijvHLrj08vAiUN+MgOXwyrNEO
         4kgCydTR6hHEWiORKXjP/nf1QSjQdVRJ2bMMyNSZ/nq4CxeC4R6Di8BOMMEl0Xwd3E+I
         wRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MxAVnmeCITQM5EGE+dNz8IU9ONLUO2kOZUK5vuhseKw=;
        b=FDBTYCfjKaBnqG68Yy73BZHFhtlDjVoggaXEYUzIvEQmBWeTDaee8l/lhJmhKpG94Q
         xe/6FnEfJsb2VxKEbsqWoWB6zJFwXroTdBFam3cFkVd2L11hh5cXyn5KOxkHBNNJTHrV
         OrC9RZr+sTTiBD4E06gPgf8FbcGUjXQyzRZHWw2Y3BntzZAXlu8uMw7jR7y+mlwJPdin
         VWg0f1cdvXtFRGVDWWsKcN6pS+V/K54/q3JgVee/9rTAKc8z/2vIzXeasReV7AQBfs7D
         Q5ee/yVeDlmzf+7uZ4i3ohIfuj7FeGXOHMccrvZ7sM9GwjkLCfmhgI4ZzY1IyPvPyghG
         Yspg==
X-Gm-Message-State: ALQs6tBlIQMLH6bEPi2rNZKRJo5DJzgXj1N0Fc9lxWv/pRLD7aEdOzci
        qVtvZrxO5jjpxx1F+ZZRDIaULI0PGq4=
X-Google-Smtp-Source: AIpwx49VyGhiHmg3FXtnmZS6KgN190nJl+Z0SppMZF8D+dVBfw8D5CNO+s3uELajT0y5rDzIzZo1bw==
X-Received: by 10.200.45.250 with SMTP id q55mr16164441qta.215.1522701301131;
        Mon, 02 Apr 2018 13:35:01 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:35:00 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 06/14] commit-graph: implement write_commit_graph()
Date:   Mon,  2 Apr 2018 16:34:19 -0400
Message-Id: <20180402203427.170177-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach Git to write a commit graph file by checking all packed objects
to see if they are commits, then store the file in the given object
directory.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |   1 +
 commit-graph.c | 359 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h |   6 +
 3 files changed, 366 insertions(+)
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h

diff --git a/Makefile b/Makefile
index a59b62bed1..26a23257e9 100644
--- a/Makefile
+++ b/Makefile
@@ -777,6 +777,7 @@ LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
+LIB_OBJS += commit-graph.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
diff --git a/commit-graph.c b/commit-graph.c
new file mode 100644
index 0000000000..f3f7c4f189
--- /dev/null
+++ b/commit-graph.c
@@ -0,0 +1,359 @@
+#include "cache.h"
+#include "config.h"
+#include "git-compat-util.h"
+#include "lockfile.h"
+#include "pack.h"
+#include "packfile.h"
+#include "commit.h"
+#include "object.h"
+#include "revision.h"
+#include "sha1-lookup.h"
+#include "commit-graph.h"
+
+#define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
+#define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
+#define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
+#define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
+#define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */
+
+#define GRAPH_DATA_WIDTH 36
+
+#define GRAPH_VERSION_1 0x1
+#define GRAPH_VERSION GRAPH_VERSION_1
+
+#define GRAPH_OID_VERSION_SHA1 1
+#define GRAPH_OID_LEN_SHA1 GIT_SHA1_RAWSZ
+#define GRAPH_OID_VERSION GRAPH_OID_VERSION_SHA1
+#define GRAPH_OID_LEN GRAPH_OID_LEN_SHA1
+
+#define GRAPH_OCTOPUS_EDGES_NEEDED 0x80000000
+#define GRAPH_PARENT_MISSING 0x7fffffff
+#define GRAPH_EDGE_LAST_MASK 0x7fffffff
+#define GRAPH_PARENT_NONE 0x70000000
+
+#define GRAPH_LAST_EDGE 0x80000000
+
+#define GRAPH_FANOUT_SIZE (4 * 256)
+#define GRAPH_CHUNKLOOKUP_WIDTH 12
+#define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + \
+			GRAPH_OID_LEN + 8)
+
+
+static char *get_commit_graph_filename(const char *obj_dir)
+{
+	return xstrfmt("%s/info/commit-graph", obj_dir);
+}
+
+static void write_graph_chunk_fanout(struct hashfile *f,
+				     struct commit **commits,
+				     int nr_commits)
+{
+	int i, count = 0;
+	struct commit **list = commits;
+
+	/*
+	 * Write the first-level table (the list is sorted,
+	 * but we use a 256-entry lookup to be able to avoid
+	 * having to do eight extra binary search iterations).
+	 */
+	for (i = 0; i < 256; i++) {
+		while (count < nr_commits) {
+			if ((*list)->object.oid.hash[0] != i)
+				break;
+			count++;
+			list++;
+		}
+
+		hashwrite_be32(f, count);
+	}
+}
+
+static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
+				   struct commit **commits, int nr_commits)
+{
+	struct commit **list = commits;
+	int count;
+	for (count = 0; count < nr_commits; count++, list++)
+		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
+}
+
+static const unsigned char *commit_to_sha1(size_t index, void *table)
+{
+	struct commit **commits = table;
+	return commits[index]->object.oid.hash;
+}
+
+static void write_graph_chunk_data(struct hashfile *f, int hash_len,
+				   struct commit **commits, int nr_commits)
+{
+	struct commit **list = commits;
+	struct commit **last = commits + nr_commits;
+	uint32_t num_extra_edges = 0;
+
+	while (list < last) {
+		struct commit_list *parent;
+		int edge_value;
+		uint32_t packedDate[2];
+
+		parse_commit(*list);
+		hashwrite(f, (*list)->tree->object.oid.hash, hash_len);
+
+		parent = (*list)->parents;
+
+		if (!parent)
+			edge_value = GRAPH_PARENT_NONE;
+		else {
+			edge_value = sha1_pos(parent->item->object.oid.hash,
+					      commits,
+					      nr_commits,
+					      commit_to_sha1);
+
+			if (edge_value < 0)
+				edge_value = GRAPH_PARENT_MISSING;
+		}
+
+		hashwrite_be32(f, edge_value);
+
+		if (parent)
+			parent = parent->next;
+
+		if (!parent)
+			edge_value = GRAPH_PARENT_NONE;
+		else if (parent->next)
+			edge_value = GRAPH_OCTOPUS_EDGES_NEEDED | num_extra_edges;
+		else {
+			edge_value = sha1_pos(parent->item->object.oid.hash,
+					      commits,
+					      nr_commits,
+					      commit_to_sha1);
+			if (edge_value < 0)
+				edge_value = GRAPH_PARENT_MISSING;
+		}
+
+		hashwrite_be32(f, edge_value);
+
+		if (edge_value & GRAPH_OCTOPUS_EDGES_NEEDED) {
+			do {
+				num_extra_edges++;
+				parent = parent->next;
+			} while (parent);
+		}
+
+		if (sizeof((*list)->date) > 4)
+			packedDate[0] = htonl(((*list)->date >> 32) & 0x3);
+		else
+			packedDate[0] = 0;
+
+		packedDate[1] = htonl((*list)->date);
+		hashwrite(f, packedDate, 8);
+
+		list++;
+	}
+}
+
+static void write_graph_chunk_large_edges(struct hashfile *f,
+					  struct commit **commits,
+					  int nr_commits)
+{
+	struct commit **list = commits;
+	struct commit **last = commits + nr_commits;
+	struct commit_list *parent;
+
+	while (list < last) {
+		int num_parents = 0;
+		for (parent = (*list)->parents; num_parents < 3 && parent;
+		     parent = parent->next)
+			num_parents++;
+
+		if (num_parents <= 2) {
+			list++;
+			continue;
+		}
+
+		/* Since num_parents > 2, this initializer is safe. */
+		for (parent = (*list)->parents->next; parent; parent = parent->next) {
+			int edge_value = sha1_pos(parent->item->object.oid.hash,
+						  commits,
+						  nr_commits,
+						  commit_to_sha1);
+
+			if (edge_value < 0)
+				edge_value = GRAPH_PARENT_MISSING;
+			else if (!parent->next)
+				edge_value |= GRAPH_LAST_EDGE;
+
+			hashwrite_be32(f, edge_value);
+		}
+
+		list++;
+	}
+}
+
+static int commit_compare(const void *_a, const void *_b)
+{
+	const struct object_id *a = (const struct object_id *)_a;
+	const struct object_id *b = (const struct object_id *)_b;
+	return oidcmp(a, b);
+}
+
+struct packed_commit_list {
+	struct commit **list;
+	int nr;
+	int alloc;
+};
+
+struct packed_oid_list {
+	struct object_id *list;
+	int nr;
+	int alloc;
+};
+
+static int add_packed_commits(const struct object_id *oid,
+			      struct packed_git *pack,
+			      uint32_t pos,
+			      void *data)
+{
+	struct packed_oid_list *list = (struct packed_oid_list*)data;
+	enum object_type type;
+	off_t offset = nth_packed_object_offset(pack, pos);
+	struct object_info oi = OBJECT_INFO_INIT;
+
+	oi.typep = &type;
+	if (packed_object_info(pack, offset, &oi) < 0)
+		die("unable to get type of object %s", oid_to_hex(oid));
+
+	if (type != OBJ_COMMIT)
+		return 0;
+
+	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
+	oidcpy(&(list->list[list->nr]), oid);
+	list->nr++;
+
+	return 0;
+}
+
+void write_commit_graph(const char *obj_dir)
+{
+	struct packed_oid_list oids;
+	struct packed_commit_list commits;
+	struct hashfile *f;
+	uint32_t i, count_distinct = 0;
+	char *graph_name;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
+	uint32_t chunk_ids[5];
+	uint64_t chunk_offsets[5];
+	int num_chunks;
+	int num_extra_edges;
+	struct commit_list *parent;
+
+	oids.nr = 0;
+	oids.alloc = approximate_object_count() / 4;
+
+	if (oids.alloc < 1024)
+		oids.alloc = 1024;
+	ALLOC_ARRAY(oids.list, oids.alloc);
+
+	for_each_packed_object(add_packed_commits, &oids, 0);
+
+	QSORT(oids.list, oids.nr, commit_compare);
+
+	count_distinct = 1;
+	for (i = 1; i < oids.nr; i++) {
+		if (oidcmp(&oids.list[i-1], &oids.list[i]))
+			count_distinct++;
+	}
+
+	if (count_distinct >= GRAPH_PARENT_MISSING)
+		die(_("the commit graph format cannot write %d commits"), count_distinct);
+
+	commits.nr = 0;
+	commits.alloc = count_distinct;
+	ALLOC_ARRAY(commits.list, commits.alloc);
+
+	num_extra_edges = 0;
+	for (i = 0; i < oids.nr; i++) {
+		int num_parents = 0;
+		if (i > 0 && !oidcmp(&oids.list[i-1], &oids.list[i]))
+			continue;
+
+		commits.list[commits.nr] = lookup_commit(&oids.list[i]);
+		parse_commit(commits.list[commits.nr]);
+
+		for (parent = commits.list[commits.nr]->parents;
+		     parent; parent = parent->next)
+			num_parents++;
+
+		if (num_parents > 2)
+			num_extra_edges += num_parents - 1;
+
+		commits.nr++;
+	}
+	num_chunks = num_extra_edges ? 4 : 3;
+
+	if (commits.nr >= GRAPH_PARENT_MISSING)
+		die(_("too many commits to write graph"));
+
+	graph_name = get_commit_graph_filename(obj_dir);
+	fd = hold_lock_file_for_update(&lk, graph_name, 0);
+
+	if (fd < 0) {
+		struct strbuf folder = STRBUF_INIT;
+		strbuf_addstr(&folder, graph_name);
+		strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
+
+		if (mkdir(folder.buf, 0777) < 0)
+			die_errno(_("cannot mkdir %s"), folder.buf);
+		strbuf_release(&folder);
+
+		fd = hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
+
+		if (fd < 0)
+			die_errno("unable to create '%s'", graph_name);
+	}
+
+	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+
+	hashwrite_be32(f, GRAPH_SIGNATURE);
+
+	hashwrite_u8(f, GRAPH_VERSION);
+	hashwrite_u8(f, GRAPH_OID_VERSION);
+	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, 0); /* unused padding byte */
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	if (num_extra_edges)
+		chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
+	else
+		chunk_ids[3] = 0;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * num_extra_edges;
+
+	for (i = 0; i <= num_chunks; i++) {
+		uint32_t chunk_write[3];
+
+		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
+		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		hashwrite(f, chunk_write, 12);
+	}
+
+	write_graph_chunk_fanout(f, commits.list, commits.nr);
+	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	write_graph_chunk_large_edges(f, commits.list, commits.nr);
+
+	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	commit_lock_file(&lk);
+
+	free(oids.list);
+	oids.alloc = 0;
+	oids.nr = 0;
+}
diff --git a/commit-graph.h b/commit-graph.h
new file mode 100644
index 0000000000..16fea993ab
--- /dev/null
+++ b/commit-graph.h
@@ -0,0 +1,6 @@
+#ifndef COMMIT_GRAPH_H
+#define COMMIT_GRAPH_H
+
+void write_commit_graph(const char *obj_dir);
+
+#endif
-- 
2.17.0.14.gba1221a8ce

