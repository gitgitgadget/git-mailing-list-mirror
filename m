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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10A5C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 06:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819E860FE4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 06:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhESGlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhESGlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 02:41:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76340C06175F
        for <git@vger.kernel.org>; Tue, 18 May 2021 23:39:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i17so12678813wrq.11
        for <git@vger.kernel.org>; Tue, 18 May 2021 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3aYwi1f/UV8Vkc+984bIH/tnj0mBThDspWJirtVcJdE=;
        b=gw5kVt17oc9MDXwj5ZB09B0l0mMvDF980vCUdSMNmMCDCj9JmFyJLzxe3BsGxYDX7j
         5vtuCYp6P7zOm8xO+vszPhSaiOH6YGz+shOpB0oUAEyQxNKB9WXqCx0ghGBwKumPDOgN
         rw6f/2Qm1U8OMMqG8+f5tsy4ZLt72hR7TfuPnNzoZa6tzpQMpCIGXMUBSoQwRK3Oxb3O
         sNIofak5Sg60R75nTXFr3+OCQiVnJuXrDgiLFA/evcmt5YXmWcer9ZWRRg27YlbpjabQ
         Dq+SYqBfI1hUa2GTWaXNuTlachqUJGuyVaiZiGHYH04HEC39WFDRT4lVv3ZRmvTp1P6l
         X+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3aYwi1f/UV8Vkc+984bIH/tnj0mBThDspWJirtVcJdE=;
        b=n7gOvC5xVlvgE4KRdE+pRSPk9YKxDsrO/kW7W31RWDnJiBLyXCajq8kqh0nxZJkdKt
         pcBHSVNKei2egMXthv+MljdfdczAh/NutQArH+R9R94XGf3mZcppn8YyDMNZ85UKG/Gm
         0L7QWH88RELjgvbaU14ooEPYT1y8cYJivQYsSBhbwsOMJv4oyTlp3lIE1kZrlLix4bkx
         38OZPUYN8U2ZkdQV0t+CfQexGk5PX4gwBlSvPZoRrafozXwdWrHe5wCTxtBl8uuevHZx
         90ckEqaqBp6C772Gfx4bSF0KULKhhYvaNZ8KqgqVScmciOBFf48nZ2UFyQg6jPqvoyAT
         ATgg==
X-Gm-Message-State: AOAM530xF/hbTixbyuaTzjkOTjHEfmcauurrodkEtnV6LCBpLJRV1gbC
        zcCZZ4AdF5+tekJpHPh0pGdf4fpQlwU=
X-Google-Smtp-Source: ABdhPJz7jM79gD3nQR6HHZylSizcSZB2RjbovaM8Qc7SHNRGm1rKpBVJqjjSRl8iX24uiWk6o82j1Q==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr12288879wrn.120.1621406382458;
        Tue, 18 May 2021 23:39:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm24571139wrw.20.2021.05.18.23.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 23:39:41 -0700 (PDT)
Message-Id: <pull.957.git.1621406381404.gitgitgadget@gmail.com>
From:   "Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 May 2021 06:39:40 +0000
Subject: [PATCH] docs: typo in glossary content
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Reuven Y." <robi@post.jce.ac.il>, Reuven Y <robi@post.jce.ac.il>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Reuven Y <robi@post.jce.ac.il>

his->this
The 't' probably just failed while typing, since we refer here to a branch not a person

Signed-off-by: Reuven Yagel <robi@post.jce.ac.il>
---
    typo in glossary content
    
    his->this The 't' probably just failed while typing, since we refer here
    to a branch not a person

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-957%2Frobi-y%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-957/robi-y/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/957

 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 67c7a50b96a0..e75aed00ffe1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -146,7 +146,7 @@ current branch integrates with) obviously do not work, as there is no
 	<<def_revision,revision>> and you are "merging" another
 	<<def_branch,branch>>'s changes that happen to be a descendant of what
 	you have. In such a case, you do not make a new <<def_merge,merge>>
-	<<def_commit,commit>> but instead just update to his
+	<<def_commit,commit>> but instead just update to this
 	revision. This will happen frequently on a
 	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
 	<<def_repository,repository>>.

base-commit: bf949ade81106fbda068c1fdb2c6fd1cb1babe7e
-- 
gitgitgadget
