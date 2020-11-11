Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24844C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B002F2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lbMk2yiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgKKTlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKKTlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:41:51 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE744C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:41:49 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so2860601qkl.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YfB1LW/vqaO3YmLzAXyzg2hBvw20Dcx/Uldtx6zwBcs=;
        b=lbMk2yiB6Wh6jx84tSQ3+nQrxJUTAXZgkntCbG2nJ8W03dyO1YavYDx86WWJj556ND
         ps6+QThGc05S3D2BpXh9yOFGmO9EMqyIDBHlxDVA0ef2s9EiMVGokHFbjML1WsYT0IFl
         HF7lHRdZw8S2O912W8tPl6r4oSB5F2ZQuLa3tofk9j3T6ti69z/bUOA1zqBFxTIFwMx4
         077CmXXiKYgOeQgXerWP1ve4/on64Gi4OraF/jlxsUed4UgC4cPNeOaN/wWc74k5WcXk
         kC9hPwNTkMTsn0XFcDX9eNW/+7sEtKQ2zr/1D2lgnhcwYZMHRH9YHP6OHq1lFmSYNtDz
         2brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YfB1LW/vqaO3YmLzAXyzg2hBvw20Dcx/Uldtx6zwBcs=;
        b=BZtETV7T5JUFkdWSxcR7R/3ltbbAjzsUhxkzTzkEuQ7jK1wE26PJjh7xK6j1K+cK0n
         RPE/Qjia73ZEtOHwk3qKmUAF0lOmIUYcxu1pXy3PX91CW3SYirYDud7g3KNcgpiYTGYb
         nC+Fl3BF8BQK3WIJdOSqzJmoA66q1ygUSuzQq4yRgDVwIwiFIA4DlVz0U9zg1tQzDPCL
         tMH9AN2oD+YMRlPA9x+yMyL7hETKk8Z9lVHo5H3Bj76vyaX3Q5YARKyteq62TGI0jdXT
         eRRj+4ODFBgLm2U+5EpxfZ30wX37wotzwzk040qRvmQENjSVqmWQHekQMHFrhPXxd7Pe
         buZQ==
X-Gm-Message-State: AOAM5304co05Z1+Yy5tPEFcci2D5QuX7SkDSqm+EAMHyUULfSd2IMX6E
        JelN0m8RAYbmOQMVqh9OzNXOfH3gSoAdcsrN
X-Google-Smtp-Source: ABdhPJyV6fAtAmZ3NJmp3zf3LtszvCzEBMWha3QfW2Hw4BjDYgTSc1PTE/ZTgBGzu6SCTb7/Pg6F2g==
X-Received: by 2002:ae9:ea14:: with SMTP id f20mr25928195qkg.239.1605123708683;
        Wed, 11 Nov 2020 11:41:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id z125sm3098243qke.54.2020.11.11.11.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:41:48 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:41:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 01/23] ewah/ewah_bitmap.c: grow buffer past 1
Message-ID: <36deaad366d66d10b96755dd6969bfe51123a2d4.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the buffer size is exactly 1, we fail to grow it properly, since
the integer truncation means that 1 * 3 / 2 = 1. This can cause a bad
write on the line below.

Bandaid this by first padding the buffer by 16, and then growing it.
This still allows old blocks to fit into new ones, but fixes the case
where the block size equals 1.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/ewah_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index d59b1afe3d..3fae04ad00 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -45,7 +45,7 @@ static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
 static inline void buffer_push(struct ewah_bitmap *self, eword_t value)
 {
 	if (self->buffer_size + 1 >= self->alloc_size)
-		buffer_grow(self, self->buffer_size * 3 / 2);
+		buffer_grow(self, (self->buffer_size + 16) * 3 / 2);
 
 	self->buffer[self->buffer_size++] = value;
 }
-- 
2.29.2.156.gc03786897f

