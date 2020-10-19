Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5107C43467
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794B9223BE
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZylJ5xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgJSTbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD7C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q5so692054wmq.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EoJI1ouLT/ZJfAuVhka/RIrJPu5Bifloh1/ncu4uzQk=;
        b=MZylJ5xgTsWDi5aFlr/Q5sW3S640BUSLDDx6ODsNbQkx+jpefblbRp47e2ADx91Vn3
         3egIvF4VRntduVAZkKwa88JLohvebnjo9ywYpYuYMEQNLJ9GCYMaLXgB7ZAvZvAa31Gu
         qj0ZS0VPKoGlagsn7S9EzHimTbZWda5hQ/7hao98AUb+sx/wTIhUE6/CHtAh8i0q1Jvi
         SHfQiZuH9lNqUxklYqr2E3HgPQZsB7MDeDNzbOCfCIdf2G9Z50AEiLNF8b4i3zmoMJ85
         GCopg9bGzFUxrSL+NlqCgH8HOG5yHAz6sw5121tPqmdN5hRR3Uf2g6OpZMzgqfCk2ZTA
         PFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EoJI1ouLT/ZJfAuVhka/RIrJPu5Bifloh1/ncu4uzQk=;
        b=POS9JuR5+/OPyG7qnyBk61cZK/dZz89e+yXhtt9lceC7FXEF0iVGtV8mo2Z1xBi4UC
         jTbTuZny2Wcq/Y3dVI7egNa1yy9GD8myr4FjoMyDtAaIQwXtJZi5h1CQAzAnMn4ip4OS
         vhfFvBJtlbFom2r5ZqTkOZM6iEqJOXo+iBSTKgDwK6pMDohwZfI3mMXgnf79ju+lX3bw
         Ipi/tol2SKez7ha0acGb/YZxDLtwedK0D7s29CXLAhwtFrbdgHYG1OvZ1/GECUaclAEU
         A5gqg5YynlTSCYxNRbCdD2MXONC3nV/bBbDYT76+YSDW/aEv0KkqhtWiUxx9m978xfqJ
         g5QQ==
X-Gm-Message-State: AOAM531zu8GoP3v0CGAe46SooFTSq01BlFK67AnarzuN1B3gTP77Dplm
        Lr1jv/iDOcVvW451GW7Q1r7ev3QmJMI=
X-Google-Smtp-Source: ABdhPJwC0rNSByiy2ygVaAy53pGHEdjrZgouwUVp8ya5vtt0B4Nenymi15km3cTmpR6zS7hqYCRcTA==
X-Received: by 2002:a1c:bc03:: with SMTP id m3mr773252wmf.171.1603135907140;
        Mon, 19 Oct 2020 12:31:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm1275278wmc.0.2020.10.19.12.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:46 -0700 (PDT)
Message-Id: <5849eda331e09732026f0432cf1040a4e973a702.1603135902.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:33 +0000
Subject: [PATCH 02/10] t9801: use `--` in preparation for default branch
 rename
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

