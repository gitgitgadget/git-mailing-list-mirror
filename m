Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ABBC2BB40
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3048523A7C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgLHWEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbgLHWE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:27 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7DFC0617A7
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:41 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id h18so205798otq.12
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+PfCUh8SD4AoMOsjP36g0QEn/qzOI2Cq9Wdhx/41HM=;
        b=L8eTbS4aQZ3hxwgtGK3f1X6bNgbZcUNaFLzvqdFJQpZCxt/Hli1XILrGnEpixRk092
         6C78kog7v0FhqpuwQ3SOIe1HB0JrBRvA0Nhd0YRAcG8b7VFYDqCKE/Xc4zYFhtVs2Mxh
         a2HLQpvFMR/OdM1OGl6ogrWWJ54veOQE+tRCE5x6lw34ChFYpl4XvYdWnkgStBIKcG6r
         aotw4Enytmsq6HIdmIuWpKsMO5QPzSie6va1gC/jKRdfUSFViKQExkVb4TBLcCZWH7C7
         eQQjPqjaeUtfe46/wIGWHN77WfT4mTwWZlJQU1N8XFUbqjqlA0t+U8l6XXlEOFho7pv0
         e1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+PfCUh8SD4AoMOsjP36g0QEn/qzOI2Cq9Wdhx/41HM=;
        b=nWGACugTvRS2mwrohiFeU/s+wif4NHpVHp9cNg3nIm8NnbTCCi7Gb2UVL5ZH8fnpEx
         uE2QMUpfFAe31TD02yaWhbMtGyYJoSr86O2sOWWa95psbrhcXkTGfQznmhRPgBhnZtVA
         Ds9ePr6JDdzpYKeCudE0KqA334M2It5BfvL+WI+fLIAhJNI5ohKRQZWC8DgJf5vAfTAd
         r57xVVDT+gAoMk6cEie+dWAxB5ntVJWFbGxVMnZV6sHDX0fa41lKT+hLH66j8fEREi4t
         HE3Ka76ndJvfNPqnRFoBU3af39ZoEB6f3lteCgya6CxQFpZVuuWPKGlrtmsjcvpWCkHB
         PTGA==
X-Gm-Message-State: AOAM532//uBlIXAvZ4eW+5kwggObcUZwThmidIXUubwTkbaKD7Tj23dY
        nDTRTn9r2tc8Ia1aVvq0T4xFFYGVKFvT4Wom
X-Google-Smtp-Source: ABdhPJzXXhFPpRhUATanC/NuUxLSSW85lnl+YAVqbfyktZnUhbWfs9MawPBvGEgN8gW84HuMtob1hw==
X-Received: by 2002:a05:6830:1f50:: with SMTP id u16mr104415oth.265.1607465020429;
        Tue, 08 Dec 2020 14:03:40 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a4sm67416oot.6.2020.12.08.14.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:39 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 06/24] ewah: factor out bitmap growth
Message-ID: <570bf22425b1b9d9088846e39b26b07265079ece.1607464775.git.me@ttaylorr.com>
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

We auto-grow bitmaps when somebody asks to set a bit whose position is
outside of our currently allocated range. Other operations besides
single bit-setting might need to do this, too, so let's pull it into its
own function.

Note that we change the semantics a little: you now ask for the number
of words you'd like to have, not the id of the block you'd like to write
to.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index d8cec585af..7c1ecfa6fd 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -35,18 +35,22 @@ struct bitmap *bitmap_new(void)
 	return bitmap_word_alloc(32);
 }
 
-void bitmap_set(struct bitmap *self, size_t pos)
+static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
-	size_t block = EWAH_BLOCK(pos);
-
-	if (block >= self->word_alloc) {
+	if (word_alloc > self->word_alloc) {
 		size_t old_size = self->word_alloc;
-		self->word_alloc = block ? block * 2 : 1;
+		self->word_alloc = word_alloc * 2;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
 	}
+}
 
+void bitmap_set(struct bitmap *self, size_t pos)
+{
+	size_t block = EWAH_BLOCK(pos);
+
+	bitmap_grow(self, block + 1);
 	self->words[block] |= EWAH_MASK(pos);
 }
 
-- 
2.29.2.533.g07db1f5344

