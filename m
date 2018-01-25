Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D9F1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeAYODD (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:03:03 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32779 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeAYOCs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:48 -0500
Received: by mail-qt0-f193.google.com with SMTP id d8so19401161qtm.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjpF1aUOvnWnIe5RRuawj+EL7KzUcvG1th4s8Dmfcrw=;
        b=KOJGSzE7RSlBa21rbjBM7um6bDSTaferznHeYYRKi9BE78Jdlio95FJKBnGBwlxqox
         I7iJX1smjQ9G8qNHoZrJs/YDO/EdJeRHGMfnStN6ctXcapKFtJYyDmElcYneFiAYk402
         /QqOWNVPc4no5PwTTd3OtHprt0k/aP7VA1t6B8jLJUNX0rZ8h38sfai3droJROkzUHau
         GDWlTxHPAnCvnH6tZA/1vgmYFN2PcadoP7EoCqU68QWpn7dmGDTUT2B30mJ3yXhxTNSn
         hSkD0Cpww7D2Tv10RAVoZAzvqe10Uf2yj7rGWYJZLqysAaq5vSwIUrwFjraM/TQhn8Uv
         W8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zjpF1aUOvnWnIe5RRuawj+EL7KzUcvG1th4s8Dmfcrw=;
        b=qIXaAk16vStjwWtXfL13t+ppQkfT1+0yJlbo7RefO7oEZPoJRi7GhOq9++jn9ZeX9+
         xYh27yYSTEoI/77THpnxEz/3GToL2V8lgQrQ0tye3HUZDMDxP0x7aMz7hShV/+WZpZSE
         oxS0ZuaG/NzEP75ITZ8YoM2rQlQapDzwxNKB0zoazv62YPuDhLDLsxZYjuUWsVAusuNp
         RCMpoa6txmjorcblc7/4KGi/z3D+4BXoAILqmKN88YtJ7uzHORYholUT1gHCSnDkWzBh
         WADMRbj2PIwBapcPf6pZAW37v6ibLzWUX2IokXFOw+Bc1yMXbIIumC8R4S3bgmZxvJ/p
         xXKw==
X-Gm-Message-State: AKwxytedXG+vY67BEMzpUlS+SMsZVM5xO6h7m9YogL1EyhpJCMntRMjv
        Rg5lNv+1zjeK+s4gJ5uKlFKe5lcs
X-Google-Smtp-Source: AH8x224bpr4vZdS+4mHs/H/bgfhWTN1UCtFvgOP56GVI+ykQhgdAA14bIeWXGQYrwVUDg+s2MTlziQ==
X-Received: by 10.200.24.174 with SMTP id s43mr16887990qtj.239.1516888966967;
        Thu, 25 Jan 2018 06:02:46 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:46 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 05/14] packed-graph: implement construct_graph()
Date:   Thu, 25 Jan 2018 09:02:22 -0500
Message-Id: <20180125140231.65604-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to write a packed graph file by checking all packed objects
to see if they are commits, then store the file in the given pack
directory.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |   1 +
 packed-graph.c | 375 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packed-graph.h |  20 +++
 3 files changed, 396 insertions(+)
 create mode 100644 packed-graph.c
 create mode 100644 packed-graph.h

