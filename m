Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E815C4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490A760F9C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhG0VVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhG0VVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:19 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F9C061A18
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 10so625792ill.10
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ESiovRhC+obCzPbDYUVPyG7soegof7XIaVCLMWV+sCw=;
        b=fZZIgg3l1A1+K4pnv8BebF3eygid3ZajKYA1YF/2KZihPf38eOJPZH3pxchVT2+3rd
         fg77eflbA4T0vCKWGGcPfjIHTEyN2LcTj1RtjJpyysU+iCfERBYjD2V72xcZsQ4VQp7t
         xsHeOEyhOS04sgv3NljOjS29Aby4PtAXdaXXLuHJECaQ3WhkW6sB2MXHOO7AKfd6ZoJP
         3xElotK/9g8pEwgj7cwFwXVnn/WkyfnjrxyUx7qOoEI2cjl6JfQQyoDscYKX3+4/xVut
         MW5c/MA4Y9PxzzvVIUQhlw9Pe71OBARVDxUg9VG0xz8VLIPAueB9/VuhpoJWIx/3lOGp
         h1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ESiovRhC+obCzPbDYUVPyG7soegof7XIaVCLMWV+sCw=;
        b=UaCWpx3G5dPYBPjWao057N1crwBOUVNO+N9FGlyaYSWhZ/ba4MKMxifhkHmhC9YBJ+
         eBP3GvB27bf/SI7nRIf+ORms1/s9n7QfTp7UjNWqZZIrNr9NC2ElgOqIUOG0N8NMjIGl
         b/cgPEUNQnyDUOe1bdu+eFf0n0J4BMuAYfQpAzz1xJ2AYFHRDX22++UZwIcmN9Hn+h1R
         n6TU+q+Aikn/tm/VsWCJPZK8VM/j1LAqInYppeaKVNGEHtpWaZjFIrMdu3g3IFlFIw+h
         xVjGO77CyMoDHudyuwX59V60OIkO7Fjk0q+NJWbYADwoqP31BFvlr+hvDRk8l/cOZwib
         nqHw==
X-Gm-Message-State: AOAM533S3apumplQsT0VkjA6rq72zquzq39kyQZvptp23/0g3/8Oz0dn
        NFPKf2JuOH90FtlDO9/m39Yo4tB3wqiKNu8E
X-Google-Smtp-Source: ABdhPJz2o0AQtBQVBv0dog3JIjU4EgTm1YtDvX+iXdu4Xjp3TWWG3f8VHrcjv10Iv4tvmReUW+hNrA==
X-Received: by 2002:a05:6e02:1a67:: with SMTP id w7mr17840797ilv.175.1627420787309;
        Tue, 27 Jul 2021 14:19:47 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id k7sm2561320ilr.19.2021.07.27.14.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:47 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 09/25] midx: avoid opening multiple MIDXs when writing
Message-ID: <40cff5beb50cdfbd13ae7f6017152f2628b25814.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Opening multiple instance of the same MIDX can lead to problems like two
separate packed_git structures which represent the same pack being added
to the repository's object store.

The above scenario can happen because prepare_midx_pack() checks if
`m->packs[pack_int_id]` is NULL in order to determine if a pack has been
opened and installed in the repository before. But a caller can
construct two copies of the same MIDX by calling get_multi_pack_index()
and load_multi_pack_index() since the former manipulates the
object store directly but the latter is a lower-level routine which
allocates a new MIDX for each call.

So if prepare_midx_pack() is called on multiple MIDXs with the same
pack_int_id, then that pack will be installed twice in the object
store's packed_git pointer.

This can lead to problems in, for e.g., the pack-bitmap code, which does
something like the following (in pack-bitmap.c:open_pack_bitmap()):

    struct bitmap_index *bitmap_git = ...;
    for (p = get_all_packs(r); p; p = p->next) {
      if (open_pack_bitmap_1(bitmap_git, p) == 0)
        ret = 0;
    }

which is a problem if two copies of the same pack exist in the
packed_git list because pack-bitmap.c:open_pack_bitmap_1() contains a
conditional like the following:

    if (bitmap_git->pack || bitmap_git->midx) {
      /* ignore extra bitmap file; we can only handle one */
      warning("ignoring extra bitmap file: %s", packfile->pack_name);
      close(fd);
      return -1;
    }

Avoid this scenario by not letting write_midx_internal() open a MIDX
that isn't also pointed at by the object store. So long as this is the
case, other routines should prefer to open MIDXs with
get_multi_pack_index() or reprepare_packed_git() instead of creating
instances on their own. Because get_multi_pack_index() returns
`r->object_store->multi_pack_index` if it is non-NULL, we'll only have
one instance of a MIDX open at one time, avoiding these problems.

To encourage this, drop the `struct multi_pack_index *` parameter from
`write_midx_internal()`, and rely instead on the `object_dir` to find
(or initialize) the correct MIDX instance.

Likewise, replace the call to `close_midx()` with
`close_object_store()`, since we're about to replace the MIDX with a new
one and should invalidate the object store's memory of any MIDX that
might have existed beforehand.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 18e1949613..d67d7f383d 100644
--- a/midx.c
+++ b/midx.c
@@ -893,7 +893,7 @@ static int midx_checksum_valid(struct multi_pack_index *m)
 	return hashfile_checksum_valid(m->data, m->data_len);
 }
 
-static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       unsigned flags)
@@ -904,6 +904,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
+	struct multi_pack_index *cur;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -914,10 +915,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name);
 
-	if (m)
-		ctx.m = m;
-	else
-		ctx.m = load_multi_pack_index(object_dir, 1);
+	for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
+		if (!strcmp(object_dir, cur->object_dir)) {
+			ctx.m = cur;
+			break;
+		}
+	}
+	if (!ctx.m)
+		ctx.m = get_local_multi_pack_index(the_repository);
 
 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
 		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
@@ -1182,8 +1187,7 @@ int write_midx_file(const char *object_dir,
 		    const char *preferred_pack_name,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   flags);
+	return write_midx_internal(object_dir, NULL, preferred_pack_name, flags);
 }
 
 struct clear_midx_data {
@@ -1460,8 +1464,10 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 
 	free(count);
 
-	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, m, &packs_to_drop, NULL, flags);
+	if (packs_to_drop.nr) {
+		result = write_midx_internal(object_dir, &packs_to_drop, NULL, flags);
+		m = NULL;
+	}
 
 	string_list_clear(&packs_to_drop, 0);
 	return result;
@@ -1650,7 +1656,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, m, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
-- 
2.31.1.163.ga65ce7f831

