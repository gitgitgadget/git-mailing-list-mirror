Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE64A1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeGLTvl (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:41 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39843 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:40 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so14053120qkg.6
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ReO5CFshmijubkxp4OS+oKXmnRAAD67iatBcVbANcg=;
        b=kPF7l/JyBRogbpA7dj66aDsg/VftcfGvM3BZiBptPsb6vBzawJZ3H7iK7BXX5N2JOS
         fa7SVgtb425XqmfJvtSXl2aiC6wLaVXNO0/nkLS16Cbg8DIp0fDQrZwTydpAO2n3NSTw
         yQeEfhN0G3FuAR4U/UhSzFGnealOQWQWLZhzSSaArVUctWyd3yTeUGrPNTiP79Ywyj32
         2ogmN9k6YxtoTqgg+swC1dvT2Puinur46Sa0luQPtRTGfhpJEr/T2TQKmTa2cHoyndnF
         +L6X8SVvICvvnxuPcmSe/vMXmu1OrvUCk9AEdCZA0S3HvY2bNdJ4gDzIS8fo+IhAcb8N
         QPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ReO5CFshmijubkxp4OS+oKXmnRAAD67iatBcVbANcg=;
        b=DF1Gf+u5s2y0RTozdfKCxdLhZW2er6ymOhiKiZFaXxbIZsYdFICGLCdBlN1k3vEXdw
         wWAjdJyeXzFbxY469bBxOh3L+IlOhCccyx0SPoXUi+PI9ckxfTNGfFYxQEN5fmBkdAcd
         NRdZj2mQJbY0B0KxpmJXNlL3/OqskUE78vZqCA0p3JiDtufFpMKb7DtZkc4hUa6xk/RC
         GIzNToAhvYJxU6x+3dpKura5XID6d3lrssBoB6unASBvOraGkvpouxCJU2q4TolV2zKN
         taiW9javUyLd+Ua0LEWeb2/H/6QVhn/ojHmtza3cgrT5cxxk+YV8DEKRtNVZ+5o41L2t
         J2HQ==
X-Gm-Message-State: AOUpUlHeEmfjCcrz+V2jfTB/Y3LymF7FQpSmGROf0gsww13C2nUQ82lU
        CwaGDSZgHgmwSry9sO/cc/3SdG4DwD8=
X-Google-Smtp-Source: AAOMgpfS+qrAXnHRTiD3yqSVW87BOGqMIP3SCXuPhxR2CAlHtjb2ee6LWuOjk7jh2bbGfUipn0myNw==
X-Received: by 2002:a37:3c01:: with SMTP id j1-v6mr2935338qka.249.1531424439977;
        Thu, 12 Jul 2018 12:40:39 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:39 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 19/23] midx: use existing midx when writing new one
Date:   Thu, 12 Jul 2018 15:39:36 -0400
Message-Id: <20180712193940.21065-20-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to how Windows handles replacing a lockfile when there is an open
handle, create the close_midx() method to close the existing midx before
writing the new one.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 midx.h |   1 +
 2 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/midx.c b/midx.c
index 4e014ff6e3..bf2334acc6 100644
--- a/midx.c
+++ b/midx.c
@@ -179,6 +179,23 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	return NULL;
 }
 
