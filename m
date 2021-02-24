Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91778C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A1A64E85
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhBXTNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhBXTMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:12:14 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25459C06121D
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:25 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d20so2281299qkc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLkmbjCgrPzs5QwZZHoC9S2ZRHXiY/McDvgVmb26zK0=;
        b=XqE62G6TQoGA4zIqnwMFaE6VHVfuEvym0erY8sCvYk7RH4/wDH9r8l4gbfEs3aY2BM
         wVvMruoXpa7vqusGTU4u05Gnp4gyYxw4Qz1BKBjD8+EBRvLCx1mrtFKVm6oiNnmJX27V
         1FwVzKaMIz87cb+tO+829t4CC8uYzxTekoNC/dQUFpm/NZRyX4l9ly97j94abdfb4dov
         Xws4LoeWryXYVQiaLsW6IjYLhJy8nGJ8olbJn/jCx92M6H9S3Uc/6AM5QwD0fWq2wmVK
         xz1u91+RkZujFhxfuS7MIvtNte0bO/px47geEqE+0QZTU0J80ZaZcUMLiqw3BfJl8Nw6
         vCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLkmbjCgrPzs5QwZZHoC9S2ZRHXiY/McDvgVmb26zK0=;
        b=qNrE/FtQSuCiahHnUUucAMBjH8avONIz2xYRZ/baxKb2/DDG6a6XJbH7SzDOSaTkto
         6lTYGNNuyMylj6HEYx+M5GmZ0QbKgkcmr7IkAbGYDfnwsrVLtqBslFJYYHO9ZIz2l6rX
         kmK/UeuD7Z1AsIzg93oudu4E4bMVEi6gi7uP0RLmF/Hb1B8fW3bT0Z49dc6TpXFMSizX
         n5c6/yiVXoxjemm13z82aFuaY4YvfmFb5bxsZdusdAgEQVMM0zjUgdq1BfDHUk7TXL9L
         6AHSUhZMD1BaE20DeVr5vP5y04DYSX9h8j1nufby0/PSk/YDrsX4pY6nWuDo7MbkoZTX
         IyCA==
X-Gm-Message-State: AOAM531YUTranFLLdQCcRW1IzvP2xDvyTmEcp7nKwXkLVjUt8l8HSZen
        If49xX47HFAi9RJLfHMmj1Hau/gnD4VS9zTC
X-Google-Smtp-Source: ABdhPJwWnObT/5/qp2yVpgPejFxGcmFDExgIdjc9zP5zA2dtyMgX6tae/7Q3lNJXYl+MnpHr/S+r/g==
X-Received: by 2002:a37:b4c:: with SMTP id 73mr7936025qkl.112.1614193824089;
        Wed, 24 Feb 2021 11:10:24 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id f22sm2150252qkm.54.2021.02.24.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:10:23 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:10:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 15/15] pack-revindex: write multi-pack reverse indexes
Message-ID: <01bd6a35c6c441a30a22a4c2d17e9cf53de6b148.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement the writing half of multi-pack reverse indexes. This is
nothing more than the format describe a few patches ago, with a new set
of helper functions that will be used to clear out stale .rev files
corresponding to old MIDXs.

Unfortunately, a very similar comparison function as the one implemented
recently in pack-revindex.c is reimplemented here, this time accepting a
MIDX-internal type. An effort to DRY these up would create more
indirection and overhead than is necessary, so it isn't pursued here.

Currently, there are no callers which pass the MIDX_WRITE_REV_INDEX
flag, meaning that this is all dead code. But, that won't be the case
for long, since subsequent patches will introduce the multi-pack bitmap,
which will begin passing this field.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.h |   1 +
 2 files changed, 112 insertions(+)

diff --git a/midx.c b/midx.c
index 8d7a8927b8..820276cc45 100644
--- a/midx.c
+++ b/midx.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "repository.h"
 #include "chunk-format.h"
+#include "pack.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -472,6 +473,7 @@ struct write_midx_context {
 	uint32_t entries_nr;
 
 	uint32_t *pack_perm;
+	uint32_t *pack_order;
 	unsigned large_offsets_needed:1;
 	uint32_t num_large_offsets;
 
@@ -826,6 +828,66 @@ static int write_midx_large_offsets(struct hashfile *f,
 	return 0;
 }
 
