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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C780C0018C
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A535207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501863AbgLCQRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501860AbgLCQRn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:43 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234BFC061A56
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so3226896wmc.5
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yFAN4RKKlPaLrUGEWuSO/NjeD0s+//v0DUSw0DUyvJw=;
        b=DPQHRUpC3rLFICEHd72yW5Q1rfocUjHOnCuH+8ftVn72St4/4EYrMhxOvo7aS5R+gM
         g17y8n8TNC2FoAFpIZQ1owWsaVbvsWvYzLv/jTnCC2D662y/9v+TAud0bAxhoeTJqD6N
         AGOLemoOab+lKfM2yoB3gweXRqhwkSEs3c5bhkMWBpaGtLPLVEF1CqiTtTZKqN66skEz
         65C8Qx/nA0Xhx2mGsmtOax8YUJVEsPrh9o70kSGXEcp3efosA9zpxz+pE+pCjVPbkKR9
         XMzpuVzgbAVUIU0RV5bTVzkhKetyBwcWDwI+EHL1Lz2PAyQGamXJfPoL0D8Mqv+lPFSi
         gDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yFAN4RKKlPaLrUGEWuSO/NjeD0s+//v0DUSw0DUyvJw=;
        b=cNKqbH1HPJhuhFmbp09LFY84mcsjW9hX+musq3iI4v9lEy8sP5F8P78ytliGhnjlPw
         ASbF0gECcV+kvGe70CKQrNvYXSFXp1hdOWyGxW7IYswEUdEY1FXaVXbAc8pnI5G731oB
         p7jTB7jBJmPvuEphemINeZEQg7go7iCs/RHSr7ucvEOJOQXxIM7gje69vvcrkvam2rtO
         qBhBsu/5sk1MGbqLs4xX6r/rbU/58YqgEHL7n8TOweTyjhmNZlc7m8MHmnMb4NKMZkCX
         hrLn0GknuWoLJkglK0UfsbYDWbY3AYo+ljS7m2kPW0woROL4C2BSrH5wrvcfaVigbNo+
         4XvA==
X-Gm-Message-State: AOAM530K2ZMYoPL+XFPKuylXispNGa89pM9l8aJeyXU8nu/QzMzPUtm/
        79fcmgkNpsu5ITbPuSLcov6xnsXiPtw=
X-Google-Smtp-Source: ABdhPJwEmV66GQfKcRWaDG/hca4ZriPD/BkL20U0OWMMkIvHVL6F5wjBQsRI2BCDs1maBn7JAGk8Vw==
X-Received: by 2002:a1c:17:: with SMTP id 23mr3141346wma.35.1607012221617;
        Thu, 03 Dec 2020 08:17:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm2065290wmf.25.2020.12.03.08.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:01 -0800 (PST)
Message-Id: <491667de2baef422e801df1e2c7d3173462a96ff.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:44 +0000
Subject: [PATCH 05/15] midx: add entries to write_midx_context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an effort to align write_midx_internal() with the chunk-format API,
continue to group necessary data into "struct write_midx_context". This
change collects the "struct pack_midx_entry *entries" list and its count
into the context.

Update write_midx_oid_fanout() and write_midx_oid_lookup() to take the
context directly, as these are easy conversions with this new data.

