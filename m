Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207C41F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDJM5R (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:57:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34481 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbeDJM4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:56:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id y12-v6so7357781plt.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W6l2HCtUPHXyXIq3/xm3lcfXvNCqjHpMHG/IqnUEDzQ=;
        b=dBFK6/hqKUG2hd/qjAs+ZG3gA82fLZH4vleGrDIIyrVxhPM1YlIU5Lj58PL38aLMIw
         VJIU6YVvNsSEXFdsS1DN5121wMNI9gWDO4gAU7ofooQeE4ZBIGBnES6D7wzER1dLwkau
         K8dYzxChYObkAsgK3bE9hRBKKBqjSNR6jk5ponukBzY/UfQpWvxBn+SuTpQ17w6sYd/Y
         ymgpmfDYXo6+5B7E1eF41HDJgqIYA708zsP1AL4RPdt25A/MWhPIGMW7daNO6Isyqj6j
         S878Z0/OeGGiPBkhnIGHHxhOodLxfulWt3BwuVd8i4FuxNNMLKOJy6UCCT3PwsSLH/ZU
         pH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W6l2HCtUPHXyXIq3/xm3lcfXvNCqjHpMHG/IqnUEDzQ=;
        b=ABv+/CplxaksViBNqxSo/WFHQHh+ajww6RwGzI0d0r00Cv8cia8+M0sAnJYbpRrcWr
         1Ti5/qivbDN7MVEXYB0e06h7FtJ00Bga2Mj5RE0wmTowI5OSuSMUkfwPfNRSuMFHGcNQ
         hBv777bv0gqPXDMJHfpof8HxzJB3k/Lc5/luZrfll56ByO5RYK1nyrm7dcItSrJwL5aN
         105VFe+W4P9hxjt46LSwnFfgIA9ypYz1n3l0ixNfUZuloVa5z6NrdOGOZXt69putpmfi
         rph3FraIC4o0hx4W316H6vMfy0Mc5a0z9lF0liYOm9QiVkz5Z8uSny0aIRuKSdH/Sxtd
         eoQA==
X-Gm-Message-State: ALQs6tDFSp8+kgN/6hHS/V7Bj/kFt1ukmT2T3DBKeIoVVDJ7mH5qmV2b
        mrhEJ7ic9JSMayXLZ3MNZwRthaCfahA=
X-Google-Smtp-Source: AIpwx49n896MA6u0hdneP1ysBXkd1o85urmR8yB136ANv0/wK3MfJefp69KYRJ7CVG4d7T6J0MIfmg==
X-Received: by 2002:a17:902:207:: with SMTP id 7-v6mr300011plc.261.1523365013149;
        Tue, 10 Apr 2018 05:56:53 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:56:52 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 06/14] commit-graph: implement write_commit_graph()
Date:   Tue, 10 Apr 2018 08:56:00 -0400
Message-Id: <20180410125608.39443-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
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
2.17.0

