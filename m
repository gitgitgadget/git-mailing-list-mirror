Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD421F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeBHUib (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:31 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36486 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBHUh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:37:57 -0500
Received: by mail-qt0-f195.google.com with SMTP id q18so1152182qtl.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=533WNkGZ9+R3YcS8m7IzvYX/WQUsSNbXb/jbuAW8vmM=;
        b=lkFZMcd770co4Z0hRKReTayopXbbG1wBaj8+aQ5fRk5+poVir/afL19tSJ7DI/miJE
         vAV/vndCjObH1XXLv86jtAh2vcFVX6mswNp2c4kItVyLu6k9M7cLlWv5/er2VA1VGy4b
         j5bqrsw/WQKZHN5dGF65olmu9plcv/la3Vz3SPAzIe4Ub0QrmlILc913XAXneJJbv91T
         WBgkf/KNZ+cis1CvD10WudiQOg1a1GW3Hgb7H9ALYaMlMGfRNARmrDAnjiLka7/aQKZZ
         8OWX52j5EbGqXPSWVhn+WNKgNWwKnXMRNPa1GbKGU2LTxnYdSWvdiwi9/AMrtpZ9rsQs
         oXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=533WNkGZ9+R3YcS8m7IzvYX/WQUsSNbXb/jbuAW8vmM=;
        b=RsS7suzQQlRrSlieTW1ABJuFddpns8Ma5Qfz+uWzb/9L+yIyhHWkW3k3rFHPrltJO/
         Tyh2GXsdxvI4EObWoNcIFYIfGaSgvqF4ZlQja3ZWng5z+OPV41WIiS2YsLHwoiCYzyKI
         GhJ3royt0NAFlvFkm69mIbZ/jZvz+PjzakNAZnM+y9hawKB6lm5VNtrrCmablM3K95M1
         auzQHPZmb0vsIRA/Dro5AOHNeiKUQrzumXHhWRY5cid/6PfZi2fbdd+/RYjJxa7+b59l
         zx1CQAWzYYqsAK1+vjt10n+JxOWUPjqV479eKx3UThnH4UpPucqLQPuXyyj2n67MiTjw
         jSIw==
X-Gm-Message-State: APf1xPDCbO8NKZUChS019GQDHvXSwMYo62TzIVX9QsBwn2XByd3mHXRm
        1QL7E1bXM9TvEACs3WQvGBZmnC6zrv4=
X-Google-Smtp-Source: AH8x227Ix4TiP2q0qHWJWdULe/ErPtUR51/k9TrLhg/R2hGrixozHmuZ9Y+zMQgZ1Di3BeU0Y5P1WA==
X-Received: by 10.237.42.120 with SMTP id k53mr756426qtf.283.1518122276053;
        Thu, 08 Feb 2018 12:37:56 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:55 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 04/14] commit-graph: implement write_commit_graph()
Date:   Thu,  8 Feb 2018 15:37:28 -0500
Message-Id: <1518122258-157281-5-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to write a commit graph file by checking all packed objects
to see if they are commits, then store the file in the given pack
directory.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |   1 +
 commit-graph.c | 368 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h |  13 ++
 3 files changed, 382 insertions(+)
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h

