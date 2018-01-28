Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C5C1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeA1ANf (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:35 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43184 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbeA1ANb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:31 -0500
Received: by mail-lf0-f67.google.com with SMTP id o89so5012984lfg.10
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=tpJwMZYL+oxH8z9scd8jSR0RztMPKX+ty7luNp1tKbg=;
        b=hu6UylaSIrRGSsXsrCSS9qS/fCzlM9/R1wkXL16melP1DESaHjs8FL6foE/IMqFBLS
         WjrIZTQ6K1HSKQGu+59Th7IhXRbGGyLUoPMrXKwy7Hq8fedbnUCcbrDv8RgXzkdW4/aO
         FI25w1yVCr4kh8W6sQqphgSnbywUg85ZcH899CkxaiP9DkVyLFp5iTgWtEIOfbMpbTLf
         YB3EdHkSv8NH/jt5CEjsiPWFPKwhVeJET4GGFTY9ro/kuDL8pWAKO5+Oz/N9GxbQekQT
         ziDK0a3QlfFFG87ZRMRl5IoAxYVM30QV/KoClL0J8zyuLeXFd0YjG4SPIIp9NeXjRwFl
         1qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tpJwMZYL+oxH8z9scd8jSR0RztMPKX+ty7luNp1tKbg=;
        b=sdWC1wW6Dc899BqPj4SQETQUHlGTakPAU0AsR3LhBxsp3g37xgaKv4BKLvVBsruxHP
         kFM4nsyjsvy/in48Zn9Xo1aHA0QA5V7yus192rUx/tnxWIUfBerTLOz/ry+i0HN2ekdu
         oFIpHwtfMPGZwnwy0JWZx7coBR5w17gLJ0KKYKblEj/sgueB2E32nU3xXX+NQRjduFyW
         RBe8pJCRVhCLc1pCWZpC76Vuy3i2WC8bK5gw6TId+XszxfyT54w/iw+SOofWNOg1cvgu
         Cn3dWgbsArkCmI97qsdrRSuTjRkyJJ7qyU95M57G3U2oFMIhlUmShYZbIyErKTFJoKEi
         pLCw==
X-Gm-Message-State: AKwxytfRre25h+SaNhnG5EajcmzfwK9q+BDLZA7PwUr8Dn3Q3v9A9M1q
        L1+LKoJADczmofSKHjdb5FtSdseR
X-Google-Smtp-Source: AH8x224hUILwFmi7cCvJN2jIPfeMGTw5zCQFZyjeUAWsikQCISDW0dnE/321TMqxjqbj1P0a3fe9qQ==
X-Received: by 10.25.208.210 with SMTP id h201mr9823951lfg.22.1517098409988;
        Sat, 27 Jan 2018 16:13:29 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:28 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 04/12] cache: clear whole hash buffer with oidclr
Date:   Sun, 28 Jan 2018 01:13:14 +0100
Message-Id: <ca4fac44f11c767c6042404ed9ed0c2e1b2f5369.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As long as GIT_SHA1_RAWSZ is equal to GIT_MAX_RAWSZ there's no problem,
but when new hashing algorithm will be in place this memset will clear
only 20-byte prefix of hash buffer.

Alternatively, hashclr implementation could be adjusted, but this
function is almost removed from codebase already.  Separate
implementation of oidclr prevents potential buffer overrun in case
someone incorrectly used hashclr on object_id in future.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 08f2b81e1b..d5d78d6a51 100644
--- a/cache.h
+++ b/cache.h
@@ -1029,7 +1029,7 @@ static inline void hashclr(unsigned char *hash)
 
 static inline void oidclr(struct object_id *oid)
 {
-	hashclr(oid->hash);
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
 }
 
 
-- 
2.14.3