+static int midx_pack_order_cmp(const void *va, const void *vb, void *_ctx)
+{
+	struct write_midx_context *ctx = _ctx;
+
+	struct pack_midx_entry *a = &ctx->entries[*(const uint32_t *)va];
+	struct pack_midx_entry *b = &ctx->entries[*(const uint32_t *)vb];
+
+	uint32_t perm_a = ctx->pack_perm[a->pack_int_id];
+	uint32_t perm_b = ctx->pack_perm[b->pack_int_id];
+
+	/* Sort objects in the preferred pack ahead of any others. */
+	if (a->preferred > b->preferred)
+		return -1;
+	if (a->preferred < b->preferred)
+		return 1;
+
+	/* Then, order objects by which packs they appear in. */
+	if (perm_a < perm_b)
+		return -1;
+	if (perm_a > perm_b)
+		return 1;
+
+	/* Then, disambiguate by their offset within each pack. */
+	if (a->offset < b->offset)
+		return -1;
+	if (a->offset > b->offset)
+		return 1;
+
+	return 0;
+}
+
+static uint32_t *midx_pack_order(struct write_midx_context *ctx)
+{
+	uint32_t *pack_order;
+	uint32_t i;
+
+	ALLOC_ARRAY(pack_order, ctx->entries_nr);
+	for (i = 0; i < ctx->entries_nr; i++)
+		pack_order[i] = i;
+	QSORT_S(pack_order, ctx->entries_nr, midx_pack_order_cmp, ctx);
+
+	return pack_order;
+}
+
+static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
+				     struct write_midx_context *ctx)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
+
+	write_rev_file_order(buf.buf, ctx->pack_order, ctx->entries_nr,
+			     midx_hash, WRITE_REV);
+
+	strbuf_release(&buf);
+}
+
+static void clear_midx_files_ext(struct repository *r, const char *ext,
+				 unsigned char *keep_hash);
+
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -1018,6 +1080,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
+
+	if (flags & MIDX_WRITE_REV_INDEX)
+		ctx.pack_order = midx_pack_order(&ctx);
+
+	if (flags & MIDX_WRITE_REV_INDEX)
+		write_midx_reverse_index(midx_name, midx_hash, &ctx);
+	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+
 	commit_lock_file(&lk);
 
 cleanup:
@@ -1032,6 +1102,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	free(ctx.info);
 	free(ctx.entries);
 	free(ctx.pack_perm);
+	free(ctx.pack_order);
 	free(midx_name);
 	return result;
 }
@@ -1044,6 +1115,44 @@ int write_midx_file(const char *object_dir,
 				   flags);
 }
 
+struct clear_midx_data {
+	char *keep;
+	const char *ext;
+};
+
+static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
+				const char *file_name, void *_data)
+{
+	struct clear_midx_data *data = _data;
+
+	if (!(starts_with(file_name, "multi-pack-index-") &&
+	      ends_with(file_name, data->ext)))
+		return;
+	if (data->keep && !strcmp(data->keep, file_name))
+		return;
+
+	if (unlink(full_path))
+		die_errno(_("failed to remove %s"), full_path);
+}
+
+static void clear_midx_files_ext(struct repository *r, const char *ext,
+				 unsigned char *keep_hash)
+{
+	struct clear_midx_data data;
+	memset(&data, 0, sizeof(struct clear_midx_data));
+
+	if (keep_hash)
+		data.keep = xstrfmt("multi-pack-index-%s%s",
+				    hash_to_hex(keep_hash), ext);
+	data.ext = ext;
+
+	for_each_file_in_pack_dir(r->objects->odb->path,
+				  clear_midx_file_ext,
+				  &data);
+
+	free(data.keep);
+}
+
 void clear_midx_file(struct repository *r)
 {
 	char *midx = get_midx_filename(r->objects->odb->path);
@@ -1056,6 +1165,8 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx))
 		die(_("failed to clear multi-pack-index at %s"), midx);
 
+	clear_midx_files_ext(r, ".rev", NULL);
+
 	free(midx);
 }
 
diff --git a/midx.h b/midx.h
index 0a8294d2ee..8684cf0fef 100644
--- a/midx.h
+++ b/midx.h
@@ -40,6 +40,7 @@ struct multi_pack_index {
 };
 
 #define MIDX_PROGRESS     (1 << 0)
+#define MIDX_WRITE_REV_INDEX (1 << 1)
 
 char *get_midx_rev_filename(struct multi_pack_index *m);
 
-- 
2.30.0.667.g81c0cbc6fd
