Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29586C00528
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 16:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjGXQj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGXQjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0EE53
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583d702129cso19287787b3.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690216772; x=1690821572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IntfoclGuCOXeVpRz5aBKjJIPEGXvrz9Z61fFEG4lQ=;
        b=e03KAa1xpyAYGArjqaR8aJZ5Tu5ul9UZE9NDga+dh+Lff/tq2mDIcjOleGYErVDKFZ
         Ku+x1OU7+mBflgPuFLjuwn1bOYTdo5tCt3Q2vDEE/vTMj62O1D53FWqO4+hmLE6q3+R4
         nmRRbgCpKn2k7fSHsHAkxxn8DuMIWnG0N8meDaBOZk3lUjPUru4ZnNNBGigHI78a6T76
         tVtyO0/UTRJFdmnu1GsLyP9jRlQWBpXoNaH7b+q/wftHqK13WqEteySSWx2XjnCWP65t
         kIwmdSV3e4lBGKLkq9rrQMceIN3DM2/MX02eyHdTc3vc73jd5rJ2shx2WiI2Y6apEYXt
         SoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216772; x=1690821572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IntfoclGuCOXeVpRz5aBKjJIPEGXvrz9Z61fFEG4lQ=;
        b=knK9KE0OmNtX/jPgoweVpwwo9ScRFSEFA6BSpi06zmoyh0KfqbR9Rz+xAJAvGJiQS+
         eot3Op9A2Wh4Ro+qX0VC02eaR7+5gjwqjnHV4AHJXfEKrr4JKnSGhBCvnWizGqyelRBQ
         QB6KBzw7eSRD9lNzQF2cX/RURi7w5nwtxVWY4WBB0R4HW/ktE18sHDdpS7MKN6H4Giqa
         qItSeJoZ7EOcxSlolU1QboPOt7sBHjp17IjJ3LH/c+Ly+3Kh3Pwoj7D1Aa455fi2Nry+
         xBBpw6mG7C2Me2A8AfRYXMOufCQSLzkvp7xeWXDlUZg+6K6GkyeOwAsDGUgAHGkjTCpu
         kXGQ==
X-Gm-Message-State: ABy/qLYXFfjw3xsNbY9kmkqs+OWGZyPagvGFOprWntIWDSI0OOzwnAGn
        HbKL06+8tDoqIKukBT5STgU0asVHoKLgZmd9M0PEgg==
X-Google-Smtp-Source: APBJJlEQ7QWXYXMhP9+WRLDnxZ2vCVKef2hCCWi4FFVcEK95XJFbJrhLK2F1nFVF64GCGfNYj6g97g==
X-Received: by 2002:a0d:d50c:0:b0:580:fa79:d52 with SMTP id x12-20020a0dd50c000000b00580fa790d52mr6763914ywd.47.1690216772336;
        Mon, 24 Jul 2023 09:39:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i135-20020a81918d000000b0057a8de7f43dsm2872735ywg.109.2023.07.24.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:39:32 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:39:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] t5328: avoid top-level directory changes
Message-ID: <79b3444660fbc5f75a9dde023677b0858717b602.1690216758.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
 <cover.1690216758.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1690216758.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the last commit, avoid top-level directory
changes in the last remaining commit-graph related test, t5328.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5328-commit-graph-64bit-time.sh | 54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index 57e4d9c6998..e9c521c061c 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -37,39 +37,39 @@ test_expect_success 'lower layers have overflow chunk' '
 graph_git_behavior 'overflow' '' HEAD~2 HEAD
 
 test_expect_success 'set up and verify repo with generation data overflow chunk' '
-	mkdir repo &&
-	cd repo &&
-	git init &&
-	test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
-	test_commit 2 &&
-	test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
-	git commit-graph write --reachable &&
-	graph_read_expect 3 generation_data &&
-	test_commit --date "$FUTURE_DATE" 4 &&
-	test_commit 5 &&
-	test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
-	git branch left &&
-	git reset --hard 3 &&
-	test_commit 7 &&
-	test_commit --date "$FUTURE_DATE" 8 &&
-	test_commit 9 &&
-	git branch right &&
-	git reset --hard 3 &&
-	test_merge M left right &&
-	git commit-graph write --reachable &&
-	graph_read_expect 10 "generation_data generation_data_overflow" &&
-	git commit-graph verify
+	git init repo &&
+	(
+		cd repo &&
+		test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
+		test_commit 2 &&
+		test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
+		git commit-graph write --reachable &&
+		graph_read_expect 3 generation_data &&
+		test_commit --date "$FUTURE_DATE" 4 &&
+		test_commit 5 &&
+		test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
+		git branch left &&
+		git reset --hard 3 &&
+		test_commit 7 &&
+		test_commit --date "$FUTURE_DATE" 8 &&
+		test_commit 9 &&
+		git branch right &&
+		git reset --hard 3 &&
+		test_merge M left right &&
+		git commit-graph write --reachable &&
+		graph_read_expect 10 "generation_data generation_data_overflow" &&
+		git commit-graph verify
+	)
 '
 
 graph_git_behavior 'overflow 2' repo left right
 
 test_expect_success 'single commit with generation data exceeding UINT32_MAX' '
 	git init repo-uint32-max &&
-	cd repo-uint32-max &&
-	test_commit --date "@4294967297 +0000" 1 &&
-	git commit-graph write --reachable &&
-	graph_read_expect 1 "generation_data" &&
-	git commit-graph verify
+	test_commit -C repo-uint32-max --date "@4294967297 +0000" 1 &&
+	git -C repo-uint32-max commit-graph write --reachable &&
+	graph_read_expect -C repo-uint32-max 1 "generation_data" &&
+	git -C repo-uint32-max commit-graph verify
 '
 
 test_done
-- 
2.41.0.399.g887006eab46

