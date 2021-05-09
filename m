Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C8C433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 09:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002FE613D9
	for <git@archiver.kernel.org>; Sun,  9 May 2021 09:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhEIJLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhEIJLn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 05:11:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99055C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 02:10:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r5so1813126lfr.5
        for <git@vger.kernel.org>; Sun, 09 May 2021 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pb4rDh+RouQaqWj6ihZcfr14Cpa02a4rHLbaN5PFPEc=;
        b=iRJlt5pR3H5szPth2ZsGLhDRju/f/2yz/iH2oS6DMxHt+artZbWLNtMarfyU7Ls7q2
         GpuvoSec46+WUcVuHribqclGrp3ZTXJRwfaIS7mSaNYfGejqHkWwTw1ZUXtKS7Pz1gCT
         5VzjUvfESg9R/O+Lndn6a3fFNPNw6dKO9RnPA8BBWtIEWc6cltZDWXjuOyYnfVoR2ZUC
         sgcdWFFPMhTVruxfbUumErYynHAOvCcH3hU2lM4I36o8dTJZ86OwxFmrgB84eQi4l7Hx
         kptKqoTuV+109Df0s1tHT8lPUTGTJDQ+x5CQecuEjdrb7SJymgyWkRlyX/0Y28wR4br9
         FiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pb4rDh+RouQaqWj6ihZcfr14Cpa02a4rHLbaN5PFPEc=;
        b=GFju/sXmXgWllWkxZxnZ+dftVWoeyj8AY0pFfVKN6lhrcSHj5aQEXCOZRmX1z3Rpav
         At1LwWGFWSX69K1l+tb6fiB2iR+4S3ZBGDELulHxP3CCBQfT7+r+HMqopdPFaxIwCOqz
         VRqXhh4+m/UnAoj1FcvNU70dnk5AokmocXJqJpmlBF5/kXiw7CGMsZfGfpcex4NXsINU
         pWRMA9qretE1yWhJkBmySJuhs/ANCJOsrrbgG5WcGnjiEL7MwUWpAdeIIcH3OzShcSQ6
         9IzHgHERvt2cwWHvvFex03Zl5hi13E2F5R1hDJQ83SIG6Rga2Lq54yQoAnlAEA0lCrGy
         3fHg==
X-Gm-Message-State: AOAM530AIeXZaRqj6QmauUKiDgBUT6EIcA85+dapvpYBgZFwlTSmy/Cd
        VopJNyLHKgko8NnFNCmmK+ZaY6Abcr8=
X-Google-Smtp-Source: ABdhPJwLx6OEqXe8IqxteS/Qu4ye0GFxNEDaZifoHBpzzyzKYIXpfXkN5ldDMxUs3wCn2xeKBpBkBw==
X-Received: by 2002:a05:6512:3b21:: with SMTP id f33mr12855247lfv.293.1620551437872;
        Sun, 09 May 2021 02:10:37 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id h9sm1839164lfu.305.2021.05.09.02.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 02:10:37 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/2] git-repack.txt: remove spurious ")"
Date:   Sun,  9 May 2021 11:09:59 +0200
Message-Id: <8adf03f456c756188863a8258f3867c389958a52.1620551314.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620551314.git.martin.agren@gmail.com>
References: <cover.1620551314.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drop the ")" at the end of this paragraph. There's a parenthetical
remark in this paragraph, but it's been closed on the line above.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-repack.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 317d63cf0d..ef310f362e 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -186,7 +186,7 @@ When `--unpacked` is specified, loose objects are implicitly included in
 this "roll-up", without respect to their reachability. This is subject
 to change in the future. This option (implying a drastically different
 repack mode) is not guaranteed to work with all other combinations of
-option to `git repack`).
+option to `git repack`.
 
 CONFIGURATION
 -------------
-- 
2.31.1.751.gd2f1c929bd

