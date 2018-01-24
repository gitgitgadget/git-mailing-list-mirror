Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801941F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbeAXLM6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:58 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41687 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932891AbeAXLMR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:17 -0500
Received: by mail-lf0-f65.google.com with SMTP id f136so4706369lff.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=tpJwMZYL+oxH8z9scd8jSR0RztMPKX+ty7luNp1tKbg=;
        b=oPHcLsSs1hHmB3ZP81mAB9hmtW66o9vASvpPF5gzFiinal3Oky2K4hSZ2P74U/FNWD
         G3rcfOFi4iDZjI1n2X52yQZSqZj0FHQ6/cQpfyftE/QPd5WR5f5EPGBjNWM3ArPACzd/
         eS4ih1R0Zr9lElK+KekuuwToyQplIQoZHI6P9EyvuKV60lK4og2MGo+dKKruzbnRc/2M
         QCFj5PyhfrBaZzs3THYCLhr+l4fko+PNqo1uT8RR2VKwukiRTryRtReZrlFE3sMvl4Qm
         WcaW3zH6NryJAyN0LbqZpMAmw6D+aAV9/4b73AZDAOdNIEhwwqcJKIza/kLviElis9Yj
         M3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tpJwMZYL+oxH8z9scd8jSR0RztMPKX+ty7luNp1tKbg=;
        b=fDooT5pyzUqeuBImVpD/HCWUMSvHl2jTEC5/oYPRW0fABVWPEDjQRpZpq/0cHaJzcZ
         pYnpJi2P+pgJbW2+gRapaRj0EkCJXB8+UMlHp0CzM5Y0zISIsA8ttVsyUEsZ5z2U3fwC
         o+5b7OV2mF6MpzJ77mLHsXJvzXbg8fyqiQ3mT6u0Uxbcyi31D6vvk0etQTytle643pzZ
         WhzQVNyD9wEOMQmyH0rKuuMuPeke0nVCJ8Yr3cWsOc9Am6wbALKMnT0sZAwX7C9jwpW2
         q7M8kpHtbw4v83TwLeMk9xcTU4HZhPtcHg5YOYUagYagTB7E5U4oKKv1sLDtiRTY/efT
         w7Zw==
X-Gm-Message-State: AKwxyteG5IUNo8+Ilx9GDAz9d8LvU32k1ovo/Cy0qmvNNOXTn5b+HJh7
        NsBuPY1qReVC3ieWrHm4hMf6/JFh
X-Google-Smtp-Source: AH8x224nDgdSBEm8+xHFpZRsxRa9D7qk3K8+twvFCfc+Gqw46LqUP+/3ewa4+8CO1riXKS0olqIXsQ==
X-Received: by 10.25.20.168 with SMTP id 40mr3254216lfu.23.1516792336257;
        Wed, 24 Jan 2018 03:12:16 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:15 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 06/14] cache: clear whole hash buffer with oidclr
Date:   Wed, 24 Jan 2018 12:11:58 +0100
Message-Id: <15e5ee78314a66d8f64d5baa29d3feac14585808.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
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

