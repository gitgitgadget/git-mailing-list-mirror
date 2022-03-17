Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435F6C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiCQKPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiCQKOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C17DBD05
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso2876403wmr.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86bFelr4Vn7SVbZR0wLNSeGkU5UebBPrpSN6VaVPQSE=;
        b=f3QbMev4ruqr0VOiK+qQ3GzeURg2mUXh2/jdi/4sAjU25XctaBRrWguBgKHthkDLU0
         cC9gZCH2SEVIOj61mi5nQS/CcH62C4DhLcfW4gffJdDsv3kkTWuW1JQhJJpwXBGn/fm7
         LzKq0XQ4K4F0Rv4UQb5MSgLdMgK2VSLzceXWRHH67OeolVZI+RgVbYNz6JpeOtIYpM5n
         xol1jW1sC9NUynAagco6LC6cMcFViKVfGABTrWtelDWHi9P1NRxhuF2w7n3js61Lo9Bg
         54JK5/lFI5iEfOgRTHjL3idT9TvUru9KX1cOEO6aWNeLIUBDCC0VKPFeagkN1b5kwzgm
         bD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86bFelr4Vn7SVbZR0wLNSeGkU5UebBPrpSN6VaVPQSE=;
        b=Mhkbk6mkhaMbC5Vcc842tuREeCAgR5ek0eRjxsbLDcvlrev2chMj9HayjhJyNBa8Zm
         EN03shmrlL4qfIrKZI/hwDl2DYm48Yo0FiUCKvnJZRiYmLbT5k228qPbGhc83R4uMRUu
         V9FhD7L/EeSMM7qgLuIHsIO+Cv176EFJ8SSFq7KF2zsxrPKx6L50YHdDdWdt7olBA4w/
         FDNUlbZtJd24TGT4jqWF1ngBJeNq6OssOmTWbKLf9OlGv9LT5XICpwuwR324VTJpSnAK
         kxzLWF9Lh//UjizOb1PDQwZkmuOaxKuDznR5ZhbvKhJCBlmV6NgZ94pU8i0zFdOmU3qE
         Bwcw==
X-Gm-Message-State: AOAM531MPQBrSY+u6dk9Uh5Xe/BK0Rm0GNIUEd7GLneRHu7UyEnQZNOZ
        RJHDdbMd0tQ5QwALdyEE+MhQD+dwSdQ=
X-Google-Smtp-Source: ABdhPJxnPXWQO13/kbnV9tVbD0HmTXo1EHUsr6qzbxOcJ2ZfiSJwOv+kiX5GlZOKh34YQh6u4kxHLA==
X-Received: by 2002:a7b:c855:0:b0:384:91d1:8120 with SMTP id c21-20020a7bc855000000b0038491d18120mr10685343wml.110.1647512011049;
        Thu, 17 Mar 2022 03:13:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/13] tests: change "mkdir -p && write_script" to use "test_hook"
Date:   Thu, 17 Mar 2022 11:13:14 +0100
Message-Id: <patch-v3-09.13-f908e27da82-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change tests that used a "mkdir -p .git/hooks && write_script" pattern
to use the new "test_hook" helper instead. The new helper does not
create the .git/hooks directory, rather we assume that the default
template will do so for us.

An upcoming series[1] will extend "test_hook" to operate in a
"--template=" mode, but for now assuming that we have a .git/hooks
already is a safe assumption. If that assumption becomes false in the
future we'll only need to change 'test_hook", instead of all of these
callsites.

1. https://lore.kernel.org/git/cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0029-core-unsetenvvars.sh      |  3 +--
 t/t1350-config-hooks-path.sh      |  4 ++--
 t/t3404-rebase-interactive.sh     | 10 ++--------
 t/t3430-rebase-merges.sh          |  6 +++---
 t/t4150-am.sh                     | 24 ++++++------------------
 t/t5403-post-checkout-hook.sh     |  3 +--
 t/t5534-push-signed.sh            | 26 ++++++++------------------
 t/t7113-post-index-change-hook.sh |  7 +++----
 t/t9001-send-email.sh             |  4 +---
 9 files changed, 27 insertions(+), 60 deletions(-)

diff --git a/t/t0029-core-unsetenvvars.sh b/t/t0029-core-unsetenvvars.sh
index b138e1d9cbc..4e8e90dd982 100755
--- a/t/t0029-core-unsetenvvars.sh
+++ b/t/t0029-core-unsetenvvars.sh
@@ -12,8 +12,7 @@ then
 fi
 
 test_expect_success 'setup' '
