Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAD5C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDF6206D4
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 10:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdq03ZCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFKhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFKhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 06:37:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF48C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 03:37:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o5so12861524wrn.13
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Q/QP7HLiEhmK5UmKbmNIKmDekXq87okost2OFKLVjZw=;
        b=fdq03ZCRThkMks7TA9iolFxX8/nQnXoKTEL5gqoxdzTYtH7/RuhX6QFl+oppSJb5Hk
         M0Be0EFoX/3jS/YmnsTElv0Evf0XUmdZLtB2RKOArZ+XUlcLDIe8YFK0y+PAKdqQjR2u
         N1PocvT8YFpLAiAY+FVzhC+6PgrJiUVDFLsR5VqOgN+bzOledcPjShR4qI3uEiTheEL6
         jgPVWD0LAwXdo3es0hcv1n/pnJAF9cJaSy4lIGKZ4kYLMeL4Vj/vRb/KMJi2aFC+pg/v
         db8RN+qKGpEkJNQb/3LlXOVZHO4yptBwWVSE3OG+F+1PRQGQeOtCkTTEKBZGm4c0esAA
         QDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q/QP7HLiEhmK5UmKbmNIKmDekXq87okost2OFKLVjZw=;
        b=dx8tC30P22ARaHDML50b0aea5SjBZWGTzfpLVineuJuBu0teqaWl1O0FzfMokqxbZx
         oBZoWoLH5cFH9S2tBWjBd9x0089XxuR2dXuguw3fDIlFtU0C1IWFj9g80QwKdHxA6icZ
         uvdbOx/aV1sCv5bfdOSe9g/tMwIqqlobxYdshD47G6AoJiPQatCQxm9euzAWVV43ZjWb
         OOjRJ8eu4JxN1l2lJnEPIireOk6G+2Ne+gjTs7peBVZjyakn2nJudaz69hdZG9Uqwq4j
         gKKJJzVSgzXUPEIgLg2fitcKSNUxZf01pDo0o5yCXQ58DZUk7P9iwWACdUEgAcUMeqx9
         w0+w==
X-Gm-Message-State: AOAM531OF6B2ySG/HoNQpkWUu63M7YL0SgCFvmVfNRH9l3KRVCAVMnMJ
        nzd9YWIRpTh5cmSiohp832QouQKkmx0=
X-Google-Smtp-Source: ABdhPJycEQ6ymNctiSkStxeES0l1DOG9y4da2G7kgMz9HBdbN5ohB7jF4o9ol7IVnkm6GNEU/tb4Iw==
X-Received: by 2002:adf:df81:: with SMTP id z1mr4350087wrl.9.1601980657963;
        Tue, 06 Oct 2020 03:37:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm4165775wrn.3.2020.10.06.03.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 03:37:37 -0700 (PDT)
Message-Id: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
From:   "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 10:37:36 +0000
Subject: [PATCH] Improve diff pattern for PHP files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Javier Spagnoletti <phansys@gmail.com>,
        Javier Spagnoletti <phansys@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Javier Spagnoletti <phansys@gmail.com>

Improve the output diff readability for php files by taking into account some missing function modifiers.

Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
---
    Improve diff pattern for PHP files
    
    Improve the output diff readability for php files by taking into account
    some missing function modifiers.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-864%2Fphansys%2Fuserdiff_php-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-864/phansys/userdiff_php-v1
Pull-Request: https://github.com/git/git/pull/864

 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 1df884ef0b..a99d84a7e3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -143,7 +143,7 @@ PATTERNS("perl",
 	 "|=~|!~"
 	 "|<<|<>|<=>|>>"),
 PATTERNS("php",
-	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
+	 "^[\t ]*(((public|protected|private|static|abstract|final)[\t ]+)*function.*)$\n"
 	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
