Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4925C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB871611ED
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhINWH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhINWHY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:07:24 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96DC061767
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h29so741802ila.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cuLvF0o8RqwzkFaFHWHASqoMkWK041CGb/7BF49RNi4=;
        b=Ud7diljsPiVraWmQYAK/5Nn3NQ3bU6Kh4BhZIqgxUyP/fZ1ALQzLl8aZcUAFw9cCrZ
         TfZ+0a6Tsxc1KPE6DVjtu968dl2drU1wxNMBiMfU1fdUZ+LKUMorZTmwO6qlU794CL23
         LO4mgaMn7kbH/yPoZ8gw592fJNswYlKYvmqto4Kh0JHPQC2LfZHWmqUsrYs1PIxwPOWl
         3Od9CHJM4j9W4UQ0X+8df5lPpENb4iNPU+fFgIoHyOmluezPuFSUH+/QrS55eNi2QN52
         AAid+3TtLQBcNZtWkgmiZ5ZI7e1MyHMwldBbGRpedYVlHpVGifWK47ElpII9gGKrxJ3/
         OkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cuLvF0o8RqwzkFaFHWHASqoMkWK041CGb/7BF49RNi4=;
        b=2qGS0bUHjcO+IWwOEhULGY9Pq6ALilmY3M6LObYP99xFRJxhTZ189p2mnQ5Xlpo8IJ
         iklrQHucFKX3CssEAlaaAo79m8fWTL/mQjxH1HJVdH2K3VY+Yof3ykS0oMzhtg9aG37+
         /zJT6Zp8IaKEFjBH4Oiyf2kxgkR4r7eKZ5ANWT6+u1c7Zlre2ozie7Jh0kc8EGa8X7XZ
         KkFJdM42mabksWETu9Fspz7FE+dyF7OJeO2AhTYRtOI78vwU9EFfhYIoKUpvsRezc0DO
         Y0kkx/EUXdfLzqM8mYadDBtkeH6CNTGe+zmo/WiIvjNPF/U0eTfJcVUKFxZ+At7IO7sM
         DPmQ==
X-Gm-Message-State: AOAM531/JeL7B+5wNwyizIcXvTCr77R2A7dDbGE17uMtwfOSPw3HGgxS
        uS9aiLZZ0mMc/Wcw/CoCkDFzwbUiCG7t2Wwx
X-Google-Smtp-Source: ABdhPJxcNiJGu2vrzz+fxeABSPAyyB/TtK4eWQ0DbZTfMODWLQZOGlb4HShRMQ5AUPkCalLwnbaikg==
X-Received: by 2002:a05:6e02:eb2:: with SMTP id u18mr14112542ilj.138.1631657165355;
        Tue, 14 Sep 2021 15:06:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g19sm8092685ilb.84.2021.09.14.15.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:06:05 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:06:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 2/7] pack-bitmap.c: propagate namehash values from
 existing bitmaps
Message-ID: <2cd2f3aa5e74a3aefd6924c528cbfb578a510d31.1631657157.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an old bitmap exists while writing a new one, we load it and build
a "reposition" table which maps bit positions of objects from the old
bitmap to their respective positions in the new bitmap. This can help
when we encounter a commit which was selected in both the old and new
bitmap, since we only need to permute its bit (not recompute it from
scratch).

We do not, however, repurpose existing namehash values in the case of
the hash-cache extension. There has been thus far no good reason to do
so, since all of the namehash values for objects in the new bitmap would
be populated during the traversal that was just performed by
pack-objects when generating single-pack reachability bitmaps.

But this isn't the case for multi-pack bitmaps, which are written via
`git multi-pack-index write --bitmap` and do not perform any traversal.
In this case all namehash values are set to zero, but we don't even
bother to check the `pack.writeBitmapHashcache` option anyway, so it
fails to matter.

There are two approaches we could take to fill in non-zero hash-cache
values:

  - have either the multi-pack-index builtin run its own
    traversal to attempt to fill in some values, or let a hypothetical
    caller (like `pack-objects` when `repack` eventually drives the
    `multi-pack-index` builtin) fill in the values they found during
    their traversal

  - or copy any existing namehash values that were stored in an
    existing bitmap to their corresponding positions in the new bitmap

In a system where a repository is generally repacked with `git repack
--geometric=<d>` and occasionally repacked with `git repack -a`, the
hash-cache coverage will tend towards all objects.

Since populating the hash-cache is additive (i.e., doing so only helps
our delta search), any intermediate lack of full coverage is just fine.
So let's start by just propagating any values from the existing
hash-cache if we see one.

The next patch will respect the `pack.writeBitmapHashcache` option while
writing MIDX bitmaps, and then test this new behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 04de387318..33a3732992 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1818,18 +1818,20 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	for (i = 0; i < num_objects; ++i) {
 		struct object_id oid;
 		struct object_entry *oe;
+		uint32_t index_pos;
 
 		if (bitmap_is_midx(bitmap_git))
-			nth_midxed_object_oid(&oid,
-					      bitmap_git->midx,
-					      pack_pos_to_midx(bitmap_git->midx, i));
+			index_pos = pack_pos_to_midx(bitmap_git->midx, i);
 		else
-			nth_packed_object_id(&oid, bitmap_git->pack,
-					     pack_pos_to_index(bitmap_git->pack, i));
+			index_pos = pack_pos_to_index(bitmap_git->pack, i);
+		nth_bitmap_object_oid(bitmap_git, &oid, index_pos);
 		oe = packlist_find(mapping, &oid);
 
-		if (oe)
+		if (oe) {
 			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
+			if (bitmap_git->hashes && !oe->hash)
+				oe->hash = get_be32(bitmap_git->hashes + index_pos);
+		}
 	}
 
 	return reposition;
-- 
2.33.0.96.g73915697e6

