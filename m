Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F8FC4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1BD2087C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="JBc7+Nq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgKDUei (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732184AbgKDUe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:27 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89061C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:26 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id o205so13858410qke.10
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcECZuewGQIzLYTOXVySAK04qScKz5c+cmRSWyERmok=;
        b=JBc7+Nq70CBk8qTqxWoJbi0M63+yq83Bg06VX1mefZzfHNlT/8RGlh8uR1XS/nx6IT
         eU7s7XCsyqw8gf4YmMNSSRnXkMaQ8ZRKLpdhyUd56h5WAwIXQdx7+b15MrDQCm3xuH1w
         k5yIMDaUvp/HzPbrZKTEoCb7zMrSmticb9vcTQX9zQwTE2Tem0tGXSZ5Fi/kyyawt4Tw
         Po7jel6A4TjkEUMaE/kUCoeTfv4uvF2Yxxz8hnf+hIaisMVUsedYCjMpa5ujm1T8Y4VC
         tLSWJfz2mAdWif2iAyPQcBW1pSvAIRCAwLD6fBeOTPIRtJSV5BsoAYl3HTzV9a3U2MGQ
         1bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcECZuewGQIzLYTOXVySAK04qScKz5c+cmRSWyERmok=;
        b=W3p01KZI/vbeGm9sDKUsFuLRIWD2mcajZjD6GOpdBusk4012L54ZWmoYoXQixvCWDd
         u2H7dvR3ahyZnNA7XKkG4FOCqsy7AZFGFicsnYUTtxrFokvSLGX1iJUs3k+gYEguMeft
         NAOFQMQDJLaNYA/rlvU/GL08gaRMuzlEN+NY9RG3r4ZsNo4V8n6GABOtgNRpBvr4Vz6d
         proYEI9JQHtP+ppOBQtzJ9l4XUudln7GHO3bXVG1/vNzymzzcZdg32tHgDbvd5ezyeZM
         iNpkhJ16XBWTApY7j+4odJ2M7DNtDFgeGpxXM9AmdcgUCj8tu/X5oOo9/i7GtqDkxETv
         Hzsg==
X-Gm-Message-State: AOAM5332eCsf1s03OQTZ8xyvvtpPA7VqkA0g3caKg6d2sDfjtNf5n8+n
        CB/VImnNAlldqFA/Ehup/K05sf4jaw8kmw==
X-Google-Smtp-Source: ABdhPJwHUmPO5qpDDtEX0a75Pq0yAZ8r7nNPi5PM3m9ECrc0K27l1i01VC1pKGRBV0Tl3YJrFbrU3g==
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr994050qkm.231.1604522065257;
        Wed, 04 Nov 2020 12:34:25 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:24 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 16/19] parallel-checkout: add tests for basic operations
Date:   Wed,  4 Nov 2020 17:33:15 -0300
Message-Id: <3733857ffa47c4d16fba91c2ca02ad0cce278dd7.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to populate the working tree during clone and checkout using
the sequential and parallel modes, to confirm that they produce
identical results. Also test basic checkout mechanics, such as checking
for symlinks in the leading directories and the abidance to --force.

Note: some helper functions are added to a common lib file which is only
included by t2080 for now. But it will also be used by other
parallel-checkout tests in the following patches.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-parallel-checkout.sh          |  40 +++++++
 t/t2080-parallel-checkout-basics.sh | 170 ++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
