Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C895F1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeA3Vk4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:56 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35341 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeA3VkP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:15 -0500
Received: by mail-qk0-f195.google.com with SMTP id d80so12126358qkg.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0sPLmBeJAyJWGNrOm/OA74xjN4MHnLFOCqKPqwLRE6s=;
        b=CUcPtvUt+mjvUX74ssW5yA/0rGMnSh4cp4AgFwZZA4aNhKFfdE1VyirjGQXmgYAr5y
         6UT+GmnEcM09+Qysl7N7xHkfWuzq7IrHATINkBJqMl44EzZG7F97Pn5Qaq769r24GkUU
         3IPLJKFKv1nvKtZE130MvH2Ab9pSlL3VGLIoox0pvXvmEfro2Wbvip2UsNTe6FbsiblG
         2/cLpp4icfJByboUM7ge2LSPPhk+5oYyaiudG0vsGPSCRRidYmh+69Wdt6I5Ub5y6rmU
         Tt2O7Kd4XBCglqnnxHd+u9VfEMnoNQKgeHCelYM3572PBfoRQYbSAsxLR+6hLPH25dly
         +rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0sPLmBeJAyJWGNrOm/OA74xjN4MHnLFOCqKPqwLRE6s=;
        b=IjfGNJb2nDesPTkmQBWm5Hb+MYKp8p9pEzHGgUcImOrxSgFgRGV34zK8+nPEbLr+3B
         ZLKtiEPDNpOyHHsrhHF42iaJgo1eAwJbEHGL6zjPYhGjhQM8zR3qXApaXmiHi8ZYEFUz
         FfPpXnMDxzjt+NgPLuCNAMwnhqMCRS6MWxTyMZCd6gjlRUUAH+oc4RtFwWLVEvmcgz1Q
         Tlof2MsjtDyxTgppkVezinNCgcHuRy530CteiMKUXhr/xhfb23PkArhUXjS1ZoT44oBA
         ctqrFqop8DMl9+nPIJJLyYPYKjAH4M+ctXJOdeZCnmd9J4Sy0Gjxw9Tw0a0U9mwGfg9o
         LvCg==
X-Gm-Message-State: AKwxytcvzRfCPPIJRaCkpM+U0y8pbrpNlA7GHONr6d4+2hOt/4edvMg8
        jxJ9stvj7Sw9izrJ1WyOyL73kCUS
X-Google-Smtp-Source: AH8x224fgIrXGruJtLCR3Qw+t8a4qQt17/t1ff+iJxmTSxGygEWbVqiH3ZBSTSJX9GKZMQ9S8gKCRw==
X-Received: by 10.55.50.213 with SMTP id y204mr41145700qky.86.1517348414795;
        Tue, 30 Jan 2018 13:40:14 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:14 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 04/14] commit-graph: implement construct_commit_graph()
Date:   Tue, 30 Jan 2018 16:39:33 -0500
Message-Id: <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
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
 commit-graph.c | 376 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h |  20 +++
 3 files changed, 397 insertions(+)
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h

