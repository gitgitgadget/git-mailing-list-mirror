Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C3C43462
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B4B61477
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhD3Vlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhD3Vls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A51C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o5so72282537qkb.0
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHpZlOkHakUer84LEdkSVmO9C57GByvpp8AUl27heaY=;
        b=XpyKFhbdrRWkl/VavOLqqY0glLZUt63aTHw+oIuvN6lpYaByu+10AEciyuVqHvSAIt
         tuXbA+YN49aQdkrQ63vzwkUrAAJbwKEb293ShRjcT1rOv6/DY1RUfRSv9Sk9OMpCRFp5
         Z0LZo+UqEqcm4+gd1lKW3wt3KjdPaYgKVeWNY9LfF5oNjifRiIOyL11PmhirbBjSLcFB
         B2bPLcPKfIaECpbzgCkm+peyeVwiFzyu4YN/hMIFPKM0OuIidRrmPyvt1lD6K8jjOKXa
         qKAqGZhQynNi9+pdHzSmpeW/UWpg85k7v1XbRqypNMTgXk9Uanp/87z4m0ihK4du2LyW
         V1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHpZlOkHakUer84LEdkSVmO9C57GByvpp8AUl27heaY=;
        b=gdArkDHNHnrnlgYEi4WG5qoRUAXpNOylzzr5kwlmcJ0oQQNFBJrWxmHV+URMy8bSzb
         i74bhVCNlyclbO2VnzjPRyHSKS+HcZrOjF1d3XIEWwnI8m8lrYTSmiOmPLigoDSiXGEc
         0et7KsksNWfs9TyP21R4S3VYuzczyuESCgZHocbGBSRY+FxIqdZEyZEyOWoFHlELpKvg
         eNp/V3oZN6ukJzCU1kP5lAWNK5actU3nn1t1fX9lYKVqCdJwQo0w2GND43jD0NoV4cT3
         I2aEGdK/okscUKi6uu77H4pbCkb2bhE6ZgKgUcv9YKySTzLSw/SzM74WLtr3TFzqlIoK
         9Atw==
X-Gm-Message-State: AOAM530OpJruYWf/GRS++csXdZ7YNjoM8gp/FAg/of0QGVJ/4tCspZ9C
        az6VuAhh+G3GwCMR2UZPz+sJdZ5F8AdKAw==
X-Google-Smtp-Source: ABdhPJwynfxRhhWlTirWCu/kDu72n1CoQgbbbYRluEcpP+y8mte59aiKnRij0Hb7SZYDwLP/mYpDKQ==
X-Received: by 2002:a37:9dd8:: with SMTP id g207mr51109qke.340.1619818858646;
        Fri, 30 Apr 2021 14:40:58 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:58 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 8/8] ci: run test round with parallel-checkout enabled
Date:   Fri, 30 Apr 2021 18:40:35 -0300
Message-Id: <1bc5c523c5f8522facf5c08b07fd58fb4a99987f.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
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
index a66b5e8c75..23b28e7391 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -25,6 +25,7 @@ linux-gcc)
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
index fd9375b146..a194488f27 100644
--- a/t/README
+++ b/t/README
@@ -436,6 +436,10 @@ and "sha256".
 GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
 'pack.writeReverseIndex' setting.
 
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

