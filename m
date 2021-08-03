Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09A2C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 06:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A7960F58
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 06:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhHCGAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhHCGAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 02:00:33 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C451C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 23:00:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y18so27000916oiv.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EzC/l7iVxvipsL3rdH9WXZOANZmEWkIjqvZsgeaBP3E=;
        b=s37eABTYxnQG/7yH4rCZ6EjJuY8kdvtBQJWdhMQd2zMQDfsleLnF042K5NvajbUT0D
         qAp+nyHi5lzONq/IDI36YT2A5JwLgtLeDIhTt5Rphk5ecN2n0WJlxdKg8hQNRwIj1gDK
         Dsm1FbyI8f3szPBTqG8JKwBDSIrgsSvfZ8PHZV56dAkqE960jyzE8ukgOZ0eE4xui5RS
         ccGf6kyjuNMWjzYAn9SGaN6DRxHLVeELv4R+5FIgdPAX4eU9Lf1ikswvHm0O4w9uyG9R
         oHqNW2wLGT7Z3q53fzyHhD17zJdSDYjixAmCKikOcdjJYIB6Tpv3bYGBvHABc5HA9+Vm
         gsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EzC/l7iVxvipsL3rdH9WXZOANZmEWkIjqvZsgeaBP3E=;
        b=tEqKvIjWdwpSYiubD85VOLAmpeahXrGBtDXCxjW2sBUAN9Yy9vM13lRyFmCoWP/5V/
         5ReRY5wCfGddRLli9WVfcIKAfuzALSEl0yTz1z8RXWdIfKENp24u2Bh31gHiprV4Zf2K
         Tp4StyZdEyAzkS0HZsIY867Z98KuHWHfkwWs/VoQQBdwWw7nW9uQfvwDeGOVMmKZtK1i
         Bxvn8AGL9MTTlkgAtiFnJ2Ckrg/tCtXnvToD4mKlBfZg38uanNvkwJDSlN01tvB1IYsk
         vjm7FMSbuf5f+9kihVnGYoGTYjjMkLphjiJleXgtfUJl8UZloLSRe+sm2QgKHHLnYER6
         qdzA==
X-Gm-Message-State: AOAM531L9i2J8EyCFcA8aN7T5YOk5T1F008gAvWDq3mUHUqT6caVeG3P
        l+YhHKfWNU9s0fJrudn4/lqve+chLHc=
X-Google-Smtp-Source: ABdhPJyeAP04wSdCnMW+pjFbeKvjFL8lzSS+qg3ETLXPKSNL+SaGm1Yv2UOVK8HaqSC2Eyt1jLMohQ==
X-Received: by 2002:a05:6808:bcf:: with SMTP id o15mr13532419oik.118.1627970421435;
        Mon, 02 Aug 2021 23:00:21 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q24sm145892otg.29.2021.08.02.23.00.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 23:00:21 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! {upload,receive}-pack tests: add --advertise-refs tests
Date:   Mon,  2 Aug 2021 23:00:05 -0700
Message-Id: <20210803060005.18151-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.433.g9a510e7e11
In-Reply-To: <patch-09.12-beafe9811c1-20210721T233307Z-avarab@gmail.com>
References: <patch-09.12-beafe9811c1-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

avoids CI windows run failures showing:

  non-executable tests: t5555-http-smart-common.sh
  make: *** [Makefile:90: test-lint-executable] Error 1
  make: *** Waiting for unfinished jobs....
  Error: Process completed with exit code 2.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t5555-http-smart-common.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index 8d9d6a556f..49faf5e283 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 test_description='test functionality common to smart fetch & push'
 
 . ./test-lib.sh
-- 
2.33.0.rc0.433.g9a510e7e11

