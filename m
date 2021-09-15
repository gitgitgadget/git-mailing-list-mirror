Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394E5C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 21:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7B9610D1
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 21:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhIOVUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhIOVUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 17:20:33 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72201C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 14:19:14 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j18so5268929ioj.8
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XSvk0ES9yuHsh84XJcir3vpH22lMtgQObu7IkXdALOU=;
        b=XBsZ1JxeUsAoQRWoYsVRyMH841RsbL0uaUlbPkHu7XINnbQxxXagqWv8mqsy1c5QbR
         zhtCwUu9Xlpo3/fQTp1NPbE2aQi9tJC09fZgEddR7oJwX1yYi02BOD5M8eezsQApzfaP
         V5y5wM/VRTaj6BWZfrv42Y0WLf3t7PkBpMit/3URlDUo46BdW23GKTKA9CrL9qabfvdd
         Co+6ukegA4JRZ6664O7XO3+gaL73Tu87vJLvtY8tnHXf3QJ19yGDi/6v4adX1PTbOVij
         3SJSEG0/qNcKyL2VDg5tfkIc5mLHMoAXSGcP+8jWOFO4ZMYlo24MeSuicv2vNkizqB8m
         Gh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSvk0ES9yuHsh84XJcir3vpH22lMtgQObu7IkXdALOU=;
        b=n9TYKWvKII9zpmkCYy7GiYkC8eM3UEL/iTWcZ1sThPgCYqFCFhaI4+ypETHqlzBwBZ
         6Q2BRVy6NcPIRcsHRGRxqqKFduPtGODTTpp899uvWAGgw9abJJ7D2IPrYg5cjvk766lo
         E1XMXElsLaBwMQw1G27PwxVFrycF4qz3+D8JMHlY6syQUxvfU96kvZFvP/DyKTTq05rM
         UvcJ+TjGGbC1yek9EeLe3NsiM66CmB1D0H34dJCaWpLXkz9RyswJWUNJGHEd1VoY4ALK
         FKeBzeLFNtslYmWgQJpZARq/g6woiTfs4ijwYWhi85V9zDMMtSoEGW+rA0ZCHCwaeJgs
         bNkg==
X-Gm-Message-State: AOAM531NN5CovILhw4eRi5lVxVIz+hZhI94Gw6Z2XlMABlCJ55u1aJ12
        j6NBtZ0fhPAEkw5GBoZAxk1ESA==
X-Google-Smtp-Source: ABdhPJxorCk5P5XI+glLwJe5xxYTBd2P04T+1exvLPT3p4GH9ReKg9ryOPT7n+4Pnd6wilTaEgbwdA==
X-Received: by 2002:a6b:b2d4:: with SMTP id b203mr1704159iof.179.1631740753839;
        Wed, 15 Sep 2021 14:19:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f14sm527017ile.82.2021.09.15.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:19:13 -0700 (PDT)
Date:   Wed, 15 Sep 2021 17:19:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        avarab@gmail.com
Subject: Re: [PATCH v2 0/8] repack: introduce `--write-midx`
Message-ID: <YUJjUIEmIFTH0+jq@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
 <xmqqmtodwsnz.fsf@gitster.g>
 <xmqqilz1wsbz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilz1wsbz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 12:29:20PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > But if it is the case, I'd step back a bit and further question if
> > "else if" is a good construct to use here.  We'd return if .m passes
> > midx_contains_pack() check, and another check based on .to_include
> > gives us an orthogonal chance to return early, so two "if" statement
> > that are independent sitting next to each other may have avoided
> > such a bug from the beginning, perhaps?
>
> OK, I went back and checked your response to a review in an earlier
> round.  If .m and .to_include cannot be turned on at the same time,
> then I think "else if" would express the intention more clearly.

Yeah, exactly. I didn't think that this would be as interesting to
reviewers as it ended up being, hence I didn't put much thought into it.

> But if we go that route, the whole "if ... else if" may deserve a
> comment that explains why .m and .to_include are fundamentally and
> inherently mutually exclusive.  In other words, is it possible if
> future enhancement may want to pass both .m and .to_include to allow
> the code path to check both conditions and return early?

The gist is that they aren't inherently exclusive, but that using an
existing MIDX (which is the result of having `.m` point at a MIDX
struct) right now blindly reuses all of the existing packs in that MIDX,
which is what to_include is trying to avoid.

We could reuse an existing MIDX with to_include by filtering down its
packs before carrying them forward, but don't currently. So that would
cause this change to produce unexpected results if we ever changed that
behavior.

I think all of this is non-obvious enough that it warrants being written
down in a comment. Here's a replacement for that first patch that should
apply without conflict. But if you'd rather have a reroll or anything
else, I'm happy to do that, too.

--- >8 ---

Subject: [PATCH] midx: expose `write_midx_file_only()` publicly

Expose a variant of the write_midx_file() function which ignores packs
that aren't included in an explicit "allow" list.

This will be used in an upcoming patch to power a new `--stdin-packs`
mode of `git multi-pack-index write` for callers that only want to
include certain packs in a MIDX (and ignore any packs which may have
happened to enter the repository independently, e.g., from pushes).

Those patches will provide test coverage for this new function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 midx.h |  5 +++++
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index 864034a6ad..61226eaa9d 100644
--- a/midx.c
+++ b/midx.c
@@ -475,6 +475,8 @@ struct write_midx_context {
 	uint32_t num_large_offsets;

 	int preferred_pack_idx;
+
+	struct string_list *to_include;
 };

 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -484,8 +486,26 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,

 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
+		/*
+		 * Note that at most one of ctx->m and ctx->to_include are set,
+		 * so we are testing midx_contains_pack() and
+		 * string_list_has_string() independently (guarded by the
+		 * appropriate NULL checks).
+		 *
+		 * We could support passing to_include while reusing an existing
+		 * MIDX, but don't currently since the reuse process drags
+		 * forward all packs from an existing MIDX (without checking
+		 * whether or not they appear in the to_include list).
+		 *
+		 * If we added support for that, these next two conditional
+		 * should be performed independently (likely checking
+		 * to_include before the existing MIDX).
+		 */
 		if (ctx->m && midx_contains_pack(ctx->m, file_name))
 			return;
+		else if (ctx->to_include &&
+			 !string_list_has_string(ctx->to_include, file_name))
+			return;

 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);

@@ -1058,6 +1078,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 }

 static int write_midx_internal(const char *object_dir,
+			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       unsigned flags)
@@ -1082,10 +1103,17 @@ static int write_midx_internal(const char *object_dir,
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

@@ -1136,10 +1164,13 @@ static int write_midx_internal(const char *object_dir,
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
@@ -1237,7 +1268,7 @@ static int write_midx_internal(const char *object_dir,

 	QSORT(ctx.info, ctx.nr, pack_info_compare);

-	if (packs_to_drop && packs_to_drop->nr) {
+	if (ctx.m && packs_to_drop && packs_to_drop->nr) {
 		int drop_index = 0;
 		int missing_drops = 0;

@@ -1380,7 +1411,17 @@ int write_midx_file(const char *object_dir,
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
@@ -1660,7 +1701,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);

 	if (packs_to_drop.nr) {
-		result = write_midx_internal(object_dir, &packs_to_drop, NULL, flags);
+		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, flags);
 		m = NULL;
 	}

@@ -1851,7 +1892,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
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