diff --git a/Makefile b/Makefile
index aee5d3f7b9..894432b35b 100644
--- a/Makefile
+++ b/Makefile
@@ -773,6 +773,7 @@ LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
+LIB_OBJS += commit-graph.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
diff --git a/commit-graph.c b/commit-graph.c
new file mode 100644
index 0000000000..db2b7390c7
--- /dev/null
+++ b/commit-graph.c
@@ -0,0 +1,376 @@
+#include "cache.h"
+#include "config.h"
+#include "git-compat-util.h"
+#include "pack.h"
+#include "packfile.h"
+#include "commit.h"
+#include "object.h"
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
+#define GRAPH_FANOUT_SIZE (4*256)
+#define GRAPH_CHUNKLOOKUP_SIZE (5 * 12)
+#define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
+			GRAPH_OID_LEN + sizeof(struct commit_graph_header))
+
+char* get_commit_graph_filename_hash(const char *pack_dir,
+				     struct object_id *hash)
+{
+	size_t len;
+	struct strbuf head_path = STRBUF_INIT;
+	strbuf_addstr(&head_path, pack_dir);
+	strbuf_addstr(&head_path, "/graph-");
+	strbuf_addstr(&head_path, oid_to_hex(hash));
+	strbuf_addstr(&head_path, ".graph");
+
+	return strbuf_detach(&head_path, &len);
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
+		uint32_t swap_count;
+
+		while (list < last) {
+			if ((*list)->object.oid.hash[0] != i)
+				break;
+			count++;
+			list++;
+		}
+
+		swap_count = htonl(count);
+		sha1write(f, &swap_count, 4);
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
+		uint32_t int_id, swap_int_id;
+		uint32_t packedDate[2];
+
+		parse_commit(*list);
+		sha1write(f, (*list)->tree->object.oid.hash, hash_len);
+
+		parent = (*list)->parents;
+
+		if (!parent)
+			swap_int_id = htonl(GRAPH_PARENT_NONE);
+		else if (commit_pos(commits, nr_commits,
+				    &(parent->item->object.oid), &int_id))
+			swap_int_id = htonl(int_id);
+		else
+			swap_int_id = htonl(GRAPH_PARENT_MISSING);
+
+		sha1write(f, &swap_int_id, 4);
+
+		if (parent)
+			parent = parent->next;
+
+		if (!parent)
+			swap_int_id = htonl(GRAPH_PARENT_NONE);
+		else if (parent->next)
+			swap_int_id = htonl(GRAPH_LARGE_EDGES_NEEDED | num_large_edges);
+		else if (commit_pos(commits, nr_commits,
+				    &(parent->item->object.oid), &int_id))
+			swap_int_id = htonl(int_id);
+		else
+			swap_int_id = htonl(GRAPH_PARENT_MISSING);
+
+		sha1write(f, &swap_int_id, 4);
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
+		for (parent = (*list)->parents; parent; parent = parent->next) {
+			uint32_t int_id, swap_int_id;
+			uint32_t last_edge = 0;
+
+			if (parent == (*list)->parents)
+				continue;
+
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
+	int num;
+	int size;
+};
+
+struct packed_oid_list {
+	struct object_id **list;
+	int num;
+	int size;
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
+	ALLOC_GROW(list->list, list->num + 1, list->size);
+	list->list[list->num] = (struct object_id *)malloc(sizeof(struct object_id));
+	oidcpy(list->list[list->num], oid);
+	(list->num)++;
+
+	return 0;
+}
+
+struct object_id *construct_commit_graph(const char *pack_dir)
+{
+	struct packed_oid_list oids;
+	struct packed_commit_list commits;
+	struct commit_graph_header hdr;
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
+	oids.num = 0;
+	oids.size = 1024;
+	ALLOC_ARRAY(oids.list, oids.size);
+	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+	QSORT(oids.list, oids.num, commit_compare);
+
+	count_distinct = 1;
+	for (i = 1; i < oids.num; i++) {
+		if (oidcmp(oids.list[i-1], oids.list[i]))
+			count_distinct++;
+	}
+
+	commits.num = 0;
+	commits.size = count_distinct;
+	ALLOC_ARRAY(commits.list, commits.size);
+
+	num_long_edges = 0;
+	for (i = 0; i < oids.num; i++) {
+		int num_parents = 0;
+		if (i > 0 && !oidcmp(oids.list[i-1], oids.list[i]))
+			continue;
+
+		commits.list[commits.num] = lookup_commit(oids.list[i]);
+		parse_commit(commits.list[commits.num]);
+
+		for (parent = commits.list[commits.num]->parents;
+		     parent; parent = parent->next)
+			num_parents++;
+
+		if (num_parents > 2)
+			num_long_edges += num_parents - 1;
+
+		commits.num++;
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
+	hdr.graph_signature = htonl(GRAPH_SIGNATURE);
+	hdr.graph_version = GRAPH_VERSION;
+	hdr.hash_version = GRAPH_OID_VERSION;
+	hdr.hash_len = GRAPH_OID_LEN;
+	hdr.num_chunks = 4;
+
+	assert(sizeof(hdr) == 8);
+	sha1write(f, &hdr, sizeof(hdr));
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = sizeof(hdr) + GRAPH_CHUNKLOOKUP_SIZE;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.num;
+	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.num;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * num_long_edges;
+
+	for (i = 0; i <= hdr.num_chunks; i++) {
+		uint32_t chunk_write[3];
+
+		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
+		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		sha1write(f, chunk_write, 12);
+	}
+
+	write_graph_chunk_fanout(f, commits.list, commits.num);
+	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.num);
+	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.num);
+	write_graph_chunk_large_edges(f, commits.list, commits.num);
+
+	sha1close(f, final_hash, CSUM_CLOSE | CSUM_FSYNC);
+
+	f_hash = (struct object_id *)malloc(sizeof(struct object_id));
+	memcpy(f_hash->hash, final_hash, GIT_MAX_RAWSZ);
+	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
+
+	if (rename(graph_name, fname))
+		die("failed to rename %s to %s", graph_name, fname);
+
+	free(oids.list);
+	oids.size = 0;
+	oids.num = 0;
+
+	return f_hash;
+}
+
diff --git a/commit-graph.h b/commit-graph.h
new file mode 100644
index 0000000000..7b3469a7df
--- /dev/null
+++ b/commit-graph.h
@@ -0,0 +1,20 @@
+#ifndef COMMIT_GRAPH_H
+#define COMMIT_GRAPH_H
+
+#include "git-compat-util.h"
+#include "commit.h"
+
+extern char* get_commit_graph_filename_hash(const char *pack_dir,
+					    struct object_id *hash);
+
+struct commit_graph_header {
+	uint32_t graph_signature;
+	unsigned char graph_version;
+	unsigned char hash_version;
+	unsigned char hash_len;
+	unsigned char num_chunks;
+};
+
+extern struct object_id *construct_commit_graph(const char *pack_dir);
+
+#endif
-- 
2.16.0.15.g9c3cf44.dirty

