Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2608C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6047E20781
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAEfAX+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJEI7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEI7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:59:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D2C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:59:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so8630369wrn.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nwvwZNX2snzesO9pCCQAtasmDvtqWe7rkgSiyKZvwSI=;
        b=SAEfAX+t5k7oJ7IYvVq42UPNplYjvFGN6Ly2Ex2hqoxnB8JyEiX27tsky1OC7zfMPn
         49IjRwWFlP7U9lbXeiL6Ksk0umVBlaFQeNavBM/uvyy+VCUGSH058xsT4KSQGp4IM2g1
         FnPoFA853CjVKKzVOSVI727X7g97dTbqNVIjtQ4BUX+y6fLjjVyg2vDMwthKCCCeTUAw
         wX258AxieqZQ7BAEQhwqU4eql+W+29u4lXvtMaM+XePSzJEN6xHG5XLNebJIvISQNDdD
         zQ66tmcMDTgvZmyGx4mOhL3WyiWXBJxQigyySoTQcM48m0lgGRDE5iD8ObDaciOf2a9t
         ZAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nwvwZNX2snzesO9pCCQAtasmDvtqWe7rkgSiyKZvwSI=;
        b=jeIKMchWHV1NEaYib27S54+trVsanmJ99SZceHlEBAXTv/16r1xWysc6e+JVI+q98C
         siA2fCsv52QsOxm+fDuejpeJvWgRnNrtHal8TQWLDL6OUX9ZtCjxp/LxCr303qIrcbcT
         8w0aJiaQuydsBv0i2zRwt9/nzzfDWfEjiw19vBsOgz7AOihze+nxpLyKfMF81Dv+epjW
         0KHnzACtiLyYwE1cpFUIKFKA5MaSzoXglAvwXGLndKjtyelqJ8frKJ8UDbzQGuDO8G/8
         k6SfPDzSKk74SVDpPQXUbkurxK2Gd00N7GGoIMyVyUtB6Ca4EUtVcDFL8pNhf2GGY+qT
         xSpw==
X-Gm-Message-State: AOAM5318zwrFdjf4OTtA72yJEF9B0zO7kAepX8PMbDffW4Go57wTaFjz
        IE60aITty2qBJctWFU263amU4W2h57Q=
X-Google-Smtp-Source: ABdhPJysDrPnTc1Zp67nqeTuafYh/iJCJDsXmSGvvO/WWspzTEmojT5OSZKTgCNZs2p+VKXI8BF3Xw==
X-Received: by 2002:adf:f207:: with SMTP id p7mr17740838wro.152.1601888339453;
        Mon, 05 Oct 2020 01:58:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e19sm14366031wme.2.2020.10.05.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:58:59 -0700 (PDT)
Message-Id: <pull.862.git.git.1601888338644.gitgitgadget@gmail.com>
From:   "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 08:58:58 +0000
Subject: [PATCH] docs: clarify git rm --cached function in gitignore note
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sohom Datta <sohom.datta@learner.manipal.edu>,
        Sohom <sohom.datta@learner.manipal.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sohom <sohom.datta@learner.manipal.edu>

Added text explaining that the git rm --cached command
isn't analogous to the gitignore file and that the file
will need to be added to gitignore to prevent later
commits from adding the file back.

Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
---
    docs: Clarify git rm --cached function in gitignore note
    
    Added text explaining that the git rm --cached command isn't analogous
    to the gitignore file and that the file will need to be added to 
    gitignore to prevent later commits from adding the file back.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-862%2Fsohomdatta1%2Fgitignore-note-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-862/sohomdatta1/gitignore-note-v1
Pull-Request: https://github.com/git/git/pull/862

 Documentation/gitignore.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index d47b1ae296..22d58df805 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -147,7 +147,9 @@ The purpose of gitignore files is to ensure that certain files
 not tracked by Git remain untracked.
 
 To stop tracking a file that is currently tracked, use
-'git rm --cached'.
+'git rm --cached' to remove the file from the index. The filename
+can then be added to the `gitignore` file to stop the file from
+being reintroduced in later commits.
 
 EXAMPLES
 --------

base-commit: ab4691b67bc1a2cd8d9068fb03e3fbd6979247d6
-- 
gitgitgadget
