Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1700AC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A3D2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ySqkrOr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgKKTnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgKKTnN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:13 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391CC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:12 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b16so1952012qtb.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bzeOBd/U/47Er7muYEe+SEG0TcfPAQqvipRIyq1W2Yw=;
        b=ySqkrOr8tR3GMgUtqy33ABBnoIZr03chDCS33nCUcIibJseTsluJBajvCmRq8oqPal
         WGm3qKATafMUvd0o824Nw6fOxPv82WUnxvJkyg4iRBBlOl29PvBND11lQNfs738EULTW
         AT4c73WVqHuzRAc61UIG2mP3eW51cSZLPsYjkUqKqTo9M+C0BMlS0GN8LIas4/fog5Rh
         gneuuLw94DObjzp1iz9LaUQ7wR+fdfvq4x19ShVEZijCX/bPez/6mUpM5sFevUIbPGBw
         7pzdyvtkKtLHK0JjGjqagVVXMwQ0HYWtJywGKaRQJQ6cn9udl7ppe44iVBdoBAqdWK6z
         PwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bzeOBd/U/47Er7muYEe+SEG0TcfPAQqvipRIyq1W2Yw=;
        b=YN95rtIb5ROTuaKK1vJQ+vsheFVgVE8N2KeqimegdyTxcV57LYOxbNyqLcbd915DKn
         O3nUqnrKrOSt6JQ0pcZQppBjhXH33En67GKhOMXrrMVqRaDcabyMvJwixt72mPqhreF1
         vK4YwC0fn0NIcGR8MltdLO9NtoF1PItcvkEV6qhpFSCbZ+JGFrkHberalELptPl/Kk56
         xWHO/CiPd54jVmSog4e1qvU4GyQ5/vVLRDkMvqEKyf08RXDZEhAQ8PzWq5qBIxLxbyIX
         JyoffTvgz6MkkouVxeBNuis2zpjF0hLXv9zzPJwjr5lv2MSH+GUf+nU1gOjQJMoJkRft
         nQ/A==
X-Gm-Message-State: AOAM532qUYO0BcSpblePm+G5QexE1sAMH9GMm3P1jjGjXcIM1dKBiLCV
        +OhLuTn64/AJ1lCBn041gvUTDq3YhgBSIdZc
X-Google-Smtp-Source: ABdhPJzt63DGcuodKbUiKbfwMIQYU8iibHGIZnL18xMyJtWoZJ6TCL2KsfTX8bZwF+A0QKZt1dyP+g==
X-Received: by 2002:a05:622a:4e:: with SMTP id y14mr17336842qtw.392.1605123791026;
        Wed, 11 Nov 2020 11:43:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id j50sm3297161qtc.5.2020.11.11.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:10 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 09/23] ewah: add bitmap_dup() function
Message-ID: <242bd3f110fe43c127208a7351215f1b238c714b.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
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
2.29.2.156.gc03786897f

