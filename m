Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D831F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934505AbeFYOfi (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:38 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39223 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934489AbeFYOfe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:34 -0400
Received: by mail-qt0-f194.google.com with SMTP id c23-v6so3192595qtn.6
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFfRUc6NiR5YUY2Qj8e5OxX0eMEelqKU1jLadAcMoOc=;
        b=EVJkmT/lvOgtcmjuNEFHgw9VdFaDOyRkPHf2q8P9SVASEJk0uxCQOyycdnEWWZX3ar
         6079OcOcGPqMr1clH+kTavpXee8QEJ4WwxffK2nuy5dvStVD64p/SbDmASLFnuNlp+IN
         zVlCfRifDJ0AJVLFIYFEJ3LngL3iPTJpAB2YftLbCeOZiu+BSkGAb2DoDr7HrPWfA36e
         zcelTFzAJkjh7gBRhgcV5lwhOEzDWRy3IfV6iokX2ZEMbbx59ikrB08KXY5v1+VhPvN5
         AgTLe5k+GMS+xXvvtKnhhm6Wi+ODiCWBFGpDEGjPhdOSW84BZTozzPogCYVPa2gfEqu1
         CuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFfRUc6NiR5YUY2Qj8e5OxX0eMEelqKU1jLadAcMoOc=;
        b=bsYpdISOR21ouYC1Br8TUIxfT0a2lyOz1NNw9beAeiVsJ3XokL9am3yKN1q1CywjvH
         E4aY5rSaSrj216wKSYno1kSE6ANNyzx3moctSyJrcnX57YJ4bUZbBBreCQo6uzj4kpue
         PHJMRwUDJS526Xum5g+ERhWvYuLq6Nf99tOKqnAMyD6vNRL+Fmf237XAJFyfBb4Cr9W/
         dZcp/W03/ZnijxH6n76m/W8b2nStMI2ivjUOp22K2djhqwdzjYiTp224nmzANpAGCydS
         E2Jc1P8/fFmAfFfLDQ7ce3FWBYU9q5r5/Raek6ZPjY8xK7EOhe5+0gELE56cX/yntBf4
         5cEg==
X-Gm-Message-State: APt69E2Jsz/WStL38c865B6oL7sJTp52IAeHKVA1VMttd9A18AEST+u6
        OzEfTsOPFxqsIGWvfofSkB2E+Ztg
X-Google-Smtp-Source: AAOMgpfHbobV218NgHgufIbmDVdZYAKNqPqHjVAqV/hWZp1VTey6MpqNz2oz5WjWxnWVRjf3hiu3pw==
X-Received: by 2002:ac8:31b7:: with SMTP id h52-v6mr11161786qte.100.1529937333488;
        Mon, 25 Jun 2018 07:35:33 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:32 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 20/24] midx: use existing midx when writing new one
Date:   Mon, 25 Jun 2018 10:34:30 -0400
Message-Id: <20180625143434.89044-21-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 midx.h |   1 +
 2 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/midx.c b/midx.c
index c258e3ebdf..02cbfc5bd5 100644
--- a/midx.c
+++ b/midx.c
@@ -47,7 +47,6 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	fd = git_open(midx_name);
 
 	if (fd < 0) {
-		error_errno(_("failed to read %s"), midx_name);
 		FREE_AND_NULL(midx_name);
 		return NULL;
 	}
@@ -276,6 +275,29 @@ int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct mu
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
@@ -322,6 +344,7 @@ struct pack_list
 	uint32_t alloc_list;
 	uint32_t alloc_names;
 	size_t pack_name_concat_len;
+	struct multi_pack_index *m;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -330,6 +353,9 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 	struct pack_list *packs = (struct pack_list *)data;
 
 	if (ends_with(file_name, ".idx")) {
+		if (packs->m && midx_contains_pack(packs->m, file_name))
+			return;
+
 		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
 		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
 
@@ -413,6 +439,23 @@ static int midx_oid_compare(const void *_a, const void *_b)
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
@@ -438,7 +481,8 @@ static void fill_pack_entry(uint32_t pack_int_id,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
+static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
+						  struct packed_git **p,
 						  uint32_t *perm,
 						  uint32_t nr_packs,
 						  uint32_t *nr_objects)
@@ -447,8 +491,9 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
 	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
 	struct pack_midx_entry *entries_by_fanout = NULL;
 	struct pack_midx_entry *deduplicated_entries = NULL;
+	uint32_t start_pack = m ? m->num_packs : 0;
 
-	for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
+	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
 		total_objects += p[cur_pack]->num_objects;
 	}
 
@@ -466,7 +511,23 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
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
@@ -661,7 +722,7 @@ int write_midx_file(const char *object_dir)
 	struct hashfile *f;
 	struct lock_file lk;
 	struct pack_list packs;
-	uint32_t *pack_perm;
+	uint32_t *pack_perm = NULL;
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
@@ -676,24 +737,42 @@ int write_midx_file(const char *object_dir)
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
-					(packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
+					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
-	ALLOC_ARRAY(pack_perm, packs.nr);
+	ALLOC_ARRAY(pack_perm, packs.alloc_list);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
-	entries = get_sorted_entries(packs.list, pack_perm, packs.nr, &nr_entries);
+	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
+
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
 			num_large_offsets++;
@@ -796,14 +875,18 @@ int write_midx_file(const char *object_dir)
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
+cleanup:
 	for (i = 0; i < packs.nr; i++) {
-		close_pack(packs.list[i]);
-		FREE_AND_NULL(packs.list[i]);
+		if (packs.list[i]) {
+			close_pack(packs.list[i]);
+			FREE_AND_NULL(packs.list[i]);
+		}
 		FREE_AND_NULL(packs.names[i]);
 	}
 
 	FREE_AND_NULL(packs.list);
 	FREE_AND_NULL(packs.names);
 	FREE_AND_NULL(entries);
+	FREE_AND_NULL(pack_perm);
 	return 0;
 }
diff --git a/midx.h b/midx.h
index f7c2ec7893..5faffb7bc6 100644
--- a/midx.h
+++ b/midx.h
@@ -11,6 +11,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
-- 
2.18.0.24.g1b579a2ee9

