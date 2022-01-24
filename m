Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC794C4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbiAXTBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344775AbiAXS7M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:12 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE8C06125D
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h10so460554wrb.5
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l5LgNAQ7EM+LvbeG09TiAtpeOQEXEidrSkjZl/ZTkBk=;
        b=f3gQtyYYJMC8G6F0UL0dLE092aLv9Jh9+kKDaWd7BdL9MvzDl7qWHXizgqNlZZLjOT
         IZJi8EK9CxriLBKCX9XPhOwOviHKzSS3j2xVGPplT3M1JN5wII7G58RVxL1HVTJdq9S6
         Z7+68lQDvuxl1AJPcMADbq2s6WFb4mpxUf37E4wieZE6joBSFByDeIZzej9cBMNoX8uL
         xSnQI3eqf5OWm1bskql5x4UwWiKyv+VtpIBtmzH9ybLEmogfSrLslSJOJbN+DQHLWa3u
         yf1XA7rjqE42rAEh1/Oou0Eq6ZbnLoePfrERDHrIZAOnt+R3FJUinKeJg9g9HMeFhbTf
         0upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l5LgNAQ7EM+LvbeG09TiAtpeOQEXEidrSkjZl/ZTkBk=;
        b=jQaW1h1wjKTYxLOGj14WjHlXqIknefZpLxAeUGimTn0k+RQ4I1bJhYmopx5014Gkls
         d1ZlD0MSdazBknFAv9SaJW3ipQpe9ucESMumG/rqyUoS6Vaz+8IqdXmqFnCGD2lSR8Xz
         AFf3rAbOeEFvUr5VAg2lxe9sHLLk8LOIsiujqVzFi8HGXZVOEBn/UX2OJyZjZtQ9GVON
         DBGjaBNQk5WOE2OF10xbTeO5zZSuez0mPsQ0MxqNkr2O5IxhSYFkQARgMvKUQlO/ePve
         ffro4hY9jH6hjlD10kPqCgpGIAKGG2mf2yfxWsXcYySSNN8g+O2r50JHM1QWDUm2bKsf
         I5ew==
X-Gm-Message-State: AOAM531lR/wjBoBKKvnAtD7NfNUHkAGTJdkCw7ohOcCJIZzX/2dAly5j
        jHa/bXG50b99UPSLcgYD/12hT547stI=
X-Google-Smtp-Source: ABdhPJxx0WVaGalkEAC3/ybAFBF99Kpuyzdf8FnwTPxAQWwJ7AFQ8Kv5VFPGAvRTRGTPsu412N+VnA==
X-Received: by 2002:adf:cd0d:: with SMTP id w13mr15521270wrm.522.1643050579173;
        Mon, 24 Jan 2022 10:56:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm18956829wry.87.2022.01.24.10.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:18 -0800 (PST)
Message-Id: <d2ff51bb5dacfe084166de106e9a864c902f0f36.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:07 +0000
Subject: [PATCH 2/9] ci/run-build-and-tests: take a more high-level view
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

In the web UI of GitHub workflows, failed runs are presented with the
job step that failed auto-expanded. In the current setup, this is not
helpful at all because that shows only the output of `prove`, which says
which test failed, but not in what way.

What would help understand the reader what went wrong is the verbose
test output of the failed test.

The logs of the failed runs do contain that verbose test output, but it
is shown in the _next_ step (which is marked as succeeding, and is
therefore _not_ auto-expanded). Anyone not intimately familiar with this
would completely miss the verbose test output, being left mostly
puzzled with the test failures.

We are about to show the failed test cases' output in the _same_ step,
so that the user has a much easier time to figure out what was going
wrong.

But first, we must partially revert the change that tried to improve the
CI runs by combining the `Makefile` targets to build into a single
`make` invocation. That might have sounded like a good idea at the time,
but it does make it rather impossible for the CI script to determine
whether the _build_ failed, or the _tests_. If the tests were run at
all, that is.

So let's go back to calling `make` for the build, and call `make test`
separately so that we can easily detect that _that_ invocation failed,
and react appropriately.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 280dda7d285..b70373c172f 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-export MAKE_TARGETS="all test"
+run_tests=t
 
 case "$jobname" in
 linux-gcc)
@@ -41,14 +41,18 @@ pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
 	export DEVOPTS=pedantic
-	export MAKE_TARGETS=all
+	run_tests=
 	;;
 esac
 
 # Any new "test" targets should not go after this "make", but should
 # adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
 # start running tests.
-make $MAKE_TARGETS
+make
+if test -n "$run_tests"
+then
+	make test
+fi
 check_unignored_build_artifacts
 
 save_good_tree
-- 
gitgitgadget