diff --git a/Makefile b/Makefile
index d8b0d0457a..59439e13a1 100644
--- a/Makefile
+++ b/Makefile
@@ -841,6 +841,7 @@ LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
+LIB_OBJS += packed-graph.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
diff --git a/packed-graph.c b/packed-graph.c
new file mode 100644
index 0000000000..9be9811667
--- /dev/null
+++ b/packed-graph.c
@@ -0,0 +1,375 @@
+#include "cache.h"
+#include "config.h"
+#include "git-compat-util.h"
+#include "pack.h"
+#include "packfile.h"
+#include "commit.h"
+#include "object.h"
+#include "packed-graph.h"
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
+char* get_graph_filename_oid(const char *pack_dir,
+				  struct object_id *oid)
+{
+	size_t len;
+	struct strbuf head_path = STRBUF_INIT;
+	strbuf_addstr(&head_path, pack_dir);
+	strbuf_addstr(&head_path, "/graph-");
+	strbuf_addstr(&head_path, oid_to_hex(oid));
+	strbuf_addstr(&head_path, ".graph");
+
+	return strbuf_detach(&head_path, &len);
+}
+
+static void write_graph_chunk_fanout(
+	struct sha1file *f,
+	struct commit **commits, int nr_commits)
+{
+	uint32_t i, count = 0;
+	struct commit **list = commits;
+	struct commit **last = commits + nr_commits;
+
+	/*
+	* Write the first-level table (the list is sorted,
+	* but we use a 256-entry lookup to be able to avoid
+	* having to do eight extra binary search iterations).
+	*/
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
+static void write_graph_chunk_oids(
+	struct sha1file *f, int hash_len,
+	struct commit **commits, int nr_commits)
+{
+	struct commit **list = commits;
+	uint32_t i;
+	for (i = 0; i < nr_commits; i++) {
+		sha1write(f, (*list)->object.oid.hash, (int)hash_len);
+		list++;
+	}
+}
+
+static int commit_pos(struct commit **commits, int nr_commits, const struct object_id *oid, uint32_t *pos)
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
+static void write_graph_chunk_data(
+	struct sha1file *f, int hash_len,
+	struct commit **commits, int nr_commits)
+{
+	struct commit **list = commits;
+	struct commit **last = commits + nr_commits;
+	uint32_t num_large_edges = 0;
+
+	while (list < last) {
+		struct commit_list *parent;
+		uint32_t intId, swapIntId;
+		uint32_t packedDate[2];
+
+		parse_commit(*list);
+		sha1write(f, (*list)->tree->object.oid.hash, hash_len);
+
+		parent = (*list)->parents;
+
+		if (!parent)
+			swapIntId = htonl(GRAPH_PARENT_NONE);
+		else if (commit_pos(commits, nr_commits, &(parent->item->object.oid), &intId))
+			swapIntId = htonl(intId);
+		else
+			swapIntId = htonl(GRAPH_PARENT_MISSING);
+
+		sha1write(f, &swapIntId, 4);
+
+		if (parent)
+			parent = parent->next;
+
+		if (!parent)
+			swapIntId = htonl(GRAPH_PARENT_NONE);
+		else if (parent->next)
+			swapIntId = htonl(GRAPH_LARGE_EDGES_NEEDED | num_large_edges);
+		else if (commit_pos(commits, nr_commits,  &(parent->item->object.oid), &intId))
+			swapIntId = htonl(intId);
+		else
+			swapIntId = htonl(GRAPH_PARENT_MISSING);
+
+		sha1write(f, &swapIntId, 4);
+
+		if (parent && parent->next) {
+			do {
+				num_large_edges++;
+				parent = parent->next;
+			} while (parent);
+		}
+
+		packedDate[0] = htonl((*list)->date >> 32);
+		packedDate[1] = htonl((*list)->date);
+		sha1write(f, packedDate, 8);
+
+		list++;
+	}
+}
+
+static void write_graph_chunk_large_edges(
+	struct sha1file *f,
+	struct commit **commits, int nr_commits)
+{
+	struct commit **list = commits;
+	struct commit **last = commits + nr_commits;
+	struct commit_list *parent;
+
+	while (list < last) {
+		int num_parents = 0;
+		for (parent = (*list)->parents; num_parents < 3 && parent; parent = parent->next)
+			num_parents++;
+
+		if (num_parents <= 2) {
+			list++;
+			continue;
+		}
+
+		for (parent = (*list)->parents; parent; parent = parent->next)
+		{
+			if (parent != (*list)->parents)
+			{
+				uint32_t intId, swapIntId;
+				uint32_t lastEdge = 0;
+
+				if (!parent->next)
+					lastEdge |= GRAPH_LAST_EDGE;
+
+				if (commit_pos(commits, nr_commits,  &(parent->item->object.oid), &intId))
+					swapIntId = htonl(intId | lastEdge);
+				else
+					swapIntId = htonl(GRAPH_PARENT_MISSING | lastEdge);
+
+				sha1write(f, &swapIntId, 4);
+			}
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
+struct object_id *construct_graph(const char *pack_dir)
+{
+	// Find a list of oids, adding the pointer to a list.
+	struct packed_oid_list oids;
+	struct packed_commit_list commits;
+	struct packed_graph_header hdr;
+	struct sha1file *f;
+	int i, count_distinct = 0;
+	struct strbuf tmp_file = STRBUF_INIT;
+	unsigned char final_hash[GIT_MAX_RAWSZ];
+	char *graph_name;
+	int fd;
+	uint32_t chunk_ids[5];
+	uint64_t chunk_offsets[5];
+	int num_long_edges;
+	struct object_id *f_oid;
+	char *fname;
+	struct commit_list *parent;
+
+	if (!core_graph)
+		return 0;
+
+	oids.num = 0;
+	oids.size = 1024;
+	ALLOC_ARRAY(oids.list, oids.size);
+	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+	QSORT(oids.list, oids.num, commit_compare);
+
+	count_distinct = 1;
+	for (i = 1; i < oids.num; i++)
+	{
+		if (oidcmp(oids.list[i-1], oids.list[i]))
+			count_distinct++;
+	}
+
+	commits.num = 0;
+	commits.size = count_distinct;
+	ALLOC_ARRAY(commits.list, commits.size);
+
+	num_long_edges = 0;
+	for (i = 0; i < oids.num; i++)
+	{
+		int num_parents = 0;
+		if (i > 0 && !oidcmp(oids.list[i-1], oids.list[i]))
+			continue;
+
+		commits.list[commits.num] = lookup_commit(oids.list[i]);
+		parse_commit(commits.list[commits.num]);
+
+		for (parent = commits.list[commits.num]->parents; parent; parent = parent->next) {
+			num_parents++;
+		}
+
+		if (num_parents > 2)
+			num_long_edges += num_parents - 1;
+
+		commits.num++;
+	}
+
+	// Create header (including chunk lengths?!?)
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
+	/* fill header info */
+	hdr.graph_signature = htonl(GRAPH_SIGNATURE);
+	hdr.graph_version = GRAPH_VERSION;
+	hdr.hash_version = GRAPH_OID_VERSION;
+	hdr.hash_len = GRAPH_OID_LEN;
+	hdr.num_chunks = 4;
+
+	/* write header to file */
+	assert(sizeof(hdr) == 8);
+	sha1write(f, &hdr, sizeof(hdr));
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = sizeof(hdr) + 12 * 5; // Skip header and chunk list
+	chunk_offsets[1] = chunk_offsets[0] + 256 * 4; // fanout table size
+	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.num; // lookup size
+	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.num; // data size
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
+	f_oid = (struct object_id *)malloc(sizeof(struct object_id));
+	memcpy(f_oid->hash, final_hash, GIT_MAX_RAWSZ);
+	fname = get_graph_filename_oid(pack_dir, f_oid);
+
+	if (rename(graph_name, fname))
+		die("failed to rename %s to %s", graph_name, fname);
+
+	free(oids.list);
+	oids.size = 0;
+	oids.num = 0;
+
+	return f_oid;
+}
diff --git a/packed-graph.h b/packed-graph.h
new file mode 100644
index 0000000000..d4e10fb612
--- /dev/null
+++ b/packed-graph.h
@@ -0,0 +1,20 @@
+#ifndef PACKED_GRAPH_H
+#define PACKED_GRAPH_H
+
+#include "git-compat-util.h"
+#include "commit.h"
+
+extern char* get_graph_filename_oid(const char *pack_dir,
+				    struct object_id *oid);
+
+struct packed_graph_header {
+	uint32_t graph_signature;
+	unsigned char graph_version;
+	unsigned char hash_version;
+	unsigned char hash_len;
+	unsigned char num_chunks;
+};
+
+extern struct object_id *construct_graph(const char *pack_dir);
+
+#endif
-- 
2.16.0

