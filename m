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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B805C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27563207C4
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhA0P5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbhA0PDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438FC061355
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c128so1953750wme.2
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z+FgrS4l2ZoIlJaYhz8gp4+eXO+7nQ97g0QFJMohY60=;
        b=ZWGp/UXCpuhpIAc9YIE2k9PO5zH3CHc817FYaHnQwjLwlmQYax/KSq4nizUjY3P/pR
         Z1C7XCcenFPHAyL8wYH06/9jFR2F3oDtX8yJgqzZY/KJ+DsfKnnUktGgswX5sLRZp4/M
         xfALqrF/UCHwLon40NIwSDXPV7c7mUlb+1OfutHYpgI9d4bpxbj7qEWdrR7HhG/4/THa
         cXMR0JE7AhL6CBolw5lpnqrR9OvGA9Y8SoXpEZ2uq2uxn0EkBQbHDbx8UC09hy6aYg7f
         Hu/ldbgHh/p3vAYq7I/g+POBRpH0rruUxC/nppUsr9Y6u1nuJNYgmnbxU/qaAeXqWxbV
         c3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z+FgrS4l2ZoIlJaYhz8gp4+eXO+7nQ97g0QFJMohY60=;
        b=aUhRAHep6uDk5dqQiS5emjBb5yiWCOgrjjZVYsq8pPJ/D9evk5Scdzswo3dto4aG9W
         GMYjHmt8B6tgHIPR4u/I/9IQdXlN/3HmS6zQHveKXmWTS3ii+toNlDjNoiTtNcLLBs+/
         Rzj6UyKGwe48NFn/VhEe2Dt+0m2de/c7uWeNf+7H10+QWA7apSfWJUDESKdumCceeJ8g
         nHbAX7/MNXXxFUsYHzAArR9CftSg6j5rl0/Ie8AIoiiql/bXd4VpyRmZMytI1TFGBnH0
         BrMqq79ahqpPeMX8XJR8ZhJ9oKwPD35QvYxqYne+KXbfuOJlr7h0kyFTCO9f975g7F1m
         oCZQ==
X-Gm-Message-State: AOAM530RxSNl5Q47xTBifiXfR37j5RBLkivUheeYgHtEvBfDae7FBEx3
        gJ4oibVnlxFqbe6Za+KaK5RTFpsEHHk=
X-Google-Smtp-Source: ABdhPJzMcguITWly7spm2QfHEK5zb5kqXXtWj5vboYdDg1Bcy4aFbM8YSR4UuWiJFAGip4UwYv0Now==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr4665638wmc.39.1611759725156;
        Wed, 27 Jan 2021 07:02:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g187sm2888415wmf.1.2021.01.27.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:04 -0800 (PST)
Message-Id: <30ad423997b71645c928b1b6f3cbec71e712d31c.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:45 +0000
Subject: [PATCH v2 06/17] midx: add entries to write_midx_context
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
index 88452b04433..4520ef82b91 100644
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
+	struct write_midx_context *ctx = data;
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
+	struct write_midx_context *ctx = data;
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

