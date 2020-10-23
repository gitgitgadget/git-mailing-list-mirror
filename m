Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707FCC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDCF20FC3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaPAXar+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750239AbgJWOAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750228AbgJWOAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB8C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so1700928wme.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EoJI1ouLT/ZJfAuVhka/RIrJPu5Bifloh1/ncu4uzQk=;
        b=qaPAXar+2qSthDN1zXuAVNbH622kG9AxT4+oiUo2pXGO+dNqo/Um1t3fq+czbbfMBM
         0OFH6LvHmzq5ppjJCDB2iLHD2M6cSZKdgxFNxyTgoWRHEhBD8fotOY4WM8FVOwntTXVS
         6sIZroF0K4+w1lCWIE8veQJ50PPVCERGKSmBNhCp3tCbEwEPPyawePhfNlTAmsUPJ5AW
         5k2UppD8Jcu07TMoxO+O//TOu8ajf8o8g5nB+OObzLEeDiQn93pLBYsuB+ZfrDsqb4dO
         1yYvv52PXo2ZzTv+/mLrv0RPxot0XD1cuUoh07CcAf4KSH4sGb5ro183h5FBXzZMqHbc
         wveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EoJI1ouLT/ZJfAuVhka/RIrJPu5Bifloh1/ncu4uzQk=;
        b=KqHc0K5FioZc9XaQUtVGZYOCTZr6zxY79dFOlfBP2k5d5bDIzjjt4ksLiVi3aTkzH4
         yaHNFXhfALrDWf8wykHCWa2TSk7UagmcHhO+vOSPDgTNWMXopjUALivVMXLsvyu/NvNT
         0lV0UUFRs2Tb/NngRInAwxY1u+ZIy3WKJsawWhEj3oe4DeI+8+1cXjGk7ddFPiYKO4a8
         +XXS7YiBCoClyjaa/4WwsGcKTVI+GQ1ePayWiECqUopvS3LIqeaObq6r0u1zxoaPdjWQ
         3x81grFcEb/Y1bc4ehJt0uqbflhjT7XUIXRCUcl3UcdlcfZ2st4qVoCqMaTNaod9DfMN
         v2og==
X-Gm-Message-State: AOAM532gf6hUuE2lm3Fvknx1K5YBm3sHrg6et/TIyOAsSrgy3fBvM3F2
        zl+LRnwuKQbJ77aZOP3c6zdPO2RvImc=
X-Google-Smtp-Source: ABdhPJzcdUqJ7MoopvEbEAvWiyM9j8eh1MkEmdZr7U7xWR9+5l0SMLY8v1XM/xtmKwHaXOG/oTsO1A==
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr2545129wmj.126.1603461609990;
        Fri, 23 Oct 2020 07:00:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm3611503wrm.25.2020.10.23.07.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:09 -0700 (PDT)
Message-Id: <e819084eb31a1fd3861c28f38856fa334fca798c.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 13:59:59 +0000
Subject: [PATCH v2 2/9] t9801: use `--` in preparation for default branch
 rename
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Seeing as we want to use `main` as the new default branch name used by
`git init`, and that `main` is used as directory name in t9801, let's
tighten the rev-list arguments to make it explicit when we are referring
to a ref instead of a directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9801-git-p4-branch.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 67ff2711f5..a3abd778f9 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -67,7 +67,7 @@ test_expect_success 'import main, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master >wc &&
+		git rev-list master -- >wc &&
 		test_line_count = 4 wc
 	)
 '
@@ -78,7 +78,7 @@ test_expect_success 'import branch1, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master >wc &&
+		git rev-list master -- >wc &&
 		test_line_count = 2 wc
 	)
 '
@@ -89,7 +89,7 @@ test_expect_success 'import branch2, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master >wc &&
+		git rev-list master -- >wc &&
 		test_line_count = 2 wc
 	)
 '
@@ -100,7 +100,7 @@ test_expect_success 'import depot, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master >wc &&
+		git rev-list master -- >wc &&
 		test_line_count = 8 wc
 	)
 '
@@ -114,7 +114,7 @@ test_expect_success 'import depot, branch detection' '
 		git log --oneline --graph --decorate --all &&
 
 		# 4 main commits
-		git rev-list master >wc &&
+		git rev-list master -- >wc &&
 		test_line_count = 4 wc &&
 
 		# 3 main, 1 integrate, 1 on branch2
@@ -137,7 +137,7 @@ test_expect_success 'import depot, branch detection, branchList branch definitio
 		git log --oneline --graph --decorate --all &&
 
 		# 4 main commits
-		git rev-list master >wc &&
+		git rev-list master -- >wc &&
 		test_line_count = 4 wc &&
 
 		# 3 main, 1 integrate, 1 on branch2
-- 
gitgitgadget

