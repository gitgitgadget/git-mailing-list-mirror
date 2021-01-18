Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6911C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8312C224B1
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbhARDYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 22:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbhARDYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 22:24:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD93C061575
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 19:23:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so7808573wrz.0
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 19:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5GLs7wX5UqVG7mVcuB0GageUGwGu72XwEGAUS4bWggY=;
        b=ialwqOJebtV8b7ULUodwtPsLMiIJnPsIRcBY0V1b199LptBw06u6b/zs5/peMwX2hQ
         TKAT9isyixC5K6u7qDQNOTMYSrdef1dCoDFi0grtgnXeeT9E9meYWNI6kdFi1GPcgN5d
         aNAhvcU2/eH3a0xUnUFpqrbEDeUJjnYJvy19BqjILvuA4mPd8X8JQaeUYiRLaoF0q7SE
         O4lNP9dq2B76brNYwdvzctdRHRtlyTM8+juLk4P3oMQRke4vV7PSErhuzFsf4BzzuRvq
         FMQvhHb6YuUyQOYObbm9mk3kPsEKr6dXH1d3YuUOoCZNa2QnatudhyXBh3owAacylJt3
         rZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5GLs7wX5UqVG7mVcuB0GageUGwGu72XwEGAUS4bWggY=;
        b=rwAq/oY0NxHtwpbh1g1IiWPLZ4EhDBXVE1tCwJIuR6mW5JTmL7kIbU0WTRhdBdkFFD
         VFd7aUW8QcrtPLo46OCMWFuDAQRAxwYv9tFp58i44UKuDSxvfvtsCmzXHPCze0iWB6iD
         4ff7s3bwJU9klz0GDDDhAMM/5hsbFUMMM3GmYvwcD+kT5u2N94lHyB1jfVcTRWz87/S/
         /2CbvJ6Td+b0y5XGKfSsB7xQ4lq9tZVT3sEy3qGXIrc7l7RJyBdQjDO99zN85DDu5M1o
         y0/p1ljL/6FbZR7Air9Oki6h0M87oxblpNaDUh/2a8Qnb44Wvqd4JyHYmBsJVRJsbSvx
         G9CA==
X-Gm-Message-State: AOAM531Pn5UMTKrXU/eQze9sLS09InpTmAxaTOKGL/xO6uKlqV1gBe8h
        Nou/UKDFroN87x4A1xYraWjt3KwRlCg=
X-Google-Smtp-Source: ABdhPJzQmXuuBvmNq5CjsDc4aAU+Fm1vTBCP33Zr4nVkXm4KteBBxACaZyB4Xpu48k1x3Ue6Pu5tWg==
X-Received: by 2002:adf:eac7:: with SMTP id o7mr23894808wrn.23.1610940219960;
        Sun, 17 Jan 2021 19:23:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm21938372wru.96.2021.01.17.19.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 19:23:39 -0800 (PST)
Message-Id: <616b73a6556824fb94753cfcc62bf01d36b8b311.1610940216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.838.git.1610940216.gitgitgadget@gmail.com>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Jan 2021 03:23:36 +0000
Subject: [PATCH 2/2] t7900: clean up some broken refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The tests for the 'prefetch' task create remotes and fetch refs into
'refs/prefetch/<remote>/' and tags into 'refs/tags/'. These tests use
the remotes to create objects not intended to be seen by the "local"
repository.

In that sense, the incrmental-repack tasks did not have these objects
and refs in mind. That test replaces the object directory with a
specific pack-file layout for testing the batch-size logic. However,
this causes some operations to start showing warnings such as:

 error: refs/prefetch/remote1/one does not point to a valid object!
 error: refs/tags/one does not point to a valid object!

This only shows up if you run the tests verbosely and watch the output.
It caught my eye and I _thought_ that there was a bug where 'git gc' or
'git repack' wouldn't check 'refs/prefetch/' before pruning objects.
That is incorrect. Those commands do handle 'refs/prefetch/' correctly.

All that is left is to clean up the tests in t7900-maintenance.sh to
remove these tags and refs that are not being repacked for the
incremental-repack tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7900-maintenance.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index f9031cbb44b..6be9d42767a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -256,6 +256,11 @@ test_expect_success 'incremental-repack task' '
 	HEAD
 	^HEAD~1
 	EOF
+
+	# Replace the object directory with this pack layout.
+	# However, it does not include all objects from the remotes.
+	rm -rf .git/refs/prefetch &&
+	rm -rf .git/refs/tags &&
 	rm -f $packDir/pack-* &&
 	rm -f $packDir/loose-* &&
 	ls $packDir/*.pack >packs-before &&
-- 
gitgitgadget
