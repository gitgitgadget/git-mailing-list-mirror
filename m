Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EDBC4332D
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4881F23A7A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbhAHSSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbhAHSSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:16 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8EFC0612EA
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:34 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p5so4713843qvs.7
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5SiY02Oy0Xb62PPHOJxVqcbNUHkVa6NVif34C1mP8AM=;
        b=yf3OskJKq8q0SZdSsvuRlHmIwblqOHBZy5l9trBEx76ZP50Tx/Uf/7S8UAZBKrrkJY
         hNI3iVaMBcmO5vhY0hd8oUu05wD0ArRdw0r1Te//qfxn+NUKOjNgKpyYCQxXHni7kEnG
         U2Mr5haCIQYK68I2ATEiFkhferr88Qb1AOkMGDxdDf6dyOFQEoWe9QHAdYR1HUQPZ5uR
         htAAnt8ML3u7u/roZcvu60lC6zAxWdRpAghEc1M1aOEgJIEM+2S/dhkDls0oS3V2bOHZ
         6LOvzhSKK7NhiOVITG0gmm7O0ljH5xnMwLZxIsMEoxmsAxD2wxSixrd8JsgMHTO6Z5jz
         ChHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5SiY02Oy0Xb62PPHOJxVqcbNUHkVa6NVif34C1mP8AM=;
        b=IYi77ugFr1AFxvZBoSkrUzbIWN6dREvPzrNyxWbLZ8edq7i8NJ6y7KPrbkxcYzlGj4
         iM9wOhGUGDfxdErJs0zST5vQAw9zIgwgPdRwjfU3FpfR1FYyG5t//KOGoaB4EY+dIiLh
         7qN/b4yBMRXoiTIvmUJu2Q5S0ekhqyLbQgpcASuwJV5GDPkqd0oVImlhP2iE9Anrly6S
         rRoS6QJaxTgmmja3iWAaM9UO/WmDPcPM3hNffD0nyDju6v8Iucw8+La+e1JvO5HWAP/J
         Li3Jf2ffbX5GnUN66LfZ5jDGW/1asicewMeF0LGCVAMjNGWHdb3HnvNXU3tw5zgWrwRn
         SfWA==
X-Gm-Message-State: AOAM533rlHNum60fHuqAxx9/x/Boi+tYkX3G2d+SZskk0DoXQOmiACPD
        0jN0bINU2Ts2ClqxNEBHPiDnxF/bw5E0Dw==
X-Google-Smtp-Source: ABdhPJwiQyrCBro/ODlhP3akqJ4+NpkQlZjaOcioidRhrFM10NQxFntFyj51t7AQiNyQDpzf0uHdfQ==
X-Received: by 2002:a0c:e84c:: with SMTP id l12mr8029818qvo.0.1610129852727;
        Fri, 08 Jan 2021 10:17:32 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id j30sm4849540qtl.43.2021.01.08.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:32 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 12/20] retry_bad_packed_offset(): convert to new revindex API
Message-ID: <aae01d70293545e32c317454748ef72480331d49.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perform exactly the same conversion as in the previous commit to another
caller within 'packfile.c'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 3e3f391949..7c37f9ec5c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1256,12 +1256,11 @@ static int retry_bad_packed_offset(struct repository *r,
 				   off_t obj_offset)
 {
 	int type;
-	struct revindex_entry *revidx;
+	uint32_t pos;
 	struct object_id oid;
-	revidx = find_pack_revindex(p, obj_offset);
-	if (!revidx)
+	if (offset_to_pack_pos(p, obj_offset, &pos) < 0)
 		return OBJ_BAD;
-	nth_packed_object_id(&oid, p, revidx->nr);
+	nth_packed_object_id(&oid, p, pack_pos_to_index(p, pos));
 	mark_bad_packed_object(p, oid.hash);
 	type = oid_object_info(r, &oid, NULL);
 	if (type <= OBJ_NONE)
-- 
2.30.0.138.g6d7191ea01

