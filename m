Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A37C433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991BA206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbj22Cu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHHRBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHRBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1877CC061A28
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r4so4411521wrx.9
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i00B2BT4Kn6NDWnpqeIIET1PxK/n8DZQOVdnCgauGS8=;
        b=dbj22Cu4EBSr6LUvuG36aPzZAYeY/eHYtW5Di01VEEh9jsDFrMBP9vA3BFDBaWUwFL
         Ub9MB7MJxt9eGdjeXhuycfL0jupABqApWddajrbt9pspTAgEtmEew4yyVy7x1X+tOj/h
         WiSWqbJNHtnRxBaFsuDJcBsDa96U/RMV//oRXpkwEVCySdx+fA113Res0pmU9Noa781w
         RFVBrrKm+903rPJcMPuOM2tkLkbzPvHyXd//eIttWvPEXKBdNJHAJeeYNjwHthtb+A78
         H4UFb3Gz5RIo5jkHqO39yM4nLDB9zFMsytRTU63x6w8BOxLnWTvlfbz0e0+Ujg+4akmG
         o3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i00B2BT4Kn6NDWnpqeIIET1PxK/n8DZQOVdnCgauGS8=;
        b=GoVuxlWEm0r99l5c/FFj5sUOopiuUmUHw+MT8WIFBPn0OfSDkETr6aPhWL7Ri37QhM
         y89DAXq7USRyGcJybAd0FtOFpe8AuX8AqrSiGi50mmEuCeb/MkYbfZveUAH9zcsqtW16
         EXukxPg1/wTh/HqHx49SPDiL4KUQ3Az9DBqDW4nQhX6Jx6+RbxLu/jw5s+M7fFmv5rKA
         L6fv0wRThuCs+oYrMa0jfyFRfqLf4WO/cM1iXGFjoAMxWthcd9GKSBYc8JZdGGwbGG8k
         lns/iuzJcmfemeaR14aUUyHPXC+1xUtKgrsUjpLFoDlb2zX7mAJ7sc/5VIV917LacBLB
         zCIg==
X-Gm-Message-State: AOAM533NIxXMfiz+asu9tiXrbX/UjbgJ2Jjty/D7Zc2KaiAKPtPJeiH9
        36zViiycBBfpCKWeheN6DhYzZocc
X-Google-Smtp-Source: ABdhPJyCSbeV/ZZShAAltcW1zjG6d8kuYbwlx88FbVih0ZcWJ6YArdQYp/GUYy7qV+8PnMTut6+vNg==
X-Received: by 2002:adf:9361:: with SMTP id 88mr18664386wro.403.1596906088038;
        Sat, 08 Aug 2020 10:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm14516799wrj.94.2020.08.08.10.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:27 -0700 (PDT)
Message-Id: <56e169b1d8e8b24c89f826c3efe7a4d3ca6ade05.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:15 +0000
Subject: [PATCH v2 06/11] t6422: fix multiple errors with the mod6 test
 expectations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This test had multiple issues causing it to fail for the wrong
reason(s):

  * rename/rename(1to2) conflicts have always left the original source
    path present in the working directory and index (at stage 1).  Thus,
    the triple rename/rename(1to2) should result in 9 unstaged files,
    not 6.
  * It messed up the three-way content merge for checking the results of
    merging for one of the renames, accidentally turning it into a
    two-way merge.
  * It got the contents of the base files it was using to compare
    against wrong, due to an off-by-one error, and overwrite-redirection
    ('>') instead of append-redirection ('>>').
  * It used slightly too-long conflict markers
  * It didn't include filenames in the conflict marker hunks (granted,
    that was a shortcoming of the merge-recursive backend for rename/add
    and rename/rename(2to1) conflicts, but since it's
    test_expect_failure anyway we might as well make it expect our
    preferred behavior rather than some compromise that we can't yet
    reach anyway).

Fix these issues so that a merge backend which correctly handles these
kinds of nested conflicts will pass the test.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6422-merge-rename-corner-cases.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index c8ee033ad9..2413f517e7 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1042,25 +1042,25 @@ test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename
 		test_must_be_empty err &&
 
 		git ls-files -s >file_count &&
-		test_line_count = 6 file_count &&
+		test_line_count = 9 file_count &&
 		git ls-files -u >file_count &&
-		test_line_count = 6 file_count &&
+		test_line_count = 9 file_count &&
 		git ls-files -o >file_count &&
 		test_line_count = 3 file_count &&
 
 		test_seq 10 20 >merged-one &&
 		test_seq 51 60 >merged-five &&
 		# Determine what the merge of three would give us.
-		test_seq 30 40 >three-side-A &&
+		test_seq 31 39 >three-base &&
+		test_seq 31 40 >three-side-A &&
 		test_seq 31 39 >three-side-B &&
-		echo forty >three-side-B &&
-		>empty &&
+		echo forty >>three-side-B &&
 		test_must_fail git merge-file \
-			-L "HEAD" \
+			-L "HEAD:four" \
 			-L "" \
-			-L "B^0" \
-			three-side-A empty three-side-B &&
-		sed -e "s/^\([<=>]\)/\1\1\1/" three-side-A >merged-three &&
+			-L "B^0:two" \
+			three-side-A three-base three-side-B &&
+		sed -e "s/^\([<=>]\)/\1\1/" three-side-A >merged-three &&
 
 		# Verify the index is as expected
 		git rev-parse >actual         \
@@ -1075,6 +1075,7 @@ test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename
 
 		git cat-file -p :2:two >expect &&
 		git cat-file -p :3:two >other &&
+		>empty &&
 		test_must_fail git merge-file    \
 			-L "HEAD"  -L ""  -L "B^0" \
 			expect     empty  other &&
-- 
gitgitgadget

