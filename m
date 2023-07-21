Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA00AC00528
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGURak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGURac (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:30:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D98D30DD
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:23 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d066d72eb12so328035276.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689960622; x=1690565422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FkP/sDOEkOFyNY8xs2o2bW5d1m75CZG1oH87HIHt7d0=;
        b=UkmR3TRMenkwqF7ptpyr78LFSJ90a+O5CIX+jI/gQ0+PRe0qO27KqcgbwLEn6qXdAh
         IVQUMjJGWPh1y5nAqcSUry9JfR7QkhWdi+Un/Vkrgf7GeBA4lalcnY15SWxAmTHi8Sq/
         llt3tFKMy1PE/Ennpyew/W7CXscZL4dvVuUc/IhKKw/HWMsDcfoS5LBrNIPGLqCVaT7e
         oIDEZwNA8b/a8t7dEoCbOGG9UVMGAMLstTAVA8qEqb+184QiiBn71FO4PAJ5GdQYO2Bd
         je0qKOd80qNcIib9IRFHYx1UMOCrS7IJE5JH7qTT2vJWEcBN3OKpI/0bl6NWZW+xbQU9
         78gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960622; x=1690565422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkP/sDOEkOFyNY8xs2o2bW5d1m75CZG1oH87HIHt7d0=;
        b=hr3CUCOIUDgcWLajpUhzUCX7to9BohbdsnXIdI+UHnH0NF542ZvHndvLXY3k+N4ebH
         XwpboahDuwJW53uWo+z2RaARbdA9Sz8koX88NaEQXvoqewwQvTdvBwdBwKtx3+br0eRO
         a8wbwPnhhQgBcy0uvrTV2twFcImNVNGDdySqBcpr8hXXLM+G3VJorzrbllScaG649Cl6
         +VULe1SIKn4xKiAnnTy0F3ZAqfUCMc5N8zPAC0r5dtxiTO069PE/k/KB23nOZW0CsPxi
         4KoJE1ZexFxc7952L/ELOxe0d/0dMhUZ2vDIFSgQEEMIfcxIxyTOdHESUlIKESiw+s1u
         3+XQ==
X-Gm-Message-State: ABy/qLYrTcbjxMoP1jcYzTUzqcsL3ooNpiaThoYS09eF1dyywfGERMlv
        IgrpumrerSa9M2Z4nty3FPwnoDQP9nZtkYW+yyjvTw==
X-Google-Smtp-Source: APBJJlF55rz7AgGk0HxGLqmomu0n0HSWnv+wbwFpTNozhif6AgAiaQf/XwbqJzsTrrdwkk8rGFl6dg==
X-Received: by 2002:a25:b19d:0:b0:cee:3ecd:bf16 with SMTP id h29-20020a25b19d000000b00cee3ecdbf16mr9523573ybj.7.1689960622061;
        Fri, 21 Jul 2023 10:30:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y188-20020a2532c5000000b00c39e3d75bfcsm893470yby.44.2023.07.21.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:30:21 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:30:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] t5328: avoid top-level directory changes
Message-ID: <ba550987055ea8ba3333f18c1a814602f124e419.1689960606.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com>
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
2.41.0.381.gd8424d64777

