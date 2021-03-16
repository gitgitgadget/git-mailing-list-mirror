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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEC3C433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7016E65108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhCPQSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhCPQR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75DC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d15so10776593wrv.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqG/oiypWxs/T2AFfrd+LlTiGmoLK7qKkujxPs+b1Sg=;
        b=NAuGCNl4jBA1qa6K5T1AbJViarGslrVOcw7mp20Hp9Kz55AOw4CIho9AQPpuLM4l1D
         F6Ks06O9UNjL/kgfT8YyuTwe3u3TXJT55ZtsWTVOXohvHxhgVJwDTMXE6Hh/ZIjU0bsP
         qoMZSJJzTnXFxZB7UVTTVLlJojZSETlPYCOjQ44vHcqOS1q8o9nO9y21DK4S9KTPLlAg
         LHoUXlUhJLICinjr0oo5O30d7ohbg0DOsNZCMIVfH21i8j84a+SDqA+VwoNPBYNMytNF
         o1XwqVi1e9TywEczpuvOqtZX5vInPM8uMFYdOJOyc8LF8IXArsY5g5XYDH+tcMHp4Qc2
         q8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqG/oiypWxs/T2AFfrd+LlTiGmoLK7qKkujxPs+b1Sg=;
        b=fDQY8GYFnF/mX8PiZCddq6gT1l/zM4LwB0VrerUmzYjpR+KCHYRjtUKglDJKc1KVVq
         lYdVgvmvSU2eu9u6uP7T5FBXSzRYMtdxOyY+TocC7VsJm9uF9hYH2GBRBQmF9bWdkdpe
         VVE+KVcB64TbjlhHLpeeQ4pIzlCXdVPh14hosEYYyL9GdnsrXKS537NLXJfPPWpPjXDE
         8iJaKWywJlE2BdI8DRLn5WCFlP0ogeubxewZtHQFCqLXTX3yGOTMB2Zc6FPC0rEAG0ck
         PxZwnbqG5jh2TKptyuf9dyQ2dgWkTrLkmHL8T/DbrvwBJhFB4Ks9fUDjJTorG15rr8Bl
         QDkw==
X-Gm-Message-State: AOAM533xgD14UlVtX5vh0/w1jC5PnnNVLJN/OB8UHjXDin9Hz8wom2Rn
        ctTkmv69k3EVOIP9c9YRJZKAh7XjPTqD9A==
X-Google-Smtp-Source: ABdhPJyxyqZpsW6k8zjYbCcq3M5nzpmVeWHJgTL87iQbQMFXE3sJkp8bjHra11BW3/HkuJgTBgEZ6g==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr5668301wre.386.1615911477147;
        Tue, 16 Mar 2021 09:17:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/22] fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
Date:   Tue, 16 Mar 2021 17:17:20 +0100
Message-Id: <20210316161738.30254-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro for those that would like
to use FSCK_OPTIONS_COMMON in their own initialization, but supply
their own error functions.

Nothing is being changed to use this yet, but in some subsequent
commits we'll make use of this macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fsck.h b/fsck.h
index ea3a907ec3..dc35924cbf 100644
--- a/fsck.h
+++ b/fsck.h
@@ -45,12 +45,15 @@ struct fsck_options {
 
 #define FSCK_OPTIONS_COMMON \
 	.walk = NULL, \
-	.error_func = fsck_error_function, \
 	.msg_type = NULL, \
 	.skiplist = OIDSET_INIT, \
 	.object_names = NULL,
-#define FSCK_OPTIONS_DEFAULT	{ .strict = 0, FSCK_OPTIONS_COMMON }
-#define FSCK_OPTIONS_STRICT	{ .strict = 1, FSCK_OPTIONS_COMMON }
+#define FSCK_OPTIONS_COMMON_ERROR_FUNC \
+	FSCK_OPTIONS_COMMON \
+	.error_func = fsck_error_function
+
+#define FSCK_OPTIONS_DEFAULT	{ .strict = 0, FSCK_OPTIONS_COMMON_ERROR_FUNC }
+#define FSCK_OPTIONS_STRICT	{ .strict = 1, FSCK_OPTIONS_COMMON_ERROR_FUNC }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.0.260.g719c683c1d