-	mkdir -p "$TRASH_DIRECTORY/.git/hooks" &&
-	write_script "$TRASH_DIRECTORY/.git/hooks/pre-commit" <<-\EOF
+	test_hook --setup pre-commit <<-\EOF
 	echo $HOBBES >&2
 	EOF
 '
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index fa9647a7c0b..f6dc83e2aab 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -6,11 +6,11 @@ test_description='Test the core.hooksPath configuration variable'
 
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
 	>actual &&
-	mkdir -p .git/custom-hooks .git/hooks &&
+	mkdir -p .git/custom-hooks &&
 	write_script .git/custom-hooks/pre-commit <<-\EOF &&
 	echo CUSTOM >>actual
 	EOF
-	write_script .git/hooks/pre-commit <<-\EOF
+	test_hook --setup pre-commit <<-\EOF
 	echo NORMAL >>actual
 	EOF
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a38f2da7691..f31afd4a547 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -619,9 +619,7 @@ test_expect_success 'rebase a detached HEAD' '
 '
 
 test_expect_success 'rebase a commit violating pre-commit' '
-
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/pre-commit <<-\EOF &&
+	test_hook pre-commit <<-\EOF &&
 	test -z "$(git diff --cached --check)"
 	EOF
 	echo "monde! " >> file1 &&
@@ -636,8 +634,6 @@ test_expect_success 'rebase a commit violating pre-commit' '
 '
 
 test_expect_success 'rebase with a file named HEAD in worktree' '
-
-	rm -fr .git/hooks &&
 	git reset --hard &&
 	git checkout -b branch3 A &&
 
@@ -1688,10 +1684,8 @@ test_expect_success 'valid author header when author contains single quote' '
 '
 
 test_expect_success 'post-commit hook is called' '
-	test_when_finished "rm -f .git/hooks/post-commit" &&
 	>actual &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/post-commit <<-\EOS &&
