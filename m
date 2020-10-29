Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD30C388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA0120747
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="oUiw9uYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391069AbgJ2CQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbgJ2CQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:25 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2628AC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id w5so747082qvn.12
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcECZuewGQIzLYTOXVySAK04qScKz5c+cmRSWyERmok=;
        b=oUiw9uYoGUk8zS30Z5QA98UoujXbvRa37XSEsSfkRyThdz6vEdDi3jN6MlK+BJCL0g
         I2FDtR00n1Hpwnaq1D92z80eXoRxRobcIfGOEVNhntxmGZYn2cI1K536yTAtzTdqPGDX
         rcKeq5n5pfyiL+tSlO5POUwmbEYjEJYPjhAbiI+Ef8IGXJ5D69OsQZKmqEf3TqiRjRv0
         LD0RcxYwmtitDkdT3/SOTHbAym5yfydqY/2hpFEI83hWgfv7PGFIPtBPKLh6EcFagbIb
         tk2mhHngK1m0/qUNRvlyii5nnq+pXn5q9GUAeYjlk+crenC+27cIUAicN/XBwSZ9nsgb
         10JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcECZuewGQIzLYTOXVySAK04qScKz5c+cmRSWyERmok=;
        b=G2Q6Q7XkylMdzI/na3e/nRP/+ET+qETSsO6feKqGP3j3l0o8zQ++AS5MvuYj/f3fjA
         45ESV7iJ0WknVVO/pUjGm01Sey1zsplUx6p9jKhPMz+R/21zTVxsjVoHwSFMA+GGFIZB
         Nmqt/AJCluWqkRFJbTU9TgVQTD7CzEgitsRSSNtyMEZX/a3yEGiavfBCw49VQf+PENAn
         PCWlYeR8my0gZ6I+QYZXagsT9EWtcvVKhZ+iLa/x4+Dx9N8G6hN3NWYM9DxmfSdPDq9M
         p3L6BbIbZ4VzJCcJILt9YPtBtt0/xalQSssWemp6Z2gzhKEAyBlYrhtDHVAy0gk/Ljbq
         +fEA==
X-Gm-Message-State: AOAM533K5LcUzuc+OAuigrcXrk7L6ymoDidqdX4ZgzDzrQrT7jD1oojS
        KMz8JooXmZ4Czwbi46/r/Q2OZIKwqHmz0A==
X-Google-Smtp-Source: ABdhPJxQf/9A4Qn/PsUDxUpGZLHQOyZGcNeIoAU2n0nwEdrNehunx/AXNcSVOknQmXCh7rfybxb9sg==
X-Received: by 2002:ad4:4841:: with SMTP id t1mr1043677qvy.34.1603937783888;
        Wed, 28 Oct 2020 19:16:23 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:23 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 16/19] parallel-checkout: add tests for basic operations
Date:   Wed, 28 Oct 2020 23:14:53 -0300
Message-Id: <05299a3cc0ae8ebb55d17ba35adb953aeb003dca.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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

