Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807DDC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8702087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cHQn3DX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgKKTmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKKTmE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:42:04 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACC9C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:04 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id i12so2204511qtj.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WJoyeKHouA+s3pojn9t5eLjcAQwqU/UHOR9tm2lp0R0=;
        b=cHQn3DX0DHvS1ULAOHu7p5dsQCBkQ6dPaUizKTo+z5czYs1x/O2nddTgeeyaGc7Hp/
         n/PryO09EJdqZ2uTvtUIhaXNrxpb0VbfPUaI6lHuQHK4f5HRC/aV4GhYngvHGB5Z1nnN
         1HTgYNSLU5d0ljeNYD1TAsAzpWPPmktN8OyeHumvEarpQoA40L18+9vOsxi2E/bcu8oy
         r63OGddljm8nzZzrVoPqWBniSeYtGfh9hAvDLLuUNFaAemzc5MVIj8fetb3Ezt+ezSu8
         bzZvTCqllcC+hm9A5tMBl+GaC3+YqjrY9qJOecT8K+lT+gdxsF12N0p9f1znma1PIIRs
         f2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WJoyeKHouA+s3pojn9t5eLjcAQwqU/UHOR9tm2lp0R0=;
        b=XVNBLyUlOeM2mbYBiqAB/hZMFJq3w5yejQValsvmuOXc1RJ+u3TpGcDnvJASCGuBdN
         qTDxkM47V8YjZFnuHq72S/l5L3Xf9YKARpkdL5c3bu8JGSqt6t+4a6p+PYNR10+ZrHSs
         gLeEsYv1aVB5WLsdsmVNAq2irb9JU8dGnS8XtcGFnN/9saAq0PVUl6xXjEJVyKCjj3lc
         NifExXm4s5FiZQltX6QaEd4hglalESvb1L17vzksdBRcqlb35tCF/NJ5K7XCkUlUEYiz
         WQfIDQxTxg4fHE9or2BpVn82eqMWbkwEZYdG782o1AXPuU30YCGiHC49L6TyGZj+Z7Zl
         MbDg==
X-Gm-Message-State: AOAM530pwUFfSRqOqBsZKecG8Vjs+h9S+cPu3nVBPPwcc/Hp2Q5xdpFa
        cP47pQrgT0CFraQh2nnyVS/IwvBOYG26SDAj
X-Google-Smtp-Source: ABdhPJwhCe/GcuJIFgxAhhSFk7gmNHSvSdO82uMjguQwhqUuDTbW4Dc74Le0KwQKcnhAL8mufW+xPg==
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr5402929qtw.293.1605123723244;
        Wed, 11 Nov 2020 11:42:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id f130sm1774843qke.30.2020.11.11.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:42:02 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:42:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 03/23] pack-bitmap: bounds-check size of cache extension
Message-ID: <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

A .bitmap file may have a "name hash cache" extension, which puts a
sequence of uint32_t bytes (one per object) at the end of the file. When
we see a flag indicating this extension, we blindly subtract the
appropriate number of bytes from our available length. However, if the
.bitmap file is too short, we'll underflow our length variable and wrap
around, thinking we have a very large length. This can lead to reading
out-of-bounds bytes while loading individual ewah bitmaps.

We can fix this by checking the number of available bytes when we parse
the header. The existing "truncated bitmap" test is now split into two
tests: one where we don't have this extension at all (and hence actually
do try to read a truncated ewah bitmap) and one where we realize
up-front that we can't even fit in the cache structure. We'll check
stderr in each case to make sure we hit the error we're expecting.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c           |  8 ++++++--
 t/t5310-pack-bitmaps.sh | 17 +++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index cea3bb88bf..42d4824c76 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -153,14 +153,18 @@ static int load_bitmap_header(struct bitmap_index *index)
 	/* Parse known bitmap format options */
 	{
 		uint32_t flags = ntohs(header->options);
+		uint32_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));
+		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
 
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
 			return error("Unsupported options for bitmap index file "
 				"(Git requires BITMAP_OPT_FULL_DAG)");
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
-			unsigned char *end = index->map + index->map_size - the_hash_algo->rawsz;
-			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
+			if (index->map + header_size + cache_size > index_end)
+				return error("corrupted bitmap index file (too short to fit hash cache)");
+			index->hashes = (void *)(index_end - cache_size);
+			index_end -= cache_size;
 		}
 	}
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 8318781d2b..e2c3907a68 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -343,7 +343,8 @@ test_expect_success 'pack reuse respects --incremental' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'truncated bitmap fails gracefully' '
+test_expect_success 'truncated bitmap fails gracefully (ewah)' '
+	test_config pack.writebitmaphashcache false &&
 	git repack -ad &&
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
@@ -352,7 +353,19 @@ test_expect_success 'truncated bitmap fails gracefully' '
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
-	test_i18ngrep corrupt stderr
+	test_i18ngrep corrupt.ewah.bitmap stderr
+'
+
+test_expect_success 'truncated bitmap fails gracefully (cache)' '
+	git repack -ad &&
+	git rev-list --use-bitmap-index --count --all >expect &&
+	bitmap=$(ls .git/objects/pack/*.bitmap) &&
+	test_when_finished "rm -f $bitmap" &&
+	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+	mv -f $bitmap.tmp $bitmap &&
+	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
+	test_cmp expect actual &&
+	test_i18ngrep corrupted.bitmap.index stderr
 '
 
 # have_delta <obj> <expected_base>
-- 
2.29.2.156.gc03786897f

