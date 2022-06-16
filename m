Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78317C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiFPUzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378689AbiFPUzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:55:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154235FF1C
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cv13so40019pjb.4
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J10NdTWWuCtcqMBhnqy1hwqxlGNrDJsG2P87KQwGxZY=;
        b=Tggo4H3c1j3TWx0gTgVLnl/fLgTFcb/T/2RpYQIpuUHc/Dxq6nbFlZmJ/RTqOtbJS6
         7lIuBBkvHrRlmxPZqFA2Qif0tlHZUapg4WT2hFX5OLdUc4Y1R262a0Z7NyyBqwD/tn2j
         5gRxrTZKQZbhbuOARROomEcnAp0o9Si4RYZP0fYKHw8hBz8xRZiQ+m40tW5CWf4C9fDD
         j/2XKttyrW3/VirRwpEm5xlpkMcQ+DTE1sMkdSCmMx6a1fJmHAJ19gWC6eqtJbdFyY8R
         t6b7xM4Ng7RlfXArFC5sfzZnZcKZIa4a5mOomS4CO6be7eBjiT02scsN38+m3ndkp89L
         0Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J10NdTWWuCtcqMBhnqy1hwqxlGNrDJsG2P87KQwGxZY=;
        b=AqU4cqaU0UWGmWZ3nuv5uczTaqdEtqDbTYULl18fNN68Ix+bG290l52CPL0EysMG8Z
         PZRDBt5nwLwdWJ+rUCVJrUWThqs6oZVhh93tGgKEDHR6DkoIT+oPH2TgyzKiiQZnm2E3
         A0540lAx4M5eIP+GRegI2gZAUjEqawnNKYNJwqTvi27WU5U24X3UbhFM4virZ2l185a4
         4XoY7uknUxRDmT/njY/QMB5r9ZVmk2mXuURL8bkh55yN4ENZ++xWOH2qbXE5U+aeYNjE
         e//OKGAN3NEIj1iEfdUGmsz/n/8j1yVHZTH6sk5DKhAFT9JILK5jni29EQFEn3Rv8/Nh
         nF7w==
X-Gm-Message-State: AJIora8WUVx62iUyN13DbrCa+tOco9AOD/76WkgCNaNDOJS1f2M3SaO1
        iLNRTLvADkaK5CthgjwG/M9DGxo0ogo=
X-Google-Smtp-Source: AGRyM1uOwBzdFylZAskSDZK8h0W4LDSxZ61mDE/seJqrUvy4AJOLCajXalhqOmnpS+pYq5LoH7CyXw==
X-Received: by 2002:a17:90b:17d2:b0:1e2:c0a2:80fb with SMTP id me18-20020a17090b17d200b001e2c0a280fbmr18381138pjb.67.1655412898050;
        Thu, 16 Jun 2022 13:54:58 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0051b9e224623sm2249165pfn.141.2022.06.16.13.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:54:57 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
X-Google-Original-From: Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 2/5] tests: handle --global directly in test_config/test_unconfig
Date:   Thu, 16 Jun 2022 13:54:53 -0700
Message-Id: <20220616205456.19081-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616205456.19081-1-jacob.e.keller@intel.com>
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_config function is used to set a configuration value and then
ensure its unset at the end of the test. The test_config_global function
does the same, but for global values.

