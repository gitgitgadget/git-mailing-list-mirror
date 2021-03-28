Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7C5C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A101E61938
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhC1KT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1KTw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 06:19:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA25C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:19:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j9so8177073wrx.12
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=D/sEmEcvKCJ0hqoXDIh5K5LfSy89IrZXqWfvrvTAdv0=;
        b=Zb6g1VnxxpQ+N8a+i2b3CdyGTONTtID4n6UaGTB1qVPwLX8STaOGqMDUCmp8Ihd6oh
         OiKAH9Ce5jLT3BMLWIBoLAnGcVFifm+0aC/4n6KdwaWX/7IuHRExgAv9QXpPfwWgfm47
         6V4LFUrhDcf4pzESjMEs5NkxERtjQPX8l58ntaIrHz07Y7yrqvjTgZ7kS3TxSampuH5x
         EN2Jz0GZ1ML0Zvss68xBTZylDfEQv0ntuKnpemlBHGDJgAQxU4hMfhwEjeDYNmPrndwW
         b5R7X3OK/M+hwy1uSqVuN4y55nfILXKpmzUGrPZ0qypBsBRQGVbstW0c0myE4LewKU0g
         LeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D/sEmEcvKCJ0hqoXDIh5K5LfSy89IrZXqWfvrvTAdv0=;
        b=CrSPhXCXWSQIdqBR4xFyEVXRWQDOynSHt5M/KO5bWLlYGwE94rWKK2VMTMOR3ast2U
         Qw7WpiHozGNwQpf5Yju1BsydjgZmi0+DeHI66nM91JOYhFD9lWleeEIJPPdIACMxtBFb
         yp56FMq/nkf9rwJP1RM+PmE2zVkBMJUtQlPFOXpeGghbOhMhWyY5uX/eHRRzuYLUKt8N
         SHngv9bA/jPFHWXDMhtn0N+k30s3JT1BAj8TnPKO8N5zJmn3vOCUH0yz48adCJwsxLWT
         x0vGmVHr9P+Pqpc+B4K0qG2lebsW2kQvFuM8ZMT2XR6iefgCdKoZ1C+wAebnsG8Q4r14
         JdnQ==
X-Gm-Message-State: AOAM533/yKRjlL96h4OCxundKN1CK8w/w5HSbOEGf6+KYWZFpGmgI3pR
        c6WedzbKeWNqiO1JZoLG8dwT2Xz2prs=
X-Google-Smtp-Source: ABdhPJyiK03RscEeStzdV5yLQXeMf7DjIJdj3Rmd+E50KXf9LXSIoU8Ru6ynvv02abjmAEr+9/XuNg==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr22413082wrq.27.1616926790960;
        Sun, 28 Mar 2021 03:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm21675691wrp.96.2021.03.28.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 03:19:50 -0700 (PDT)
Message-Id: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Mar 2021 10:19:49 +0000
Subject: [PATCH] Documentation: updated documentation for git commit --date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chinmoy <chinmoy12c@gmail.com>,
        Chinmoy Chakraborty <chinmoy12c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chinmoy Chakraborty <chinmoy12c@gmail.com>

This commit lists the special strings used with `--date`
in `git-commit.txt` and also a brief explanation about
the strings in `date-formats.txt`.

Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
---
    Documentation: updated documentation for git commit --date
    
    This commit lists the special strings used with --date in git-commit.txt
    and also a brief explanation about the strings in date-formats.txt.
    
    Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
    
    
    Related Issue
    =============
    
    #302

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-918%2Fchinmoy12c%2Fissue_302-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-918/chinmoy12c/issue_302-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/918

 Documentation/date-formats.txt | 32 ++++++++++++++++++++++++++++++++
 Documentation/git-commit.txt   |  5 ++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 99c455f51c04..66dae179eb66 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -1,6 +1,38 @@
+[[DATE FORMATS]]
 DATE FORMATS
 ------------
 
+`yesterday`::
+	Change commit time to yesterday, that is, 24 hours ago.
+
+`noon`::
+	Change commit time to noon, that is 12:00. If current
+	time is less than 12:00, the time will be set to 12:00
+	on the previous day, else it will be set to 12:00 on
+	the same day.
+
+`midnight`::
+	Change commit time to midnight, that is, 00:00.
+
+`tea`::
+	Change commit time to 17:00(tea time). If the current
+	time is less than 17:00, the time will be set to 17:00
+	on the previous day, else it will be set to 17:00 on
+	the same day.
+
+`PM`::
+	Change commit time from AM to PM. If the current time
+	is already greater than 12:00, then the time remains
+	unaltered.
+
+`AM`::
+	Change commit time from PM to AM. If current time is
+	already less than 12:00, then the time remains
+	unaltered.
+
+`now`::
+	Change commit time to current time.
+
 The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
 support the following date formats:
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 3c69f461c9af..b2f51cdcafaf 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -176,7 +176,10 @@ See linkgit:git-rebase[1] for details.
 	the commit author is then copied from the first such commit found.
 
 --date=<date>::
-	Override the author date used in the commit.
+	Override the author date used in the commit. The value of <date>
+	may be any one of the following special values - "yesterday",
+	"noon", "midnight", "tea", "PM", "AM", "never", "now"
+	(see <<DATE FORMATS>>).
 
 -m <msg>::
 --message=<msg>::

base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
-- 
gitgitgadget
