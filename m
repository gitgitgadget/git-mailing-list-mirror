Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9346CC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AB4613C8
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhDVPTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbhDVPSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:18:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A9C06138E
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 66so7069084qkf.2
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQ0ZQZDm7kU0tedVttmtXpkGv1JCa4r2oeCDSjzZKX4=;
        b=lVGRU6p8m4yhFxyhUkiHRMWK2PsoQZSnCQ6UIvySA9yoy9l7ig50vlsBoa56iKBn4C
         GE9/ZkBOnTk/HSEisjCDA/VQlO1klnrM4+/Oie/ANTjCMc430ddAIE0H/+WaAfc0ZVp/
         71ICggu4c2D/w3GrOPhGlp5sfW2ChAdQbqt5OtN8fp2tE8+GOYZRb3L+urKNgX2g/IX4
         u3cbYlRb/BbuTUXeCLjr83GEKWl4e79M9ljPX1uP+vIPZECUWeLd+UI6ECaz4wROMwBG
         cxl+Q7DYsf9zq/kc+1++Mi+Il6KTmv8rIfhpQgBvvIFRoJ8eYIKYahs9oDjIu/b+9N7k
         3MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQ0ZQZDm7kU0tedVttmtXpkGv1JCa4r2oeCDSjzZKX4=;
        b=jo5PXL1IJgAjgGvCIkN0IDTDHLMSns5Ii8WMY+VmMP7knqZ4On2gOmWP7qNkdeGwOD
         3ahlcfRHBdzcguh6mzJBo/edgBGyrskPSooc8eUODbXVGR/AibGM1rBkLH2kEXRPpcl9
         WV29dj9Dbdk5oHbOlWy0d2qtvu6iiQtBEiozexwAxs/64iHjuZabJxqbGrBVrQ1nkFlL
         K4c6CZR+oJ171vmBc3d6SAO3xjlBUbsl0TFIlUzOhqM5I+TmWnXRDmfa0yrF6JKy2ESU
         Y1+xaYD194Uz/A+H9ut3YGFERZNo0oFcr31bjiiPhD1aXRB39t9wDa9vA0JHs4CWQQWP
         z1cg==
X-Gm-Message-State: AOAM531HsJTDBUovpqVx1Vot/TztsZ8LTIoWmejNhQdyZ8mn651FRU3X
        Y7VTWnJQNEVYMLq0roiuwFhFlbnpaKswSQ==
X-Google-Smtp-Source: ABdhPJyrnKBYDWOFvsp0b3fyBlXkOIVIh0le8hDh2hrib5ltKn1Zch549k1iYmqQ3vkEcUHlQbKg1Q==
X-Received: by 2002:a37:bc43:: with SMTP id m64mr4199965qkf.186.1619104696604;
        Thu, 22 Apr 2021 08:18:16 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l16sm2348909qkg.91.2021.04.22.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:18:15 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] parallel-checkout: add tests for basic operations
Date:   Thu, 22 Apr 2021 12:17:50 -0300
Message-Id: <6379b8df6a59361dd44733e379880a11c6cd977c.1619104091.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619104091.git.matheus.bernardino@usp.br>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to populate the working tree during clone and checkout using
sequential and parallel mode, to confirm that they produce identical
results. Also test basic checkout mechanics, such as checking for
symlinks in the leading directories and the abidance to --force.

Note: some helper functions are added to a common lib file which is only
included by t2080 for now. But they will also be used by other
parallel-checkout tests in the following patches.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-parallel-checkout.sh          |  37 +++++++
 t/t2080-parallel-checkout-basics.sh | 150 ++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
