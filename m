Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDD01F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeCNT2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42209 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCNT2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:02 -0400
Received: by mail-qk0-f196.google.com with SMTP id b198so4750962qkg.9
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pO9udK7xk5XmQuHYIeQ6gonkAlrRebjHMoDdAHZblOo=;
        b=vbhr1c5+zMovIT01lZrtNDCfVmVdRResIPoyyoqRHbIHChE3NBRTfpR1U9oVKjk2hi
         1ZRmudwdlGNgKyGIBISs6xYoxaUKP7qKRX8Q34ZWwtHam8qH+mDlEhqzFqYKeUh4Ul/d
         jGKeDpadXPGB1vZ3PJND4OdyRrbteddpij2pEMqdjzynqUB6mrDdnMCUWyKS74li8+S2
         mhrhKMxku1ipGgqNi7y8eFy7MNUtSK1Smz0HlDMiBtQa37HhBE2bk6jwNW6B16+8tNtd
         XWbZroDchdgIErsJ4mw/Sg+iKhShDg2V3Axhy/7Sn/JG6UK+usvxq7JuGdrMZVmHs/09
         xf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pO9udK7xk5XmQuHYIeQ6gonkAlrRebjHMoDdAHZblOo=;
        b=Fv5VtRG+1I0WM6UHwb4EU7+DisOOvEvjD6PcuRUNFF3hA4BoUKQu71A60rk0j4CRia
         nJ5Dz7rYOUd1+GNtJHyL+0uCaVJyl7wlC2LM+3allcdYi5qY0AdENwXY7onPHBjDjjRQ
         TxFzYsrqNjYF6Aur10ZCjl5mAzQ4o548nTXURA5Dt69HEfrWiVE+nPufD8oCt3xM+8c7
         MwvelBdE7Q+VCkVx6YWal6Qbg4sSh0ktnalSHRu0x6rjnlIHlZI61QkcAMyZT+QhM98J
         GpYDBGhvyLJi5Q4Y7wa4HyYW+O9XiuLn6nfD8Usw69W5kUm9AWoYIZz4rWfrJXWksKLm
         lE1g==
X-Gm-Message-State: AElRT7Hd5u/1WdQ8dMkFEKy/Uq5BOC5o/X3ROGj5BI8vMGpjdnVZbKp8
        407f66E0ha4+fWtTc+o5SCY1ytCIbf0=
X-Google-Smtp-Source: AG47ELv/95RDVSRUHOqakomKlBosYpVN9Zm1qzpjC2Qco96oJNDoyT/3/TML/wx/pV1MhdovPBGpOg==
X-Received: by 10.55.215.16 with SMTP id m16mr8302770qki.303.1521055680589;
        Wed, 14 Mar 2018 12:28:00 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:28:00 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 06/14] commit-graph: implement write_commit_graph()
Date:   Wed, 14 Mar 2018 15:27:28 -0400
Message-Id: <20180314192736.70602-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach Git to write a commit graph file by checking all packed objects
to see if they are commits, then store the file in the given object
directory.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |   1 +
 commit-graph.c | 359 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h |   7 ++
 3 files changed, 367 insertions(+)
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h

diff --git a/Makefile b/Makefile
index a928d4de66..49492c3e1c 100644
--- a/Makefile
+++ b/Makefile
@@ -771,6 +771,7 @@ LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
+LIB_OBJS += commit-graph.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
diff --git a/commit-graph.c b/commit-graph.c
new file mode 100644
index 0000000000..9bef691d9b
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
+	unsigned long size;
+	void *inner_data;
+	off_t offset = nth_packed_object_offset(pack, pos);
+	inner_data = unpack_entry(pack, offset, &type, &size);
+	FREE_AND_NULL(inner_data);
+
+	if (type != OBJ_COMMIT)
+		return 0;
+
+	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
+	oidcpy(&(list->list[list->nr]), oid);
+	(list->nr)++;
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
+ 	fd = hold_lock_file_for_update(&lk, graph_name, 0);
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
+ 		fd = hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
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
+
diff --git a/commit-graph.h b/commit-graph.h
new file mode 100644
index 0000000000..4cb3f12d33
--- /dev/null
+++ b/commit-graph.h
@@ -0,0 +1,7 @@
+#ifndef COMMIT_GRAPH_H
+#define COMMIT_GRAPH_H
+
+void write_commit_graph(const char *obj_dir);
+
+#endif
+
-- 
2.14.1

