Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEDDC4727D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48373206A5
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="KCr9V6UZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIVWvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVWvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:23 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573DC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so17038077qtj.11
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mA3fRuXoDIZ2h2bmfvApyLQ8HaIxgJIJJuh/fQoOM5M=;
        b=KCr9V6UZmIYKONk2RwfEXY3FQxfKD31fUl3evWsPWXNdsJSsfHVuY+TEu5220matQx
         WeSq5Nm7tnH2ltArei9JK5Qlr32AbDc1oEQuOnXGROk2TE2GeBpIaHJunaaPvbaB72Ro
         oR/Nmn3yr7dmn9pRAGQT/MsAMur2rV5ZzMcpvGBSldRaWlSLToKxnXgdpHsw7/NHZ8VV
         aZi8FjeY8l0XVDPi5EhiZAHpFXcFWV3lUyOZ4xZkHtTv9gqenfOhol9LYZo+5EN0EUeu
         fNrFht4uLqD+EolVWiUb7jYcl3UPEv4duEhoOWWHy7G7IooPixHJBxZO31ykOComcd/L
         BzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mA3fRuXoDIZ2h2bmfvApyLQ8HaIxgJIJJuh/fQoOM5M=;
        b=r7CEVcwGvTfvDscQ7/jnBYUEtKwsF+DWf8gC7UKsG+82NHXOTaG7ZNtJoPzZ7lzqFi
         PTy9njEacNZCXFv8NOREJNy0gzH9Z33rxl44EkSO+qTPU4lwq6Li1niYUUtdJd5LHYJ8
         vZCNghTpdz3E95sMW8ATnPMPEBff4n8eYXsOqWajGCwLvbDRKY8dcUBUR0BaA2woKECe
         YTxqlQ3UgId5hxC19+SGhLjoN7liBF49z++81pgHRDmV0x9wZVh/uibmzKjlEnkFreKq
         bcGrPWYHwVxAyMRjoev8dkZmkCxDwezLhA3XFBP8e8xk6usSbBNcZZOoR4T3081RjVh+
         HU/Q==
X-Gm-Message-State: AOAM533oKlTC7AwdRgSQfD5+yBet6Ff04aTnvGYagsVWGaTpaN7/rTxb
        Jw8gSzbzASwhyPutG0NgDaoFOUKCb4GUlg==
X-Google-Smtp-Source: ABdhPJxHEHnUULwk+QkOsoIGR1EIgTqx4Q4RMHKSgDGvMwzONvkGLwxBiMEpNVhCg2jO/h80P5jXUw==
X-Received: by 2002:ac8:435e:: with SMTP id a30mr7102122qtn.201.1600815081649;
        Tue, 22 Sep 2020 15:51:21 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 16/19] parallel-checkout: add tests for basic operations
Date:   Tue, 22 Sep 2020 19:49:30 -0300
Message-Id: <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
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
included by t2080 for now. But it will also be used by another
parallel-checkout test in a following patch.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-parallel-checkout.sh          |  39 ++++++
 t/t2080-parallel-checkout-basics.sh | 197 ++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
new file mode 100644
index 0000000000..c95ca27711
--- /dev/null
+++ b/t/lib-parallel-checkout.sh
@@ -0,0 +1,39 @@
+# Helpers for t208* tests
+
+# Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
+# and checks that the number of workers spawned is equal to $3.
+git_pc()
+{
+	if test $# -lt 4
+	then
+		BUG "too few arguments to git_pc()"
+	fi
+
+	workers=$1 threshold=$2 expected_workers=$3 &&
+	shift && shift && shift &&
+
+	rm -f trace &&
+	GIT_TRACE2="$(pwd)/trace" git \
+		-c checkout.workers=$workers \
+		-c checkout.thresholdForParallelism=$threshold \
+		-c advice.detachedHead=0 \
+		$@ &&
+
+	# Check that the expected number of workers has been used. Note that it
+	# can be different than the requested number in two cases: when the
+	# quantity of entries to be checked out is less than the number of
+	# workers; and when the threshold has not been reached.
+	#
+	local workers_in_trace=$(grep "child_start\[.\+\] git checkout--helper" trace | wc -l) &&
+	test $workers_in_trace -eq $expected_workers &&
+	rm -f trace
+}
+
+# Verify that both the working tree and the index were created correctly
+verify_checkout()
+{
+	git -C $1 diff-index --quiet HEAD -- &&
+	git -C $1 diff-index --quiet --cached HEAD -- &&
+	git -C $1 status --porcelain >$1.status &&
+	test_must_be_empty $1.status
+}
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
new file mode 100755
index 0000000000..c088a06ecc
--- /dev/null
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -0,0 +1,197 @@
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
+# NEEDSWORK: cloning a SHA1 repo with GIT_TEST_DEFAULT_HASH set to "sha256"
+# currently produces a wrong result (See
+# https://lore.kernel.org/git/20200911151717.43475-1-matheus.bernardino@usp.br/).
+# So we skip the "parallel-checkout during clone" tests when this test flag is
+# set to "sha256". Remove this when the bug is fixed.
+#
+if test "$GIT_TEST_DEFAULT_HASH" = "sha256"
+then
+	skip_all="t2080 currently don't work with GIT_TEST_DEFAULT_HASH=sha256"
+	test_done
+fi
+
+R_BASE=$GIT_BUILD_DIR
+
+test_expect_success 'sequential clone' '
+	git_pc 1 0 0 clone --quiet -- $R_BASE r_sequential &&
+	verify_checkout r_sequential
+'
+
+test_expect_success 'parallel clone' '
+	git_pc 2 0 2 clone --quiet -- $R_BASE r_parallel &&
+	verify_checkout r_parallel
+'
+
+test_expect_success 'fallback to sequential clone (threshold)' '
+	git -C $R_BASE ls-files >files &&
+	nr_files=$(wc -l <files) &&
+	threshold=$(($nr_files + 1)) &&
+
+	git_pc 2 $threshold 0 clone --quiet -- $R_BASE r_sequential_fallback &&
+	verify_checkout r_sequential_fallback
+'
+
+# Just to be paranoid, actually compare the contents of the worktrees directly.
+test_expect_success 'compare working trees from clones' '
+	rm -rf r_sequential/.git &&
+	rm -rf r_parallel/.git &&
+	rm -rf r_sequential_fallback/.git &&
+	diff -qr r_sequential r_parallel &&
+	diff -qr r_sequential r_sequential_fallback
+'
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
+test_expect_success SYMLINKS 'compare working trees from checkouts' '
+	rm -rf various_sequential/.git &&
+	rm -rf various_parallel/.git &&
+	rm -rf various_sequential_fallback/.git &&
+	diff -qr various_sequential various_parallel &&
+	diff -qr various_sequential various_sequential_fallback
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

