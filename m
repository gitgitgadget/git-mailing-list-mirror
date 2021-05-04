Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B31C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF1461153
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhEDQ3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhEDQ3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 12:29:02 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890CEC06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 09:28:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o5so9163626qkb.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKajkqyAJR2cWRG4UyaQ6mLUoNVl9zrHgnM7E69bptA=;
        b=w8Bn/in66rqKty1QjjD38yzA7BGUNLTA3ucduJz0LXhS8VHRvRIrb1+Hd6uO2Sz1FT
         qTpyYvE/zOHrRy1KbSke3AJEM/KA/yLpcv0Zkx66axgUX7rCLRcn4EzsQ2seIKfm6Cjo
         d7gbw+w4GsEu8iDT7Gu6mgNgXmQn6xezFsPaizCIzxjsx7eFsCW59o8T0iwvLZj3/72b
         QRPrgTYS8yhepiS3Sy4M2Klt+yqeEEqIn7XuKyaX9dqbPmse02bpEQoo0nguk3jC2SF0
         ylCyfi5wvxzerPJ1BtuDp0K53H8aQWFjDvKQrvol2nyxYo5+uVuB8EJLMH57nsItPcI1
         eLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKajkqyAJR2cWRG4UyaQ6mLUoNVl9zrHgnM7E69bptA=;
        b=Jx6eOb2GfV9LK4W5p7RHWarZoI8Xd9Y5GAstGMcA5X/dMkh8lk7Yrww19UFFKLVY4t
         Cu+P+OyxnGyu5l92un0AVKB7N9VoPL+3tWbH/cvSiuE8zutoWpUwi9brc62psRa4fAew
         ofxH0I/ME/1hW6n1RBfRCEDSiVnlK+mzXezUrUVeCpDpF7LqUv9T3GvS92X0yY+fMflx
         CIPpx2eq274unnSRqG66Q92lhy1mB7RKDR5ywnLiF+dJyCX+PIdBq4GOKeG96Qxk8XoN
         29RNToImNGLD5SS8q1SmH885R9W8d+TFyFTLvxWZCIkYMqW9AjCY2B4bV8YrOoxh/b7z
         8JzA==
X-Gm-Message-State: AOAM532vMuOLbLPNvHcRVi3BJ4CuORal6xz82AV2xEMYmy21FJilqQ0B
        7DkCUqGJb/2KPCyxL+s9eM+vLjPVVqTYJg==
X-Google-Smtp-Source: ABdhPJxUidjSZ3cGTvXUttCxh4SND/tPVSETnm11HdsBxL0G64dKyAG5sjJUe+5zsfJDoX4jS3ppMQ==
X-Received: by 2002:a37:7006:: with SMTP id l6mr25360586qkc.137.1620145685522;
        Tue, 04 May 2021 09:28:05 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x19sm11202689qkx.107.2021.05.04.09.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:28:05 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        stolee@gmail.com, tboegi@web.de
Subject: [PATCH v3 8/8] ci: run test round with parallel-checkout enabled
Date:   Tue,  4 May 2021 13:27:35 -0300
Message-Id: <7b2966c488c29578aa621c609e3d6fc7e36534a9.1620145501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1620145501.git.matheus.bernardino@usp.br>
References: <cover.1620145501.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have tests for the basic parallel-checkout operations. But
this code can also run be executed by other commands, such as
git-read-tree and git-sparse-checkout, which are currently not tested
with multiple workers. To promote a wider test coverage without
duplicating tests:

1. Add the GIT_TEST_CHECKOUT_WORKERS environment variable, to optionally
   force parallel-checkout execution during the whole test suite.

2. Set this variable (with a value of 2) in the second test round of our
   linux-gcc CI job. This round runs `make test` again with some
   optional GIT_TEST_* variables enabled, so there is no additional
   overhead in exercising the parallel-checkout code here.

Note that tests checking out less than two parallel-eligible entries
will fall back to the sequential mode. Nevertheless, it's still a good
exercise for the parallel-checkout framework as the fallback codepath
also writes the queued entries using the parallel-checkout functions
(only without spawning any worker).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 ci/run-build-and-tests.sh  |  1 +
 parallel-checkout.c        | 14 ++++++++++++++
 t/README                   |  4 ++++
 t/lib-parallel-checkout.sh |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index d19be40544..3ce81ffee9 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -26,6 +26,7 @@ linux-gcc)
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
+	export GIT_TEST_CHECKOUT_WORKERS=2
 	make test
 	;;
 linux-clang)
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 6fb3f1e6c9..6b1af32bb3 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -35,6 +35,20 @@ static const int DEFAULT_NUM_WORKERS = 1;
 
 void get_parallel_checkout_configs(int *num_workers, int *threshold)
 {
+	char *env_workers = getenv("GIT_TEST_CHECKOUT_WORKERS");
+
+	if (env_workers && *env_workers) {
+		if (strtol_i(env_workers, 10, num_workers)) {
+			die("invalid value for GIT_TEST_CHECKOUT_WORKERS: '%s'",
+			    env_workers);
+		}
+		if (*num_workers < 1)
+			*num_workers = online_cpus();
+
+		*threshold = 0;
+		return;
+	}
+
 	if (git_config_get_int("checkout.workers", num_workers))
 		*num_workers = DEFAULT_NUM_WORKERS;
 	else if (*num_workers < 1)
diff --git a/t/README b/t/README
index 8eb9e46b1d..a8cfd37387 100644
--- a/t/README
+++ b/t/README
@@ -439,6 +439,10 @@ GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
 GIT_TEST_SPARSE_INDEX=<boolean>, when true enables index writes to use the
 sparse-index format by default.
 
+GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
+to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
+execution of the parallel-checkout code.
+
 Naming Tests
 ------------
 
diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index d6740425b1..21f5759732 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -1,5 +1,8 @@
 # Helpers for tests invoking parallel-checkout
 
+# Parallel checkout tests need full control of the number of workers
+unset GIT_TEST_CHECKOUT_WORKERS
+
 set_checkout_config () {
 	if test $# -ne 2
 	then
-- 
2.30.1

