Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E8C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF92241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fMX8usJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKQVrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQVrK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:10 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E98C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:09 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so22349838qkb.7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hFtrMf4H0HoMBwwREAKCo9ihlUTZl2c1Fk0BmPe3kV4=;
        b=fMX8usJ3foe4qQgdxfcVyO63tQSRLdEDKGhRR/Q6TU6ce6KWet/8DDpVQAxnpNfsl3
         1r0kHebmYM0+A/q5FEfXyW4sexrI5iRZpar4A2N6f59J4OxrN5LAy4sOYs/zc8hXxYZ1
         A8T1Nk34Gv3O9m76hveeeTRoU8nqoiy1OWWIYo6DBbkIl8gewzU7R7yKKIUXHMxZ15/J
         eB/ireWn1duWkaJuuH032/EnAgupzHtOkOBPmmcMLjK7dGlTZLLHzvVp9CXlCLtDsv+n
         ThEqgMsFKqAa90cbe0FFhjjh4mnwFK7sOEiBQ7mn2nEALaUhZH26xtoRv63dn5VCtUvK
         o5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFtrMf4H0HoMBwwREAKCo9ihlUTZl2c1Fk0BmPe3kV4=;
        b=NC2gKuDjz/P/jV30gMy7rw9Zy1a/UQixfYMZxE8Y0FJn3ME/qPC8WQdQ+sLiVg9vQd
         7n649paAbNUCcyXXDp7ESnZyOwQzIg09rJYcAOMXLuemp6bXc3qGqBj40XelneqFlB9O
         9OuotIwwu+GiLQs5THczv9VVJBylaZt+dO2e+BP2ojh/HL0uhPi01cKNTCOfuczD+HcL
         a7x9AVK5/X+2oQwPbuiqDO+nTW39H3SkcyRUHIwV2304zGStGaUoHz0Lut1h7Yq4gzGF
         RINbVYnxm2NeCVx/cfkNnexL5fxDaVukL0wRwnx63nCCJ9TeYW1pZqVnV1OPR7t5RR2/
         O48g==
X-Gm-Message-State: AOAM530IRlbuJ112ghCitDCfmk+4Cs5t4oaTmwzx9k4gP23+X0iaSQST
        OQDZleX8fbSrLUp71Hg7RAO2+jASwVHu2+dO
X-Google-Smtp-Source: ABdhPJwmVhd3MmO0qGMezaZNzA4BgM+fPnJYnhIIB5Cjecb+OkrlYNo57+JOum9LZzvqcdVd2NYcjg==
X-Received: by 2002:a37:9b06:: with SMTP id d6mr1732298qke.116.1605649628741;
        Tue, 17 Nov 2020 13:47:08 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id o15sm14779932qtq.91.2020.11.17.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:08 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 08/24] ewah: implement bitmap_or()
Message-ID: <674e31f98e9ad3a69504125a9aaa6e914383858b.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We have a function to bitwise-OR an ewah into an uncompressed bitmap,
but not to OR two uncompressed bitmaps. Let's add it.

Interestingly, we have a public header declaration going back to
e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14), but the
function was never implemented.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 43a59d7fed..c3f8e7242b 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -127,6 +127,15 @@ void bitmap_and_not(struct bitmap *self, struct bitmap *other)
 		self->words[i] &= ~other->words[i];
 }
 
+void bitmap_or(struct bitmap *self, const struct bitmap *other)
+{
+	size_t i;
+
+	bitmap_grow(self, other->word_alloc);
+	for (i = 0; i < other->word_alloc; i++)
+		self->words[i] |= other->words[i];
+}
+
 void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 {
 	size_t original_size = self->word_alloc;
-- 
2.29.2.312.gabc4d358d8

