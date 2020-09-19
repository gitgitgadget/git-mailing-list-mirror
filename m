Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86FEC43466
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6751D21582
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="Qpw6GbEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISIx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISIx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 04:53:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42061C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:53:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so7853078wrn.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXMLzkOkn9I04C+dF/LGy1JF4W3OErj8c9doi455Y6o=;
        b=Qpw6GbEQc7td8nt0SVxDDr2bOuYG5+ftgNQXEclvxHM9ee78rEu/oyaLKFik21aLrL
         NTL9TV+h1Uzws7/x+ieBQ69RoWYPWRZAzzONJBDSrOWn20mdtyKLyW+YjE0m8ogor4d2
         SeYkc3hDxPQMGjAbgEvnaBKChjVT+DA7cJxnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXMLzkOkn9I04C+dF/LGy1JF4W3OErj8c9doi455Y6o=;
        b=GviOwj0D55jGff1/KlO8ZBAJFUyasA+0RaOZgD4EyFI+Dn80wapQPxdBthKRyPSeq2
         fl/1uF+5hqWsj7V7GrbXFgK7OSxmKCCG76hKnPrwG7OpmrgJNhrvNhMd3ME87SsSzcFy
         YxQL6j+kmfeNN1S/lQCijaQSoW2WCHJa+u8qZtxVXeEtB8Pk/b2jjfwwB3xoXkOAugcC
         YqbYQ+3nV6cF6NFz0wfnONqOJabzdl68bXGZ7wmij3szTiwq+1zGckAH+yLW6nrDsf2n
         vKtRZt52ZJJ/GcEke2Y3RqKZRH8jPwgGWIs8vVCKfLeky16S1pw2kBxwrPmAeoPuaZZd
         7MBg==
X-Gm-Message-State: AOAM533OdXktB3aRuFVgkx1SselCNM2LPGSz3bYRD388Ac2zh7h58OTy
        hespURv9/Q4bX/KYFPWVQEXAFtIsiZJQPQ==
X-Google-Smtp-Source: ABdhPJzHKRM0V/bsFes1J3JCTZF9tM/N27rtqW+vugJcooVX7EXdJDsO9G3FfqYAT6RmL7g/K2OyRQ==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr41291754wrn.63.1600505636867;
        Sat, 19 Sep 2020 01:53:56 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id t15sm8798872wmj.15.2020.09.19.01.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:53:56 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/2] git-p4: use HEAD~$n to find parent commit for unshelve
Date:   Sat, 19 Sep 2020 09:54:41 +0100
Message-Id: <20200919085441.7621-3-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200919085441.7621-2-luke@diamand.org>
References: <20200919085441.7621-1-luke@diamand.org>
 <20200919085441.7621-2-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Found-by: Liu Xuhui (Jackson) <Xuhui.Liu@amd.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py           | 2 +-
 t/t9832-unshelve.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ca79dc0900..4433ca53de 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4237,7 +4237,7 @@ def findLastP4Revision(self, starting_point):
         """
 
         for parent in (range(65535)):
-            log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
+            log = extractLogMessageFromGitCommit("{0}~{1}".format(starting_point, parent))
             settings = extractSettingsGitLog(log)
             if 'change' in settings:
                 return settings
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index feda4499dd..7194fb2855 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -80,7 +80,7 @@ EOF
 	)
 '
 
-test_expect_failure 'update shelved changelist and re-unshelve' '
+test_expect_success 'update shelved changelist and re-unshelve' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.28.0

