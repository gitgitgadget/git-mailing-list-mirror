Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F004C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2643F241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="h2a5iP5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgKQVre (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQVrd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:33 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25C8C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:33 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so17116477qtp.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NBbvdD+apBGnqe7XsCbQb+AUlARGfFxhZp5Yln7ln9o=;
        b=h2a5iP5J02SK6lDYIBO9elVy9rII8AylH6PJfBHQIBknJ2nwELjOsBC5jNX94CkLhG
         2XvR6QSSD/LRyGk38WfYwWFoglBvl67evyV6NJG5CFcQizyLy+1V63kkXCvgzbRxAuRr
         Tuldu16FTOO37pab8MNoY6GbyGj5MS9SE9MsqfIsvatDOU/84BeK7lhiX5AcpSsJZeZv
         E76HbrjfQvkIWamK/vADEPzs/W030FtFjzn+fW169le3QQ5amMpaVwgekkmskT/rNUVg
         pD+G1WOhWnDRDkedZfkn1IsfRC6nt62q1mXkAtEPxVBRgP01d+ByUEcdtLTMhqHrDdKp
         1r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBbvdD+apBGnqe7XsCbQb+AUlARGfFxhZp5Yln7ln9o=;
        b=tSyhEhD+vF+ITxmYGRZTErxkLqCTWhF9ws7hN7W8AA29aA3n7OLRF9Uf7xOhxlzkSx
         1CffLA2P7RroBzgrmsAN7ztD31XR+HgX5quhfrnXM6EcksE5HyWrZU+qWzyajQjaKdSJ
         Woj6jqIOF2167aGevPV+6pwiv220w7dFnI8SPEKMMHZD2x+XH0RT9tb2CWSKe2kzQRzO
         fPE24BC8OOULRBSGtG0SdGQzmBUmLeP+4Z+3PE87y0eHh8/2PMI7qG5I1sRPNRqd7nPA
         lteg9FSNLybqJiT87G1XcNybHZSrtySpyJEh0uPo2BQOXvE8MuiQEgF7Immbv3WlN8bW
         Dc/Q==
X-Gm-Message-State: AOAM53161Jr9DzxGLriORVX6b6oizxtUpQXWjSg+7EYi+p9b02iJ9k0W
        6Yd0kr679nUvoQrHRKYhkwujXw2mpKSfJf0V
X-Google-Smtp-Source: ABdhPJwyv37Vr7+RHbFwm3xCoirlJTzkxBiBa8kRPZ3476yLBVA26IHEXKdI8kY3sN3uAfKQLZjiaw==
X-Received: by 2002:ac8:7619:: with SMTP id t25mr1834844qtq.244.1605649652633;
        Tue, 17 Nov 2020 13:47:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id k15sm15233472qke.75.2020.11.17.13.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:32 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 13/24] bitmap: add bitmap_diff_nonzero()
Message-ID: <4840c64c51d65ea7bf1ebe03cad4588267db0207.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The bitmap_diff_nonzero() checks if the 'self' bitmap contains any bits
that are not on in the 'other' bitmap.

Also, delete the declaration of bitmap_is_subset() as it is not used or
implemented.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 24 ++++++++++++++++++++++++
 ewah/ewok.h   |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index eb7e2539be..e2ebeac0e5 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -200,6 +200,30 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
 	return 1;
 }
 
+int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other)
+{
+	struct bitmap *small;
+	size_t i;
+
+	if (self->word_alloc < other->word_alloc) {
+		small = self;
+	} else {
+		small = other;
+
+		for (i = other->word_alloc; i < self->word_alloc; i++) {
+			if (self->words[i] != 0)
+				return 1;
+		}
+	}
+
+	for (i = 0; i < small->word_alloc; i++) {
+		if ((self->words[i] & ~other->words[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
 void bitmap_reset(struct bitmap *bitmap)
 {
 	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 1fc555e672..156c71d06d 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -180,7 +180,7 @@ int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
-int bitmap_is_subset(struct bitmap *self, struct bitmap *super);
+int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other);
 
 struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
 struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
-- 
2.29.2.312.gabc4d358d8