diff --git a/Makefile b/Makefile
index fc40b816dc..eeaeb6a745 100644
--- a/Makefile
+++ b/Makefile
@@ -761,6 +761,7 @@ LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
+LIB_OBJS += commit-graph.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
diff --git a/commit-graph.c b/commit-graph.c
new file mode 100644
index 0000000000..cb47b68871
--- /dev/null
+++ b/commit-graph.c
@@ -0,0 +1,368 @@
+#include "cache.h"
+#include "config.h"
+#include "git-compat-util.h"
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
+#define GRAPH_OID_LEN_SHA1 20
+#define GRAPH_OID_VERSION GRAPH_OID_VERSION_SHA1
+#define GRAPH_OID_LEN GRAPH_OID_LEN_SHA1
+
+#define GRAPH_LARGE_EDGES_NEEDED 0x80000000
+#define GRAPH_PARENT_MISSING 0x7fffffff
+#define GRAPH_EDGE_LAST_MASK 0x7fffffff
+#define GRAPH_PARENT_NONE 0x70000000
+
+#define GRAPH_LAST_EDGE 0x80000000
+
+#define GRAPH_FANOUT_SIZE (4 * 256)
+#define GRAPH_CHUNKLOOKUP_WIDTH 12
+#define GRAPH_CHUNKLOOKUP_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH)
+#define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
+			GRAPH_OID_LEN + 8)
+
+char* get_commit_graph_filename_hash(const char *pack_dir,
+				     struct object_id *hash)
+{
+	size_t len;
+	struct strbuf path = STRBUF_INIT;
+	strbuf_addstr(&path, pack_dir);
+	strbuf_addstr(&path, "/graph-");
+	strbuf_addstr(&path, oid_to_hex(hash));
+	strbuf_addstr(&path, ".graph");
+
+	return strbuf_detach(&path, &len);
+}
+
+static void write_graph_chunk_fanout(struct sha1file *f,
+				     struct commit **commits,
+				     int nr_commits)
+{
+	uint32_t i, count = 0;
+	struct commit **list = commits;
+	struct commit **last = commits + nr_commits;
+
+	/*
+	 * Write the first-level table (the list is sorted,
+	 * but we use a 256-entry lookup to be able to avoid
+	 * having to do eight extra binary search iterations).
+	 */
+	for (i = 0; i < 256; i++) {
+		while (list < last) {
+			if ((*list)->object.oid.hash[0] != i)
+				break;
+			count++;
+			list++;
+		}
+
+		sha1write_be32(f, count);
+	}
+}
+
+static void write_graph_chunk_oids(struct sha1file *f, int hash_len,
+				   struct commit **commits, int nr_commits)
+{
+	struct commit **list, **last = commits + nr_commits;
+	for (list = commits; list < last; list++)
+		sha1write(f, (*list)->object.oid.hash, (int)hash_len);
+}
+
+static int commit_pos(struct commit **commits, int nr_commits,
+		      const struct object_id *oid, uint32_t *pos)
+{
+	uint32_t first = 0, last = nr_commits;
+
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		struct object_id *current;
+		int cmp;
+
+		current = &(commits[mid]->object.oid);
+		cmp = oidcmp(oid, current);
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
+static void write_graph_chunk_data(struct sha1file *f, int hash_len,
+				   struct commit **commits, int nr_commits)
+{
+	struct commit **list = commits;
+	struct commit **last = commits + nr_commits;
+	uint32_t num_large_edges = 0;
+
+	while (list < last) {
+		struct commit_list *parent;
+		uint32_t int_id;
+		uint32_t packedDate[2];
+
+		parse_commit(*list);
+		sha1write(f, (*list)->tree->object.oid.hash, hash_len);
+
+		parent = (*list)->parents;
+
+		if (!parent)
+			int_id = GRAPH_PARENT_NONE;
+		else if (!commit_pos(commits, nr_commits,
+				     &(parent->item->object.oid), &int_id))
+			int_id = GRAPH_PARENT_MISSING;
+
+		sha1write_be32(f, int_id);
+
+		if (parent)
+			parent = parent->next;
+
+		if (!parent)
+			int_id = GRAPH_PARENT_NONE;
+		else if (parent->next)
+			int_id = GRAPH_LARGE_EDGES_NEEDED | num_large_edges;
+		else if (!commit_pos(commits, nr_commits,
+				    &(parent->item->object.oid), &int_id))
+			int_id = GRAPH_PARENT_MISSING;
+
+		sha1write_be32(f, int_id);
+
+		if (parent && parent->next) {
+			do {
+				num_large_edges++;
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
+		sha1write(f, packedDate, 8);
+
+		list++;
+	}
+}
+
+static void write_graph_chunk_large_edges(struct sha1file *f,
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
+			uint32_t int_id, swap_int_id;
+			uint32_t last_edge = 0;
+			if (!parent->next)
+				last_edge |= GRAPH_LAST_EDGE;
+
+			if (commit_pos(commits, nr_commits,
+				       &(parent->item->object.oid),
+				       &int_id))
+				swap_int_id = htonl(int_id | last_edge);
+			else
+				swap_int_id = htonl(GRAPH_PARENT_MISSING | last_edge);
+
+			sha1write(f, &swap_int_id, 4);
+		}
+
+		list++;
+	}
+}
+
+static int commit_compare(const void *_a, const void *_b)
+{
+	struct object_id *a = *(struct object_id **)_a;
+	struct object_id *b = *(struct object_id **)_b;
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
+	struct object_id **list;
+	int nr;
+	int alloc;
+};
+
+static int if_packed_commit_add_to_list(const struct object_id *oid,
+					struct packed_git *pack,
+					uint32_t pos,
+					void *data)
+{
+	struct packed_oid_list *list = (struct packed_oid_list*)data;
+	enum object_type type;
+	unsigned long size;
+	void *inner_data;
+	off_t offset = nth_packed_object_offset(pack, pos);
+	inner_data = unpack_entry(pack, offset, &type, &size);
+
+	if (inner_data)
+		free(inner_data);
+
+	if (type != OBJ_COMMIT)
+		return 0;
+
+	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
+	list->list[list->nr] = xmalloc(sizeof(struct object_id));
+	oidcpy(list->list[list->nr], oid);
+	(list->nr)++;
+
+	return 0;
+}
+
+struct object_id *write_commit_graph(const char *pack_dir)
+{
+	struct packed_oid_list oids;
+	struct packed_commit_list commits;
+	struct sha1file *f;
+	int i, count_distinct = 0;
+	struct strbuf tmp_file = STRBUF_INIT;
+	unsigned char final_hash[GIT_MAX_RAWSZ];
+	char *graph_name;
+	int fd;
+	uint32_t chunk_ids[5];
+	uint64_t chunk_offsets[5];
+	int num_long_edges;
+	struct object_id *f_hash;
+	char *fname;
+	struct commit_list *parent;
+
+	oids.nr = 0;
+	oids.alloc = 1024;
+	ALLOC_ARRAY(oids.list, oids.alloc);
+
+	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+
+	QSORT(oids.list, oids.nr, commit_compare);
+
+	count_distinct = 1;
+	for (i = 1; i < oids.nr; i++) {
+		if (oidcmp(oids.list[i-1], oids.list[i]))
+			count_distinct++;
+	}
+
+	commits.nr = 0;
+	commits.alloc = count_distinct;
+	ALLOC_ARRAY(commits.list, commits.alloc);
+
+	num_long_edges = 0;
+	for (i = 0; i < oids.nr; i++) {
+		int num_parents = 0;
+		if (i > 0 && !oidcmp(oids.list[i-1], oids.list[i]))
+			continue;
+
+		commits.list[commits.nr] = lookup_commit(oids.list[i]);
+		parse_commit(commits.list[commits.nr]);
+
+		for (parent = commits.list[commits.nr]->parents;
+		     parent; parent = parent->next)
+			num_parents++;
+
+		if (num_parents > 2)
+			num_long_edges += num_parents - 1;
+
+		commits.nr++;
+	}
+
+	strbuf_addstr(&tmp_file, pack_dir);
+	strbuf_addstr(&tmp_file, "/tmp_graph_XXXXXX");
+
+	fd = git_mkstemp_mode(tmp_file.buf, 0444);
+	if (fd < 0)
+		die_errno("unable to create '%s'", tmp_file.buf);
+
+	graph_name = strbuf_detach(&tmp_file, NULL);
+	f = sha1fd(fd, graph_name);
+
+	sha1write_be32(f, GRAPH_SIGNATURE);
+
+	sha1write_u8(f, GRAPH_VERSION);
+	sha1write_u8(f, GRAPH_OID_VERSION);
+	sha1write_u8(f, GRAPH_OID_LEN);
+	sha1write_u8(f, 4); /* number of chunks */
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = 8 + GRAPH_CHUNKLOOKUP_SIZE;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * num_long_edges;
+
+	for (i = 0; i <= 4; i++) {
+		uint32_t chunk_write[3];
+
+		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
+		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		sha1write(f, chunk_write, 12);
+	}
+
+	write_graph_chunk_fanout(f, commits.list, commits.nr);
+	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	write_graph_chunk_large_edges(f, commits.list, commits.nr);
+
+	sha1close(f, final_hash, CSUM_CLOSE | CSUM_FSYNC);
+
+	f_hash = xmalloc(sizeof(struct object_id));
+	hashcpy(f_hash->hash, final_hash);
+	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
+
+	if (rename(graph_name, fname))
+		die("failed to rename %s to %s", graph_name, fname);
+
+	free(oids.list);
+	oids.alloc = 0;
+	oids.nr = 0;
+
+	return f_hash;
+}
+
diff --git a/commit-graph.h b/commit-graph.h
new file mode 100644
index 0000000000..4756f6ba5b
--- /dev/null
+++ b/commit-graph.h
@@ -0,0 +1,13 @@
+#ifndef COMMIT_GRAPH_H
+#define COMMIT_GRAPH_H
+
+#include "git-compat-util.h"
+#include "commit.h"
+
+extern char* get_commit_graph_filename_hash(const char *pack_dir,
+					    struct object_id *hash);
+
+extern struct object_id *write_commit_graph(const char *pack_dir);
+
+#endif
+
-- 
2.15.1.45.g9b7079f

