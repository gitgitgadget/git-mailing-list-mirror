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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E0C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112E364E15
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhBIRfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhBIReb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:34:31 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F9DC06178C
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z7so228382plk.7
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gfk4ClQpcJm886xeJ5dk14ZHlKvVFDE4MmC50jAdgA0=;
        b=hFmMHTrqzHj/WVdPjgRSyewH9ZYTfce5Tbgm87muVR+iqkz5ww8kXMHTlfS3CP9huY
         9UXQj1BQ6DJ6p78We5VM1tExPuIOWifVk6CRdzJtm8j5yWU62cdcsYFJ4KiTGN0pteY3
         cHsf7EsM2dCNUlv2l+9LkRyyNPPCVZ6X2crliHpX2pw8s8gCF/FnofUXUFO9+JPOrFyI
         v6pALgyssmg069KuiJ72J8903I7YjPQ/sTMprW8m4xBR6HdRD87XsZ2RrxQXZBfFptgU
         GqOzoyVMB4CtKFYrklnBXQkOUh6Ch9z6Qkk6jcgnL2uOl15fDM0eG8tTkB9KwwCYwsuL
         SCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gfk4ClQpcJm886xeJ5dk14ZHlKvVFDE4MmC50jAdgA0=;
        b=uC3Krs5but4lqb4Kn3HvsplTXobYSLFeBcRmzgfy9CYszpOl5KEuSnmPzsQZVVzhv0
         +DDexv8QnFURuszBXkM6MdSIzPfi9+qXaJZ315z3QbZxcHLOvJyP4Cly2tJZtilMHxGy
         hxOGN18FZtLv4ZAE7dDAuHWAz/jXm9jPJ/AfqMcVtfKeR+pe3ewaTzrAx/gVpMnWF1Gq
         /HFdddJL5kHuJpncKKmCnvf5fdDvkW2zy2Dnxq3JEH+9jJCgbb/CuwqgtUwBfN2lW+pc
         jWu8ne12/IFK+PThmmhcl/c+o8mXceiaQL2M+75Y6mzL8BXjZax9uWUNqflBbJsc47e4
         si+w==
X-Gm-Message-State: AOAM532LpKQP/a2pKvtHi1F4PQsbW4hbZx4Y8Ce+hggs7OsDXBM847Hp
        Cr5PoruUc0XNojVbBG2eO5yvNutmeGQ+7g==
X-Google-Smtp-Source: ABdhPJyjNFbacrTFmY/fCwsFafweCVWEkt7HPbJG3TCfL8w4GQdd5gOWeY3D9hIAoZsJI+J7jzAHQg==
X-Received: by 2002:a17:902:f688:b029:da:a817:1753 with SMTP id l8-20020a170902f688b02900daa8171753mr21877130plg.76.1612891997159;
        Tue, 09 Feb 2021 09:33:17 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:16 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 07/10] t7001: use '>' rather than 'touch'
Date:   Tue,  9 Feb 2021 23:02:51 +0530
Message-Id: <20210209173254.17712-8-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use `>` rather than `touch` to create an empty file when the
timestamp isn't relevant to the test.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 81897a3095..1671241fc8 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -47,14 +47,14 @@ test_expect_success 'checking -k on non-existing file' '
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
@@ -63,7 +63,7 @@ test_expect_success 'checking -k on multiple untracked files' '
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
-	touch path0/untracked1 &&
+	>path0/untracked1 &&
 	test_must_fail git mv -f untracked1 path0 &&
 	test ! -f .git/index.lock &&
 	test -f untracked1 &&
@@ -486,7 +486,7 @@ test_expect_success 'moving nested submodules' '
 	mkdir sub_nested_nested &&
 	(
 		cd sub_nested_nested &&
-		touch nested_level2 &&
+		>nested_level2 &&
 		git init &&
 		git add . &&
 		git commit -m "nested level 2"
@@ -494,7 +494,7 @@ test_expect_success 'moving nested submodules' '
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

