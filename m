Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD093C4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600A320936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJHzuelM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgIYRD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9274C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so3757208pfa.10
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dfk/t+Ic8hEa1xD1DKuZ34g6MVpKRFuB2Wvtp2NR+tg=;
        b=MJHzuelM2nQMa6M4jYC1rWixa5Jd3PBZvUJaVsuxQXlHJeKQdAppdxWENntv0H5VAE
         KahE93zPmeXX8MVMVgX2O04gP3g6p+A6Leuh2ttB+j2FQndE1KDDD+rdhLJin0h2XbmW
         ylRjMnI0SM9eb99Ipf0KjQLN8k1YTTWgU0u/NR0xmXNocfqq/I3pVCBok2uBRbgupMMn
         Qkkji9VGvz4wtM8tgARurvaPKNVrERgh5vXBQ7cCK1gLDVlWAYN/cyVadqKHaKAxp15A
         tfdqK3vn5AwiQnHCJhTZ5qh3Ld7ziWJSO61edf00zgDFLDwPHGLztf4b7ZJd1B4esIFH
         6xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dfk/t+Ic8hEa1xD1DKuZ34g6MVpKRFuB2Wvtp2NR+tg=;
        b=uFcT68T66XTlxRYI02USlh86lOAVHCSuEO+y1gFY9xKMz0It2Chao9gyIS3/+oUcxC
         gybdLbpJEB0BZFqc7drBy7IHE9ql++nvIBRrlgc/ESs9qfw6aSWGbRcQ4RCudOgzpn0F
         rJNjohHXtgFMVTRrK86Gyu0tOIcGSRpAfNblgGWxhp0yw83MuORLy1jhIEFl69fFXTOM
         RsKmTO8fN4Tv1wBxV5ejHbFU+xjnoVxWxp8ghLMQKt7INdLoZAdFI204VCHOh6hUdO/h
         kE1SlAYe+783SD4QpVj2hPSaweiH7gsZqphboHIGBmRhLoqdiGPq+LkNrHGwMfwO+r33
         pwyA==
X-Gm-Message-State: AOAM530TUhfy59JRxBw0B/OCbSNCF/UA94LNcOySc6LOaBzcz/VbdTa2
        3Q+OHhaVHbZP/sF4ai6vTaApURSEe3287A==
X-Google-Smtp-Source: ABdhPJxwn+HseCEA+Vb3fukneC7jasr9hLPHwxXROz8NHMEWPONBLMRvB++olAV+olf8hfU40K5hMw==
X-Received: by 2002:a65:5c8b:: with SMTP id a11mr833193pgt.272.1601053407884;
        Fri, 25 Sep 2020 10:03:27 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:27 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 06/11] t7001: change (cd <path> && git foo) to (git -C <path> foo)
Date:   Fri, 25 Sep 2020 22:32:51 +0530
Message-Id: <20200925170256.11490-7-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

Let's avoid the use of `cd` outside subshells by encapsulating them
inside subshells or by using `git -C <dir> ...`.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 45 +++++++++++----------------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7581e4b407..3a3ace6d73 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -11,12 +11,11 @@ test_expect_success 'prepare reference tree' '
 '
 
 test_expect_success 'moving the file out of subdirectory' '
-	cd path0 && git mv COPYING ../path1/COPYING
+	git -C path0 mv COPYING ../path1/COPYING
 '
 
-# in path0 currently
 test_expect_success 'commiting the change' '
-	cd .. && git commit -m move-out -a
+	git commit -m move-out -a
 '
 
 test_expect_success 'checking the commit' '
@@ -25,12 +24,11 @@ test_expect_success 'checking the commit' '
 '
 
 test_expect_success 'moving the file back into subdirectory' '
-	cd path0 && git mv ../path1/COPYING COPYING
+	git -C path0 mv ../path1/COPYING COPYING
 '
 
-# in path0 currently
 test_expect_success 'commiting the change' '
-	cd .. && git commit -m move-in -a
+	git commit -m move-in -a
 '
 
 test_expect_success 'checking the commit' '
@@ -324,10 +322,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	git mv sub mod/sub &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -347,10 +342,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	git mv sub mod/sub &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
 	test_cmp expected actual &&
@@ -364,16 +356,10 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	git submodule update &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
-	(
-		cd mod &&
-		git mv ../sub/ .
-	) &&
+	git -C mod mv ../sub/ . &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
 	test_cmp expected actual &&
@@ -392,10 +378,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -416,10 +399,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -437,10 +417,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
-- 
2.25.1

