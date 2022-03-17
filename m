Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B64C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiCQKO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiCQKOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12ADDCAA1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r10so6655807wrp.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwcMcBvKegk3TsshKzV9PRL3MVNaao0nUw05GRsFweA=;
        b=kPZfMZc2ToPofT/SvEghjROmiILlMxMaj8cAJmbHoLBUUovqiq2GzsZq+4WJRFyCaR
         FiWJVe3vAAHylw2BdNqcgRP/um84XgwD9ZQA8KRWaFDCfsCX2UY7eLE/Nt+G+C1h0nQm
         ug7NLhf+vhWJ6m39ORnEE0Wy7n9TVhawh7MtI5Ko5gse9GadwJqasGerUShcUy5TixRm
         8aYfVC868MBHa9NuAAA+QC1KU5EKbAsPhCdex+1XcwwDbKcP1YgwkgftHUifokvdTKaD
         XO1WmlU0WVDtt5XK07gzZjIvFQcdjzMiWEr8f/q7vmc7VJau4IFf9Gk04Ew+PMnHIx70
         w6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwcMcBvKegk3TsshKzV9PRL3MVNaao0nUw05GRsFweA=;
        b=oIy4pwcD5c45SRuggHgc8cmAG+iycyQnEg91LnzvFHkxSf+rC4QMRnveJH02hbiMQr
         gALYJdsYA3szvufyTSlyPkK/oTK8lCaMCn2o4AcGsu/2+3KWf5a5InQw3L1anvSSROvf
         MFjn5BSZraV/3NgEu8b1BKZtutftX4KP7bz5cqIBfQyqnn84R/vZX0y/Zk/qjQ9h/MVG
         FwbT393WoDzrzRb0GeQ75Frtp0oLHw98TMmrku32jNPg8xMDZ5B35qSGbJJNQXNqf3Ih
         WBVX0rtOdLSpD3DB/DWCyi1V4X+14RnLesn3tnC4gJ11V0mJ6yNRNma6jk20V2taW5w+
         +gww==
X-Gm-Message-State: AOAM530aWzPrc0OSZwsezeXuHkew9XcGEb6QnVH2GLG5tiN/+UtxRwa0
        iWhGEoRcJ/pYNT+NjMeHxUOB/JOfqTQ=
X-Google-Smtp-Source: ABdhPJyzurYBLR0ls9FVaSK67w28SNL11F9d/8f1eN7ktx1vfAnjDCMwdDSrHpmpNNkYh8HiUcq++w==
X-Received: by 2002:a5d:4890:0:b0:1ed:9d4e:f8ef with SMTP id g16-20020a5d4890000000b001ed9d4ef8efmr3337528wrq.595.1647512012088;
        Thu, 17 Mar 2022 03:13:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/13] tests: use "test_hook" for misc "mkdir -p" and "chmod" cases
Date:   Thu, 17 Mar 2022 11:13:15 +0100
Message-Id: <patch-v3-10.13-dab99b8359d-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of "test_hook" in various cases that didn't fit neatly into
preceding commits. Here we need to indent blocks in addition to
changing the test code, or to make other small cosmetic changes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3412-rebase-root.sh       | 18 ++++-------
 t/t3413-rebase-hook.sh       | 18 ++++-------
 t/t5401-update-hooks.sh      | 62 ++++++++++++++++--------------------
 t/t5407-post-rewrite-hook.sh | 14 ++++----
 t/t5541-http-push-smart.sh   | 22 ++++++-------
 5 files changed, 56 insertions(+), 78 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 1e9f7833dd6..58371d8a547 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -31,12 +31,9 @@ test_expect_success 'rebase --root fails with too many args' '
 '
 
 test_expect_success 'setup pre-rebase hook' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-echo "\$1,\$2" >.git/PRE-REBASE-INPUT
-EOF
-	chmod +x .git/hooks/pre-rebase
+	test_hook --setup pre-rebase <<-\EOF
+	echo "$1,$2" >.git/PRE-REBASE-INPUT
+	EOF
 '
 cat > expect <<EOF
 4
@@ -141,12 +138,9 @@ commit work7~5
 EOF
 
 test_expect_success 'setup pre-rebase hook that fails' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-false
-EOF
-	chmod +x .git/hooks/pre-rebase
+	test_hook --setup --clobber pre-rebase <<-\EOF
+	false
+	EOF
 '
 
 test_expect_success 'pre-rebase hook stops rebase' '
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index b4acb3be5cf..9fab0d779bb 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -41,12 +41,9 @@ test_expect_success 'rebase -i' '
 '
 
 test_expect_success 'setup pre-rebase hook' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-echo "\$1,\$2" >.git/PRE-REBASE-INPUT
-EOF
-	chmod +x .git/hooks/pre-rebase
+	test_hook --setup pre-rebase <<-\EOF
+	echo "$1,$2" >.git/PRE-REBASE-INPUT
+	EOF
 '
 
 test_expect_success 'pre-rebase hook gets correct input (1)' '
@@ -102,12 +99,9 @@ test_expect_success 'pre-rebase hook gets correct input (6)' '
 '
 
 test_expect_success 'setup pre-rebase hook that fails' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-false
