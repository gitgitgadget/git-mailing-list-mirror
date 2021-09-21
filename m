Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD0C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D3760E08
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhIUPro (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhIUPrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:47:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331FC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:46:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u15so40544518wru.6
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0yjoR8J97Sd79M1jceEuHzhGEfz/u6As4HVyC+bBZjs=;
        b=e7T48S3wIpqGhxG8hqE/8smL077g5jLKmwP0KR/wuN1ObrLH++rSfOVUXRJjtdBlra
         nprR6zHAhRCJo26Aam1Dp3Z9XoaHe7UXXtKtGCBateJdde/v+nRSEMX9npnH19RutCUX
         wjVhof5hPpIo8ZBeYPdOMqSECSuKKEbRaUl7Rhsu9ATaqIFFXW9y0tn32dDZBzGetQrK
         pTgFCaWmQQ4pBTCgolAlxXrtsJmlXoiCAs7oR4jJGU2tIJAebNTme6EnfTOnS1rq3XxS
         p9Gm2Wc0euzYPVpk/g/yATqKHPLGdpbjUHyVF/6h6HeGqwaHAPONAVKWdi1Nw6tscx7N
         wVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0yjoR8J97Sd79M1jceEuHzhGEfz/u6As4HVyC+bBZjs=;
        b=R7Nu3FYGMYNWsGGskNeUypnZALoHWCcLpx4IJf/A4UZeSSd3UuCJhKc2S91cse3wt5
         Z1fgeUAVRzDBwz5llcxAw55h54wmQ6oy+v65HZilynGuex6uMC5vtCV84n94iDDqT+/o
         4MKRcS+S5OrELXFu3bKIibVosjzXe3nA2Vw8HU6vJSWRX4ioTejZMLmunFjHNV2+SqE0
         5Kq8KFmcHa/sNI8n8P1A5KtGA2HGLbp+ipziiyNCrLMoF3B0LSFtNrXhDgK7eq7rlFOz
         lWIzU1I2vm/vjxku2/tjVzg2W8x6sPM5sODevLqsqVzWXiIhks6Xalf12asLv1AaHAc4
         vW3A==
X-Gm-Message-State: AOAM531vL56Jubd//t2feJkp4EMqP461xJJmCqlc/bfoFANyT/kKg9kI
        o0cuCaVl59YKTZQsbPH6jBNqMPxKquI=
X-Google-Smtp-Source: ABdhPJwero17ydnetgiU2BBCSW9whW68HJDriLKIYGDdSxGaZ5rIR19jlV1UIMi6C3dPvm2itZWOpA==
X-Received: by 2002:a1c:1f15:: with SMTP id f21mr5475094wmf.106.1632239173696;
        Tue, 21 Sep 2021 08:46:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm22871318wri.53.2021.09.21.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:46:13 -0700 (PDT)
Message-Id: <pull.1044.git.1632239172735.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 15:46:12 +0000
Subject: [PATCH] t/perf/run: fix bin-wrappers computation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, vdye@github.com,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The GIT_TEST_INSTALLED was moved from perf-lib.sh to run in df0f5021
(perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh, 2019-05-07)
and that included a change to how it inspected the existence of a
bin-wrappers directory. However, that included a typo that made the
match of bin-wrappers never work. Specifically, the assignment was

	mydir_abs_wrappers="$mydir_abs_wrappers/bin-wrappers"

which uses the same variable before it is initialized. By changing it to

	mydir_abs_wrappers="$mydir_abs/bin-wrappers"

We can correctly use the bin-wrappers directory.

This is critical to successfully computing performance of commands that
execute subcommands. The bin-wrappers ensure that the --exec-path is set
correctly.

Reported-by: Victoria Dye <vdye@github.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    t/perf/run: fix bin-wrappers computation
    
    Found this while we were testing sparse index improvements to 'git
    stash', which uses a lot of subcommands.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1044%2Fderrickstolee%2Fperf-run-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1044/derrickstolee/perf-run-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1044

 t/perf/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index d19dec258a2..55219aa4056 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -74,7 +74,7 @@ set_git_test_installed () {
 	mydir=$1
 
 	mydir_abs=$(cd $mydir && pwd)
-	mydir_abs_wrappers="$mydir_abs_wrappers/bin-wrappers"
+	mydir_abs_wrappers="$mydir_abs/bin-wrappers"
 	if test -d "$mydir_abs_wrappers"
 	then
 		GIT_TEST_INSTALLED=$mydir_abs_wrappers

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
