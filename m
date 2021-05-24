Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47883C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 19:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2BF61406
	for <git@archiver.kernel.org>; Mon, 24 May 2021 19:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhEXT4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEXT4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 15:56:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A7C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 12:55:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n2so29826111wrm.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SwrP4TwQNLh6muLxkOvBH/57dtDJ6IJ3suxAFP3npHc=;
        b=GSruD/WtvQWC+Bz80ZhGDnrCKK+Xo6v6Ixv8nt4UdE4rtkh/gUj203zjUvO6kd54s2
         TL9dUhvGe3ZEa3qVQa3tGigcMKOL7PeizPlTeiROQdZPQZ4XU4uekBYxkU17V4kSg1im
         Eo24HHy9K7nE9DuYATemLls+MIcPc2pUlN15lB4LKEYfizrlt4JJOWB0/3dHw1RJ36zn
         3tA1aAynRZpy7ibsjdWjmjggSycWmi+sTW+3cWBOoJN+Fp7j0RtMCuuZQMDjQiSjkIXC
         yP0mmXpNcy/CPOSsaNNSeQx7cg+kk+0kYewbist8gyZY+L+MzoHPpnRNVKIcfd7EviBR
         Cjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SwrP4TwQNLh6muLxkOvBH/57dtDJ6IJ3suxAFP3npHc=;
        b=lIYANqmV6XNcWSK/PkeWZqen8xUzJgFAmt3uVdVHTR682C5tHOLw0EpIYjOnZnVFNH
         B0TaA38q1E+0TELNIwhmOS6yzDqa935KD/DbOZVNlmyMiqo98zbdH6hZW9aatvuow5YC
         pLj6jFGmC1aF+a2ma6kUFhLB68ibfi16XTN6dY17MjB3pryXV4VYKgLN2fXkd/Y4BBig
         W6zvHYzePg0vhsdvzPcDKDlOt9ZzMVGuc/m8lXNfeQaIpbsO3xol+OKKyQcG+197Jiw7
         aCA3k/WtHBtybfKHx4GPOLQQvtAQ4HvJ8BJjHEtuJHXJ6zr7MMQB5PEZdccta8dUzpPb
         eoDQ==
X-Gm-Message-State: AOAM530vVxpJp6uxR1MBXP90aK7c3d8OhZg/+NKgZwFKbwiWE3u14Skk
        UDAx1lu0Zmeq6QJK0hbUHGIUbGIuWdU=
X-Google-Smtp-Source: ABdhPJzR+6ALRJ1lzb+5gM4kEIon16H1LC8gSe0ANZiW6406QntHpAQANxI55TX2Kygb/EhEIeZLCA==
X-Received: by 2002:a5d:4561:: with SMTP id a1mr23542265wrc.55.1621886109819;
        Mon, 24 May 2021 12:55:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm8852446wmh.37.2021.05.24.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 12:55:09 -0700 (PDT)
Message-Id: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 May 2021 19:55:07 +0000
Subject: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The t1092-sparse-checkout-compatibility.sh tests compare the stdout and
stderr for several Git commands across both full checkouts, sparse
checkouts with a full index, and sparse checkouts with a sparse index.
Since these are direct comparisons, sometimes a progress indicator can
flush at unpredictable points, especially on slower machines. This
causes the tests to be flaky.

One standard way to avoid this is to add GIT_PROGRESS_DELAY=0 to the Git
commands that are run, as this will force every progress indicator
created with start_progress_delay() to be created immediately. However,
there are some progress indicators that are created in the case of a
full index that are not created with a sparse index. Moreover, their
values may be different as those indexes have a different number of
entries.

Instead, use GIT_PROGRESS_DELAY=100000 to ensure that any reasonable
machine running these tests would never display delayed progress
indicators.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    t1092: use GIT_PROGRESS_DELAY for consistent results
    
    We found this while running PR builds in microsoft/git.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-960%2Fderrickstolee%2Fsparse-index%2Fprogress-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-960/derrickstolee/sparse-index/progress-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/960

 t/t1092-sparse-checkout-compatibility.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 12e6c453024f..e9a815ca7aaa 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -106,18 +106,18 @@ init_repos () {
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
+		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
 	) &&
 	(
 		cd sparse-index &&
-		"$@" >../sparse-index-out 2>../sparse-index-err
+		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
 	)
 }
 
 run_on_all () {
 	(
 		cd full-checkout &&
-		"$@" >../full-checkout-out 2>../full-checkout-err
+		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
 	) &&
 	run_on_sparse "$@"
 }

base-commit: de88ac70f3a801262eb3aa087e5d9a712be0a54a
-- 
gitgitgadget
