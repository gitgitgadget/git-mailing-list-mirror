Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6191CC4332B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408A965002
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCKRF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCKRFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:41 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80902C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:41 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id a9so21310129qkn.13
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zupcjOX+OjuhNAqQZ1wmKITSMCyqlzkRPDe7kRUGDz8=;
        b=c8o/xYfGrTIIe4Zih7o/15UYVm77toPrqLb7JVH970jFu3ou7Y0XNxI0N7rV0YA8ii
         XXitxq89/NskcIb1maXY3rXx0ra9YhEq0Xh9VGJ9RgIxBMO7MNsM7mfkGDPpKyoG+fmH
         hAssj02HAFzp/x+tB5gRh0M+sX8uF6xLPiZ+PVH5Pd/dOULnAT08FEVo6PAdzRkKWmoF
         tHfUWXUZbqQlCX884BezJo6uGv/x6q0cqYrDM1otA6xtmYFYp511JZDEuNhh7lHDptqr
         v0Y2w2jmoKsUl4EzQxYcNaOsmnsIa+LxRaoLCwwtcnMnC310CIdoZiuVx9clYifXuVs6
         JfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zupcjOX+OjuhNAqQZ1wmKITSMCyqlzkRPDe7kRUGDz8=;
        b=hm/LZSz9Yzdkwzn9iTc6SHgs9uXVbaqRDIqLFyLK73j7kngfzkcpPvo7fpQxaoTeS/
         ja5AXLW/VV0CE+sAGJw1mjhF398cAPN564Oc+JlHPbtjA1k11JGobLre0F2Rl7AR55Rp
         +neakdg2NUN6xYerZbQpL1tV43e9I3RrU4wy+nsGJNnO9vnKDLAKWq5np4Ewo2Fb2Vcu
         FRyJJrFg65WRBYjokZ5knMy1PdpimYbaFBX8lFsxsX+593cWjjlV0hhhgrwPieL78V+c
         5Fvj81tNrJQrNW6p5R26L9yWRKmlgw13SMw4FixmIFURoPzBSL+M0OPcu/eB18slrEop
         CZ2A==
X-Gm-Message-State: AOAM533ndm3l7r+DLf/548BQothNYsYBJk5WOOoJDvM807YgPZ7kI377
        JayAezhfzgzsCJkJUTSuA+NtfVKrM4jQhYZK
X-Google-Smtp-Source: ABdhPJx//h5X0BW42+68fF739KeENPsI/lnCb5pa8KAWivbcl1/3rVRksEymsH3qk1fSKKVSj6u/Qg==
X-Received: by 2002:a37:9d57:: with SMTP id g84mr7982786qke.71.1615482340407;
        Thu, 11 Mar 2021 09:05:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id w197sm2278253qkb.89.2021.03.11.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:40 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 15/16] pack-revindex: write multi-pack reverse indexes
Message-ID: <fa3acb5d5af3aab46dd2a9703e4da03928625346.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
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

(In midx.c:write_midx_internal(), the two adjacent if statements share a
conditional, but are written separately since the first one will
eventually also handle the MIDX_WRITE_BITMAP flag, which does not yet
exist.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.h |   1 +
 2 files changed, 116 insertions(+)

diff --git a/midx.c b/midx.c
index 55f4567fca..eea9574d92 100644
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
 
@@ -826,6 +828,70 @@ static int write_midx_large_offsets(struct hashfile *f,
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
+	const char *tmp_file;
+
+	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
+
+	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
+					midx_hash, WRITE_REV);
+
+	if (finalize_object_file(tmp_file, buf.buf))
+		die(_("cannot store reverse index file"));
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
@@ -1011,6 +1077,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
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
@@ -1025,6 +1099,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	free(ctx.info);
 	free(ctx.entries);
 	free(ctx.pack_perm);
+	free(ctx.pack_order);
 	free(midx_name);
 	return result;
 }
@@ -1037,6 +1112,44 @@ int write_midx_file(const char *object_dir,
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
@@ -1049,6 +1162,8 @@ void clear_midx_file(struct repository *r)
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

