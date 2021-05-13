Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC8C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F1D6140C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEMGXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEMGXu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:23:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385CEC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:22:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u133so2615581wmg.1
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=50QAKmd1u9LqHVd3dD/vWuCp5mFyx1YtT6YKUiJLSIA=;
        b=bLWLzIC7PMIn8Qqvtfj03pnGGxarvS7xP7gGcWOFRPzT3GI8kSfYeo/uh8SlRZViMv
         UBDuPMMmafWnfh4u5KogMGJhFb0hFiSFMoUSvSROsSGWqyEnscu7C6e+Ucz5wtbI4AbY
         jPrtETbJ9axHNzIoz01yheC6m/Yx170Au1Ied8xvFv4Ae/ucTHI5Mz7X/WshgbuBJSte
         zztzj8oHSET24mwB0NRMxZDIdvkfMgPe8azTT6SGF3iCDD0F0dUaoHv1Wov+FfZUt69c
         QB1UE+R2wIyAs3jVfKdlaaiGz2AT5pBo/COxH6+xzuzI0Rn4VQACpOw1S9u0iEKIivFr
         OU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=50QAKmd1u9LqHVd3dD/vWuCp5mFyx1YtT6YKUiJLSIA=;
        b=Ah/BNfHmkuz1GkEFQgufqq7iKskU1T0M8sMpaI6u6Vn662buGwk7Q8ZfJAzbVgqbfn
         xBNFQI+LhSr+e6zJu7xIqtkRHya5ORdDjKW6clVHxSB0eITGv0SwD2NRaOpAk1vHqzFi
         1MxKwo4p5uGASLQf0W8gsu/HZ5f6SzU40osMcjF5l9NFJdgIRoQVnXQqQpkGvkwm4XuN
         bQszaCU5MctQwczw8O6k7Xa+q4Om9379BADGDUE2jMfZm0ttZVQu4THuCbKpPYscwDwL
         Upm+ibs7ZL0yeVbmYo2HvgS1SEDyOgcjtDR/cHd8VrGOtWvUusQyHieZBoG6QRfTWZ9I
         hGUg==
X-Gm-Message-State: AOAM530JeMkCktoOpXfVFYykvFYv8EsEVDXJH62gOSJy1dACuuw3CtO7
        FvRotelebgD8rbP+cu1CtPosAkBP44w=
X-Google-Smtp-Source: ABdhPJwdRv7tjlX/+JedWVYlhEsrKZ9l93m6TcWbqb08/KFCN28EbeVKvvbwnCgcRY1jIfKkUVvq2w==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr3090254wmc.127.1620886959059;
        Wed, 12 May 2021 23:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm4785894wmh.32.2021.05.12.23.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:22:38 -0700 (PDT)
Message-Id: <pull.1024.git.git.1620886957441.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 06:22:36 +0000
Subject: [PATCH] git-prompt: work under set -u
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit afda36dbf3 ("git-prompt: include sparsity state as well",
2020-06-21) added the use of some variables to control how to show
sparsity state in the git prompt, but implicitly assumed that undefined
variables would be treated as the empty string.  This breaks users who
run under 'set -u'; fix the code to be more explicit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    git-prompt: work under set -u

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1024%2Fnewren%2Ffix-git-prompt-under-set-u-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1024/newren/fix-git-prompt-under-set-u-v1
Pull-Request: https://github.com/git/git/pull/1024

 contrib/completion/git-prompt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4640a1535d15..db7c0068fb55 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -433,8 +433,8 @@ __git_ps1 ()
 	fi
 
 	local sparse=""
-	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
-	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
+	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
+	   [ -z "${GIT_PS1_OMITSPARSESTATE-}" ] &&
 	   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
 		sparse="|SPARSE"
 	fi
@@ -543,7 +543,7 @@ __git_ps1 ()
 			u="%${ZSH_VERSION+%}"
 		fi
 
-		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
+		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
 		   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
 			h="?"
 		fi

base-commit: df6c4f722c94641d5a9ea5496511f7043433abc2
-- 
gitgitgadget