new file mode 100644
index 0000000000..4dad9043fb
--- /dev/null
+++ b/t/lib-parallel-checkout.sh
@@ -0,0 +1,40 @@
+# Helpers for t208* tests
+
+# Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
+# and checks that the number of workers spawned is equal to $3.
+#
+git_pc()
+{
+	if test $# -lt 4
+	then
+		BUG "too few arguments to git_pc()"
+	fi &&
+
+	workers=$1 threshold=$2 expected_workers=$3 &&
+	shift 3 &&
+
+	rm -f trace &&
+	GIT_TRACE2="$(pwd)/trace" git \
+		-c checkout.workers=$workers \
+		-c checkout.thresholdForParallelism=$threshold \
+		-c advice.detachedHead=0 \
+		"$@" &&
+
+	# Check that the expected number of workers has been used. Note that it
+	# can be different from the requested number in two cases: when the
+	# threshold is not reached; and when there are not enough
+	# parallel-eligible entries for all workers.
+	#
+	local workers_in_trace=$(grep "child_start\[..*\] git checkout--helper" trace | wc -l) &&
+	test $workers_in_trace -eq $expected_workers &&
+	rm -f trace
+}
+
+# Verify that both the working tree and the index were created correctly
+verify_checkout()
+{
+	git -C "$1" diff-index --quiet HEAD -- &&
+	git -C "$1" diff-index --quiet --cached HEAD -- &&
+	git -C "$1" status --porcelain >"$1".status &&
+	test_must_be_empty "$1".status
+}
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
new file mode 100755
index 0000000000..edea88f14f
--- /dev/null
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -0,0 +1,170 @@
+#!/bin/sh
+
+test_description='parallel-checkout basics
+
+Ensure that parallel-checkout basically works on clone and checkout, spawning
+the required number of workers and correctly populating both the index and
+working tree.
+'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
+
+# Test parallel-checkout with different operations (creation, deletion,
+# modification) and entry types. A branch switch from B1 to B2 will contain:
+#
+# - a (file):      modified
+# - e/x (file):    deleted
+# - b (symlink):   deleted
+# - b/f (file):    created
+# - e (symlink):   created
+# - d (submodule): created
+#
+test_expect_success SYMLINKS 'setup repo for checkout with various operations' '
+	git init various &&
+	(
+		cd various &&
+		git checkout -b B1 &&
+		echo a>a &&
+		mkdir e &&
+		echo e/x >e/x &&
+		ln -s e b &&
+		git add -A &&
+		git commit -m B1 &&
+
+		git checkout -b B2 &&
+		echo modified >a &&
+		rm -rf e &&
+		rm b &&
+		mkdir b &&
+		echo b/f >b/f &&
+		ln -s b e &&
+		git init d &&
+		test_commit -C d f &&
+		git submodule add ./d &&
+		git add -A &&
+		git commit -m B2 &&
+
+		git checkout --recurse-submodules B1
+	)
+'
+
+test_expect_success SYMLINKS 'sequential checkout' '
+	cp -R various various_sequential &&
+	git_pc 1 0 0 -C various_sequential checkout --recurse-submodules B2 &&
+	verify_checkout various_sequential
+'
+
+test_expect_success SYMLINKS 'parallel checkout' '
+	cp -R various various_parallel &&
+	git_pc 2 0 2 -C various_parallel checkout --recurse-submodules B2 &&
+	verify_checkout various_parallel
+'
+
+test_expect_success SYMLINKS 'fallback to sequential checkout (threshold)' '
+	cp -R various various_sequential_fallback &&
+	git_pc 2 100 0 -C various_sequential_fallback checkout --recurse-submodules B2 &&
+	verify_checkout various_sequential_fallback
+'
+
+test_expect_success SYMLINKS 'parallel checkout on clone' '
+	git -C various checkout --recurse-submodules B2 &&
+	git_pc 2 0 2 clone --recurse-submodules various various_parallel_clone  &&
+	verify_checkout various_parallel_clone
+'
+
+test_expect_success SYMLINKS 'fallback to sequential checkout on clone (threshold)' '
+	git -C various checkout --recurse-submodules B2 &&
+	git_pc 2 100 0 clone --recurse-submodules various various_sequential_fallback_clone &&
+	verify_checkout various_sequential_fallback_clone
+'
+
+# Just to be paranoid, actually compare the working trees' contents directly.
+test_expect_success SYMLINKS 'compare the working trees' '
+	rm -rf various_*/.git &&
+	rm -rf various_*/d/.git &&
+
+	diff -r various_sequential various_parallel &&
+	diff -r various_sequential various_sequential_fallback &&
+	diff -r various_sequential various_parallel_clone &&
+	diff -r various_sequential various_sequential_fallback_clone
+'
+
+test_cmp_str()
+{
+	echo "$1" >tmp &&
+	test_cmp tmp "$2"
+}
+
+test_expect_success 'parallel checkout respects --[no]-force' '
+	git init dirty &&
+	(
+		cd dirty &&
+		mkdir D &&
+		test_commit D/F &&
+		test_commit F &&
+
+		echo changed >F.t &&
+		rm -rf D &&
+		echo changed >D &&
+
+		# We expect 0 workers because there is nothing to be updated
+		git_pc 2 0 0 checkout HEAD &&
+		test_path_is_file D &&
+		test_cmp_str changed D &&
+		test_cmp_str changed F.t &&
+
+		git_pc 2 0 2 checkout --force HEAD &&
+		test_path_is_dir D &&
+		test_cmp_str D/F D/F.t &&
+		test_cmp_str F F.t
+	)
+'
+
+test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading dirs' '
+	git init symlinks &&
+	(
+		cd symlinks &&
+		mkdir D E &&
+
+		# Create two entries in D to have enough work for 2 parallel
+		# workers
+		test_commit D/A &&
+		test_commit D/B &&
+		test_commit E/C &&
+		rm -rf D &&
+		ln -s E D &&
+
+		git_pc 2 0 2 checkout --force HEAD &&
+		! test -L D &&
+		test_cmp_str D/A D/A.t &&
+		test_cmp_str D/B D/B.t
+	)
+'
+
+test_expect_success SYMLINKS,CASE_INSENSITIVE_FS 'symlink colliding with leading dir' '
+	git init colliding-symlink &&
+	(
+		cd colliding-symlink &&
+		file_hex=$(git hash-object -w --stdin </dev/null) &&
+		file_oct=$(echo $file_hex | hex2oct) &&
+
+		sym_hex=$(echo "./D" | git hash-object -w --stdin) &&
+		sym_oct=$(echo $sym_hex | hex2oct) &&
+
+		printf "100644 D/A\0${file_oct}" >tree &&
+		printf "100644 E/B\0${file_oct}" >>tree &&
+		printf "120000 e\0${sym_oct}" >>tree &&
+
+		tree_hex=$(git hash-object -w -t tree --stdin <tree) &&
+		commit_hex=$(git commit-tree -m collisions $tree_hex) &&
+		git update-ref refs/heads/colliding-symlink $commit_hex &&
+
+		git_pc 2 0 2 checkout colliding-symlink &&
+		test_path_is_dir D &&
+		test_path_is_missing D/B
+	)
+'
+
+test_done
-- 
2.28.0

