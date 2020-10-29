Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE40AC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3AF20738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="dT8zKcKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbgJ2CQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389009AbgJ2CQi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:38 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EAC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:38 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s39so1001018qtb.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcfJ3MakZ1gPCKrlP6Fji0VV2INYQGopaTF/QWlRaGE=;
        b=dT8zKcKp5HpmgGTIukyBxTRnMoTR6driRr0y9s11ZNqoIDzk/B2Uj5wmE+X0HegccY
         maXJUYdBDkoHkyivcFlUydbOOWn6g0NPyGmGS9D1AmFtdQIs0o2671wwZz7l6vjV+YS1
         duw3SOiQrHv+k1OaQ1sZ4VQMN1nGsMu3E63iww/tECxWz2DM0+QFWJEey6Jtyt94FuJq
         X2EMBoGDVG+RjEeveXljDhtSDFH/4U+O72jo0V6qE+m4765zMkMpuE4aTFHiOUC/tQIo
         ebdXZPZjbr919NFWb3qo/jypfLHRuxOBKlfK7TrDoayafFzxyqEYnMOfZRufXri9DXn8
         ZJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcfJ3MakZ1gPCKrlP6Fji0VV2INYQGopaTF/QWlRaGE=;
        b=FnuPA2DWPB23++wdWq0bF3BysR2hh94ecmWYB56JfyI88oUihcTXwK4J9/thjaVXH1
         lgXlK6aETVIoWNSEqLDpAApN+DYQKb6oo2sSGzhtuieER6RWRI7X4KKYFgf5gTzRv8hG
         BY+VEFVyaC1iFBDkAAnz+Vy2MVEGjDN6WUSVVZzQ+cey/1n5QRC+ufV48Xc+RyMQ3lyq
         lp8AQ025n5xNclfiwsurZQTqdzms+SyAH9/FHN6LJPX0QHTiYOLeEmZyYdKiD2z7+Zi9
         wXgRqfC9UAv/Q6QoHkjzuC3kfELCHZFAVgM4trpWOhNueMab6EGDUp9/M44cKTE7otJv
         Gt5g==
X-Gm-Message-State: AOAM533MBZPfKlAvB50R0gvJ+26aXqPNGondjepYixlBpVq+pNM489/6
        hqiCaauYnDya7FeYX+eBA8GfJqJSo0bjHg==
X-Google-Smtp-Source: ABdhPJyjj++tE+BAJRV8n+Kvsa0DUt5w7atqn6bPr4uUk5zdUyh0NVA64aUf+VRF2TzaTIGHA16cEQ==
X-Received: by 2002:ac8:1c39:: with SMTP id a54mr1768177qtk.344.1603937796803;
        Wed, 28 Oct 2020 19:16:36 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:36 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 19/19] ci: run test round with parallel-checkout enabled
Date:   Wed, 28 Oct 2020 23:14:56 -0300
Message-Id: <641c61f9b65ee99be1f8ed3031b53ece90ec187c.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
index c5c449d224..7482447f2d 100644
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

