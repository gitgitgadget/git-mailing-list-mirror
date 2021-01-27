Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A992BC433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D3020825
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhA0P6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhA0PCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B3CC061354
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y187so1946904wmd.3
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u102xFMKu2YfUtpFo0uIws1L5jfUcZTWZdjsCY1+jas=;
        b=IuNxWJvhQWz6YlbhT7ruLDbAauIhIcQfDZmXIN+96acao6fCWUmpWaQUu58uMdJfub
         blHExg3sP3UnyvQjHao82Jg/jVJA3bA4UNfmo0h4/VN3ha74vgOBek4Wzshr1M/ZVpzn
         AhXiyMdNLXo9hQlsh4dB29LkjO3fsiegfiPzqybI7bqBKPslISlmbtXBH1ks/HuImCam
         uJdvcyY9NkZ4SCDczeCIZ95PcZr101TKUoOKpdQjEG+h4WhNayQZQSKJ6nvAwPvd6a3D
         CSl6khy3rWDpNmviPPxScV8C7zHVer2XoCJ0J9+1tmxyeIu5a4yt1QRCie0uqVvWr/HI
         esiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u102xFMKu2YfUtpFo0uIws1L5jfUcZTWZdjsCY1+jas=;
        b=QZ+qvZxsuNnBTPHvyKnEy09e0dUJc8khAaSoonEL75ftzR0D1L2hkUyc0w/JUTco1f
         2eEJISEpTez0tWmq/h8mSTA1M0ykil8TZbuedWAk2ZlMd4w8NL3UhJx5Zzj6yM/IVgN2
         bZ2xAV8DgLP1qVfINIIKCO4vDdMTboh0coXFc3/li9gMSrHmSzFKRKjcypprRz+675iy
         OSmDR3fVK4DxAHQcuTa4pFDOM9z6CyKufy/zuWYOgsybcBJcntHRW99cKn+gmkpqMiuc
         yXtDXccNGuiEcTbZSw80hRVK/za0AnSRBGmmHpHceUQxOm3q0P/EFPZE30VnUewICO1N
         PNyA==
X-Gm-Message-State: AOAM5325h9UngAPEjuekjWclRNB2WJqP6MVXedX+A1h60hFTWs4pvpBD
        ur7yZEO9w4ZYK4zH2hDh8GyRDdAEZHg=
X-Google-Smtp-Source: ABdhPJzqIn+ExDITvSOYEljbPt3aD+S5Lf/hl6K6bQ4egsdfTKMbDveqowhSu1Fvwou7CdPr2rlZvw==
X-Received: by 2002:a7b:c41a:: with SMTP id k26mr4600721wmi.1.1611759722869;
        Wed, 27 Jan 2021 07:02:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm3258800wrq.29.2021.01.27.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:02 -0800 (PST)
Message-Id: <0cac7890bed7774296e9984f9891c3e765a9a11d.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:43 +0000
Subject: [PATCH v2 04/17] midx: rename pack_info to write_midx_context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an effort to streamline our chunk-based file formats, align some of
the code structure in write_midx_internal() to be similar to the
patterns in write_commit_graph_file().

Specifically, let's create a "struct write_midx_context" that can be
used as a data parameter to abstract function types.

This change only renames "struct pack_info" to "struct
write_midx_context" and the names of instances from "packs" to "ctx". In
future changes, we will expand the data inside "struct
write_midx_context" and align our chunk-writing method with the
chunk-format API.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 130 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/midx.c b/midx.c
index 79c282b070d..561f65a63a5 100644
--- a/midx.c
+++ b/midx.c
@@ -451,7 +451,7 @@ static int pack_info_compare(const void *_a, const void *_b)
 	return strcmp(a->pack_name, b->pack_name);
 }
 
