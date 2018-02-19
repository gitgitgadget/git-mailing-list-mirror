Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39311F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeBSSyV (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:54:21 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37095 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753494AbeBSSxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:37 -0500
Received: by mail-qk0-f193.google.com with SMTP id y137so7367671qka.4
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2WXgP2zOSneeCU18TIZZP5jXbeXUCzLm5iuLDEizjf4=;
        b=hfEIMCBvSyPuMz1S6p4dVN2dmwyGbggdOBaOVn0CmnUsgke6FkuQHIkCd8FPHOC7+d
         F6VodOjJ/lqnOoGC5EtzcJGjkl43IVr4Rnj+eJlm5as/FR5lFQ/Qmz/Ctjj1pnYwSdkI
         Rb79B8aMVEo0T1mnb9OKHIvUSccpWcafYqCBPN4227ctpvtVDRYicND1sqTQ+Yf9Q18O
         YL4C/k9cw9PpZMvxRU/+vTomWCCrCvSeiPcLGrrPPeO9j0pYqvXR6Ihc5eE6cmIMusXc
         XmWsT9LCqloKpc/oB9H7CWqVWJtfjkEL44+FPNg5T0j6Wbxh4h5PUC3/6xmM+10pDLsc
         7YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2WXgP2zOSneeCU18TIZZP5jXbeXUCzLm5iuLDEizjf4=;
        b=V+cOTGn54TyedRVCQlear+lL/USOjqEg0GE3ECqcxaJBww/ZVt/GxQWjlamBYn0XZE
         CXWe7Erd8Y7FjyF1KsynnzIKDs+0y5ZVKoibMI0C+cWwbEKwYz4iLmdMD5oDTW0fZhnN
         pxemL2Top+hLHlgeYNPpG6pdd9af94htT0X56Miw2tP40iueDddAYsGdpqRWiwW8ko8a
         VWLsCoisIP/yAxLMLhuIYLKhZl6KQbJCUFrSBn+mFk7M2nk4mIJDUlX68daMWfH3sYog
         hDxdtZ8SkJ87padi3j1APf6fy31kGzJw7BivU6pfuPPwTyqErnZ3IexPerQGt3yr3hZ+
         ldhA==
X-Gm-Message-State: APf1xPBzKTq62qp9hOTan5pI8YVTHlhO4JKnnbo6eRMLvqbTQVDKnKkJ
        lk1ezccAYcFdsuBQ46KRXrIj5tbVffc=
X-Google-Smtp-Source: AH8x224iUU91jZaC2KgtdCCmAWzWTzgqJtC1JjIkbY7DnWszJSd3GXHKh473UTbeqP/YqQ4msIQCCg==
X-Received: by 10.55.87.198 with SMTP id l189mr25300845qkb.325.1519066416341;
        Mon, 19 Feb 2018 10:53:36 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:35 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
Date:   Mon, 19 Feb 2018 13:53:17 -0500
Message-Id: <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to write a commit graph file by checking all packed objects
to see if they are commits, then store the file in the given object
directory.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |   1 +
 commit-graph.c | 370 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h |   7 ++
 3 files changed, 378 insertions(+)
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h

diff --git a/Makefile b/Makefile
index fc40b81..eeaeb6a 100644
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
index 0000000..f9e39b0
--- /dev/null
+++ b/commit-graph.c
@@ -0,0 +1,370 @@
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
+	struct object_id *a = (struct object_id *)_a;
+	struct object_id *b = (struct object_id *)_b;
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
+	oidcpy(&(list->list[list->nr]), oid);
+	(list->nr)++;
+
+	return 0;
+}
+
+char *write_commit_graph(const char *obj_dir)
+{
+	struct packed_oid_list oids;
+	struct packed_commit_list commits;
+	struct sha1file *f;
+	int i, count_distinct = 0;
+	DIR *info_dir;
+	struct strbuf tmp_file = STRBUF_INIT;
+	struct strbuf graph_file = STRBUF_INIT;
+	unsigned char final_hash[GIT_MAX_RAWSZ];
+	char *graph_name;
+	int fd;
+	uint32_t chunk_ids[5];
+	uint64_t chunk_offsets[5];
+	int num_chunks;
+	int num_long_edges;
+	struct commit_list *parent;
+
+	oids.nr = 0;
+	oids.alloc = (int)(0.15 * approximate_object_count());
+
+	if (oids.alloc < 1024)
+		oids.alloc = 1024;
+	ALLOC_ARRAY(oids.list, oids.alloc);
+
+	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+
+	QSORT(oids.list, oids.nr, commit_compare);
+
+	count_distinct = 1;
+	for (i = 1; i < oids.nr; i++) {
+		if (oidcmp(&oids.list[i-1], &oids.list[i]))
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
+			num_long_edges += num_parents - 1;
+
+		commits.nr++;
+	}
+	num_chunks = num_long_edges ? 4 : 3;
+
+	strbuf_addf(&tmp_file, "%s/info", obj_dir);
+	info_dir = opendir(tmp_file.buf);
+
+	if (!info_dir && mkdir(tmp_file.buf, 0777) < 0)
+		die_errno(_("cannot mkdir %s"), tmp_file.buf);
+	if (info_dir)
+		closedir(info_dir);
+
+	strbuf_addstr(&tmp_file, "/tmp_graph_XXXXXX");
+
+	fd = git_mkstemp_mode(tmp_file.buf, 0444);
+	if (fd < 0)
+		die_errno("unable to create '%s'", tmp_file.buf);
+
+	f = sha1fd(fd, tmp_file.buf);
+
+	sha1write_be32(f, GRAPH_SIGNATURE);
+
+	sha1write_u8(f, GRAPH_VERSION);
+	sha1write_u8(f, GRAPH_OID_VERSION);
+	sha1write_u8(f, num_chunks);
+	sha1write_u8(f, 0); /* unused padding byte */
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	if (num_long_edges)
+		chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
+	else
+		chunk_ids[3] = 0;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = 8 + GRAPH_CHUNKLOOKUP_SIZE;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * num_long_edges;
+
+	for (i = 0; i <= num_chunks; i++) {
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
+	strbuf_addf(&graph_file, "graph-%s.graph", sha1_to_hex(final_hash));
+	graph_name = strbuf_detach(&graph_file, NULL);
+	strbuf_addf(&graph_file, "%s/info/%s", obj_dir, graph_name);
+
+	if (rename(tmp_file.buf, graph_file.buf))
+		die("failed to rename %s to %s", tmp_file.buf, graph_file.buf);
+
+	strbuf_release(&tmp_file);
+	strbuf_release(&graph_file);
+	free(oids.list);
+	oids.alloc = 0;
+	oids.nr = 0;
+
+	return graph_name;
+}
+
diff --git a/commit-graph.h b/commit-graph.h
new file mode 100644
index 0000000..dc8c73a
--- /dev/null
+++ b/commit-graph.h
@@ -0,0 +1,7 @@
+#ifndef COMMIT_GRAPH_H
+#define COMMIT_GRAPH_H
+
+extern char *write_commit_graph(const char *obj_dir);
+
+#endif
+
-- 
2.7.4

