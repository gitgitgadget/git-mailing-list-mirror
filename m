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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D53C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E7E23B98
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 08:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLIIOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLIIOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 03:14:19 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F7C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 00:13:39 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k10so609995wmi.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 00:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fxjGSUKgCdZlFj539nfmyP3r7nbeZgzDaxsQWLwOOS0=;
        b=gJAV0jXov353aW+Xy1TnHNoFZXeLvqOC6TiaZAGFV5NKM2gzmy2zSuAPnA3baE5CpI
         HQiGoNUJREDeXuHDJmB/6j6oM4hfh9GEsu/vTbAwdH8T2jk16MdxOXd7Aem53SemjbPF
         uyQeXV6G6OEbnH9xjm+gl45KwrG3O2bPDyLuGaXig/bFTXAMc1hE6FL1RAsQvJ4Du2Xd
         mEZXkZ2httgeNx+Ro/gtg1Xbf2AsfR1J9QLpp4tD9XzYkF/DxgzuWX+614V0h6ehBv63
         i9PfkE0f1UOt2UeA/7rF/UZKUtUCZvqeIy+0P6LnPWgTaMRkjcux7nObIW/A4l0cMKQZ
         IbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fxjGSUKgCdZlFj539nfmyP3r7nbeZgzDaxsQWLwOOS0=;
        b=CZz+z0ENRolNwb1wqI8Je2BQp++J69b8C4Ppo7TIz9/4yURVszSE3QsaLFNrIDLlC+
         Qkn1OXFq7XbchQm+k7qpo5ZlnCjQB9wpNyux7zRLwXO6tgVFHMh5K3apNwbBqfXL2ZTN
         lT0eplfvIbI/h6PVMZfU/lhrbKyYPqsGhCXDAzysBFOPyOtLfZTFpUb3H4jjDdeWk7GX
         kl9J2Pop1p7R9hnkfpTvTuGUJ2ngD25fz64eGN/JADior3B90Xj0/Vc/jxFkfNFtF2WE
         mTF8M9ZRkIhFgdDdCasSscF1DY6lhCLro+a3IaBPcRCBjv0V7i62aHaGCskm57UY31bo
         wwLg==
X-Gm-Message-State: AOAM5330bTrnTLXzpBIrOZFbY1tzc/SLO1CxCO5GjCF0F+GEfbmjTaZb
        Oj2f9yfC0uO3SCRlGCJWPieO0rbev4c=
X-Google-Smtp-Source: ABdhPJz2602mwDwdxfk7Nhr0qOR01IUpleWuYXJqWRyMGLLg9E4FBB/3BXgS5pnSxJr1+sb4SEzAng==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr1418706wmk.92.1607501617812;
        Wed, 09 Dec 2020 00:13:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm1763310wmd.47.2020.12.09.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:13:37 -0800 (PST)
Message-Id: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
From:   "Julien Richard via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 08:13:36 +0000
Subject: [PATCH] doc: 'T' status code for git status
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

Git status can return 'T' status code which stands for "typechange", fixing the documentation accordingly.

Signed-off-by: Julien Richard <jairbubbles@hotmail.com>
---
    Document 'T' status code for git status
    
    Git status can return 'T' status code which stands for "typechange". I
    can't document more the behavior but it would have helped me a lot to
    see that line in the documentation so I guess it can help others too.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-930%2Fjairbubbles%2FgitStatusTypeChangeCode-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-930/jairbubbles/gitStatusTypeChangeCode-v1
Pull-Request: https://github.com/git/git/pull/930

 Documentation/git-status.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7731b45f078..850c33b3696 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -197,6 +197,7 @@ codes can be interpreted as follows:
 * 'R' = renamed
 * 'C' = copied
 * 'U' = updated but unmerged
+* 'T' = type changed
 
 Ignored files are not listed, unless `--ignored` option is in effect,
 in which case `XY` are `!!`.

base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
-- 
gitgitgadget
