Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A17C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E1C60EFF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhIOSZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIOSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:25:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608EFC061575
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:37 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a20so3937058ilq.7
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=waWqp9xMHF+5QtEfQCnymW8sJOuASsRvBi+ygugSuVY=;
        b=bO3D7goRE9gdjonJoRi+K/O+gbOFMMSQwbTniUbFfnAudGO87pINGHUkzHHiklYEcU
         Q0of4eH7l2w/vGAtqNFowaHwBdmURLfoBzAbRup7R6B3wokc0WHC+CUa3NVzBBzdf/z/
         qNKbQBb44cKvsRxvEVIGACgiwU7YrqtR47oABZbsRc6KRKMtykEY/3Gd5j+GH3K5L7zR
         PYnPZyJVja4+rrdlDHK5vSqJE1KPcuv058jo9nyqr8mbcS3u3el7ABAo9EEyhpShRdxL
         MLZc668yuYRRIbBphgTTt3G1afBziOAvxnEKtW5hS8xdaYlv6S1rZLQbR1KF+9lZ6kl6
         6JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=waWqp9xMHF+5QtEfQCnymW8sJOuASsRvBi+ygugSuVY=;
        b=D6WG6+2Y1F2vzVg4MipPFLyUDcEPPwRnB7g3oXJrKsIIkyCrQLiySh2QYDruI7G4kV
         U9BRO10H6/6wf0c4Xn9tuMMfN3HEHLwTfaBv3B9EagdLPtARsQtAolfatc/RRDTCsbuh
         aR64VYhlWnvZLYOD08ucX5JF6PoRU/SJzyr27Uwv2iOvoGANzNiMgJD8IsAWtoi6qmNb
         m5Hz97cuIzUMa9/FVrNxSbC2yF7KDqn9nE8q+s55Fegj8KCaNg+nEkQY2igR3JCkOL3+
         G21NJGojUVUkZurrRhtLqCS3h5KKDKznCymp0+tX3c8fGxFkqJ1AWKDHaczaqvDidEtG
         V68w==
X-Gm-Message-State: AOAM531ePO1SNy+yYF0EK6WQr9EgqvUSS3ergul672RHrMNAQVRyQS+8
        NB42osOD1gXKDvj0851KM3G2ud7pWd6kBMmQ
X-Google-Smtp-Source: ABdhPJysT3T6M9FDbcBjShKWoWfpG/xCN3kAtbv9sQJYlV/SQ2zYDHbsKkvTzJZ0nEgXIzmeYw1Hbw==
X-Received: by 2002:a92:c542:: with SMTP id a2mr1057679ilj.191.1631730276732;
        Wed, 15 Sep 2021 11:24:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z16sm363931ile.72.2021.09.15.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:36 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 1/8] midx: expose `write_midx_file_only()` publicly
Message-ID: <03c1b2c4d3d9d10a6768684e9c4d1c1cc8019844.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expose a variant of the write_midx_file() function which ignores packs
that aren't included in an explicit "allow" list.

This will be used in an upcoming patch to power a new `--stdin-packs`
mode of `git multi-pack-index write` for callers that only want to
include certain packs in a MIDX (and ignore any packs which may have
happened to enter the repository independently, e.g., from pushes).

Those patches will provide test coverage for this new function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 44 +++++++++++++++++++++++++++++++++++---------
 midx.h |  5 +++++
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index 864034a6ad..0330202fda 100644
--- a/midx.c
+++ b/midx.c
@@ -475,6 +475,8 @@ struct write_midx_context {
 	uint32_t num_large_offsets;
 
 	int preferred_pack_idx;
+
+	struct string_list *to_include;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -486,6 +488,9 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
 		if (ctx->m && midx_contains_pack(ctx->m, file_name))
 			return;
+		else if (ctx->to_include &&
+			 !string_list_has_string(ctx->to_include, file_name))
+			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
@@ -1058,6 +1063,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 }
 
 static int write_midx_internal(const char *object_dir,
+			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       unsigned flags)
@@ -1082,10 +1088,17 @@ static int write_midx_internal(const char *object_dir,
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name);
 
-	for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
-		if (!strcmp(object_dir, cur->object_dir)) {
-			ctx.m = cur;
-			break;
+	if (!packs_to_include) {
+		/*
+		 * Only reference an existing MIDX when not filtering which
+		 * packs to include, since all packs and objects are copied
+		 * blindly from an existing MIDX if one is present.
+		 */
+		for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
+			if (!strcmp(object_dir, cur->object_dir)) {
+				ctx.m = cur;
+				break;
+			}
 		}
 	}
 
@@ -1136,10 +1149,13 @@ static int write_midx_internal(const char *object_dir,
 	else
 		ctx.progress = NULL;
 
+	ctx.to_include = packs_to_include;
+
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop) {
+	if ((ctx.m && ctx.nr == ctx.m->num_packs) &&
+	    !(packs_to_include || packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
 		int bitmap_exists;
 		int want_bitmap = flags & MIDX_WRITE_BITMAP;
@@ -1237,7 +1253,7 @@ static int write_midx_internal(const char *object_dir,
 
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
-	if (packs_to_drop && packs_to_drop->nr) {
+	if (ctx.m && packs_to_drop && packs_to_drop->nr) {
 		int drop_index = 0;
 		int missing_drops = 0;
 
@@ -1380,7 +1396,17 @@ int write_midx_file(const char *object_dir,
 		    const char *preferred_pack_name,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, preferred_pack_name, flags);
+	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
+				   flags);
+}
+
+int write_midx_file_only(const char *object_dir,
+			 struct string_list *packs_to_include,
+			 const char *preferred_pack_name,
+			 unsigned flags)
+{
+	return write_midx_internal(object_dir, packs_to_include, NULL,
+				   preferred_pack_name, flags);
 }
 
 struct clear_midx_data {
@@ -1660,7 +1686,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr) {
-		result = write_midx_internal(object_dir, &packs_to_drop, NULL, flags);
+		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, flags);
 		m = NULL;
 	}
 
@@ -1851,7 +1877,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
diff --git a/midx.h b/midx.h
index aa3da557bb..80f502d39b 100644
--- a/midx.h
+++ b/midx.h
@@ -2,6 +2,7 @@
 #define MIDX_H
 
 #include "repository.h"
+#include "string-list.h"
 
 struct object_id;
 struct pack_entry;
@@ -62,6 +63,10 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
+int write_midx_file_only(const char *object_dir,
+			 struct string_list *packs_to_include,
+			 const char *preferred_pack_name,
+			 unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
-- 
2.33.0.96.g73915697e6

