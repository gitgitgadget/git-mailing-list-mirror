Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B068C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C7865023
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhCFLFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCFLE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A39DC06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so826538wmj.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkwZMM4LZOgbZjiWJVTUHGUtLlv5It/UlMy9Kk15kkU=;
        b=af93i9vFQ73PKiVZxI2EWoOHSQNAgIcDTfo7T/OsjRuRN9cx2SVZzI2/EuZvJXoNaY
         IYHf7/lmorfQklk1e5aThADqYjeY9yC/HrEGPUzXzL/PMeW7hlml/UPHB17p2X8SAZgM
         L/kQJe8t9W4pJH8RCl+y8eIHDDWVzQxBaRfX4JXB5uFBFDrcb6e5a1ORzoluH8FgMKGA
         T3NM5uz7EHbYFLvf8UfUBZkuiMHfJJY52DTNJ2gevwVyZvgxpxWWPvKYcluCkscvpVJF
         nII9tjqu6CEhQ72/RnhzxUySEasd3pStkXw5NQXUi4VcJsWChYVivWiHLQ6R3q+DSliq
         RsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkwZMM4LZOgbZjiWJVTUHGUtLlv5It/UlMy9Kk15kkU=;
        b=a9AXVoPHgOkDOQHn3qnhy6hu1WKGKFuK38wsYPD3letCsnk3HIstKs4ZjFohfVygZY
         esaJTB0JPNZmyIDtVFEumfG7wvmyDUx2CPuPW+5LWlFta7mfK5buE8uunCfuJAB2AsxJ
         CgNWbAKFGurQBLkpENf21EUBpOkJdBDkaLrJshTe4qCLea3l72WqLep2IUwCeoD3CDDo
         /4qOZZyctNyJjl7gTzxsR0oSh8mbj0y1ek/9UhahlzLpAVvpFX/xr0FQUGL2feAkv/u9
         JU+Qalhoze/mT5YD3xW8VDuQx4hjgtDvGmKgNeXAyeYIAZDum1eB8XFV7dTTctT8ZP7W
         pVzg==
X-Gm-Message-State: AOAM530cw3tdUPsd0Cft5TbD+uXGYqHc1HbNLxjauks6XSnGzP3XzZ2t
        x9LTbDK5uLSs8jfcCqXbXSJ7QtD8BLnqRw==
X-Google-Smtp-Source: ABdhPJw7PmHZBWrUlghVnfN6TT/0WewlUO77nJJVwai8RTZJqkOXGXM+vzXozgcsYkRzz3f/USzIFA==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr13036858wmb.33.1615028694042;
        Sat, 06 Mar 2021 03:04:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/22] fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
Date:   Sat,  6 Mar 2021 12:04:20 +0100
Message-Id: <20210306110439.27694-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a temporary macro to define what FSCK_OPTIONS_{DEFAULT,STRICT}
have in common, and define the two in terms of that macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fsck.h b/fsck.h
index 40f3cb3f645..ea3a907ec3b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -43,22 +43,14 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { \
+#define FSCK_OPTIONS_COMMON \
 	.walk = NULL, \
 	.error_func = fsck_error_function, \
-	.strict = 0, \
 	.msg_type = NULL, \
 	.skiplist = OIDSET_INIT, \
-	.object_names = NULL, \
-}
-#define FSCK_OPTIONS_STRICT { \
-	.walk = NULL, \
-	.error_func = fsck_error_function, \
-	.strict = 1, \
-	.msg_type = NULL, \
-	.skiplist = OIDSET_INIT, \
-	.object_names = NULL, \
-}
+	.object_names = NULL,
+#define FSCK_OPTIONS_DEFAULT	{ .strict = 0, FSCK_OPTIONS_COMMON }
+#define FSCK_OPTIONS_STRICT	{ .strict = 1, FSCK_OPTIONS_COMMON }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.0.rc0.126.g04f22c5b82

