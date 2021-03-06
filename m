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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B50C433E6
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F4F6501E
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCFLFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCFLE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5951EC06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j2so5220833wrx.9
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46Xsr0aFYoRx9APKd+S+W7ZX5x95jRGBbmqO4bhoAzo=;
        b=i8ATH6tqbn6or/b4dV3in/mQQrAhWykSMcbrDTdev7PVnncAJOgXYv1fCci22vBHZf
         /605Eaf/Lc0eNJx0H6a3ze2TTOq5r5m/qYXElOccApK2thVraF5kztk83JYIovnixG7M
         ljtfTsBt9TzcSBnRE8Aq6xk+NNN0biI30SlYLsWQHeZt4KwbojBpIUhdsw4PO1q5xb/+
         aU21GyjgfgPecmB5zVYGPBp0AY0TFk1jkh1aYVem10psS+w4l7PvQ6yfzwEaENmyCcjb
         zpmLuSoCkDBF3P/+ssLtS0GMTw6yLLOaa2GFZ7xt9EAkBseuULuntHIs05jVh0+Z0k6a
         okiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46Xsr0aFYoRx9APKd+S+W7ZX5x95jRGBbmqO4bhoAzo=;
        b=jcqy1JheeHRja/CacqEHmcCZvAv0MIuqcrqzELrNDSkMrWb6CvL62vt4y9TrEtYW29
         53ED9rcY7OclRJh6IWwh8S9d2M1Q74GVU03AgCZI11cnUhhO2NAXaNtwHIcZvdEQm8aL
         Krr0O/lf4IsPHRp8IqLP+rPflZYPuW/L7HEZxcQw2BdxEZKC3qvHZVBtX5EI5H0GEyU/
         qaj8Kjbmj0Wo3PSsaH4CPRLQ2j6kFj2OeGAp91acfPCpZ14DO7qv9UiOpdutYEZDdTZ8
         C+iowqMU+my6QnQsZbw3w/SeyFI/LnJSM1FH0IBaOn/NUFgMXp0Aaz2tEMGn2fBUSVPy
         MqMw==
X-Gm-Message-State: AOAM530OHWCgIR+IVVrYhJSkPAjyQvvM0eM/tqN0R24wNL21XOh1Cq3f
        lIxFa42K0SKPK5EVfb3PQ5r5mg9tOYN82w==
X-Google-Smtp-Source: ABdhPJyvIlrZhZRq8T/64nyM1jqD8VM68vSN23azepZtBUVCJOeAj2zz4THxEbqhpAmBDoPxxzWoVg==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr13993601wrh.363.1615028694860;
        Sat, 06 Mar 2021 03:04:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/22] fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
Date:   Sat,  6 Mar 2021 12:04:21 +0100
Message-Id: <20210306110439.27694-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
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
index ea3a907ec3b..dc35924cbf5 100644
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
2.31.0.rc0.126.g04f22c5b82

