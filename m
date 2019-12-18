Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F82C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E0321582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ+evK3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLRL0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37167 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLRL0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so1482791wmf.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+z4UpB8YN+FmCBQgub7FHMUlx3/iCBaiPLp4PPWTdcY=;
        b=SQ+evK3Nx0/otuklwyYZ7Z659n5FYdtixD6/nKf/JQlI14NlHD9Fivs7qiRCnvW+YI
         x2YVzHtKWCMBnLC4hxI7Rx05+/777LwoPXq6QloXK5MsyX6jRbQeLxXq5W/ciGn2AQVR
         4iUs77EK7zMY++JwfSS0SdMod4BP0VoWAtnKMK62XQe1VUhwAIvA6R1n8FuRBhuw5Vty
         iJjQc5Ov19dBvUmB8rBBU0tIABYrqoWUe/IAAr3wSomXDzhBpf8gwPIlNTPoyz/cDeV0
         ufBF/xVPKfSkxvlke61tC13ybFfPxxhdvlhL3BSFrq1OEKguLsuvMBLmBw66J71HHpiz
         kojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+z4UpB8YN+FmCBQgub7FHMUlx3/iCBaiPLp4PPWTdcY=;
        b=Q1lTxUfJzCbdu/ggcMlSFHoZkwrInC+bfyGA/+hWiAcCmA3H1o5M2zkbpu8cxw1Eap
         IKazw5lNnsei/XQls+s+HeCd+/gkZae6jDdZMKeah94aL30Mc+sjcGJ4XOHC8wVXk9Sk
         FcXPcweVIvgSD3Y8b5C5hWair6o63c8gA4kjhtP43MyCf4uBvytt1KlCeRUTYWt0DXmh
         oGd8LNMEB4ENbBUOGbGgW1/qu7MEH2pLdTOoUH+E4GmpyLY75gy8w6ZPRiTq80sSwaAg
         eovuN+XSaeVmFflXoIwd70FphOu0bDNz8j0oTMyxuUmagAMFJGJKORYnGBrhUYqzNwyr
         zjsw==
X-Gm-Message-State: APjAAAVb8HdLLUbCc+c9tlbSXEKWgVgMMpt0qSNzJwSMm38aB+U7s8Sd
        HsLDDAA6lsvB+lNP0aMnrXQrdjL9
X-Google-Smtp-Source: APXvYqyK8bEiIicCHRTHMSNPm/okTgKvUdwoaNoM68IuPPDOikkxoEuFzWgULHFxRo0VF83qaHukaA==
X-Received: by 2002:a05:600c:2c13:: with SMTP id q19mr2587420wmg.144.1576668372992;
        Wed, 18 Dec 2019 03:26:12 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:12 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 06/12] pack-bitmap: simplify bitmap_has_oid_in_uninteresting()
Date:   Wed, 18 Dec 2019 12:25:41 +0100
Message-Id: <20191218112547.4974-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's refactor bitmap_has_oid_in_uninteresting() using
bitmap_walk_contains().

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index de65f2fc36..0bbc651dde 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1130,16 +1130,6 @@ void free_bitmap_index(struct bitmap_index *b)
 int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
 				    const struct object_id *oid)
 {
-	int pos;
-
-	if (!bitmap_git)
-		return 0; /* no bitmap loaded */
-	if (!bitmap_git->haves)
-		return 0; /* walk had no "haves" */
-
-	pos = bitmap_position(bitmap_git, oid);
-	if (pos < 0)
-		return 0;
-
-	return bitmap_get(bitmap_git->haves, pos);
+	return bitmap_git &&
+		bitmap_walk_contains(bitmap_git, bitmap_git->haves, oid);
 }
-- 
2.24.1.498.g561400140f