-struct pack_list {
+struct write_midx_context {
 	struct pack_info *info;
 	uint32_t nr;
 	uint32_t alloc;
@@ -463,37 +463,37 @@ struct pack_list {
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			     const char *file_name, void *data)
 {
-	struct pack_list *packs = (struct pack_list *)data;
+	struct write_midx_context *ctx = data;
 
 	if (ends_with(file_name, ".idx")) {
-		display_progress(packs->progress, ++packs->pack_paths_checked);
-		if (packs->m && midx_contains_pack(packs->m, file_name))
+		display_progress(ctx->progress, ++ctx->pack_paths_checked);
+		if (ctx->m && midx_contains_pack(ctx->m, file_name))
 			return;
 
-		ALLOC_GROW(packs->info, packs->nr + 1, packs->alloc);
+		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
-		packs->info[packs->nr].p = add_packed_git(full_path,
-							  full_path_len,
-							  0);
+		ctx->info[ctx->nr].p = add_packed_git(full_path,
+						      full_path_len,
+						      0);
 
-		if (!packs->info[packs->nr].p) {
+		if (!ctx->info[ctx->nr].p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
 			return;
 		}
 
-		if (open_pack_index(packs->info[packs->nr].p)) {
+		if (open_pack_index(ctx->info[ctx->nr].p)) {
 			warning(_("failed to open pack-index '%s'"),
 				full_path);
-			close_pack(packs->info[packs->nr].p);
-			FREE_AND_NULL(packs->info[packs->nr].p);
+			close_pack(ctx->info[ctx->nr].p);
+			FREE_AND_NULL(ctx->info[ctx->nr].p);
 			return;
 		}
 
-		packs->info[packs->nr].pack_name = xstrdup(file_name);
-		packs->info[packs->nr].orig_pack_int_id = packs->nr;
-		packs->info[packs->nr].expired = 0;
-		packs->nr++;
+		ctx->info[ctx->nr].pack_name = xstrdup(file_name);
+		ctx->info[ctx->nr].orig_pack_int_id = ctx->nr;
+		ctx->info[ctx->nr].expired = 0;
+		ctx->nr++;
 	}
 }
 
@@ -801,7 +801,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
-	struct pack_list packs;
+	struct write_midx_context ctx = { 0 };
 	uint32_t *pack_perm = NULL;
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
@@ -820,40 +820,40 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			  midx_name);
 
 	if (m)
-		packs.m = m;
+		ctx.m = m;
 	else
-		packs.m = load_multi_pack_index(object_dir, 1);
-
-	packs.nr = 0;
-	packs.alloc = packs.m ? packs.m->num_packs : 16;
-	packs.info = NULL;
-	ALLOC_ARRAY(packs.info, packs.alloc);
-
-	if (packs.m) {
-		for (i = 0; i < packs.m->num_packs; i++) {
-			ALLOC_GROW(packs.info, packs.nr + 1, packs.alloc);
-
-			packs.info[packs.nr].orig_pack_int_id = i;
-			packs.info[packs.nr].pack_name = xstrdup(packs.m->pack_names[i]);
-			packs.info[packs.nr].p = NULL;
-			packs.info[packs.nr].expired = 0;
-			packs.nr++;
+		ctx.m = load_multi_pack_index(object_dir, 1);
+
+	ctx.nr = 0;
+	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
+	ctx.info = NULL;
+	ALLOC_ARRAY(ctx.info, ctx.alloc);
+
+	if (ctx.m) {
+		for (i = 0; i < ctx.m->num_packs; i++) {
+			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
+
+			ctx.info[ctx.nr].orig_pack_int_id = i;
+			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
+			ctx.info[ctx.nr].p = NULL;
+			ctx.info[ctx.nr].expired = 0;
+			ctx.nr++;
 		}
 	}
 
-	packs.pack_paths_checked = 0;
+	ctx.pack_paths_checked = 0;
 	if (flags & MIDX_PROGRESS)
-		packs.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
+		ctx.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
 	else
-		packs.progress = NULL;
+		ctx.progress = NULL;
 
-	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
-	stop_progress(&packs.progress);
+	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
+	stop_progress(&ctx.progress);
 
-	if (packs.m && packs.nr == packs.m->num_packs && !packs_to_drop)
+	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
 		goto cleanup;
 
-	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
+	entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &nr_entries);
 
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
@@ -862,19 +862,19 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			large_offsets_needed = 1;
 	}
 
-	QSORT(packs.info, packs.nr, pack_info_compare);
+	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
 	if (packs_to_drop && packs_to_drop->nr) {
 		int drop_index = 0;
 		int missing_drops = 0;
 
-		for (i = 0; i < packs.nr && drop_index < packs_to_drop->nr; i++) {
-			int cmp = strcmp(packs.info[i].pack_name,
+		for (i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
+			int cmp = strcmp(ctx.info[i].pack_name,
 					 packs_to_drop->items[drop_index].string);
 
 			if (!cmp) {
 				drop_index++;
-				packs.info[i].expired = 1;
+				ctx.info[i].expired = 1;
 			} else if (cmp > 0) {
 				error(_("did not see pack-file %s to drop"),
 				      packs_to_drop->items[drop_index].string);
@@ -882,7 +882,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				missing_drops++;
 				i--;
 			} else {
-				packs.info[i].expired = 0;
+				ctx.info[i].expired = 0;
 			}
 		}
 
@@ -898,19 +898,19 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	 *
 	 * pack_perm[old_id] = new_id
 	 */
-	ALLOC_ARRAY(pack_perm, packs.nr);
-	for (i = 0; i < packs.nr; i++) {
-		if (packs.info[i].expired) {
+	ALLOC_ARRAY(pack_perm, ctx.nr);
+	for (i = 0; i < ctx.nr; i++) {
+		if (ctx.info[i].expired) {
 			dropped_packs++;
-			pack_perm[packs.info[i].orig_pack_int_id] = PACK_EXPIRED;
+			pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
 		} else {
-			pack_perm[packs.info[i].orig_pack_int_id] = i - dropped_packs;
+			pack_perm[ctx.info[i].orig_pack_int_id] = i - dropped_packs;
 		}
 	}
 
-	for (i = 0; i < packs.nr; i++) {
-		if (!packs.info[i].expired)
-			pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
+	for (i = 0; i < ctx.nr; i++) {
+		if (!ctx.info[i].expired)
+			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
 	}
 
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
@@ -921,19 +921,19 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
-	if (packs.m)
-		close_midx(packs.m);
+	if (ctx.m)
+		close_midx(ctx.m);
 
 	cur_chunk = 0;
 	num_chunks = large_offsets_needed ? 5 : 4;
 
-	if (packs.nr - dropped_packs == 0) {
+	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
 		result = 1;
 		goto cleanup;
 	}
 
-	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
+	written = write_midx_header(f, num_chunks, ctx.nr - dropped_packs);
 
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
@@ -990,7 +990,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 		switch (chunk_ids[i]) {
 			case MIDX_CHUNKID_PACKNAMES:
-				written += write_midx_pack_names(f, packs.info, packs.nr);
+				written += write_midx_pack_names(f, ctx.info, ctx.nr);
 				break;
 
 			case MIDX_CHUNKID_OIDFANOUT:
@@ -1027,15 +1027,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	commit_lock_file(&lk);
 
 cleanup:
-	for (i = 0; i < packs.nr; i++) {
-		if (packs.info[i].p) {
-			close_pack(packs.info[i].p);
-			free(packs.info[i].p);
+	for (i = 0; i < ctx.nr; i++) {
+		if (ctx.info[i].p) {
+			close_pack(ctx.info[i].p);
+			free(ctx.info[i].p);
 		}
-		free(packs.info[i].pack_name);
+		free(ctx.info[i].pack_name);
 	}
 
-	free(packs.info);
+	free(ctx.info);
 	free(entries);
 	free(pack_perm);
 	free(midx_name);
-- 
gitgitgadget

