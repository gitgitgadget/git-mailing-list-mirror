Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19710C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0A723A7C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgLHWEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbgLHWEO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:14 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98AC061794
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:27 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id k2so150459oic.13
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4+YaVsaIeql0R9c8t74ily3XElRCcVkPGK0I++sGLHk=;
        b=Mhp0jXbf+oPozHd6q+1GuhMKeklre+V+tm8bswskKOXA+9zG8fVdO/R8/DArMRTRpQ
         jIp4q4fwW5ygxLK4gN9Y4kTKY6iYbUhunaD5bLyj+yROso6PRGyd2RbvUkz4akxLQaZF
         RbKMDtSHUgTh4OTEfe/AH7/5oe3F6i8aJxDjyQDaBy5RdI4XN0bzW6u0g0o3KVQNtwBl
         MyPoQtr5QYhIDQVbG+lTTbCBA/j5X4oTJ7Xk3xIra39cJDPTfTTSt8jtCNIlGOxPJqhv
         JKfOFfCAle+3pXZG4hi4kmmsko3SY18i6IDT9fYmLfGIf7joJY30hWl3K6dQUI08B7u8
         0qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4+YaVsaIeql0R9c8t74ily3XElRCcVkPGK0I++sGLHk=;
        b=mS1ECZufltJEqLPqfnn4nh4ve9/C3xCXQpXagB9v+3wXILKAIZ8nbmpdf/L5amcUw1
         KCsqaVSJABwEfDkhrCWHfnUPuqfMBURk5fXkslnbEuxBOv1wMjlfrSC3Lz5EF8abFMG8
         ZmHFXAt3O4KxtPzVXEdaf/On57pUoAJC+Apl4NUQueSv0nqlklGAkmRN8S84oUVZ3kmB
         1uUhqBicKwz7YuBQmqfb/tobYJvRhcMJSGYmtf3idcJ9dY9Ssuny3iPkxEXpM9LLyP9+
         MR90BuOBFLA9bvtiuiPhzIaPfZqPvi7itDQZBwUDOh/VI2ptP5vCpxWIh8wED0W9vHpM
         L04Q==
X-Gm-Message-State: AOAM532Ud2yF+nWfgXLPlHx5fz9eRGcvzDxT8yQA2UQyyEMCgoqRhPAu
        agclLuhAkYJGpRXEPNUMiyd0b5HLfRHVRJP2
X-Google-Smtp-Source: ABdhPJy5S7rRsYV43puAHd7TIs1uon/XLWuXLfR3d7sjOkxvbcv7RxkoFaYn/36uWLFqSmYtiY+Ycw==
X-Received: by 2002:aca:e146:: with SMTP id y67mr2973oig.70.1607465006725;
        Tue, 08 Dec 2020 14:03:26 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c18sm16220oib.31.2020.12.08.14.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:26 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 03/24] pack-bitmap: bounds-check size of cache extension
Message-ID: <97533dba2720f7709699aaf42afede65a2cb540b.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

A .bitmap file may have a "name hash cache" extension, which puts a
sequence of uint32_t values (one per object) at the end of the file.
When we see a flag indicating this extension, we blindly subtract the
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
index fe5647e72e..074d9ac8f2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -153,14 +153,18 @@ static int load_bitmap_header(struct bitmap_index *index)
 	/* Parse known bitmap format options */
 	{
 		uint32_t flags = ntohs(header->options);
+		size_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));
+		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
 
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
 			return error("Unsupported options for bitmap index file "
 				"(Git requires BITMAP_OPT_FULL_DAG)");
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
-			unsigned char *end = index->map + index->map_size - the_hash_algo->rawsz;
-			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
+			if (cache_size > index_end - index->map - header_size)
+				return error("corrupted bitmap index file (too short to fit hash cache)");
+			index->hashes = (void *)(index_end - cache_size);
+			index_end -= cache_size;
 		}
 	}
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 1d40fcad39..dbe1ffc88a 100755
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
2.29.2.533.g07db1f5344