Instead of having two separate functions, handle the '--global' option
in test_config and test_unconfig. This matches more closely with "git
config" syntax and paves the way for additional optional argument
handling.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 t/lib-parallel-checkout.sh              |  4 +-
 t/lib-proto-disable.sh                  | 12 ++---
 t/lib-submodule-update.sh               |  2 +-
 t/t0001-init.sh                         | 14 ++---
 t/t0021-conversion.sh                   | 58 ++++++++++----------
 t/t0210-trace2-normal.sh                | 10 ++--
 t/t0211-trace2-perf.sh                  |  4 +-
 t/t0212-trace2-event.sh                 |  2 +-
 t/t1309-early-config.sh                 |  2 +-
 t/t2081-parallel-checkout-collisions.sh |  2 +-
 t/t2082-parallel-checkout-attributes.sh |  4 +-
 t/t3431-rebase-fork-point.sh            |  2 +-
 t/t5505-remote.sh                       | 12 ++---
 t/t5544-pack-objects-hook.sh            |  6 +--
 t/t5550-http-fetch-dumb.sh              |  8 +--
 t/t5573-pull-verify-signatures.sh       |  6 +--
 t/t5606-clone-options.sh                | 10 ++--
 t/t5617-clone-submodules-remote.sh      |  4 +-
 t/t5702-protocol-v2.sh                  |  2 +-
 t/t7814-grep-recurse-submodules.sh      | 16 +++---
 t/test-lib-functions.sh                 | 72 ++++++++++++++++++-------
 21 files changed, 144 insertions(+), 108 deletions(-)

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index 83b279a846c6..7a1a1f2b75b9 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -9,8 +9,8 @@ set_checkout_config () {
 		BUG "usage: set_checkout_config <workers> <threshold>"
 	fi &&
 
-	test_config_global checkout.workers $1 &&
-	test_config_global checkout.thresholdForParallelism $2
+	test_config --global checkout.workers $1 &&
+	test_config --global checkout.thresholdForParallelism $2
 }
 
 # Run "${@:2}" and check that $1 checkout workers were used
diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index 83babe57d959..f3cb43ae1aab 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -147,33 +147,33 @@ test_config () {
 	# Test clone/fetch/push with protocol.allow user defined default
 	test_expect_success "clone $desc (enabled)" '
 		rm -rf tmp.git &&
-		test_config_global protocol.allow always &&
+		test_config --global protocol.allow always &&
 		git clone --bare "$url" tmp.git
 	'
 
 	test_expect_success "fetch $desc (enabled)" '
-		test_config_global protocol.allow always &&
+		test_config --global protocol.allow always &&
 		git -C tmp.git fetch
 	'
 
 	test_expect_success "push $desc (enabled)" '
-		test_config_global protocol.allow always &&
+		test_config --global protocol.allow always &&
 		git -C tmp.git push origin HEAD:pushed
 	'
 
 	test_expect_success "push $desc (disabled)" '
-		test_config_global protocol.allow never &&
+		test_config --global protocol.allow never &&
 		test_must_fail git -C tmp.git push origin HEAD:pushed
 	'
 
 	test_expect_success "fetch $desc (disabled)" '
-		test_config_global protocol.allow never &&
+		test_config --global protocol.allow never &&
 		test_must_fail git -C tmp.git fetch
 	'
 
 	test_expect_success "clone $desc (disabled)" '
 		rm -rf tmp.git &&
-		test_config_global protocol.allow never &&
+		test_config --global protocol.allow never &&
 		test_must_fail git clone --bare "$url" tmp.git
 	'
 }
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index f7c7df0ca427..17d95b8193a9 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -198,7 +198,7 @@ test_git_directory_exists () {
 # settings for diff.ignoreSubmodules.
 prolog () {
 	(test -d submodule_update_repo || create_lib_submodule_repo) &&
-	test_config_global diff.ignoreSubmodules all &&
+	test_config --global diff.ignoreSubmodules all &&
 	test_config diff.ignoreSubmodules all
 }
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d479303efa03..42242ca5ee0a 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -200,7 +200,7 @@ init_no_templatedir_env () {
 test_expect_success 'init with init.templatedir set' '
 	mkdir templatedir-source &&
 	echo Content >templatedir-source/file &&
-	test_config_global init.templatedir "${HOME}/templatedir-source" &&
+	test_config --global init.templatedir "${HOME}/templatedir-source" &&
 
 	init_no_templatedir_env templatedir-set &&
 	test_cmp templatedir-source/file templatedir-set/.git/file
@@ -209,15 +209,15 @@ test_expect_success 'init with init.templatedir set' '
 test_expect_success 'init with init.templatedir using ~ expansion' '
 	mkdir -p templatedir-source &&
 	echo Content >templatedir-source/file &&
-	test_config_global init.templatedir "~/templatedir-source" &&
+	test_config --global init.templatedir "~/templatedir-source" &&
 
 	init_no_templatedir_env templatedir-expansion &&
 	test_cmp templatedir-source/file templatedir-expansion/.git/file
 '
 
 test_expect_success 'init --bare/--shared overrides system/global config' '
-	test_config_global core.bare false &&
-	test_config_global core.sharedRepository 0640 &&
+	test_config --global core.bare false &&
+	test_config --global core.sharedRepository 0640 &&
 	git init --bare --shared=0666 init-bare-shared-override &&
 	check_config init-bare-shared-override true unset &&
 	test x0666 = \
@@ -225,7 +225,7 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 '
 
 test_expect_success 'init honors global core.sharedRepository' '
-	test_config_global core.sharedRepository 0666 &&
+	test_config --global core.sharedRepository 0666 &&
 	git init shared-honor-global &&
 	test x0666 = \
 	x$(git config -f shared-honor-global/.git/config core.sharedRepository)
@@ -569,7 +569,7 @@ test_expect_success '--initial-branch' '
 '
 
 test_expect_success 'overridden default initial branch name (config)' '
-	test_config_global init.defaultBranch nmb &&
+	test_config --global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git init initial-branch-config &&
 	git -C initial-branch-config symbolic-ref HEAD >actual &&
 	grep nmb actual
@@ -583,7 +583,7 @@ test_expect_success 'advice on unconfigured init.defaultBranch' '
 '
 
 test_expect_success 'overridden default main branch name (env)' '
-	test_config_global init.defaultBranch nmb &&
+	test_config --global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
 	git -C main-branch-env symbolic-ref HEAD >actual &&
 	grep env actual
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bad37abad2c3..119004ed9c58 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -339,8 +339,8 @@ test_expect_success "filter: smudge empty file" '
 '
 
 test_expect_success 'disable filter with empty override' '
-	test_config_global filter.disable.smudge false &&
-	test_config_global filter.disable.clean false &&
+	test_config --global filter.disable.smudge false &&
+	test_config --global filter.disable.clean false &&
 	test_config filter.disable.smudge false &&
 	test_config filter.disable.clean false &&
 
@@ -366,8 +366,8 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 '
 
 test_expect_success PERL 'required process filter should filter data' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
-	test_config_global filter.protocol.required true &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config --global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -451,8 +451,8 @@ test_expect_success PERL 'required process filter should filter data' '
 '
 
 test_expect_success PERL 'required process filter should filter data for various subcommands' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
-	test_config_global filter.protocol.required true &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config --global filter.protocol.required true &&
 	(
 		cd repo &&
 
@@ -562,9 +562,9 @@ test_expect_success PERL 'required process filter should filter data for various
 '
 
 test_expect_success PERL 'required process filter takes precedence' '
-	test_config_global filter.protocol.clean false &&
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
-	test_config_global filter.protocol.required true &&
+	test_config --global filter.protocol.clean false &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean" &&
+	test_config --global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -588,7 +588,7 @@ test_expect_success PERL 'required process filter takes precedence' '
 '
 
 test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -623,8 +623,8 @@ test_expect_success PERL 'required process filter should be used only for "clean
 '
 
 test_expect_success PERL 'required process filter should process multiple packets' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
-	test_config_global filter.protocol.required true &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config --global filter.protocol.required true &&
 
 	rm -rf repo &&
 	mkdir repo &&
@@ -688,8 +688,8 @@ test_expect_success PERL 'required process filter should process multiple packet
 '
 
 test_expect_success PERL 'required process filter with clean error should fail' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
-	test_config_global filter.protocol.required true &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config --global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -707,7 +707,7 @@ test_expect_success PERL 'required process filter with clean error should fail'
 '
 
 test_expect_success PERL 'process filter should restart after unexpected write failure' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -762,7 +762,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 '
 
 test_expect_success PERL 'process filter should not be restarted if it signals an error' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -805,7 +805,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 '
 
 test_expect_success PERL 'process filter abort stops processing of all further files' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config --global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -845,8 +845,8 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 '
 
 test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
-	test_config_global filter.protocol.process cat &&
-	test_config_global filter.protocol.required true &&
+	test_config --global filter.protocol.process cat &&
+	test_config --global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -862,10 +862,10 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 '
 
 test_expect_success PERL 'delayed checkout in process filter' '
-	test_config_global filter.a.process "rot13-filter.pl a.log clean smudge delay" &&
-	test_config_global filter.a.required true &&
-	test_config_global filter.b.process "rot13-filter.pl b.log clean smudge delay" &&
-	test_config_global filter.b.required true &&
+	test_config --global filter.a.process "rot13-filter.pl a.log clean smudge delay" &&
+	test_config --global filter.a.required true &&
+	test_config --global filter.b.process "rot13-filter.pl b.log clean smudge delay" &&
+	test_config --global filter.b.required true &&
 
 	rm -rf repo &&
 	mkdir repo &&
@@ -941,8 +941,8 @@ test_expect_success PERL 'delayed checkout in process filter' '
 '
 
 test_expect_success PERL 'missing file in delayed checkout' '
-	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
-	test_config_global filter.bug.required true &&
+	test_config --global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+	test_config --global filter.bug.required true &&
 
 	rm -rf repo &&
 	mkdir repo &&
@@ -961,8 +961,8 @@ test_expect_success PERL 'missing file in delayed checkout' '
 '
 
 test_expect_success PERL 'invalid file in delayed checkout' '
-	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
-	test_config_global filter.bug.required true &&
+	test_config --global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+	test_config --global filter.bug.required true &&
 
 	rm -rf repo &&
 	mkdir repo &&
@@ -992,9 +992,9 @@ do
 
 	test_expect_success PERL,SYMLINKS,$mode_prereq \
 	"delayed checkout with $mode-collision don't write to the wrong place" '
-		test_config_global filter.delay.process \
+		test_config --global filter.delay.process \
 			"\"$TEST_ROOT/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
-		test_config_global filter.delay.required true &&
+		test_config --global filter.delay.required true &&
 
 		git init $mode-collision &&
 		(
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 80e76a4695ed..210b99ec9c1b 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -251,8 +251,8 @@ sane_unset GIT_TRACE2_BRIEF
 
 test_expect_success 'using global config, normal stream, return code 0' '
 	test_when_finished "rm trace.normal actual expect" &&
-	test_config_global trace2.normalBrief 1 &&
-	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
+	test_config --global trace2.normalBrief 1 &&
+	test_config --global trace2.normalTarget "$(pwd)/trace.normal" &&
 	test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
@@ -267,10 +267,10 @@ test_expect_success 'using global config, normal stream, return code 0' '
 
 test_expect_success 'using global config with include' '
 	test_when_finished "rm trace.normal actual expect real.gitconfig" &&
-	test_config_global trace2.normalBrief 1 &&
-	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
+	test_config --global trace2.normalBrief 1 &&
+	test_config --global trace2.normalTarget "$(pwd)/trace.normal" &&
 	mv "$(pwd)/.gitconfig" "$(pwd)/real.gitconfig" &&
-	test_config_global include.path "$(pwd)/real.gitconfig" &&
+	test_config --global include.path "$(pwd)/real.gitconfig" &&
 	test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 22d0845544e9..1196fe9c1131 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -159,8 +159,8 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 
 test_expect_success 'using global config, perf stream, return code 0' '
 	test_when_finished "rm trace.perf actual expect" &&
-	test_config_global trace2.perfBrief 1 &&
-	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test_config --global trace2.perfBrief 1 &&
+	test_config --global trace2.perfTarget "$(pwd)/trace.perf" &&
 	test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 6d3374ff773c..39828f3345ef 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -277,7 +277,7 @@ test_expect_success JSON_PP 'basic trace2_data' '
 
 test_expect_success JSON_PP 'using global config, event stream, error event' '
 	test_when_finished "rm trace.event actual expect" &&
-	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test_config --global trace2.eventTarget "$(pwd)/trace.event" &&
 	test-tool trace2 003error "hello world" "this is a test" &&
 	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
 	sed -e "s/^|//" >expect <<-EOF &&
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 537435b90ae9..db30478260b3 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -96,7 +96,7 @@ test_expect_success 'early config and onbranch' '
 '
 
 test_expect_success 'onbranch config outside of git repo' '
-	test_config_global includeIf.onbranch:topic.path non-existent &&
+	test_config --global includeIf.onbranch:topic.path non-existent &&
 	nongit git help
 '
 
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index 6acdb89d12bd..76638658265b 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -138,7 +138,7 @@ test_expect_success CASE_INSENSITIVE_FS 'collision report on clone (w/ racy file
 test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN \
 	'collision report on clone (w/ colliding peer after the detected entry)' '
 
-	test_config_global filter.logger.smudge "\"$TEST_ROOT/logger_script\" %f" &&
+	test_config --global filter.logger.smudge "\"$TEST_ROOT/logger_script\" %f" &&
 	git reset --hard basename_collision &&
 	echo "file_x filter=logger" >.gitattributes &&
 	git add .gitattributes &&
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index 252545796182..f90dd7f156d4 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -142,9 +142,9 @@ test_expect_success PERL 'parallel-checkout and delayed checkout' '
 	write_script rot13-filter.pl "$PERL_PATH" \
 		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
 
-	test_config_global filter.delay.process \
+	test_config --global filter.delay.process \
 		"\"$(pwd)/rot13-filter.pl\" --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
-	test_config_global filter.delay.required true &&
+	test_config --global filter.delay.required true &&
 
 	echo "abcd" >original &&
 	echo "nopq" >rot13 &&
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 1d0b15380edf..97aa15b673fa 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -92,7 +92,7 @@ test_expect_success 'rebase.forkPoint set to false' '
 '
 
 test_expect_success 'rebase.forkPoint set to false and then to true' '
-	test_config_global rebase.forkPoint false &&
+	test_config --global rebase.forkPoint false &&
 	test_config rebase.forkPoint true &&
 	do_test_rebase "G F E D B A"
 '
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d5db7ce055bc..163d0f2371b0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -608,7 +608,7 @@ test_expect_success 'reject adding remote with an invalid name' '
 # the last two ones check if the config is updated.
 
 test_expect_success 'rename a remote' '
-	test_config_global remote.pushDefault origin &&
+	test_config --global remote.pushDefault origin &&
 	git clone one four &&
 	git -C four config branch.main.pushRemote origin &&
 	GIT_TRACE2_EVENT=$(pwd)/trace \
@@ -633,7 +633,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault' '
 '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
-	test_config_global remote.pushDefault other &&
+	test_config --global remote.pushDefault other &&
 	git clone one four.2 &&
 	git -C four.2 config remote.pushDefault origin &&
 	git -C four.2 remote rename origin upstream &&
@@ -642,7 +642,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but ignores
 '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
-	test_config_global remote.pushDefault origin &&
+	test_config --global remote.pushDefault origin &&
 	git clone one four.3 &&
 	git -C four.3 config remote.pushDefault origin &&
 	git -C four.3 remote rename origin upstream &&
@@ -680,7 +680,7 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 '
 
 test_expect_success 'remove a remote' '
-	test_config_global remote.pushDefault origin &&
+	test_config --global remote.pushDefault origin &&
 	git clone one four.five &&
 	git -C four.five config branch.main.pushRemote origin &&
 	git -C four.five remote remove origin &&
@@ -698,7 +698,7 @@ test_expect_success 'remove a remote removes repo remote.pushDefault' '
 '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault but ignores global' '
-	test_config_global remote.pushDefault other &&
+	test_config --global remote.pushDefault other &&
 	git clone one four.five.2 &&
 	git -C four.five.2 config remote.pushDefault origin &&
 	git -C four.five.2 remote remove origin &&
@@ -707,7 +707,7 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but ignores
 '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
-	test_config_global remote.pushDefault origin &&
+	test_config --global remote.pushDefault origin &&
 	git clone one four.five.3 &&
 	git -C four.five.3 config remote.pushDefault origin &&
 	git -C four.five.3 remote remove origin &&
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index dd5f44d986f2..7acea482224a 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -24,7 +24,7 @@ clear_hook_results () {
 
 test_expect_success 'hook runs via global config' '
 	clear_hook_results &&
-	test_config_global uploadpack.packObjectsHook ./hook &&
+	test_config --global uploadpack.packObjectsHook ./hook &&
 	git clone --no-local . dst.git 2>stderr &&
 	grep "hook running" stderr
 '
@@ -61,8 +61,8 @@ test_expect_success 'hook does not run from repo config' '
 
 test_expect_success 'hook works with partial clone' '
 	clear_hook_results &&
-	test_config_global uploadpack.packObjectsHook ./hook &&
-	test_config_global uploadpack.allowFilter true &&
+	test_config --global uploadpack.packObjectsHook ./hook &&
+	test_config --global uploadpack.allowFilter true &&
 	git clone --bare --no-local --filter=blob:none . dst.git &&
 	git -C dst.git rev-list --objects --missing=allow-any --no-object-names --all >objects &&
 	git -C dst.git cat-file --batch-check="%(objecttype)" <objects >types &&
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index f0d9cd584d3b..e97f94f1db68 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -100,7 +100,7 @@ test_expect_success 'http auth can request both user and pass' '
 '
 
 test_expect_success 'http auth respects credential helper config' '
-	test_config_global credential.helper "!f() {
+	test_config --global credential.helper "!f() {
 		cat >/dev/null
 		echo username=user@host
 		echo password=pass@host
@@ -111,14 +111,14 @@ test_expect_success 'http auth respects credential helper config' '
 '
 
 test_expect_success 'http auth can get username from config' '
-	test_config_global "credential.$HTTPD_URL.username" user@host &&
+	test_config --global "credential.$HTTPD_URL.username" user@host &&
 	set_askpass wrong pass@host &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-user &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'configured username does not override URL' '
-	test_config_global "credential.$HTTPD_URL.username" wrong &&
+	test_config --global "credential.$HTTPD_URL.username" wrong &&
 	set_askpass wrong pass@host &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-user2 &&
 	expect_askpass pass user@host
@@ -452,7 +452,7 @@ test_expect_success 'http-alternates cannot point at funny protocols' '
 test_expect_success 'http-alternates triggers not-from-user protocol check' '
 	echo "$HTTPD_URL/dumb/victim.git/objects" \
 		>"$evil/objects/info/http-alternates" &&
-	test_config_global http.followRedirects true &&
+	test_config --global http.followRedirects true &&
 	test_must_fail git -c protocol.http.allow=user \
 		clone $HTTPD_URL/dumb/evil.git evil-user &&
 	git -c protocol.http.allow=always \
diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index a53dd8550d0b..bc61ee3ef56f 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -126,7 +126,7 @@ test_expect_success GPG 'pull commit into unborn branch with untrusted signature
 test_expect_success GPG 'pull commit into unborn branch with untrusted signature and --verify-signatures and minTrustLevel=ultimate' '
 	test_when_finished "rm -rf empty-repo" &&
 	git init empty-repo &&
-	test_config_global gpg.minTrustLevel ultimate &&
+	test_config --global gpg.minTrustLevel ultimate &&
 	test_must_fail \
 		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pullerror &&
 	test_i18ngrep "has an untrusted GPG signature" pullerror
@@ -135,7 +135,7 @@ test_expect_success GPG 'pull commit into unborn branch with untrusted signature
 test_expect_success GPG 'pull commit into unborn branch with untrusted signature and --verify-signatures and minTrustLevel=marginal' '
 	test_when_finished "rm -rf empty-repo" &&
 	git init empty-repo &&
-	test_config_global gpg.minTrustLevel marginal &&
+	test_config --global gpg.minTrustLevel marginal &&
 	test_must_fail \
 		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pullerror &&
 	test_i18ngrep "has an untrusted GPG signature" pullerror
@@ -144,7 +144,7 @@ test_expect_success GPG 'pull commit into unborn branch with untrusted signature
 test_expect_success GPG 'pull commit into unborn branch with untrusted signature and --verify-signatures and minTrustLevel=undefined' '
 	test_when_finished "rm -rf empty-repo" &&
 	git init empty-repo &&
-	test_config_global gpg.minTrustLevel undefined &&
+	test_config --global gpg.minTrustLevel undefined &&
 	git -C empty-repo pull --ff-only --verify-signatures ../untrusted >pulloutput &&
 	test_i18ngrep "has a good GPG signature" pulloutput
 '
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 8f676d6b0c0e..a7efedfb79a5 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -18,11 +18,11 @@ test_expect_success 'setup' '
 
 test_expect_success 'submodule.stickyRecursiveClone flag manipulates submodule.recurse value' '
 
-	test_config_global submodule.stickyRecursiveClone true &&
+	test_config --global submodule.stickyRecursiveClone true &&
 	git clone --recurse-submodules parent clone_recurse_true &&
 	test_cmp_config -C clone_recurse_true true submodule.recurse &&
 
-	test_config_global submodule.stickyRecursiveClone false &&
+	test_config --global submodule.stickyRecursiveClone false &&
 	git clone --recurse-submodules parent clone_recurse_false &&
 	test_expect_code 1 git -C clone_recurse_false config --get submodule.recurse
 
@@ -94,7 +94,7 @@ test_expect_success 'prefers --template config over normal config' '
 	template="$TRASH_DIRECTORY/template-with-config" &&
 	mkdir "$template" &&
 	git config --file "$template/config" foo.bar from_template &&
-	test_config_global foo.bar from_global &&
+	test_config --global foo.bar from_global &&
 	git clone "--template=$template" parent clone-template-config &&
 	test "$(git -C clone-template-config config --local foo.bar)" = "from_template"
 
@@ -112,7 +112,7 @@ test_expect_success 'prefers -c config over --template config' '
 
 test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
 
-	test_config_global clone.defaultRemoteName from_config &&
+	test_config --global clone.defaultRemoteName from_config &&
 	git clone parent clone-config-origin &&
 	git -C clone-config-origin rev-parse --verify refs/remotes/from_config/main
 
@@ -142,7 +142,7 @@ test_expect_success 'redirected clone -v does show progress' '
 '
 
 test_expect_success 'clone does not segfault with --bare and core.bare=false' '
-	test_config_global core.bare false &&
+	test_config --global core.bare false &&
 	git clone --bare parent clone-bare &&
 	echo true >expect &&
 	git -C clone-bare rev-parse --is-bare-repository >actual &&
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index ca8f80083a2f..b92f2e5ca470 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -87,7 +87,7 @@ test_expect_success 'clone with --filter' '
 # check that clone.filterSubmodules works (--also-filter-submodules can be
 # omitted)
 test_expect_success 'filters applied with clone.filterSubmodules' '
-	test_config_global clone.filterSubmodules true &&
+	test_config --global clone.filterSubmodules true &&
 	git clone --recurse-submodules --filter blob:none \
 		"file://$pwd/srv.bare" super_clone2 &&
 	test_cmp_config -C super_clone2 true remote.origin.promisor &&
@@ -97,7 +97,7 @@ test_expect_success 'filters applied with clone.filterSubmodules' '
 '
 
 test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodules=true' '
-	test_config_global clone.filterSubmodules true &&
+	test_config --global clone.filterSubmodules true &&
 	git clone --recurse-submodules --filter blob:none \
 		--no-also-filter-submodules \
 		"file://$pwd/srv.bare" super_clone3 &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 00ce9aec2346..d7ac417bacb6 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -341,7 +341,7 @@ test_expect_success 'upload-pack respects config using protocol v2' '
 	EOF
 	test_commit -C server one &&
 
-	test_config_global uploadpack.packobjectshook ./hook &&
+	test_config --global uploadpack.packobjectshook ./hook &&
 	test_path_is_missing server/.git/hookout &&
 	git -c protocol.version=2 clone "file://$(pwd)/server" client &&
 	test_path_is_file server/.git/hookout
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index a4476dc49220..36aa1f8a2afb 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -444,7 +444,7 @@ test_expect_success 'grep --recurse-submodules with --cached ignores worktree mo
 
 test_expect_failure 'grep --textconv: superproject .gitattributes does not affect submodules' '
 	reset_and_clean &&
-	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	test_config --global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >.gitattributes &&
 
 	cat >expect <<-\EOF &&
@@ -456,7 +456,7 @@ test_expect_failure 'grep --textconv: superproject .gitattributes does not affec
 
 test_expect_failure 'grep --textconv: superproject .gitattributes (from index) does not affect submodules' '
 	reset_and_clean &&
-	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	test_config --global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >.gitattributes &&
 	git add .gitattributes &&
 	rm .gitattributes &&
@@ -470,7 +470,7 @@ test_expect_failure 'grep --textconv: superproject .gitattributes (from index) d
 
 test_expect_failure 'grep --textconv: superproject .git/info/attributes does not affect submodules' '
 	reset_and_clean &&
-	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	test_config --global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	super_attr="$(git rev-parse --git-path info/attributes)" &&
 	test_when_finished "rm -f \"$super_attr\"" &&
 	echo "a diff=d2x" >"$super_attr" &&
@@ -488,7 +488,7 @@ test_expect_failure 'grep --textconv: superproject .git/info/attributes does not
 #
 test_expect_failure 'grep --textconv correctly reads submodule .gitattributes' '
 	reset_and_clean &&
-	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	test_config --global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >submodule/.gitattributes &&
 
 	cat >expect <<-\EOF &&
@@ -500,7 +500,7 @@ test_expect_failure 'grep --textconv correctly reads submodule .gitattributes' '
 
 test_expect_failure 'grep --textconv correctly reads submodule .gitattributes (from index)' '
 	reset_and_clean &&
-	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	test_config --global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >submodule/.gitattributes &&
 	git -C submodule add .gitattributes &&
 	rm submodule/.gitattributes &&
@@ -514,7 +514,7 @@ test_expect_failure 'grep --textconv correctly reads submodule .gitattributes (f
 
 test_expect_failure 'grep --textconv correctly reads submodule .git/info/attributes' '
 	reset_and_clean &&
-	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	test_config --global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 
 	submodule_attr="$(git -C submodule rev-parse --path-format=absolute --git-path info/attributes)" &&
 	test_when_finished "rm -f \"$submodule_attr\"" &&
@@ -529,8 +529,8 @@ test_expect_failure 'grep --textconv correctly reads submodule .git/info/attribu
 
 test_expect_failure 'grep saves textconv cache in the appropriate repository' '
 	reset_and_clean &&
-	test_config_global diff.d2x_cached.textconv "sed -e \"s/d/x/\"" &&
-	test_config_global diff.d2x_cached.cachetextconv true &&
+	test_config --global diff.d2x_cached.textconv "sed -e \"s/d/x/\"" &&
+	test_config --global diff.d2x_cached.cachetextconv true &&
 	echo "a diff=d2x_cached" >submodule/.gitattributes &&
 
 	# We only read/write to the textconv cache when grepping from an OID,
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5f..2e160aa61233 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -506,16 +506,36 @@ test_modebits () {
 			  -e 's|^\(......\)S|\1-|' -e 's|^\(......\)s|\1x|'
 }
 
+# Usage: test_unconfig [options] <name>
+#   -C <dir>:
+#	Run all git commits in directory <dir>
+#   --global:
+#	Modify the global configuration instead of repository.
+#
 # Unset a configuration variable, but don't fail if it doesn't exist.
 test_unconfig () {
+	global=
 	config_dir=
-	if test "$1" = -C
-	then
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			config_dir="$2"
+			shift
+			;;
+		--global)
+			global=yes
+			;;
+		-*)
+			BUG "invalid test_unconfig option: $1"
+			;;
+		*)
+			break
+			;;
+		esac
 		shift
-		config_dir=$1
-		shift
-	fi
-	git ${config_dir:+-C "$config_dir"} config --unset-all "$@"
+	done
+	git ${config_dir:+-C "$config_dir"} config ${global:+--global} --unset-all "$1"
 	config_status=$?
 	case "$config_status" in
 	5) # ok, nothing to unset
@@ -525,22 +545,38 @@ test_unconfig () {
 	return $config_status
 }
 
+# Usage: test_config [options] <name> <value>
+#   -C <dir>:
+#	Run all git commits in directory <dir>
+#   --global:
+#	Modify the global configuration instead of the repository
+#	configuration.
+#
 # Set git config, automatically unsetting it after the test is over.
 test_config () {
+	global=
 	config_dir=
-	if test "$1" = -C
-	then
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			config_dir="$2"
+			shift
+			;;
+		--global)
+			global=yes
+			;;
+		-*)
+			BUG "invalid test_config option: $1"
+			;;
+		*)
+			break
+			;;
+		esac
 		shift
-		config_dir=$1
-		shift
-	fi
-	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$1'" &&
-	git ${config_dir:+-C "$config_dir"} config "$@"
-}
-
-test_config_global () {
-	test_when_finished "test_unconfig --global '$1'" &&
-	git config --global "$@"
+	done
+	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} ${global:+--global} '$1'" &&
+	git ${config_dir:+-C "$config_dir"} config ${global:+--global} "$1" "$2"
 }
 
 write_script () {
-- 
2.36.1

