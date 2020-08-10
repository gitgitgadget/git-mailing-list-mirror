Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED31C433E1
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BFB2075D
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIc9TYVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgHJW33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgHJW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A63C06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id 88so9631345wrh.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i00B2BT4Kn6NDWnpqeIIET1PxK/n8DZQOVdnCgauGS8=;
        b=GIc9TYVQ9270iiivWe5PRFlEptixLQbi4x8vWPC1DJko2gJBedVeTl1jJiao51SU2e
         9Mtw2klbRfCwfLv4n1GgycFOIKgncHwe+fHFRYE9LjegCMB6tcVmB5LS8Fxiz6d1hrlp
         /yoenoyoWo+dCN9IXLv+6H2apV9+gZrH7N7imS1ilo3dRxSoFNeVcKUzfUIySopcSdhR
         83sQHe1JwIg/s+gljQGcaLE1/dnhOJXLLWggZBVG6+ETESJDdMz9vp6/jPi5E8B16qc9
         sb6YX7X0o0uAVd7EhDR3J9djQNfymS96mBMwG6WjRWFosnaAd946s2x1zkceCUFx1p0h
         joDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i00B2BT4Kn6NDWnpqeIIET1PxK/n8DZQOVdnCgauGS8=;
        b=c4DGgCITaBPVHjX4vCRLGjXibr0/n3NKTj5e++addvaf9cSqX/lTyWXjmPlvDa4G9k
         3T0+D9+FONnYltcYbKP4/OE8K1cGArH1eGSonp9f+QCd+I5fVbqF9m0wJqV+f4W2pAea
         t1mBYPC/k+acMVoqPy3Z9yHW6IQY4XQUmNyZSgsfztdZH6kZBIMEioSxJvP/0u+msDg3
         rQAoXHwAS/3MOsHwAmOTbawvvrSo3NgssiALJSFnLBPFIcg+Ui+hzUJd7QqqwrQr8iRV
         yUoyf9pt3d4thCDc/8CBeToUAUXBmPlxH4VN39VFvlujCoOYXEVIx6LNDxQtPvwFlcmD
         grtg==
X-Gm-Message-State: AOAM532vhrfgSfoeWpCn5tHfKlWE6vWhNHej7BG1t8ZvntWOjNOlmSUy
        Zq0E7qABjTkB6M1vYtsr0ioaBPj7
X-Google-Smtp-Source: ABdhPJwycLC1k1iIAlC2nle4+k7cz0jd+fVvwUaXLL8/6p7hvjX/Vfzq11MmvM6+wzRaW+a3gFHQdw==
X-Received: by 2002:a5d:45c9:: with SMTP id b9mr25960133wrs.283.1597098566291;
        Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l81sm1714979wmf.4.2020.08.10.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:25 -0700 (PDT)
Message-Id: <6674ae9de48fe2014eb69b3fe31fddfe4b0414d8.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:14 +0000
Subject: [PATCH v3 06/11] t6422: fix multiple errors with the mod6 test
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