Only the callers of write_midx_object_offsets() and
write_midx_large_offsets() are updated here, since additional data in
the context before those methods can match chunk_write_fn.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/midx.c b/midx.c
index 6ab655ddda..2af4452165 100644
--- a/midx.c
+++ b/midx.c
@@ -458,6 +458,9 @@ struct write_midx_context {
 	struct multi_pack_index *m;
 	struct progress *progress;
 	unsigned pack_paths_checked;
+
+	struct pack_midx_entry *entries;
+	uint32_t entries_nr;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -678,11 +681,11 @@ static size_t write_midx_pack_names(struct hashfile *f, void *data)
 }
 
 static size_t write_midx_oid_fanout(struct hashfile *f,
-				    struct pack_midx_entry *objects,
-				    uint32_t nr_objects)
+				    void *data)
 {
-	struct pack_midx_entry *list = objects;
-	struct pack_midx_entry *last = objects + nr_objects;
+	struct write_midx_context *ctx = (struct write_midx_context *)data;
+	struct pack_midx_entry *list = ctx->entries;
+	struct pack_midx_entry *last = ctx->entries + ctx->entries_nr;
 	uint32_t count = 0;
 	uint32_t i;
 
@@ -706,18 +709,19 @@ static size_t write_midx_oid_fanout(struct hashfile *f,
 	return MIDX_CHUNK_FANOUT_SIZE;
 }
 
-static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
-				    struct pack_midx_entry *objects,
-				    uint32_t nr_objects)
+static size_t write_midx_oid_lookup(struct hashfile *f,
+				    void *data)
 {
-	struct pack_midx_entry *list = objects;
+	struct write_midx_context *ctx = (struct write_midx_context *)data;
+	unsigned char hash_len = the_hash_algo->rawsz;
+	struct pack_midx_entry *list = ctx->entries;
 	uint32_t i;
 	size_t written = 0;
 
-	for (i = 0; i < nr_objects; i++) {
+	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
 
-		if (i < nr_objects - 1) {
+		if (i < ctx->entries_nr - 1) {
 			struct pack_midx_entry *next = list;
 			if (oidcmp(&obj->oid, &next->oid) >= 0)
 				BUG("OIDs not in order: %s >= %s",
@@ -805,8 +809,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
-	uint32_t nr_entries, num_large_offsets = 0;
-	struct pack_midx_entry *entries = NULL;
+	uint32_t num_large_offsets = 0;
 	struct progress *progress = NULL;
 	int large_offsets_needed = 0;
 	int pack_name_concat_len = 0;
@@ -852,12 +855,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
 		goto cleanup;
 
-	entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &nr_entries);
+	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr);
 
-	for (i = 0; i < nr_entries; i++) {
-		if (entries[i].offset > 0x7fffffff)
+	for (i = 0; i < ctx.entries_nr; i++) {
+		if (ctx.entries[i].offset > 0x7fffffff)
 			num_large_offsets++;
-		if (entries[i].offset > 0xffffffff)
+		if (ctx.entries[i].offset > 0xffffffff)
 			large_offsets_needed = 1;
 	}
 
@@ -947,10 +950,10 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OBJECTOFFSETS;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * the_hash_algo->rawsz;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * the_hash_algo->rawsz;
 
 	cur_chunk++;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_CHUNK_OFFSET_WIDTH;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
 	if (large_offsets_needed) {
 		chunk_ids[cur_chunk] = MIDX_CHUNKID_LARGEOFFSETS;
 
@@ -993,19 +996,19 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				break;
 
 			case MIDX_CHUNKID_OIDFANOUT:
-				written += write_midx_oid_fanout(f, entries, nr_entries);
+				written += write_midx_oid_fanout(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_OIDLOOKUP:
-				written += write_midx_oid_lookup(f, the_hash_algo->rawsz, entries, nr_entries);
+				written += write_midx_oid_lookup(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_OBJECTOFFSETS:
-				written += write_midx_object_offsets(f, large_offsets_needed, pack_perm, entries, nr_entries);
+				written += write_midx_object_offsets(f, large_offsets_needed, pack_perm, ctx.entries, ctx.entries_nr);
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
-				written += write_midx_large_offsets(f, num_large_offsets, entries, nr_entries);
+				written += write_midx_large_offsets(f, num_large_offsets, ctx.entries, ctx.entries_nr);
 				break;
 
 			default:
@@ -1035,7 +1038,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	}
 
 	free(ctx.info);
-	free(entries);
+	free(ctx.entries);
 	free(pack_perm);
 	free(midx_name);
 	return result;
-- 
gitgitgadget

