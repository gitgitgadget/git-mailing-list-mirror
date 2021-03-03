Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AED4C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0660464E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbhCDAW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbhCCMxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 07:53:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF3C06178A
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 04:40:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l12so23513866wry.2
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0PTK3cDcbYhAXdlM/oiJDcaYXuKvWAlTpztrI9mU3MQ=;
        b=KzARGA7wEfR9O8dZYzTFnhMRW4jiyFopbldTzCdlOV/ZSSBIFCZkibyBGpQuKjRls7
         XNjMsrNIZDSExFUw7hXgpbT2cFuiYV3nOHWKD0UPtaGCoeC9xcMPLylibINaLtkPCyjx
         odnO8QXwFqOegoNHlId1GHnv6rZrZG+mDaUCMAG4KB6qCEWnHPZStASHlAKapsTbggFi
         5i+jhvtihX4XtLTJGE2VML24kreh6eUFM4+v5wvFgBSHZRZmq3Bm5DjsPWDfEg9jhM89
         h0VzVab+tuLi13760dCmVqtJKBFAAZB2zqlNuawNWY5cK6eXromcvkm9S+Ez/9hdRA/b
         X5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0PTK3cDcbYhAXdlM/oiJDcaYXuKvWAlTpztrI9mU3MQ=;
        b=a8ZOMSKFj9NI4j9s+7WMpdf/+y4du9MyVQeajXMRHhA7WmXrtx2aQuMAOH8YcDh1Ft
         VUDLkAZcOvNUKoUx7PMxoxNJDYPkBmxYD+C43SeN576kjw1OKs0SDJTWPUOmlacAR6KP
         +nEGHclT2H7xKNHD+iHLpg6TTyMrD4OQevN9iDbY4NhXNqHkyTvNjryxqMwl8GTlf2Vq
         13OlLzbNmr0xz1ONV+6ZsMEowNB6Ru1N4/wO3ObAEB8gekAN8fpnJDxe/zhkLyRpeJ3n
         O42ecMV/3JWY6IVrAx5oCAse2gJQ2pMgGL/hqQlrS/koCuIDNLLI71oUa7TAKBrox6/E
         46ig==
X-Gm-Message-State: AOAM533bvtGUmE+K4eJ6IgZ+ncJXdn2oEdQv9L2qujaUd6mi9tkrdRWa
        3Wyw4GR+jGPzgd1W12wlplDU8EI/C0Y=
X-Google-Smtp-Source: ABdhPJwdWA/KR7sQVFQW6oJLJMKRP5JOCPn19oyvfvhVkfTB3KL4GHdPoD1NSZJJ4eJkaVYn00Z8Rg==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr27561942wre.83.1614775255412;
        Wed, 03 Mar 2021 04:40:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm5897816wmj.6.2021.03.03.04.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:40:55 -0800 (PST)
Message-Id: <pull.972.git.git.1614775254623.gitgitgadget@gmail.com>
From:   "Julien Richard via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 12:40:54 +0000
Subject: [PATCH] Fix small typo in .gitignore documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Julien Richard <jairbubbles@hotmail.com>,
        Julien Richard <julien.richard@ubisoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Julien Richard <julien.richard@ubisoft.com>

Signed-off-by: Julien Richard <julien.richard@ubisoft.com>
---
    Fix small typo in .gitignore documentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-972%2Fjairbubbles%2Ffix-small-typo-in-gitignore-documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-972/jairbubbles/fix-small-typo-in-gitignore-documentation-v1
Pull-Request: https://github.com/git/git/pull/972

 Documentation/gitignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index d47b1ae29637..5751603b13f4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -153,7 +153,7 @@ EXAMPLES
 --------
 
  - The pattern `hello.*` matches any file or folder
-   whose name begins with `hello`. If one wants to restrict
+   whose name begins with `hello.`. If one wants to restrict
    this only to the directory and not in its subdirectories,
    one can prepend the pattern with a slash, i.e. `/hello.*`;
    the pattern now matches `hello.txt`, `hello.c` but not

base-commit: ec125d1bc1053df7e4103f71ebd24fe48dd624a2
-- 
gitgitgadget
