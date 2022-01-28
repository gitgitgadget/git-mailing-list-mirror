Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52FBC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiA1ANq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbiA1AMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C96C061756
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h21so7648204wrb.8
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R5kIPpI1IVduCOF4U9IiXs2MRkltUuc73PAiD4gWMus=;
        b=EOO2Zmv0eydrqO28jZI215MKDZB2Y/SgnOSS71swlJQ1dZxeEkkM4XSo8PmoWbv202
         hRFczZoxhLiQopaSivpDoVVIEwyevsRN0lWPr4xuWsuwwJwJn4+86CCESwqCevF6j8fn
         YoP2QKl/da6aoVuQ4wETFsbI7RSxFEaIijALc3IF7ZXrw7UvPuFQMia52OyZobiELWdB
         wYJgdHB7bxQUoi/mQWfNQPBwyHgRosYQ2GXaDuSBGU+vUi6Bzm082YL7V9HpQhm2uSNm
         wyBOgYw2IRd7rXmAvkkn3KODZcTWVC0eWe4BvXdk4JnQeC0onSS5+/SvRAHmz9OaJKbE
         4V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R5kIPpI1IVduCOF4U9IiXs2MRkltUuc73PAiD4gWMus=;
        b=xUoVy67HnzKr1BBjWlUBY1biTBN4Z710CnE2pbnmSWM9/Loousml+jm2jL5k7h7U7k
         8gK4q5QiUmgkNHhVaSETOfsEL7zOLPGHP/iMpbJKc5yfNi67x/tG4oasYh2pU2ZKbVZo
         9kEEeIOLmBopLlBD+PKTPkmhQ1gnK1XUpZ2nQxYSkZnQTeH8kQXN1rhglKSlagkj6Z8F
         sf45ycrwPaNhTuit5qD/KITrY4DP1RVIfHjdmpbWHHQwg7I2GJeOslICdcbMgy4A/ENd
         NJIhgBOsmPGZTGcbm0NXy66mfP/ERrQGTGa3BTSagiOc3Md+2IxqdGeHF1RbcySNthZ7
         VENA==
X-Gm-Message-State: AOAM530IdED+B/z0KHqpSR4Trrfzx2IA9O70rq3BeUksHSnsfCptaewg
        rQc9Q6UctV8sTpAHzvmAFYKRMgD5oCc=
X-Google-Smtp-Source: ABdhPJwHbDvdp2EVAZ+f35UIZsmHmC2jro8q2aHdoGY9Xa1w5JoNtF/6jacmHiIO430xDX3oIA4s/A==
X-Received: by 2002:adf:a3dd:: with SMTP id m29mr4779465wrb.129.1643328761823;
        Thu, 27 Jan 2022 16:12:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm3114761wrn.106.2022.01.27.16.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:41 -0800 (PST)
Message-Id: <dc77297c6760e630b7db678f8429face05b39773.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:32 +0000
Subject: [PATCH 11/11] bisect: no longer try to clean up left-over
 `.git/head-name` files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As per the code comment, the `.git/head-name` files were cleaned up for
backwards-compatibility: an old version of `git bisect` could have left
them behind.

Now, just how old would such a version be? As of 0f497e75f05 (Eliminate
confusing "won't bisect on seeked tree" failure, 2008-02-23), `git
bisect` does not write that file anymore. Which corresponds to Git
v1.5.4.4.

Even if the likelihood is non-nil that there might still be users out
there who use such an old version to start a bisection, but then decide
to continue bisecting with a current Git version, it is highly
improbable.

So let's remove that code, at long last.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c                    | 3 ---
 t/t6030-bisect-porcelain.sh | 1 -
 2 files changed, 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 888949fba6b..ebd4287c01c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -474,7 +474,6 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1172,8 +1171,6 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
-	/* Cleanup head-name if it got left by an old version of git-bisect */
-	unlink_or_warn(git_path_head_name());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1be85d064e7..7f7ee42a7f4 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -945,7 +945,6 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing ".git/BISECT_LOG" &&
 	test_path_is_missing ".git/BISECT_RUN" &&
 	test_path_is_missing ".git/BISECT_TERMS" &&
-	test_path_is_missing ".git/head-name" &&
 	test_path_is_missing ".git/BISECT_HEAD" &&
 	test_path_is_missing ".git/BISECT_START"
 '
-- 
gitgitgadget
