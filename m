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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007EC43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C31F6510A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhCPQSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbhCPQR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B70C061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1795618wmq.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpLn7XGIn7pKLLWVv9gQ+E/AKkWZ4G6PYzVuT44exgk=;
        b=eLQWL1D/5TB0VX/5n+rajtaDFCNa2agX1e6AE+/OkKcrztkk9v4NXu0N7y8bOSFSZK
         u+uP1+uPjAmIFoeKU05aR/9mpH7MNdLVUpLq7rE7pJbPODgJSmCzGL9van/Ea0hsjOnA
         P+igi5rciXSlySmjXdPUiEgECr9ZFUm0g/eupnPHC1o0VC3AaSKUtU7QcZDWyQXFSVAs
         rZtKM1pcrN4G8irrDwEL729a+u3i7ZiiFHusaz5i6bON4/S8QSJy+lf3HT7wv97grjaC
         gj0AdeJAa+zOccGg7dXa++DhAu/+aBHPBgMIuBw6tGkxHintq/hiSEuOXa6915t+yDEQ
         RXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpLn7XGIn7pKLLWVv9gQ+E/AKkWZ4G6PYzVuT44exgk=;
        b=eewp8pfE+YsXWE33+TBnqoBhYd61jnA8AmCI85isTFq2AiV6Xi4ZhJL2HAVWaQ6wnJ
         xr7fxOCXqAaqEhdLy+lSvLHq75e0Pjn8fIMf12V5fUcssBJlZ3aUK1/mX9apuPK/8ilw
         Mj/ieSZLWBp72UQiQ0D4WgKDa0TgJmBTvknl0zZW8YHWHKl+T8vjw7WI5cpkAENlJVg8
         Tq/jkSkt8QGOFQmPBWh3JTkXKwwdfC2+KI3M7VxMSVfIaq0iiiHCDgBLu4qC7aa53OpZ
         LYu2lS8Gf6KxtU+51eJhBF/QM8sE53OhSoFctgnLD7pg3fgYteMGLUTlQFvolM5ROtpP
         L4Mw==
X-Gm-Message-State: AOAM532fHmI1ZbzAjeTqnC7G0kPDjVuph5Lu7I+Kyh0R/0FjCIddh509
        aB/z7SPaK7P8EHn8s4CUWbEyBPKIqBp50Q==
X-Google-Smtp-Source: ABdhPJyDRJuEa8M4FcHW9ZsZRXSl4ohvC0prP5Q4ckwFYE39ltafLTKa5bPl9OinNXE62tDJT+OI9Q==
X-Received: by 2002:a1c:7210:: with SMTP id n16mr380055wmc.13.1615911476243;
        Tue, 16 Mar 2021 09:17:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/22] fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
Date:   Tue, 16 Mar 2021 17:17:19 +0100
Message-Id: <20210316161738.30254-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index 40f3cb3f64..ea3a907ec3 100644
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
2.31.0.260.g719c683c1d

