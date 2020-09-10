Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E7C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AD1207EA
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 22:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIsKMnBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgIJWIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgIJWIv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 18:08:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2910C061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 15:08:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so11008752eja.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5YnPikx+dD4XFlxP36I0HMBlTolPT0fU6uEWuNyLqk=;
        b=qIsKMnBEWdBfhK6ysj3vu69bTa3/hvzrsCESVefEiacTUJOsdIPLnHVcbS2ayNZQEz
         dtumkqn5fXsrPuyReI+dKn2s0nDJGlc7ltn4ZCCM8x7lHxCyCagq1pBuX59OlxBRq8yc
         /7AZrY119tFbxGrNz+loFA0PX053Q57gAterNGfmdO8E2n2gvZd0FszKNym4AWwfMtgm
         eiXYVezZ+ra4KsQqLdtFOBncT1XgPcyKbGkhnczW/5Q6ZCkx0xedhd+5thly8VwExKWm
         PtrZWc6YqOPZfy+Oh/GlKkcMpOGTXssiyH/EHYLrZWAcZiR6Z9tsR4ishGtSP9R2D+p8
         Nr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5YnPikx+dD4XFlxP36I0HMBlTolPT0fU6uEWuNyLqk=;
        b=pVpedWldc5pnB+cQDSIiuP0WqDFM2DO9/9AIqKHurU+jkXFlTmzfTCINVQGttUy9/J
         rwBMM+i2ie2iTW2eZGKuay/MGvQABI/usn9J+YO2seTpBo3o09woeceDx73pp5+FTT+O
         i846iSS5sluNaEJqhUitdWe6SryIApIWk6O9rcoxeViKnP3HT+yj7iA1Kvvu+kZLiSzV
         2jtxeAyzQu2nbeOTrznR+61eLnSxE3yiYBwSlVlbwMR5MKaNba1RMcm51gWkC8IsTQZo
         WOjGjfOBEl1mRVD6L32j7LvUDCjpDfMUZFcI+b8ucTA5jY+h/wVIy3adnjMDSxKjCcbg
         z94w==
X-Gm-Message-State: AOAM5326MHFObvi8S+5tuJRh7bEa3jFG120nWPXcBc6XBTcBJ1pL63f3
        NVsz4r/eMtAByD3myie6KcWCr/wdux6Erw==
X-Google-Smtp-Source: ABdhPJykZUXp/ywNsSbozM3ch35xsrSTGvdnVb/3cr1bOL7MOnDoNBEao9ZCZHFDPMlBSdmvof/70Q==
X-Received: by 2002:a17:906:a98a:: with SMTP id jr10mr10541983ejb.229.1599775729173;
        Thu, 10 Sep 2020 15:08:49 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.114.178])
        by smtp.gmail.com with ESMTPSA id f10sm175925edk.34.2020.09.10.15.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 15:08:48 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH] Documentation/RelNotes: fix a typo in 2.29's relnotes
Date:   Thu, 10 Sep 2020 22:08:33 +0000
Message-Id: <20200910220833.14015-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.28.0.660.ga41e38b8ca
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fixing a simple typo on 2.29's release notes

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/RelNotes/2.29.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.29.0.txt b/Documentation/RelNotes/2.29.0.txt
index 4adb9ce124..e8538549e3 100644
--- a/Documentation/RelNotes/2.29.0.txt
+++ b/Documentation/RelNotes/2.29.0.txt
@@ -304,7 +304,7 @@ Fixes since v2.28
    (merge 6479ea4a8a jk/xrealloc-avoid-use-after-free later to maint).
 
  * "git status" has trouble showing where it came from by interpreting
-   reflog entries that recordcertain events, e.g. "checkout @{u}", and
+   reflog entries that record certain events, e.g. "checkout @{u}", and
    gives a hard/fatal error.  Even though it inherently is impossible
    to give a correct answer because the reflog entries lose some
    information (e.g. "@{u}" does not record what branch the user was
-- 
2.28.0.660.ga41e38b8ca

