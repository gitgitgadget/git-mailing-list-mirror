Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3A5C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618CF61477
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhD3Vls (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhD3Vll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D7C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:51 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id n22so13120376qtk.9
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tEnEjfh4UFSUxC9OyF8P7l5RZeLtK76zdR1Km/Uhls=;
        b=JZ7b59ny/z9flfxCfbJSpey2zo5nXfFDA1vSc7HTmBtC+5UYtYtQlztjF1UC2Z4HbU
         ctRoIHGtQo19LilDbZ5ykoh9qMF7A0t/iArHm4WcyD6Mr1wlbFW6ep5YvIGucvvVQSj9
         qPPaBDZ26whL9OFxc6c7Z0EFqBEv2A8Uf56oIIRmNcQoT4w4hGjklVvwv6QLt+aWC1cN
         7mRsDPGuEWq0i1wbQql305EolWqRUtzQr0AbXklTxTHg7U6oU21Jz13re7vkzrIcMmp3
         G6T26oaFxxNMwtkS5nIeNwLafL0FJLawOL+srjQTZ66PL5BXvtBInYLaw+7VN0DJSWve
         pNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tEnEjfh4UFSUxC9OyF8P7l5RZeLtK76zdR1Km/Uhls=;
        b=RWQo7l9HMzrQ4c5u2a9d+POaLJmqxub3man7DiFWF8qjO4MBwsW/Xoz2HpuiV2Z9r/
         16is+fkp2Qu0BIiCKkMHEcZ9RhHtttn8JfZsOGI5epwL3Oqu8u0w0yWDSCDI8h19hSVB
         WcTLYanhhAuPfDFxVoreno4ZEge620RX51Mv1K/8kjJtK0Ldv5ikGlpBktDvCbEasitK
         eOFdCbno8IfZxMTju9SjDLjcghjtd7KV7syBwocuiXK329E+ZoKKzB1CZwSsSwHVpUmV
         FavJc7b3doons0A5PaAtJuNeNBpmnNY+NtDp0jE2IuhJCK3t7KD+gVVBGXMj1v59poq1
         19sg==
X-Gm-Message-State: AOAM5318lpSgT6qNOihRSSIi5OwGfJIk+kojTPCxYfA3RzPPXLQc67tt
        e5f776OrSLJlfMhfAkpSC8qWt7BzOcRiEw==
X-Google-Smtp-Source: ABdhPJwxomdrTyqR7P2R9bsiO1BA+KBVJKKwAwJe4Kii45qSbnD9g1msDBKN3p1zWjqunIe7Fg4/GA==
X-Received: by 2002:ac8:5f93:: with SMTP id j19mr6173651qta.49.1619818850615;
        Fri, 30 Apr 2021 14:40:50 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:50 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 4/8] parallel-checkout: add tests for basic operations
