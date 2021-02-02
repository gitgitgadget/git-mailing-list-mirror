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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6EBC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8279764D99
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhBBJid (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhBBJgV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:36:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82790C061221
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:34:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d2so1987840pjs.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gNSRZvmx9+OCMyIXehfEVMJ0vxwEygopOVzVXTd4+OE=;
        b=jdgLH9PiwnGYPOeRs69KTw2M6dstJKfYLigeESORXxXwzSK0BVbH76Q5LKAOOxitEw
         2yev8xcLieOwxzay2/aA7n/Ye+Cpyw5hK5Y6RK+CgDy/E8Fs8ZzQVmDb1xsru3tiWn1R
         wQI9jmYjP0GKaYhGYBmSrhAx75UjlbmfrZ2lV1AJxhV+bMdSFruYPQ4bLVsuyN0gf5Qz
         rvuTYTpI2PCzZewqdE7g7Ngr4gBA+XDUjCW8risak8hI8kOrHJ7rONnjvGv1ep5PNeSp
         9rDoi3j5dVnJun446lJwBa06MscQVLLTiSwt+fFEnLwF4hnya33fMn8hg9aBFKw2YYLD
         V3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNSRZvmx9+OCMyIXehfEVMJ0vxwEygopOVzVXTd4+OE=;
        b=lx5x+W2KAys9gWhfdpukzYnNDzZ6Z3DngAMVtmH8LAe9DfsO5uoyl7dQbGXsqXOSW3
         jY2aARYP6IztfEi3rX4iLZiIkMtEAAx011x/FGkRChuhBA53vNsUHxjP0I/P1oTbNNBU
         WrtCpGXYDCrUyVD+QLhBhnOoimBkQeRZSnbeRu/FkNXePRw+pwDtM7MpbrlS12MWuFQj
         FLNxpvxVsSJRt5iVylCj0OQmZfD5RphmWEDCtamY9EjglbgmN65o3BVkcrThhQL8BVdn
         /Lz7gIL/nkUrHpPFbxoxWFBrlgFU4/sWNINc2zI5k5nbvDY7cBhi9PlAVUJQW9VodGAJ
         fhkw==
X-Gm-Message-State: AOAM531va6NiSvVwlavedvTVxxrZ+ZxxFPeE15fLBX6QAK18QwVa8mkj
        dpXLxOLlfPS2+ONbtHwPeHuvVlEzrI0=
X-Google-Smtp-Source: ABdhPJwBATCoGOBc7o6tuO6S72lo8IzmEATYGLmSFZgsb7SEhdOYZ6Bcl02rzW4ZB7L+APGkYnvjHA==
X-Received: by 2002:a17:90a:ca8f:: with SMTP id y15mr3364642pjt.119.1612258453927;
        Tue, 02 Feb 2021 01:34:13 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.34.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:34:09 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/9] t3905: replace test -s with test_file_not_empty
Date:   Tue,  2 Feb 2021 01:33:22 -0800
Message-Id: <7fe27ab620457af9b777f6087dc5c235fb87eb01.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to modernize the test script, replace `test -s` with
test_file_not_empty(), which provides better diagnostic output in the
case of failure.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index f008e5d945..c87ac24042 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -169,9 +169,9 @@ test_expect_success 'stash save --include-untracked respects .gitignore' '
 	mkdir ignored.d &&
 	echo ignored >ignored.d/untracked &&
 	git stash -u &&
-	test -s ignored &&
-	test -s ignored.d/untracked &&
-	test -s .gitignore
+	test_file_not_empty ignored &&
+	test_file_not_empty ignored.d/untracked &&
+	test_file_not_empty .gitignore
 '
 
 test_expect_success 'stash save -u can stash with only untracked files different' '
@@ -189,9 +189,9 @@ test_expect_success 'stash save --all does not respect .gitignore' '
 
 test_expect_success 'stash save --all is stash poppable' '
 	git stash pop &&
-	test -s ignored &&
-	test -s ignored.d/untracked &&
-	test -s .gitignore
+	test_file_not_empty ignored &&
+	test_file_not_empty ignored.d/untracked &&
+	test_file_not_empty .gitignore
 '
 
 test_expect_success 'stash push --include-untracked with pathspec' '
-- 
2.30.0.478.g8a0d178c01