+static void close_midx(struct multi_pack_index *m)
+{
+	uint32_t i;
+	munmap((unsigned char *)m->data, m->data_len);
+	close(m->fd);
+	m->fd = -1;
+
+	for (i = 0; i < m->num_packs; i++) {
+		if (m->packs[i]) {
+			close_pack(m->packs[i]);
+			free(m->packs);
+		}
+	}
+	FREE_AND_NULL(m->packs);
+	FREE_AND_NULL(m->pack_names);
+}
+
 static int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
 {
 	struct strbuf pack_name = STRBUF_INIT;
@@ -278,6 +295,29 @@ int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct mu
 	return nth_midxed_pack_entry(m, e, pos);
 }
 
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_name)
+{
+	uint32_t first = 0, last = m->num_packs;
+
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		const char *current;
+		int cmp;
+
+		current = m->pack_names[mid];
+		cmp = strcmp(idx_name, current);
+		if (!cmp)
+			return 1;
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	return 0;
+}
+
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir)
 {
 	struct multi_pack_index *m = r->objects->multi_pack_index;
@@ -326,6 +366,7 @@ struct pack_list {
 	uint32_t alloc_list;
 	uint32_t alloc_names;
 	size_t pack_name_concat_len;
+	struct multi_pack_index *m;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -334,6 +375,9 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 	struct pack_list *packs = (struct pack_list *)data;
 
 	if (ends_with(file_name, ".idx")) {
+		if (packs->m && midx_contains_pack(packs->m, file_name))
+			return;
+
 		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
 		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
 
@@ -419,6 +463,23 @@ static int midx_oid_compare(const void *_a, const void *_b)
 	return a->pack_int_id - b->pack_int_id;
 }
 
+static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
+				      uint32_t *pack_perm,
+				      struct pack_midx_entry *e,
+				      uint32_t pos)
+{
+	if (pos >= m->num_objects)
+		return 1;
+
+	nth_midxed_object_oid(&e->oid, m, pos);
+	e->pack_int_id = pack_perm[nth_midxed_pack_int_id(m, pos)];
+	e->offset = nth_midxed_offset(m, pos);
+
+	/* consider objects in midx to be from "old" packs */
+	e->pack_mtime = 0;
+	return 0;
+}
+
 static void fill_pack_entry(uint32_t pack_int_id,
 			    struct packed_git *p,
 			    uint32_t cur_object,
@@ -444,7 +505,8 @@ static void fill_pack_entry(uint32_t pack_int_id,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
+static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
+						  struct packed_git **p,
 						  uint32_t *perm,
 						  uint32_t nr_packs,
 						  uint32_t *nr_objects)
@@ -453,8 +515,9 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
 	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
 	struct pack_midx_entry *entries_by_fanout = NULL;
 	struct pack_midx_entry *deduplicated_entries = NULL;
+	uint32_t start_pack = m ? m->num_packs : 0;
 
-	for (cur_pack = 0; cur_pack < nr_packs; cur_pack++)
+	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++)
 		total_objects += p[cur_pack]->num_objects;
 
 	/*
@@ -471,7 +534,23 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		uint32_t nr_fanout = 0;
 
-		for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
+		if (m) {
+			uint32_t start = 0, end;
+
+			if (cur_fanout)
+				start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
+			end = ntohl(m->chunk_oid_fanout[cur_fanout]);
+
+			for (cur_object = start; cur_object < end; cur_object++) {
+				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
+				nth_midxed_pack_midx_entry(m, perm,
+							   &entries_by_fanout[nr_fanout],
+							   cur_object);
+				nr_fanout++;
+			}
+		}
+
+		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
 			uint32_t start = 0, end;
 
 			if (cur_fanout)
@@ -667,16 +746,34 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
+	packs.m = load_multi_pack_index(object_dir);
+
 	packs.nr = 0;
-	packs.alloc_list = 16;
-	packs.alloc_names = 16;
+	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
+	packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
+	packs.names = NULL;
 	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
 
+	if (packs.m) {
+		for (i = 0; i < packs.m->num_packs; i++) {
+			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
+			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
+
+			packs.list[packs.nr] = NULL;
+			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
+			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
+			packs.nr++;
+		}
+	}
+
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
 
+	if (packs.m && packs.nr == packs.m->num_packs)
+		goto cleanup;
+
 	if (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
@@ -684,7 +781,8 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
-	entries = get_sorted_entries(packs.list, pack_perm, packs.nr, &nr_entries);
+	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
+
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
 			num_large_offsets++;
@@ -696,6 +794,9 @@ int write_midx_file(const char *object_dir)
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
+	if (packs.m)
+		close_midx(packs.m);
+
 	cur_chunk = 0;
 	num_chunks = large_offsets_needed ? 5 : 4;
 
@@ -787,6 +888,7 @@ int write_midx_file(const char *object_dir)
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
+cleanup:
 	for (i = 0; i < packs.nr; i++) {
 		if (packs.list[i]) {
 			close_pack(packs.list[i]);
@@ -798,5 +900,7 @@ int write_midx_file(const char *object_dir)
 	free(packs.list);
 	free(packs.names);
 	free(entries);
+	free(pack_perm);
+	free(midx_name);
 	return 0;
 }
diff --git a/midx.h b/midx.h
index 1b976df873..d4cde99473 100644
--- a/midx.h
+++ b/midx.h
@@ -35,6 +35,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
-- 
2.18.0.118.gd4f65b8d14

