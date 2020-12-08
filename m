Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809CC4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755DD23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgLHAFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgLHAFi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:38 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A36C061257
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:41 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s75so14467023oih.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+PfCUh8SD4AoMOsjP36g0QEn/qzOI2Cq9Wdhx/41HM=;
        b=fOl3IMuNceSm3Kka1Uxw7pxRpnpOupmFNK6xaZwEaYkUiOmQDBrRyEguuCAYQsSU1+
         l4bke7XeJGv8WO3EetogxgxGB+tZAUHPnNWD32KMK06Hp0EW+4J6MbtCmEaKsCkGLFH5
         BoXk6cCBEa4RL9lLD4n9UdFSRRRmjsYGWQ+VuKdde3L6FbQod+zcvuWWhqmHUhHF1VcH
         64L9+/up8viG0gDc9TH6VTy7cJgW21zBqGvJm2O/aBT8G1B4MpeqTZGSe4yQqD7G91us
         V1a6GvnDComgH4T5e6dEshhT1ojAE3HiFQwfSt4lOJAT8bcP8I+hwhfSV2l9CJ7/oWL1
         Vlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+PfCUh8SD4AoMOsjP36g0QEn/qzOI2Cq9Wdhx/41HM=;
        b=KSbQosYMlnFrGNUTVQjbqXTOPaoLDOjU9pcRdShFYEQdBiuXz77deiHFGcfxNm4k6Y
         82QOuYJ12sj09EfdyBc89mVsjxvMmC7OAcCkzcnBQbgUDPEvCt76Kb/Fru4VpqmHD3xL
         rLZZZWmZa+suZIXilY9EKz4F7wvGEGcXmKqgxn168yfNaDCb0iLD5F+J1HVkIVzLhqnu
         A46s7tepBg+0kIZdmcC0kO+DaNsup0CldtieJ+0un4qcYfNx6vz9VU8cOFBDwQjhsW3v
         lBUfKWFV0TbadmUiloaIIhbrWLXlAcJDf7ExNvRwwWQij3MUG0QdrN1Tof2dZ3eAF11R
         2KSQ==
X-Gm-Message-State: AOAM5309esj7aHeXFDKsKUkWk6PihlZaLNWPHH+IJCjXtlkxuZ/s1kWS
        j24sKJy6HfhFRevtcf6ojX3aVyol1zZQwnuz
X-Google-Smtp-Source: ABdhPJx1HNg6XCDSqqQymokQ2bmYbomfqyJ5Vi7HClu27toBrIZts6Q/514PR+2poXnYXCl4Dsz+Gw==
X-Received: by 2002:aca:c615:: with SMTP id w21mr970125oif.68.1607385880801;
        Mon, 07 Dec 2020 16:04:40 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g6sm3014978otk.40.2020.12.07.16.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:40 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 06/24] ewah: factor out bitmap growth
Message-ID: <b79360383e298051a26e2dc353548f9799f43424.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
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