+	test_hook post-commit <<-\EOS &&
 	git rev-parse HEAD >>actual
 	EOS
 	(
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 43c82d9a33b..f351701fec2 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -292,9 +292,9 @@ test_expect_success 'post-rewrite hook and fixups work for merges' '
 	git commit --fixup HEAD same2.t &&
 	fixup="$(git rev-parse HEAD)" &&
 
-	mkdir -p .git/hooks &&
-	test_when_finished "rm .git/hooks/post-rewrite" &&
-	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
+	test_hook post-rewrite <<-\EOF &&
+	cat >actual
+	EOF
 
 	test_tick &&
 	git rebase -i --autosquash -r HEAD^^^ &&
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 159fae8d016..cdad4b68807 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -315,12 +315,10 @@ test_expect_success 'am --patch-format=hg applies hg patch' '
 '
 
 test_expect_success 'am with applypatch-msg hook' '
-	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	test_hook applypatch-msg <<-\EOF &&
 	cat "$1" >actual-msg &&
 	echo hook-message >"$1"
 	EOF
@@ -335,12 +333,10 @@ test_expect_success 'am with applypatch-msg hook' '
 '
 
 test_expect_success 'am with failing applypatch-msg hook' '
-	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	test_hook applypatch-msg <<-\EOF &&
 	exit 1
 	EOF
 	test_must_fail git am patch1 &&
@@ -350,12 +346,10 @@ test_expect_success 'am with failing applypatch-msg hook' '
 '
 
 test_expect_success 'am with pre-applypatch hook' '
-	test_when_finished "rm -f .git/hooks/pre-applypatch" &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/pre-applypatch <<-\EOF &&
+	test_hook pre-applypatch <<-\EOF &&
 	git diff first >diff.actual
 	exit 0
 	EOF
@@ -368,12 +362,10 @@ test_expect_success 'am with pre-applypatch hook' '
 '
 
 test_expect_success 'am with failing pre-applypatch hook' '
-	test_when_finished "rm -f .git/hooks/pre-applypatch" &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/pre-applypatch <<-\EOF &&
+	test_hook pre-applypatch <<-\EOF &&
 	exit 1
 	EOF
 	test_must_fail git am patch1 &&
@@ -383,12 +375,10 @@ test_expect_success 'am with failing pre-applypatch hook' '
 '
 
 test_expect_success 'am with post-applypatch hook' '
-	test_when_finished "rm -f .git/hooks/post-applypatch" &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/post-applypatch <<-\EOF &&
+	test_hook post-applypatch <<-\EOF &&
 	git rev-parse HEAD >head.actual
 	git diff second >diff.actual
 	exit 0
@@ -403,12 +393,10 @@ test_expect_success 'am with post-applypatch hook' '
 '
 
 test_expect_success 'am with failing post-applypatch hook' '
-	test_when_finished "rm -f .git/hooks/post-applypatch" &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/post-applypatch <<-\EOF &&
+	test_hook post-applypatch <<-\EOF &&
 	git rev-parse HEAD >head.actual
 	exit 1
 	EOF
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index d1181816906..978f240cdac 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -10,8 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/post-checkout <<-\EOF &&
+	test_hook --setup post-checkout <<-\EOF &&
 	echo "$@" >.git/post-checkout.args
 	EOF
 	test_commit one &&
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 24d374adbae..7c0a148e73c 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -35,8 +35,7 @@ test_expect_success setup '
 
 test_expect_success 'unsigned push does not send push certificate' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
 	# record the push certificate
@@ -52,8 +51,7 @@ test_expect_success 'unsigned push does not send push certificate' '
 
 test_expect_success 'talking with a receiver without push certificate support' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
 	# record the push certificate
@@ -69,22 +67,19 @@ test_expect_success 'talking with a receiver without push certificate support' '
 
 test_expect_success 'push --signed fails with a receiver without push certificate support' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
 	test_must_fail git push --signed dst noop ff +noff 2>err &&
 	test_i18ngrep "the receiving end does not support" err
 '
 
 test_expect_success 'push --signed=1 is accepted' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
 	test_must_fail git push --signed=1 dst noop ff +noff 2>err &&
 	test_i18ngrep "the receiving end does not support" err
 '
 
 test_expect_success GPG 'no certificate for a signed push with no update' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	if test -n "${GIT_PUSH_CERT-}"
 	then
 		git cat-file blob $GIT_PUSH_CERT >../push-cert
@@ -96,9 +91,8 @@ test_expect_success GPG 'no certificate for a signed push with no update' '
 
 test_expect_success GPG 'signed push sends push certificate' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
 	git -C dst config receive.certnonceseed sekrit &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
 	# record the push certificate
@@ -139,10 +133,9 @@ test_expect_success GPG 'signed push sends push certificate' '
 
 test_expect_success GPGSSH 'ssh signed push sends push certificate' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
 	git -C dst config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git -C dst config receive.certnonceseed sekrit &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
 	# record the push certificate
@@ -223,9 +216,8 @@ test_expect_success GPG 'inconsistent push options in signed push not allowed' '
 
 test_expect_success GPG 'fail without key and heed user.signingkey' '
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
 	git -C dst config receive.certnonceseed sekrit &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
 	# record the push certificate
@@ -273,9 +265,8 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
 test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	test_config gpg.format x509 &&
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
 	git -C dst config receive.certnonceseed sekrit &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
 	# record the push certificate
@@ -326,10 +317,9 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 test_expect_success GPGSSH 'fail without key and heed user.signingkey ssh' '
 	test_config gpg.format ssh &&
 	prepare_dst &&
-	mkdir -p dst/.git/hooks &&
 	git -C dst config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git -C dst config receive.certnonceseed sekrit &&
-	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	test_hook -C dst post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
 	# record the push certificate
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index a21781d68a1..58e55a7c779 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -17,8 +17,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'test status, add, commit, others trigger hook without flags set' '
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/post-index-change <<-\EOF &&
+	test_hook post-index-change <<-\EOF &&
 		if test "$1" -eq 1; then
 			echo "Invalid combination of flags passed to hook; updated_workdir is set." >testfailure
 			exit 1
@@ -63,7 +62,7 @@ test_expect_success 'test status, add, commit, others trigger hook without flags
 '
 
 test_expect_success 'test checkout and reset trigger the hook' '
-	write_script .git/hooks/post-index-change <<-\EOF &&
+	test_hook post-index-change <<-\EOF &&
 		if test "$1" -eq 1 && test "$2" -eq 1; then
 			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
 			exit 1
@@ -106,7 +105,7 @@ test_expect_success 'test checkout and reset trigger the hook' '
 '
 
 test_expect_success 'test reset --mixed and update-index triggers the hook' '
-	write_script .git/hooks/post-index-change <<-\EOF &&
+	test_hook post-index-change <<-\EOF &&
 		if test "$1" -eq 1 && test "$2" -eq 1; then
 			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
 			exit 1
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84d0f40d76a..42694fe5841 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2288,9 +2288,7 @@ test_expect_success $PREREQ 'cmdline in-reply-to used with --no-thread' '
 '
 
 test_expect_success $PREREQ 'invoke hook' '
-	mkdir -p .git/hooks &&
-
-	write_script .git/hooks/sendemail-validate <<-\EOF &&
+	test_hook sendemail-validate <<-\EOF &&
 	# test that we have the correct environment variable, pwd, and
 	# argument
 	case "$GIT_DIR" in
-- 
2.35.1.1384.g7d2906948a1

