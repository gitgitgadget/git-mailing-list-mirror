Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F213C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4716F22CA1
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLUH4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 02:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLUH4G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 02:56:06 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD422C061282
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:55:25 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s26so21408879lfc.8
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSWnhqPvBLBwrplCiTmcJcvXrXL5CVdaXRPBlbrRqd8=;
        b=XTWqPffBlv6n5hwLcpPqaZxs5syTrKhU3DDPbEfdNf0f+W5ai+ctQJNV5yo8H77V3a
         A6+zJU41qt779QooOCKrLzNP/JXEQP6LYHWGpZVP9//F0dMoTO8OXoZXvMJ/IVIqRHEQ
         uYiG4k0k3jxGB7ltaI63Ibspw5WcWIyG0E2irdamwMIPxJybb2p/vKqUBq01GvsDGD7X
         sxKPjyj6KNyu8MmzwhLPtQzzEvIAWkZTOyYoe1X+R9/A+a/6iR8DJr4Wxpc/aIXrTT2K
         axkauSmvtr69VRjOhw2nikpwUtc9muXAvhsIlDYqzK9IrM7+HECdMPdf5GyoMwEPTQ63
         24VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSWnhqPvBLBwrplCiTmcJcvXrXL5CVdaXRPBlbrRqd8=;
        b=G5G0yk+KjdItjjlp8BTLWtf/8cofXKoPBQGcKmBcksvGVrw8f9otTzdgpWk59fnw7A
         fphoGFecAL2z3D+6JxID16S5kIh4INvWvXK4poQTnFRmrN4do9VLYSmVhDLE23whmQSS
         snE/i0bYO1kAAd7Ddasb/mFueFrfMKf/RjZYvk33dZd5OtJXfCB+9Fut1TLE2TeMPcUu
         87Mpek5jfBHvaAtYTKmK8n8c1jh6964qM6KnqSIqNqpV3nBNjX+fFtkejAIQrbqWPVeZ
         rGKHfHBSBV4H2ubMlQOWk7Z2xQTCo+3vjw9RKWi0cMHIh1OfKLHpgFKGxDzU7EJYY7DD
         X7bg==
X-Gm-Message-State: AOAM530FhCWuUGwEIQZZFg97xBGQH4Va+yQCZ73BOZH7DYITa7L0fk1d
        LmvHyDwqqdMohJycfn/euoJyEUWp2SE=
X-Google-Smtp-Source: ABdhPJy14nS+QzOQYOe8bre+rCqXJrdby5jMBwHyy16zY5jvPnN+JPBP9gC52SoCTyWOskIPp6dKNQ==
X-Received: by 2002:a05:651c:202:: with SMTP id y2mr6637875ljn.162.1608537324335;
        Sun, 20 Dec 2020 23:55:24 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id t20sm855663ljk.58.2020.12.20.23.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:55:23 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Ross Light <ross@zombiezen.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] pack-format.txt: define "varint" format
Date:   Mon, 21 Dec 2020 08:54:58 +0100
Message-Id: <42c6206b102cd97290fd9ad207bb39b20660064c.1608537234.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <cover.1608537234.git.martin.agren@gmail.com>
References: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com> <cover.1608537234.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We define our varint format pretty much on the fly as we describe a pack
file entry. In preparation for referring to it in more places in this
document, define "varint" and refer to it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/pack-format.txt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index f96b2e605f..42198de74c 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -55,6 +55,15 @@ Valid object types are:
 
 Type 5 is reserved for future expansion. Type 0 is invalid.
 
+=== Variable-length integer encoding
+
+This document uses "varint" encoding of non-negative integers: From
+each byte, the seven least significant bits are used to form the
+resulting integer. As long as the most significant bit is 1, this
+process continues; the byte with MSB 0 provides the last seven bits.
+The seven-bit chunks are concatenated. Later values are more
+significant.
+
 === Deltified representation
 
 Conceptually there are only four object types: commit, tree, tag and
@@ -196,10 +205,10 @@ Pack file entry: <+
 	1-byte size extension bit (MSB)
 	       type (next 3 bit)
 	       size0 (lower 4-bit)
-        n-byte sizeN (as long as MSB is set, each 7-bit)
-		size0..sizeN form 4+7+7+..+7 bit integer, size0
-		is the least significant part, and sizeN is the
-		most significant part.
+        n-byte size1 (varint encoding; present if MSB is set)
+        If the MSB is set, the size is size0 + 16*size1, otherwise
+        it is size0. (Equivalently, the entire packed object header
+        is a varint encoding of (size/16)*128 + type*16 + size%16.)
      packed object data:
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
-- 
2.30.0.rc1

