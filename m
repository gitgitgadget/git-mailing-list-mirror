Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2DBC83F12
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 10:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjH2K3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjH2K3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 06:29:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD9F9
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 03:29:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso39737125e9.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304965; x=1693909765;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uSzmpSgNyAj7kC5aUmztL851VutVbma8LqfIE4wtbBc=;
        b=d28ikj43vahruyDTPrbOuof92Mf8FH3JS2JSlCEWXZG/hx+mutQZ6vBuOPvyj6tR9f
         mUdIgduOBm4lQOSckNbInGWJuASnCJi92k5ostYpwtbLZlIR3+Nnzk1Wy9st4wcjXCKp
         SWcs17BlVzL2jg0ItW6LO1uoURIUcCoI2iGWwY8+cwhNBSIa/igRHdcnqxDtetPpY2jq
         Lx/p1QEe8yPeVU3AEMktZIO9aH9QS1FKE/RErK6K8nPhAblz+3nYiUMRalaIMRVXMYxn
         rJDATerfFwjzf94KPqH+pRTiD5zgK+t8htT8MD+rIJMb6vo6azJTYoUAX3f/L79yrjP6
         6OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304965; x=1693909765;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSzmpSgNyAj7kC5aUmztL851VutVbma8LqfIE4wtbBc=;
        b=EbIj0pBk5uhdDPZnfgZUbRN5pPCWQuQCXawfhFHM+pfM+giJ7qHErSBQkkBkOi1zW1
         U8UbRETyBZNk3BpjRBfretLvqcYcULa2gFBNcFKAC/JgtTDR3xrLrVwMq1QiBGksuGbK
         H4FlSyp9XR//dLgditTTEwJ3F8ITQsO24LCUhBELzhoeGX74WjP0kyB6RIP7hRkdE7/P
         SCJa0pOPnmRBjBlffKwrYP9zJ+aR90LtE7l9YiXwVHipbCKXrvASTVteqlkkPHYKgI9F
         bBuL4nVKX0nONYkGIttLl9WZM32wrM3vKFw56WhuNQhkb4Xzz6AuYSDWrVAh+dezVqVQ
         KQhA==
X-Gm-Message-State: AOJu0Yzunb4ly24mHoAU6YKfh5HNI9a7AM9bO+CZdv79EgiRbMN5yJR7
        Q6EhZHkdnvr5obIwk85nLVv3EOYE6Lc=
X-Google-Smtp-Source: AGHT+IE0tYRilk+/3JAcTwg4dxMTizO59pUNqnETOpWvcvmsFZP6yWErC00/9u9w5OR9g5pM33WWaw==
X-Received: by 2002:a1c:7403:0:b0:3fd:1daf:abd8 with SMTP id p3-20020a1c7403000000b003fd1dafabd8mr19540008wmc.40.1693304965139;
        Tue, 29 Aug 2023 03:29:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8-20020a1cf308000000b003fe2de3f94fsm13465957wmq.12.2023.08.29.03.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:29:24 -0700 (PDT)
Message-ID: <pull.1578.git.1693304963963.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Aug 2023 10:29:23 +0000
Subject: [PATCH] ci(linux-asan-ubsan): let's save some time
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

Every once in a while, the `git-p4` tests flake for reasons outside of
our control. It typically fails with "Connection refused" e.g. here:
https://github.com/git/git/actions/runs/5969707156/job/16196057724

	[...]
	+ git p4 clone --dest=/home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git //depot
	  Initialized empty Git repository in /home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git/.git/
	  Perforce client error:
		Connect to server failed; check $P4PORT.
		TCP connect to localhost:9807 failed.
		connect: 127.0.0.1:9807: Connection refused
	  failure accessing depot: could not run p4
	  Importing from //depot into /home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git
	 [...]

This happens in other jobs, too, but in the `linux-asan-ubsan` job it
hurts the most because that job often takes over a full hour to run,
therefore re-running a failed `linux-asan-ubsan` job is _very_ costly.

The purpose of the `linux-asan-ubsan` job is to exercise the C code of
Git, anyway, and any part of Git's source code that the `git-p4` tests
run and that would benefit from the attention of ASAN/UBSAN are run
better in other tests anyway, as debugging C code run via Python scripts
can get a bit hairy.

In fact, it is not even `git-p4` that is the problem (even if it flakes
often enough to be problematic in the CI builds), but really the part
about Python scripts. So let's just skip any Python parts of the tests
from being run in that job.

For good measure, also skip the Subversion tests because debugging C
code run via Perl scripts is as much fun as debugging C code run via
Python scripts. And it will reduce the time this very expensive job
takes, which is a big benefit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(linux-asan-ubsan): let's save some time
    
    I often look at failed CI runs, and the linux-asan-ubsan job comes up
    frequently, and painfully (because it takes such a long time that
    re-running is often less desirable than getting the CI runs to pass).
    
    This commit is an attempt to reduce the pain and suffering stemming from
    this particular job, simply by deciding that the benefit of running the
    Python/Subversion-related tests in that job is far outweighed by its
    cost.
    
    This commit not only reduces the number of git-p4 flakes in
    linux-asan-ubsan to 0, it also seems to shave off about 10 minutes
    runtime, comparing
    https://github.com/gitgitgadget/git/actions/runs/5929602548/job/16077585391
    to
    https://github.com/gitgitgadget/git/actions/runs/6010305446/job/16301473243?pr=1578
    (which is not quite scientific due to the lack of a controlled
    environment, but it's the best we got for now). Together, those benefits
    form a strong incentive for me to get this merged.
    
    This patch is based on maint.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1578%2Fdscho%2Fskip-p4-from-asan-runs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1578/dscho/skip-p4-from-asan-runs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1578

 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 369d462f130..8e4e6713344 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -280,6 +280,8 @@ linux-leaks)
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
+	export NO_SVN_TESTS=LetsSaveSomeTimeBack
+	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepItFlakesTooOften"
 	;;
 esac
 

base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
-- 
gitgitgadget
