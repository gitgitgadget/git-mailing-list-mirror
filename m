Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1132CC6369E
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD4622244
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARfiYCFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgKLWoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbgKLWoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:10 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD2C0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so6827735wmb.5
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uFf/6xSX7E+6jNyGq0NSZ/TSaTJ/LkXm0TtRomb+Z68=;
        b=ARfiYCFbNSyiU76X/b1iqKyz4L+ewsvd1CI6ww4xj/aogqgRvPXsOGgtP+It7ajSdP
         hpAfhnwWfvSdwetKGFULn+85kGa4atr7h/vWTPgXl7WSvfpr/R4DCLoJ58junkxZCy9a
         eoJANmr810eQHLc47gIVSy/CioJlyjhQuKm6Dz2urxq8hk172iQVqp1WfZ2Ft+wDdh9S
         4KmP1SbhjtYCJVmCpKrrajzh4pUJVCX0BZI2Vg16ruLEHae78b0Xnd2hKDkev+9Ktagh
         aKXF5lPUKjAgXTJJ3e0tw049md/EC4ZCs0yEGp7YlqCJbVoYVAMvB49Soj+5HPYVnHIz
         BEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uFf/6xSX7E+6jNyGq0NSZ/TSaTJ/LkXm0TtRomb+Z68=;
        b=Q8Z4LhoX56F7W3foB3l6s1A4iswYvAyDwkQW4LPNfQB/48JfjKCfD9LI5vSkQueN2V
         gNpyX+PVRc+0TQAFZEXBk358eWnDFHGrvluhWctXOAcBSlD4Bw0W/oQ1/In0KfvA3P1A
         aVEJ6WLotphJLtElnNhjKb+uUAuIqWOmCCTdeVmJa7tBGfim0msZzK4nihuL5+bMt2rI
         NAoc8KWF5N5agOvtFecTC+jVQDZb6AJktfBGMLaIbdUoEPe5I8yFBkDSqIVc0C0BIkdB
         GXVRUvgiFni/062+8qqnKBEcTUYfQO9FLwPVTBYOGrhYAwVCWIsm1DeXDTDL6cjx3xCj
         cJow==
X-Gm-Message-State: AOAM531DsatpXO2eS02Ti95VdZOUpNtwre3yPolIksFish9DkRv9e++B
        1Vu4JQlhsI9C0212mprkz2Zb3OoTfRo=
X-Google-Smtp-Source: ABdhPJw2bkcWe8xrc/RuKC17xDo5na8RzCiPJncD8idpiC7q7zLepKylegCUL4Xo8+hwIdys+BZ7hA==
X-Received: by 2002:a7b:c77a:: with SMTP id x26mr49061wmk.63.1605221041759;
        Thu, 12 Nov 2020 14:44:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm8697529wrq.48.2020.11.12.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:01 -0800 (PST)
Message-Id: <0a05d319c0fc2e88b94ebe488af8d02a0ef63821.1605221038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:31 +0000
Subject: [PATCH 01/28] t0060: preemptively adjust alignment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to adjust t0060 for the new default branch name `main`.
This name is two characters shorter and therefore needs two spaces more
padding to align correctly.

Adjusting the alignment before the big search-and-replace makes it
easier to verify that the final result does not leave any misaligned
lines behind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index b2e3cf3f4c..928eebbdc0 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -312,8 +312,8 @@ test_git_path GIT_COMMON_DIR=bar info/sparse-checkout     .git/info/sparse-check
 test_git_path GIT_COMMON_DIR=bar info//sparse-checkout    .git/info//sparse-checkout
 test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
 test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
-test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master   bar/logs/refs/heads/master
-test_git_path GIT_COMMON_DIR=bar refs/heads/master        bar/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master     bar/logs/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar refs/heads/master          bar/refs/heads/master
 test_git_path GIT_COMMON_DIR=bar refs/bisect/foo          .git/refs/bisect/foo
 test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
-- 
gitgitgadget