Date:   Fri, 30 Apr 2021 18:40:31 -0300
Message-Id: <f604c50dba723ae5f4c45e5292e1ba76e743ecce.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
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

Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-parallel-checkout.sh          |  42 +++++
 t/t2080-parallel-checkout-basics.sh | 229 ++++++++++++++++++++++++++++
 2 files changed, 271 insertions(+)
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
new file mode 100644
index 0000000000..f60b22ef34
--- /dev/null
+++ b/t/lib-parallel-checkout.sh
@@ -0,0 +1,42 @@
+# Helpers for tests invoking parallel-checkout
+
+set_checkout_config () {
+	if test $# -ne 2
+	then
+		BUG "usage: set_checkout_config <workers> <threshold>"
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
+		BUG "too few arguments to test_checkout_workers"
+	fi &&
+
+	local expected_workers=$1 &&
+	shift &&
+
+	local trace_file=trace-test-checkout-workers &&
+	rm -f "$trace_file" &&
+	GIT_TRACE2="$(pwd)/$trace_file" "$@" &&
+
+	local workers=$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l) &&
+	test $workers -eq $expected_workers &&
+	rm "$trace_file"
+}
+
+# Verify that both the working tree and the index were created correctly
+verify_checkout () {
+	if test $# -ne 1
+	then
+		BUG "usage: verify_checkout <repository path>"
+	fi &&
+
+	git -C "$1" diff-index --ignore-submodules=none --exit-code HEAD -- &&
+	git -C "$1" status --porcelain >"$1".status &&
+	test_must_be_empty "$1".status
+}
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
new file mode 100755
index 0000000000..7087818550
--- /dev/null
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -0,0 +1,229 @@
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
+# Test parallel-checkout with a branch switch containing a variety of file
+# creations, deletions, and modifications, involving different entry types.
+# The branches B1 and B2 have the following paths:
+#
+#      B1                 B2
+#  a/a (file)         a   (file)
+#  b   (file)         b/b (file)
+#
+#  c/c (file)         c   (symlink)
+#  d   (symlink)      d/d (file)
+#
+#  e/e (file)         e   (submodule)
+#  f   (submodule)    f/f (file)
+#
+#  g   (submodule)    g   (symlink)
+#  h   (symlink)      h   (submodule)
+#
+# Additionally, the following paths are present on both branches, but with
+# different contents:
+#
+#  i   (file)         i   (file)
+#  j   (symlink)      j   (symlink)
+#  k   (submodule)    k   (submodule)
+#
+# And the following paths are only present in one of the branches:
+#
+#  l/l (file)         -
+#  -                  m/m (file)
+#
+test_expect_success 'setup repo for checkout with various types of changes' '
+	git init sub &&
+	(
+		cd sub &&
+		git checkout -b B2 &&
+		echo B2 >file &&
+		git add file &&
+		git commit -m file &&
+
+		git checkout -b B1 &&
+		echo B1 >file &&
+		git add file &&
+		git commit -m file
+	) &&
+
+	git init various &&
+	(
+		cd various &&
+
+		git checkout -b B1 &&
+		mkdir a c e &&
+		echo a/a >a/a &&
+		echo b >b &&
+		echo c/c >c/c &&
+		test_ln_s_add c d &&
+		echo e/e >e/e &&
+		git submodule add ../sub f &&
+		git submodule add ../sub g &&
+		test_ln_s_add c h &&
+
+		echo "B1 i" >i &&
+		test_ln_s_add c j &&
+		git submodule add -b B1 ../sub k &&
+		mkdir l &&
+		echo l/l >l/l &&
+
+		git add . &&
+		git commit -m B1 &&
+
+		git checkout -b B2 &&
+		git rm -rf :^.gitmodules :^k &&
+		mkdir b d f &&
+		echo a >a &&
+		echo b/b >b/b &&
+		test_ln_s_add b c &&
+		echo d/d >d/d &&
+		git submodule add ../sub e &&
+		echo f/f >f/f &&
+		test_ln_s_add b g &&
+		git submodule add ../sub h &&
+
+		echo "B2 i" >i &&
+		test_ln_s_add b j &&
+		git -C k checkout B2 &&
+		mkdir m &&
+		echo m/m >m/m &&
+
+		git add . &&
+		git commit -m B2 &&
+
+		git checkout --recurse-submodules B1
+	)
+'
+
+for mode in sequential parallel sequential-fallback
+do
+	case $mode in
+	sequential)          workers=1 threshold=0 expected_workers=0 ;;
+	parallel)            workers=2 threshold=0 expected_workers=2 ;;
+	sequential-fallback) workers=2 threshold=100 expected_workers=0 ;;
+	esac
+
+	test_expect_success "$mode checkout" '
+		repo=various_$mode &&
+		cp -R various $repo &&
+
+		# The just copied files have more recent timestamps than their
+		# associated index entries. So refresh the cached timestamps
+		# to avoid an "entry not up-to-date" error from `git checkout`.
+		# We only have to do this for the submodules as `git checkout`
+		# will already refresh the superproject index before performing
+		# the up-to-date check.
+		#
+		git -C $repo submodule foreach "git update-index --refresh" &&
+
+		set_checkout_config $workers $threshold &&
+		test_checkout_workers $expected_workers \
+			git -C $repo checkout --recurse-submodules B2 &&
+		verify_checkout $repo
+	'
+done
+
+for mode in parallel sequential-fallback
+do
+	case $mode in
+	parallel)            workers=2 threshold=0 expected_workers=2 ;;
+	sequential-fallback) workers=2 threshold=100 expected_workers=0 ;;
+	esac
+
+	test_expect_success "$mode checkout on clone" '
+		repo=various_${mode}_clone &&
+		set_checkout_config $workers $threshold &&
+		test_checkout_workers $expected_workers \
+			git clone --recurse-submodules --branch B2 various $repo &&
+		verify_checkout $repo
+	'
+done
+
+# Just to be paranoid, actually compare the working trees' contents directly.
+test_expect_success 'compare the working trees' '
+	rm -rf various_*/.git &&
+	rm -rf various_*/*/.git &&
+
+	# We use `git diff` instead of `diff -r` because the latter would
+	# follow symlinks, and not all `diff` implementations support the
+	# `--no-dereference` option.
+	#
+	git diff --no-index various_sequential various_parallel &&
+	git diff --no-index various_sequential various_parallel_clone &&
+	git diff --no-index various_sequential various_sequential-fallback &&
+	git diff --no-index various_sequential various_sequential-fallback_clone
+'
+
+# Currently, each submodule is checked out in a separated child process, but
+# these subprocesses must also be able to use parallel checkout workers to
+# write the submodules' entries.
+test_expect_success 'submodules can use parallel checkout' '
+	set_checkout_config 2 0 &&
+	git init super &&
+	(
+		cd super &&
+		git init sub &&
+		test_commit -C sub A &&
+		test_commit -C sub B &&
+		git submodule add ./sub &&
+		git commit -m sub &&
+		rm sub/* &&
+		test_checkout_workers 2 git checkout --recurse-submodules .
+	)
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

