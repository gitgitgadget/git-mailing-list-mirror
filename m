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
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BCD1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbeGFAyK (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:10 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39760 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbeGFAyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:54:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so8712140qtp.6
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXYx7ySQAUl1rRgAV/w5jv5IsWuZF3GwbU47cGqAnpg=;
        b=Q11F0d0JWuTiMynxl9IXSS29p0AT4RUHFJvJPYXsLpdYuuMEfTfWhWO785siebZH2m
         pgFAiDV6wDv4z/HrN5GYL7omYZg+zXbkCAkBsOgiO3WGdrDPM4KHA+jMAeE5nY18VtZR
         jFziACiXntcMFajabUv6Qrjf8QwhreRWkkVLSQcrV4R4wKO8c9wYXwvOjjkF1KZ3LLNN
         Xh2DgqjnBsFd3yYrUihuObyHFm1mHOWRjOg5mbVMJb6MLrBUnMlhXI8ytghcuPqeCl93
         WJ4dthzqGVMjOi4TIwmQrvp7p+jIlKLB/gDiyK33AC04YbgN4TGiij34mH/QGhbhe3lD
         Pgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXYx7ySQAUl1rRgAV/w5jv5IsWuZF3GwbU47cGqAnpg=;
        b=HjaK8WyLe9Vj+daQBHP01YIPCnDvrGdONU4Yq4lVHJrLL4pwv73CimAnOMPMYTh3d5
         apnfxFVA16czA394G9lXWcwkKGDNDiKP+oDJ9XTGNtSrdbutRtA+SeJwupSzsQ0xWQIq
         9R8UIwcLIqv+doXgCuDOby67PZe3OeeBvewZwyzP9Y3LuBSCWYoCg5NAgdoQkO+06HrT
         HmmQPMBOm+hoeUZtJa95MR15CFlB3ZhBi8OLfqbMhSNDWLQOteOAxsge7C1xenZ8do5J
         +C7Xt3btctf8TLbQXOkOAP5eGQ9sZS36orEqWFJXOsAucEY2xA9RYegyWH9TBXbZH1ep
         bOoQ==
X-Gm-Message-State: APt69E2HYuZNSEf6zE4/N+/bIAof7E/+h/pzi3MvizhcK+ImEYv+m1RM
        ruQ4K7lYa52xQv3OqmFVc4jgYJ5C
X-Google-Smtp-Source: AAOMgpd3c2Ko5opb86JvHoFuZSR+oM+YyEeJbcpbL64MVU/6NaAe0J5CWkRcobnWKppz+aRaljn58w==
X-Received: by 2002:a0c:aa06:: with SMTP id d6-v6mr7019853qvb.26.1530838445369;
        Thu, 05 Jul 2018 17:54:05 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:54:04 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 20/24] midx: use existing midx when writing new one
Date:   Thu,  5 Jul 2018 20:53:17 -0400
Message-Id: <20180706005321.124643-21-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
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
index e66025f066..7c00b02436 100644
--- a/midx.c
+++ b/midx.c
@@ -181,6 +181,23 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
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
@@ -280,6 +297,29 @@ int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct mu
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
 
@@ -418,6 +462,23 @@ static int midx_oid_compare(const void *_a, const void *_b)
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
@@ -443,7 +504,8 @@ static void fill_pack_entry(uint32_t pack_int_id,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
+static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
+						  struct packed_git **p,
 						  uint32_t *perm,
 						  uint32_t nr_packs,
 						  uint32_t *nr_objects)
@@ -452,8 +514,9 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
 	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
 	struct pack_midx_entry *entries_by_fanout = NULL;
 	struct pack_midx_entry *deduplicated_entries = NULL;
+	uint32_t start_pack = m ? m->num_packs : 0;
 
-	for (cur_pack = 0; cur_pack < nr_packs; cur_pack++)
+	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++)
 		total_objects += p[cur_pack]->num_objects;
 
 	/*
@@ -470,7 +533,23 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
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
@@ -666,16 +745,34 @@ int write_midx_file(const char *object_dir)
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
@@ -683,7 +780,8 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
-	entries = get_sorted_entries(packs.list, pack_perm, packs.nr, &nr_entries);
+	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
+
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
 			num_large_offsets++;
@@ -695,6 +793,9 @@ int write_midx_file(const char *object_dir)
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
+	if (packs.m)
+		close_midx(packs.m);
+
 	cur_chunk = 0;
 	num_chunks = large_offsets_needed ? 5 : 4;
 
@@ -786,6 +887,7 @@ int write_midx_file(const char *object_dir)
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
+cleanup:
 	for (i = 0; i < packs.nr; i++) {
 		if (packs.list[i]) {
 			close_pack(packs.list[i]);
@@ -797,5 +899,7 @@ int write_midx_file(const char *object_dir)
 	free(packs.list);
 	free(packs.names);
 	free(entries);
+	free(pack_perm);
+	free(midx_name);
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
2.18.0.118.gd4f65b8d14

