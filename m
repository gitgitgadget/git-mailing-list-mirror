Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0831C388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EF320782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="xprX/x7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgKDUeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbgKDUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:36 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CCDC0613D4
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:36 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z6so20677217qkz.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJtHxALwDo2rgk6YmCZ8B+uR6PDSM2iJGStWhxd1RGQ=;
        b=xprX/x7SW+n+HbGex9+9S5VQoUvCMsTCRgeP62yeVHP7JzAtDU4qRq6QCiHpHLsEYG
         3cHV4njGMwj+0lP/Rfa6pVH7QYdgrs12hjHd7aaR4F5JqGjt9nXP7k/g2N7RNOT1ZEMd
         NSeZPVJsm3mCK5mA3fENnbfAAupZbnE6gUXU3TVG83jIdxqBQq2CSIBieScnf0x+ku32
         uiirKSMUofB8X+co68vuzkyqETm+aw399GBAMKUgQpglAtjGcUi8G+L162HOgAQTEvFU
         ZK3Jdhxmy6D+ILV+5cwTxVl0wPUvUHJ/KyJEEGvpDnzK48dRExTNo7sAYOh4jnhVqcLT
         xzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJtHxALwDo2rgk6YmCZ8B+uR6PDSM2iJGStWhxd1RGQ=;
        b=J6Sz4yjisbfslCM8bNo6h7Wb2xn5dF13J+39z6reCnTAdT6un3ajEbYj19Bf5Bmymu
         EVO49kcObShxdNUSDdTTltPeEncjCkgqCpgZuk1ZRQ7FPwVRcTSszf2316OIkA2ZJjtU
         SoJJ3SMXk4S6bo2dN+mRaNXDUFFdKOtgeo78F4ngi6TYXdBSh3xE7Ir11KayCfHFqNk3
         iQF+a+WMwEGYI6dM7yVnLLsL5wPEnKSBvCUfKhJ2sXgWaO55A+pt5a4qyqAgxX556kth
         3kx1+D59jFbQHlVZJqel+PhrTjnPmn35A+kUHA/R7KZ/W2qspNbB8+N4o0j0RG/dPIi5
         a2vA==
X-Gm-Message-State: AOAM531bZHXMhmnq0uLNo38ZyV1y9u/KxKE2ZQ9B34I40Wj/KZY+nyHz
        Fpcu5ytLd0KhOXsJrb9jSxwbVFUasMXG/Q==
X-Google-Smtp-Source: ABdhPJwdyqfA6Q+jGWhbtRQk6OpGXVv3BMjqVrQXzNmVL1NtQN2nxLFIawgZvOubGFG4gUOxtufC2g==
X-Received: by 2002:a05:620a:201b:: with SMTP id c27mr27008453qka.279.1604522074921;
        Wed, 04 Nov 2020 12:34:34 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:34 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 19/19] ci: run test round with parallel-checkout enabled
Date:   Wed,  4 Nov 2020 17:33:18 -0300
Message-Id: <7f3e23cc386292e24c80f1b38a109c13632fb03f.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have tests for the basic parallel-checkout operations. But
this code can also run in other commands, such as git-read-tree and
git-sparse-checkout, which are currently not tested with multiple
workers. To promote a wider test coverage without duplicating tests:

1. Add the GIT_TEST_CHECKOUT_WORKERS environment variable, to optionally
   force parallel-checkout execution during the whole test suite.

2. Include this variable in the second test round of the linux-gcc job
   of our ci scripts. This round runs `make test` again with some
   optional GIT_TEST_* variables enabled, so there is no additional
   overhead in exercising the parallel-checkout code here.

Note: the specific parallel-checkout tests t208* cannot be used in
combination with GIT_TEST_CHECKOUT_WORKERS as they need to set and check
the number of workers by themselves. So skip those tests when this flag
is set.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 ci/run-build-and-tests.sh  |  1 +
 parallel-checkout.c        | 14 ++++++++++++++
 t/README                   |  4 ++++
 t/lib-parallel-checkout.sh |  6 ++++++
 4 files changed, 25 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c27b886b8..aa32ddc361 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,6 +22,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
+	export GIT_TEST_CHECKOUT_WORKERS=2
 	make test
 	;;
 linux-clang)
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 72ac93d541..33f36fb1bf 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -32,6 +32,20 @@ enum pc_status parallel_checkout_status(void)
 
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
 		*num_workers = 1;
 	else if (*num_workers < 1)
diff --git a/t/README b/t/README
index 2adaf7c2d2..cd1b15c55a 100644
--- a/t/README
+++ b/t/README
@@ -425,6 +425,10 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
+GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
+to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
+execution of the parallel-checkout code.
+
 Naming Tests
 ------------
 
diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index e62a433eb1..7b454da375 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -1,5 +1,11 @@
 # Helpers for t208* tests
 
+if ! test -z "$GIT_TEST_CHECKOUT_WORKERS"
+then
+	skip_all="skipping test, GIT_TEST_CHECKOUT_WORKERS is set"
+	test_done
+fi
+
 # Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
 # and checks that the number of workers spawned is equal to $3.
 #
-- 
2.28.0

