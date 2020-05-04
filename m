Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763EC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31B620643
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH9PInRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgEDFmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 01:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEDFmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 01:42:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46896C061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 22:42:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so3300703pjw.0
        for <git@vger.kernel.org>; Sun, 03 May 2020 22:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERi6DVrztVOelH96Vv9qKCzrU1bwPaK3h/kcUTy+X3s=;
        b=FH9PInRHXG/sNedk4rT7FqRcyCVo8HRmjfGhnDIVOXz4zoEhafD8LgP7gVRfnz4DWs
         YGC+MIOO4az8R6bjiY5W/xX+NQTH2o4BP5ESxdy89apCK99aB0/OWwimdWy+bAcMzKr1
         RK10Jf5EBYLF/PTngqnEu3jraZDZxjxCXXzhCi8vE0Ovy4oiq4mtc/6oLXag2aAPwBvB
         LBBt3efFA1ZT6gAnLjJHgD/dSb800JcYzSh3SYpsKYVPFRoYLp/6nJBr1eWVaYfWxqaz
         Q/fabtHaBuiRFLKEGZyG0eAkv7JzA9M17KhFenlCaOOugTjc2JKHDOluheKxA21rVmqL
         lbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERi6DVrztVOelH96Vv9qKCzrU1bwPaK3h/kcUTy+X3s=;
        b=ErJuLDQOZBHXfqa1D/A0Y4CrRZBZ4ivU0SNF5m3o3pGoyt6bgKa9eUFvuX8Gup6xqA
         9IWY8WSfdz3onRQrSszSpEog1HIyxWhXwTO+Yblrv8WMU4BuyNaraEQGxaqSGY7Go2B9
         M7nBtC4nuG99BqBwAOZaWTmWIRWutwnXvndU/nn2z/qwfJOBCqDzYrega64TN5GDH8AS
         8PIUWFJN50FkdXTWnANRl1CigK6rdD4ytb1mMjeIsXKfSc8Ed0Ibb9MgnNTlpEaj1TeX
         iUbH92XrUzmWEkDgwLSuwNxBufdbItpgO0RrcSOInZgvip32aIcnT2d/J//AyAR95AMI
         wlFg==
X-Gm-Message-State: AGi0PuYsH81cmVsIRS6KS+ThfIWJhC8p7kf74am7WtGlC4AHT2dnQz7w
        80Jp/InW9m78PTgro6Xr/1A12FwOHJo=
X-Google-Smtp-Source: APiQypKtO9mIgZtEiFQ79SHIqGAIvVHFoMFY5FFM4CYk7+d0PSs4Ym+a6Ur2LimFbZTXesZvSeJ9yg==
X-Received: by 2002:a17:902:7596:: with SMTP id j22mr14971285pll.226.1588570961346;
        Sun, 03 May 2020 22:42:41 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id 189sm7850785pfd.55.2020.05.03.22.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 22:42:40 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, newren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v5 4/4] gitfaq: fetching and pulling a repository
Date:   Mon,  4 May 2020 11:12:23 +0530
Message-Id: <20200504054223.11125-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
References: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an issue in 'Common Issues' section which addresses the confusion
between performing a 'fetch' and a 'pull'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 5dfbb32089..04ea7be99f 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -255,6 +255,22 @@ way of cloning it in lesser space?::
 	presumes that the user has an always-on network connection to the
 	original repository).  See linkgit:partial-clone[1].
 
+[[fetching-and-pulling]]
+How do I know if I want to do a fetch or a pull?::
+	A fetch brings in the latest changes made upstream (i.e., the
+	remote repository we are working on) without modifying the current
+	branch or the working tree.  This allows us to inspect
+	the changes made upstream and integrate all those changes (if
+	and only if we want to) or only cherry pick certain changes.
+
+	A pull is a wrapper for a fetch and merge/rebase.  This means that
+	doing a `git pull` will not only fetch the changes made upstream
+	but integrate them immediately with our current branch too.  The
+	merge/rebase may go smoothly or have merge conflicts depending
+	on the case.  Hence, a pull does not give the user a chance to
+	review changes before applying them to their local repository/current
+	branch.
+
 Hooks
 -----
 
-- 
2.26.2

