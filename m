Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED9C433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B6560F46
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhIKDdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 23:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhIKDdm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 23:33:42 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11666C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z1so4882480ioh.7
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lHuYxpO7NYRr+JRkvTNdCiDMSBzMJzQdHVXX41gdwh4=;
        b=pFukAJHF3Rn6nYwAOYbQWIebi7AiuD6tZJRCNy6bsdGkllscMC7Ebi0W6n63PfKPbt
         9UHIqblzDg9wipRD84oF8GuLHC2Jmwqn0mu/ZYlxgSqN78SWe2GOZRm09f8K+4UjY/jp
         dyBqymuO4Or8mgvPvAngu8JcuDKnoIRNIWYrtDBkYL1p+sT2R5MqwSI8jfLv6h1yBo8Q
         /Gy1cTBfJ8Atw70juHQRw56VB+4jWhLLxFaWpDyB6IOSL+452RnkTCoZsZzLxf9IMc6x
         G2OJU7MIZoE3ckVJi5+bfCzg0BbPtQT+zMG6pPYkZt5D8lRARp+oF5ZtENJCworzUvWa
         I5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHuYxpO7NYRr+JRkvTNdCiDMSBzMJzQdHVXX41gdwh4=;
        b=kyYjuA71eJZPWq3kHaDCxNSr6f4HMm+EUlrym/9RitnT5NMC0xo6BF1/YnEQTN8KM1
         +U9oyMUeABEJJG3+4Q1QKnGZYpUkCzr19YZMX2gWKGfWlTh3CIKBH3pUxresfJrPKlnz
         IjwP1CLRMNgBD34QFExQkOpdvmwUZqaeD9PTNAwXbSmtrgTUhwu6r0Er05nxyhbbhKPh
         6wuffHqKetxySR21DWKasXYYGNrLfW81vBtaCi87hkuvDZbFmSt8g9lsDUa4Nk/PHxM9
         OcccV4Pu6kjy2KC7oVAFsyXyaGJgk+6CEWu0Re0p3DI1kVc7qhy0TWsq/cVRNgoOffoW
         lVLQ==
X-Gm-Message-State: AOAM531JZcIYM8MCmaVIrDv5JgC9MHMAJcJxDG96hsm6S6N6ak8vuIBk
        8FV9+dQHs+qsDOypXrKgYcrUl5GELmdHENbH
X-Google-Smtp-Source: ABdhPJyyeMPdALWKiG5DCx4BnwYeG816l8qCVyFprfvb95Xu1PPqqZYH1aezez7ZdmGUBrpXlR9TJg==
X-Received: by 2002:a02:caaf:: with SMTP id e15mr800087jap.11.1631331150259;
        Fri, 10 Sep 2021 20:32:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o15sm307185ilj.69.2021.09.10.20.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:32:30 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:32:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/8] midx: expose 'write_midx_file_only()' publicly
Message-ID: <4afa03b972a1885c60fbf3716f22a7ab58056383.1631331139.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631331139.git.me@ttaylorr.com>
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
 midx.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
 midx.h |  2 ++
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/midx.c b/midx.c
index 864034a6ad..29d1d107b3 100644
--- a/midx.c
+++ b/midx.c
@@ -475,6 +475,8 @@ struct write_midx_context {
 	uint32_t num_large_offsets;
 
 	int preferred_pack_idx;
+
+	struct string_list *to_include;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -484,8 +486,13 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
-		if (ctx->m && midx_contains_pack(ctx->m, file_name))
-			return;
+		if (ctx->m) {
+			if (midx_contains_pack(ctx->m, file_name))
+				return;
+		} else if (ctx->to_include) {
+			if (!string_list_has_string(ctx->to_include, file_name))
+				return;
+		}
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
@@ -1058,6 +1065,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 }
 
 static int write_midx_internal(const char *object_dir,
+			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       unsigned flags)
@@ -1082,10 +1090,17 @@ static int write_midx_internal(const char *object_dir,
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
 
@@ -1136,10 +1151,13 @@ static int write_midx_internal(const char *object_dir,
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
@@ -1237,7 +1255,7 @@ static int write_midx_internal(const char *object_dir,
 
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
-	if (packs_to_drop && packs_to_drop->nr) {
+	if (ctx.m && packs_to_drop && packs_to_drop->nr) {
 		int drop_index = 0;
 		int missing_drops = 0;
 
@@ -1380,7 +1398,17 @@ int write_midx_file(const char *object_dir,
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
@@ -1660,7 +1688,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr) {
-		result = write_midx_internal(object_dir, &packs_to_drop, NULL, flags);
+		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, flags);
 		m = NULL;
 	}
 
@@ -1851,7 +1879,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
diff --git a/midx.h b/midx.h
index aa3da557bb..aefa371c90 100644
--- a/midx.h
+++ b/midx.h
@@ -2,6 +2,7 @@
 #define MIDX_H
 
 #include "repository.h"
+#include "string-list.h"
 
 struct object_id;
 struct pack_entry;
@@ -62,6 +63,7 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
+int write_midx_file_only(const char *object_dir, struct string_list *packs_to_include, const char *preferred_pack_name, unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
-- 
2.33.0.96.g73915697e6

