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
	by dcvr.yhbt.net (Postfix) with ESMTP id B30871F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932893AbeFGOE3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:29 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33279 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeFGOEG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:06 -0400
Received: by mail-qt0-f196.google.com with SMTP id l10-v6so4732859qtj.0
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fvVrI3cIGtbfq3jVWP6dsYlNAr1iR/vAY9idtNjqzOA=;
        b=EnWLYam1d+UvM/zaAVjvmggy2IBtnHZ81RqpKTuFFyE4xbut0qdcdCeHfgngkgwOoT
         ZRhKLYevcasT5IM0Er9kSFg9LLIdlQrcyeRWUyIftVn/XOiahsUldvva5hkSQj6EMHBI
         4QXSm1YnOScwloYRpbzQ5O/9yaPR8QOQ2Wam673wvVye6IR25GCy8HeXXwtaGnOK8XsC
         KU5dJFBz2F2bURWee+0n15vqTzWVUhPfdUlBsOUzVhkQg2j74YaRHRQyBnfGZDIkCTmd
         rNnhkfW/iG5CUY15OCnfnlyRzyDetXvvj1rx7dLCok/nu8tF02fxvc0/9ESKnh7W2hWX
         naKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fvVrI3cIGtbfq3jVWP6dsYlNAr1iR/vAY9idtNjqzOA=;
        b=uTgqRoWPInTONYdZQZ5sZ5mx5tf+wCDXf5onfofZTI6IgrGju3pjWtQCgsnxv/sBk0
         ym7sAZM0B8F+vKc4v7okBiPuFM9l5mwUmL48Ak6Se8xUlrYefjRh7pXsS62CoUe7Tgn/
         dR4ntGOQsXnpjyvyV/a9AXTK0PUcARomW9cga2QXHwnJMzyYS03FOy9/rG/H7iNv1jU0
         BkhpsWmadHbhAtfrPu93mYg1e/I3eul5Mc9QRs63GU9VfRhQr/pEYqHh15VLGVHO0ajK
         3iROmeM+nL00c8ETSkyGzObzoViOAa3KhFA8xaOad4epyv7q+ZqBxaGnIO7BvCYjMkyX
         EpoA==
X-Gm-Message-State: APt69E0Jfs48JScUaEJpbjkL0CpNRmBHLl2LP5e3g87420Ld/v0VFAHZ
        0slGIFWplXmPDnrLQCtJDrpw62dl
X-Google-Smtp-Source: ADUXVKKPkCRRd8LhT0AIJxU+1bJAyFEJN+PZxC5OE5BJSfCBCbePVPvJIkj9Y7yXZVC6LjUYgSqsKw==
X-Received: by 2002:a0c:e043:: with SMTP id y3-v6mr1772567qvk.148.1528380245917;
        Thu, 07 Jun 2018 07:04:05 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:05 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 19/23] midx: use existing midx when writing new one
Date:   Thu,  7 Jun 2018 10:03:34 -0400
Message-Id: <20180607140338.32440-20-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index 25d8142c2a..388d79b7d9 100644
--- a/midx.c
+++ b/midx.c
@@ -389,6 +389,23 @@ static int midx_oid_compare(const void *_a, const void *_b)
 	return a->pack_int_id - b->pack_int_id;
 }
 
+static int nth_midxed_pack_midx_entry(struct midxed_git *m,
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
@@ -414,7 +431,8 @@ static void fill_pack_entry(uint32_t pack_int_id,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
+static struct pack_midx_entry *get_sorted_entries(struct midxed_git *m,
+						  struct packed_git **p,
 						  uint32_t *perm,
 						  uint32_t nr_packs,
 						  uint32_t *nr_objects)
@@ -423,8 +441,9 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
 	uint32_t nr_fanout, alloc_fanout, alloc_objects, total_objects = 0;
 	struct pack_midx_entry *entries_by_fanout = NULL;
 	struct pack_midx_entry *deduplicated_entries = NULL;
+	uint32_t start_pack = m ? m->num_packs : 0;
 
-	for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
+	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
 		if (open_pack_index(p[cur_pack]))
 			continue;
 
@@ -445,7 +464,23 @@ static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		nr_fanout = 0;
 
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
@@ -654,6 +689,7 @@ int write_midx_file(const char *object_dir)
 	struct pack_midx_entry *entries;
 	uint32_t nr_entries, num_large_offsets = 0;
 	int large_offsets_needed = 0;
+	struct midxed_git *m = NULL;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -662,6 +698,8 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
+	m = load_midxed_git(object_dir);
+
 	strbuf_addf(&pack_dir, "%s/pack", object_dir);
 	dir = opendir(pack_dir.buf);
 
@@ -676,11 +714,27 @@ int write_midx_file(const char *object_dir)
 	pack_dir_len = pack_dir.len;
 	ALLOC_ARRAY(packs, alloc_packs);
 	ALLOC_ARRAY(pack_names, alloc_pack_names);
+
+	if (m) {
+		for (i = 0; i < m->num_packs; i++) {
+			ALLOC_GROW(packs, nr_packs + 1, alloc_packs);
+			ALLOC_GROW(pack_names, nr_packs + 1, alloc_pack_names);
+
+			packs[nr_packs] = NULL;
+			pack_names[nr_packs] = xstrdup(m->pack_names[i]);
+			pack_name_concat_len += strlen(pack_names[nr_packs]) + 1;
+			nr_packs++;
+		}
+	}
+
 	while ((de = readdir(dir)) != NULL) {
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
 		if (ends_with(de->d_name, ".idx")) {
+			if (m && midx_contains_pack(m, de->d_name))
+				continue;
+
 			ALLOC_GROW(packs, nr_packs + 1, alloc_packs);
 			ALLOC_GROW(pack_names, nr_packs + 1, alloc_pack_names);
 
@@ -705,6 +759,9 @@ int write_midx_file(const char *object_dir)
 	closedir(dir);
 	strbuf_release(&pack_dir);
 
+	if (m && nr_packs == m->num_packs)
+		goto cleanup;
+
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
@@ -712,7 +769,7 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(pack_perm, nr_packs);
 	sort_packs_by_name(pack_names, nr_packs, pack_perm);
 
-	entries = get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);
+	entries = get_sorted_entries(m, packs, pack_perm, nr_packs, &nr_entries);
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
 			num_large_offsets++;
@@ -823,7 +880,8 @@ int write_midx_file(const char *object_dir)
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
-	for (i = 0; i < nr_packs; i++) {
+cleanup:
+	for (i = m ? m->num_packs : 0; i < nr_packs; i++) {
 		close_pack(packs[i]);
 		FREE_AND_NULL(packs[i]);
 	}
-- 
2.18.0.rc1