new file mode 100644
index 0000000000..39fd36fdf6
--- /dev/null
+++ b/t/lib-parallel-checkout.sh
@@ -0,0 +1,37 @@
+# Helpers for t208* tests
+
+set_checkout_config () {
+	if test $# -ne 2
+	then
+		BUG "set_checkout_config() requires two arguments"
+	fi &&
+
+	test_config_global checkout.workers $1 &&
+	test_config_global checkout.thresholdForParallelism $2
+}
+
+# Run "${@:2}" and check that $1 checkout workers were used
+test_checkout_workers () {
+	if test $# -lt 2
+	then
+		BUG "too few arguments to test_checkout_workers()"
+	fi &&
+
+	expected_workers=$1 &&
+	shift &&
+
+	rm -f trace &&
+	GIT_TRACE2="$(pwd)/trace" "$@" &&
+
+	workers=$(grep "child_start\[..*\] git checkout--worker" trace | wc -l) &&
+	test $workers -eq $expected_workers &&
+	rm -f trace
+}
+
+# Verify that both the working tree and the index were created correctly
+verify_checkout () {
+	git -C "$1" diff-index --quiet HEAD -- &&
+	git -C "$1" diff-index --quiet --cached HEAD -- &&
+	git -C "$1" status --porcelain >"$1".status &&
+	test_must_be_empty "$1".status
+}
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
new file mode 100755
index 0000000000..0cb1493cdc
--- /dev/null
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+
+test_description='parallel-checkout basics
+
+Ensure that parallel-checkout basically works on clone and checkout, spawning
+the required number of workers and correctly populating both the index and the
+working tree.
+'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
+
+# Test parallel-checkout with a branch switch containing file creations,
+# deletions, and modification; with different entry types. Switching from B1 to
+# B2 will have the following changes:
+#
+# - a (file):      modified
+# - e/x (file):    deleted
+# - b (symlink):   deleted
+# - b/f (file):    created
+# - e (symlink):   created
+# - d (submodule): created
+#
+test_expect_success SYMLINKS 'setup repo for checkout with various types of changes' '
+	git init various &&
+	(
+		cd various &&
+		git checkout -b B1 &&
+		echo a >a &&
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
+	set_checkout_config 1 0 &&
+	test_checkout_workers 0 \
+		git -C various_sequential checkout --recurse-submodules B2 &&
+	verify_checkout various_sequential
+'
+
+test_expect_success SYMLINKS 'parallel checkout' '
+	cp -R various various_parallel &&
+	set_checkout_config 2 0 &&
+	test_checkout_workers 2 \
+		git -C various_parallel checkout --recurse-submodules B2 &&
+	verify_checkout various_parallel
+'
+
+test_expect_success SYMLINKS 'fallback to sequential checkout (threshold)' '
+	cp -R various various_sequential_fallback &&
+	set_checkout_config 2 100 &&
+	test_checkout_workers 0 \
+		git -C various_sequential_fallback checkout --recurse-submodules B2 &&
+	verify_checkout various_sequential_fallback
+'
+
+test_expect_success SYMLINKS 'parallel checkout on clone' '
+	git -C various checkout --recurse-submodules B2 &&
+	set_checkout_config 2 0 &&
+	test_checkout_workers 2 \
+		git clone --recurse-submodules various various_parallel_clone &&
+	verify_checkout various_parallel_clone
+'
+
+test_expect_success SYMLINKS 'fallback to sequential checkout on clone (threshold)' '
+	git -C various checkout --recurse-submodules B2 &&
+	set_checkout_config 2 100 &&
+	test_checkout_workers 0 \
+		git clone --recurse-submodules various various_sequential_fallback_clone &&
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
+test_expect_success 'parallel checkout respects --[no]-force' '
+	set_checkout_config 2 0 &&
+	git init dirty &&
+	(
+		cd dirty &&
+		mkdir D &&
+		test_commit D/F &&
+		test_commit F &&
+
+		rm -rf D &&
+		echo changed >D &&
+		echo changed >F.t &&
+
+		# We expect 0 workers because there is nothing to be done
+		test_checkout_workers 0 git checkout HEAD &&
+		test_path_is_file D &&
+		grep changed D &&
+		grep changed F.t &&
+
+		test_checkout_workers 2 git checkout --force HEAD &&
+		test_path_is_dir D &&
+		grep D/F D/F.t &&
+		grep F F.t
+	)
+'
+
+test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading dirs' '
+	set_checkout_config 2 0 &&
+	git init symlinks &&
+	(
+		cd symlinks &&
+		mkdir D untracked &&
+		# Commit 2 files to have enough work for 2 parallel workers
+		test_commit D/A &&
+		test_commit D/B &&
+		rm -rf D &&
+		ln -s untracked D &&
+
+		test_checkout_workers 2 git checkout --force HEAD &&
+		! test -h D &&
+		grep D/A D/A.t &&
+		grep D/B D/B.t
+	)
+'
+
+test_done
-- 
2.30.1

