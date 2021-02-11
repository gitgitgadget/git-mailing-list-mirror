Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF01C43381
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22BE64E44
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhBKTtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhBKTsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:33 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D5C061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:28 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r38so4626802pgk.13
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SHwKAsKrEoWrKBhY2PawvgB+vBiv6nowp261v5wtFSg=;
        b=P9ZPbso7wlMi0yw/CRibVixN0iHZr7t4Rmg98eqc8BwJV16Vwy1HJeWmG4kgmUQHdy
         DqGIrOk8ql98Nba+kQ+8k2P18PFoHmtn7WplD9hqjNiX/WQtfN7RgMNfQxFt/Z4B+UgX
         qzsEdltIqNdxurIqHZuBfCLZU4AkjVymiEhez2uMSCtrf6ID6B+LFXEeco1lEG2Y4sTC
         yYMmctjUpYb69fWl3qgmOX0lpKyiOrVinN1ikkdG44u3Rp8Y5l8po8Q371fyNi7jvZ2V
         EtatazSbKYBgMWc/OAmPMkPww50vpMnCNlqpCP91dw8alURgmTUTTSgi7kCL+P+SXWft
         78Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHwKAsKrEoWrKBhY2PawvgB+vBiv6nowp261v5wtFSg=;
        b=VVXpfoMj8AJBCE7obdEkrEb9tM73OzAacEN5XPxvwCNWBXepeAwfZM+Xori8mhOXyz
         pFnFOmPMugnc8AeQzG8WM5dKg8gGj9mEzbMWPu4Tqth4zHXdviwH87mim3YA9rcaiHm+
         VFh08RlDwpcnpBPPlXnxoH09qOIJP9TMtMLwjJtuPjAsadYEreGJEIdLrsqxDoM7pgtx
         5NtD95XFXhWekkL2CXnki9IaHtTvId3M/ZOyg+/HwBQ9tAmg0K57Koy9XaQBH8IjRmh9
         Je+14iQotFEWz5pGk+X16xc4s6G2bt82+HfefAKv7rnJCgZ/omiNUcy86kfXXpT8E4g2
         bX9Q==
X-Gm-Message-State: AOAM531aLU1TFJy/YAPXmNBBzfYfaoyNMyE+T015bFHvcnGg3cP3EJOx
        m3dCC2LQWqnc6a0U5oa3n3UoQlK6JQFoAg==
X-Google-Smtp-Source: ABdhPJx4JR1cJ6U7wGsl8Gr5KtpaqWOSW5/Edu7oGyZF7WyrkpO4LtKlhaXkc5rN0iX8r0lkN88tAQ==
X-Received: by 2002:a05:6a00:1a46:b029:1d5:9acd:798c with SMTP id h6-20020a056a001a46b02901d59acd798cmr9160212pfv.25.1613072847330;
        Thu, 11 Feb 2021 11:47:27 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:26 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 07/10] t7001: use '>' rather than 'touch'
Date:   Fri, 12 Feb 2021 01:17:01 +0530
Message-Id: <20210211194704.28913-8-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use `>` rather than `touch` to create an empty file when the
timestamp isn't relevant to the test.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 6412c4f882..a56580b26d 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -49,14 +49,14 @@ test_expect_success 'checking -k on non-existing file' '
 '
 
 test_expect_success 'checking -k on untracked file' '
-	touch untracked1 &&
+	>untracked1 &&
 	git mv -k untracked1 path0 &&
 	test -f untracked1 &&
 	test ! -f path0/untracked1
 '
 
 test_expect_success 'checking -k on multiple untracked files' '
-	touch untracked2 &&
+	>untracked2 &&
 	git mv -k untracked1 untracked2 path0 &&
 	test -f untracked1 &&
 	test -f untracked2 &&
@@ -65,7 +65,7 @@ test_expect_success 'checking -k on multiple untracked files' '
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
-	touch path0/untracked1 &&
+	>path0/untracked1 &&
 	test_must_fail git mv -f untracked1 path0 &&
 	test ! -f .git/index.lock &&
 	test -f untracked1 &&
@@ -488,7 +488,7 @@ test_expect_success 'moving nested submodules' '
 	mkdir sub_nested_nested &&
 	(
 		cd sub_nested_nested &&
-		touch nested_level2 &&
+		>nested_level2 &&
 		git init &&
 		git add . &&
 		git commit -m "nested level 2"
@@ -496,7 +496,7 @@ test_expect_success 'moving nested submodules' '
 	mkdir sub_nested &&
 	(
 		cd sub_nested &&
-		touch nested_level1 &&
+		>nested_level1 &&
 		git init &&
 		git add . &&
 		git commit -m "nested level 1" &&
-- 
2.25.1

