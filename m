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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECCAC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 07:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59766112E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 07:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhHSHxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 03:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhHSHxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 03:53:41 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D35C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 00:53:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w6so7353929oiv.11
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/ng4Ee4bxrMUIgrEh/bbG3tacAQyVFM+pqycYphDhs=;
        b=Um4wfSvf+LnjIdlSfkvEj3mPf3WkWmms9LAnjE/PgrEI3gaqLgrJ1OYzu2V9c0blqS
         SHxPm5YWK1lJshcHPoRc838u/gSBc0fZ9ELkCf5vKUVbl11QYr6CcP/cW99pmClpEjF+
         5KUvFG0xjzIhBd2/nwMP3PfxZNbKyYlecfsU4Op5VhQJTKDdmBjriq50EPm5f6M8SE0s
         wVUIaorgTYv3+hjT64EANBBSFo8ycjOcqwlS/UGDk5ZJvfXQvoxjKStw7aYZNCDEXeEm
         Hpu7CN/uCZrwsh/K82VLnjhjnRsedptj05DdztRCZ3SQA1JiVHrWNQ/aXN637v8BGLlc
         WJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/ng4Ee4bxrMUIgrEh/bbG3tacAQyVFM+pqycYphDhs=;
        b=PKZY0wu4zuSmchGRoF3XDBCIciCeKHcrO+e8jZ0IWr7DqcY3p9w1SAiRh8epTWbGnX
         +wHg2H+8Nl9izgpBulAnmhabm9iPhkkTx+6yQpvjzeRFxdKldpk+Zrw154Ep+K7LscqP
         SmkBcfwz48kqSxvJYTb9sqGSiC6lGivS5AsFTUTrTACN0dg0tZ4aDteEJNYGyQo9DhEq
         DUDj2YamdzYcuqd5nOTcNYBC5Kug2Q+lgbTHweTWj9Yz5xHxmKKRmw2HVSLXu78BD17c
         PXExr+/jkUg3S3961frXReWqAcvAkgdRFZAhS4TkfDdpgJBMOHxYgSWRnEsasYnjuFzD
         TaWA==
X-Gm-Message-State: AOAM532KifZiUjpDJdjESzYKySAK54gCP6aBVmOev+Nqq2u1WEppxlV5
        hYCvtKYxtwgbTubKdlo3t1ihe3TZbo4=
X-Google-Smtp-Source: ABdhPJweDBEEZCC3W8sLR4vVRJPuCpMwasWByqXXOt3Goyk5IifzNp750/mCL28bllBmrmGCqzEa5A==
X-Received: by 2002:a05:6808:cd:: with SMTP id t13mr1698636oic.111.1629359584315;
        Thu, 19 Aug 2021 00:53:04 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q20sm521555oiw.58.2021.08.19.00.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 00:53:03 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] t3200: refactor symlink test from hn/refs-errno-cleanup
Date:   Thu, 19 Aug 2021 00:52:44 -0700
Message-Id: <20210819075244.36776-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.476.gf000ecbed9
In-Reply-To: <20210819050103.25995-1-carenas@gmail.com>
References: <20210819050103.25995-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d1931bcf0d (refs: make errno output explicit for refs_resolve_ref_unsafe,
2021-07-20) add a test for a crash when refs is a symlink, but it fails
on windows.

add the missing SYMLINKS dependency and while at it, refactor it slightly
to comply better with the CodingGuidelines.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* update subject for clarity; might be worth squashing instead into 3d63ce75e
  (refs: explicitly return failure_errno from parse_loose_ref_contents,
  2021-07-20)
* change from --git-dir to -C for clarity
* add reporting for errors to the for loop as suggested by Eric

 t/t3200-branch.sh | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd17718160..eacb6bcd35 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -109,17 +109,22 @@ test_expect_success 'git branch -m n/n n should work' '
 	git reflog exists refs/heads/n
 '
 
-test_expect_success 'git branch -m with symlinked .git/refs' '
+test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
 	git init subdir &&
 	test_when_finished "rm -rf subdir" &&
-	(cd subdir &&
-		for d in refs objects packed-refs ; do
-		rm -rf .git/$d &&
-		ln -s ../../.git/$d .git/$d ; done ) &&
-	git --git-dir subdir/.git/ branch rename-src &&
-	expect=$(git rev-parse rename-src) &&
-	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
-	test $(git rev-parse rename-dest) = "$expect" &&
+	(
+		cd subdir &&
+		for d in refs objects packed-refs
+		do
+			rm -rf .git/$d &&
+			ln -s ../../.git/$d .git/$d || exit 1
+		done
+	) &&
+	git -C subdir branch rename-src &&
+	git rev-parse rename-src >expect &&
+	git -C subdir branch -m rename-src rename-dest &&
+	git rev-parse rename-dest >actual &&
+	test_cmp expect actual &&
 	git branch -D rename-dest
 '
 

base-commit: d1931bcf0d5ef75cdaf836347f4aefce902a6a38
-- 
2.33.0.476.gf000ecbed9