-EOF
-	chmod +x .git/hooks/pre-rebase
+	test_hook --setup --clobber pre-rebase <<-\EOF
+	false
+	EOF
 '
 
 test_expect_success 'pre-rebase hook stops rebase (1)' '
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 799349a416c..001b7a17ad2 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -20,45 +20,37 @@ test_expect_success setup '
 	git clone --bare ./. victim.git &&
 	GIT_DIR=victim.git git update-ref refs/heads/tofail $commit1 &&
 	git update-ref refs/heads/main $commit1 &&
-	git update-ref refs/heads/tofail $commit0
-'
+	git update-ref refs/heads/tofail $commit0 &&
 
-cat >victim.git/hooks/pre-receive <<'EOF'
-#!/bin/sh
-printf %s "$@" >>$GIT_DIR/pre-receive.args
-cat - >$GIT_DIR/pre-receive.stdin
-echo STDOUT pre-receive
-echo STDERR pre-receive >&2
-EOF
-chmod u+x victim.git/hooks/pre-receive
+	test_hook --setup -C victim.git pre-receive <<-\EOF &&
+	printf %s "$@" >>$GIT_DIR/pre-receive.args
+	cat - >$GIT_DIR/pre-receive.stdin
+	echo STDOUT pre-receive
+	echo STDERR pre-receive >&2
+	EOF
 
-cat >victim.git/hooks/update <<'EOF'
-#!/bin/sh
-echo "$@" >>$GIT_DIR/update.args
-read x; printf %s "$x" >$GIT_DIR/update.stdin
-echo STDOUT update $1
-echo STDERR update $1 >&2
-test "$1" = refs/heads/main || exit
-EOF
-chmod u+x victim.git/hooks/update
+	test_hook --setup -C victim.git update <<-\EOF &&
+	echo "$@" >>$GIT_DIR/update.args
+	read x; printf %s "$x" >$GIT_DIR/update.stdin
+	echo STDOUT update $1
+	echo STDERR update $1 >&2
+	test "$1" = refs/heads/main || exit
+	EOF
 
-cat >victim.git/hooks/post-receive <<'EOF'
-#!/bin/sh
-printf %s "$@" >>$GIT_DIR/post-receive.args
-cat - >$GIT_DIR/post-receive.stdin
-echo STDOUT post-receive
-echo STDERR post-receive >&2
-EOF
-chmod u+x victim.git/hooks/post-receive
+	test_hook --setup -C victim.git post-receive <<-\EOF &&
+	printf %s "$@" >>$GIT_DIR/post-receive.args
+	cat - >$GIT_DIR/post-receive.stdin
+	echo STDOUT post-receive
+	echo STDERR post-receive >&2
+	EOF
 
-cat >victim.git/hooks/post-update <<'EOF'
-#!/bin/sh
-echo "$@" >>$GIT_DIR/post-update.args
-read x; printf %s "$x" >$GIT_DIR/post-update.stdin
-echo STDOUT post-update
-echo STDERR post-update >&2
-EOF
-chmod u+x victim.git/hooks/post-update
+	test_hook --setup -C victim.git post-update <<-\EOF
+	echo "$@" >>$GIT_DIR/post-update.args
+	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
+	echo STDOUT post-update
+	echo STDERR post-update >&2
+	EOF
+'
 
 test_expect_success push '
 	test_must_fail git send-pack --force ./victim.git \
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 6da8d760e28..5f3ff051ca2 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -17,15 +17,13 @@ test_expect_success 'setup' '
 	git checkout A^0 &&
 	test_commit E bar E &&
 	test_commit F foo F &&
-	git checkout main
-'
+	git checkout main &&
 
-cat >.git/hooks/post-rewrite <<EOF
-#!/bin/sh
-echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
-cat > "$TRASH_DIRECTORY"/post-rewrite.data
-EOF
-chmod u+x .git/hooks/post-rewrite
+	test_hook --setup post-rewrite <<-EOF
+	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
+	cat > "$TRASH_DIRECTORY"/post-rewrite.data
+	EOF
+'
 
 clear_hook_input () {
 	rm -f post-rewrite.args post-rewrite.data
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ca50f8b18c..ab4b5cfcd11 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -96,18 +96,18 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
-cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
-#!/bin/sh
-exit 1
-EOF
-chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
+test_expect_success 'setup rejected update hook' '
+	test_hook --setup -C "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" update <<-\EOF &&
+	exit 1
+	EOF
 
-cat >exp <<EOF
-remote: error: hook declined to update refs/heads/dev2
-To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
- ! [remote rejected] dev2 -> dev2 (hook declined)
-error: failed to push some refs to 'http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'
-EOF
+	cat >exp <<-EOF
+	remote: error: hook declined to update refs/heads/dev2
+	To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
+	 ! [remote rejected] dev2 -> dev2 (hook declined)
+	error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
+	EOF
+'
 
 test_expect_success 'rejected update prints status' '
 	cd "$ROOT_PATH"/test_repo_clone &&
-- 
2.35.1.1384.g7d2906948a1

