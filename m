Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC62C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB445241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="G7VQy5t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgKQVrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQVrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:14 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF25C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:14 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id m65so17069034qte.11
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1qPKW/h2owEnumCUEtXxvfiizBNn0zE3UKWmCTVbkm0=;
        b=G7VQy5t9IVgd3hYEqP2bARDnG1z0qm5M3+Mtowobs7gaNtH8+240wIROskt7KqxqGZ
         zCKGajoTBvuTejCSvoawis9aU48URvmVMGKG00QmzOlaOSdLZcypEMvoKnE5+oQ4BYyB
         5Bs9tp17C7KfkVGvg0EWVwil0R8uu0qQnAhGklaxk3PQ1hD3bI0wMXhLXZbXbN1o4mlA
         q+qivmQGtPrJmMEf5AUsa1Zem0HFQYnu+NFrKtMHa1V5Ggraf6s1FuIPeSQTONhNIJpv
         LK/ap+3DTx3viHb9DJWk8LJo5T7rtgLKPC2uW7VWaYnEOALEtOL2Jv1KM9byF8MOIGSA
         jKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1qPKW/h2owEnumCUEtXxvfiizBNn0zE3UKWmCTVbkm0=;
        b=h0IT61c6DVll8AoGuSk+v4mSeTFJpFTf//V9ZJypkTvZGZik358GHoJ3OW9AATU59h
         qj01oPEv0tm6sxY45NrPuPo9bjcuSuaPRDxZ5u6O/qVx9YLNaYHGoZwUxSJRkEyqYGUX
         FcM0veg2XKO/pMVp2DJDI0OHEs8zcwJwaSshXbIIlJXHbAMFJnPvuhZ4n2+8HONLFJFT
         aM6OUYMGXi50g1/huYeRyMc8+eAmMbZ9M9Y2w6h3F8KO8RTdB+agNjqXFxJT4zrH7V/D
         Ukfu1E2nedJExzh/NzYlEQ63vwUemH236sAtk/3Kt1HI0nS+srVWUNvLtlR5+qkcMDY6
         15Gg==
X-Gm-Message-State: AOAM530p8tLTU2wymH1iZrzWSEw98HGvXV3CMWXRbWoQ6ALiaFdpCE1Y
        e0P4+N1nNVWwdfYZH74YxY49SjxkiP9jZ49B
X-Google-Smtp-Source: ABdhPJwoLX8fd+OfWGYVHL8IW+XktCgFXmnJgOmYY8RfEmPTK5YNwCEuReYJ7SSLElN6EF1GYk0f0g==
X-Received: by 2002:ac8:6a16:: with SMTP id t22mr1332457qtr.304.1605649633316;
        Tue, 17 Nov 2020 13:47:13 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id 207sm10504469qki.91.2020.11.17.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:12 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 09/24] ewah: add bitmap_dup() function
Message-ID: <a903c949d8b597bb48094c100974369e259d4b40.1605649533.git.me@ttaylorr.com>
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

There's no easy way to make a copy of a bitmap. Obviously a caller can
iterate over the bits and set them one by one in a new bitmap, but we
can go much faster by copying whole words with memcpy().

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 7 +++++++
 ewah/ewok.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index c3f8e7242b..eb7e2539be 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -35,6 +35,13 @@ struct bitmap *bitmap_new(void)
 	return bitmap_word_alloc(32);
 }
 
+struct bitmap *bitmap_dup(const struct bitmap *src)
+{
+	struct bitmap *dst = bitmap_word_alloc(src->word_alloc);
+	COPY_ARRAY(dst->words, src->words, src->word_alloc);
+	return dst;
+}
+
 static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
 	if (word_alloc > self->word_alloc) {
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 011852bef1..1fc555e672 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -173,6 +173,7 @@ struct bitmap {
 
 struct bitmap *bitmap_new(void);
 struct bitmap *bitmap_word_alloc(size_t word_alloc);
+struct bitmap *bitmap_dup(const struct bitmap *src);
 void bitmap_set(struct bitmap *self, size_t pos);
 void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
-- 
2.29.2.312.gabc4d358d8

