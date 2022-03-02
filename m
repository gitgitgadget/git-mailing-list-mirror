Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADEFC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiCBNXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbiCBNXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED92219C
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n14so2772099wrq.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+H1rvKBrSCyGKPtOv4WwqwWGhFLDlDHbpXDQqBmcUM=;
        b=YGAyp2gax0/NFyBGL/mjKtX+MxwTfnv8X8w9NDp8TOx2d24tPkBoU/l2k5MVPGQQFS
         JQucz+mIHLbfsqhJoBIocOChUnjZjk9THRYt1zeyCnoU6MeUyayoNQkeHqQi/5mQDXl4
         Bc0krZQScj0CpUAGuUUB0f9yTmDb2TyZnTRlqVWOCiwu6a2KFec1NpByBM9MNXFffFFB
         p2Z4VsaE2KSTefC3HBnsCcO8oG1VkpIo7r8eV1XZV+sgDH6B8HM6KIChkKPW3D2iv2WU
         l6IcTmrbecmzIWL38ped0PvB3lH7bMB/TjuKGD0l3Gb3JR++DoSbeyJSTUNMOJlS0BXM
         rTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+H1rvKBrSCyGKPtOv4WwqwWGhFLDlDHbpXDQqBmcUM=;
        b=LXXElAJ5iRnXQZXpQ80AX8q3RL0gW/eIo8smOag+MnpNhL3FRgUqKpped++iSvbvpQ
         fG0nWyX90jrPaQF1VdKeB0cIIuDtdHeZbDd0tjcpzlUTxyQiYfFAhD9ED8LWmqfnsuoS
         MVw9T+LB+3Azh5aNAQEnM7gQcP4UykmiLcUz+91hIRWpP/V5X9puCbCsa30gfR+4Kn6S
         k92yuZT280CO15FZ42cK7oaVNkfaKbvsfkV+aDSnqTiziJqwNvno1DauUwktSyrREcLI
         IIf0e3gud+ZkWR6SL/AQZyKa7IU+gM1fIy4MJwm/M2dBa7JMaahD1rdbdoioL3elwm0R
         1Msw==
X-Gm-Message-State: AOAM532K1fvRrUIei+j5rVotEN7A8QyQRIbE1kPLeOrJFQtejsJ4oJ4F
        7Nnh/bnW+poNqBsC08KO1fBoHQoQxj7s9Q==
X-Google-Smtp-Source: ABdhPJx47NQ/8lifNxEPUndQHGGcCCGMrpUJYz7pVWfIEq6w3OaQn5Lr5GgcB3zgYmgNhFK0O0y21A==
X-Received: by 2002:adf:bac5:0:b0:1f0:2233:5dd6 with SMTP id w5-20020adfbac5000000b001f022335dd6mr4586360wrg.474.1646227358925;
        Wed, 02 Mar 2022 05:22:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] tests: indent and add hook setup to "test_expect_success"
Date:   Wed,  2 Mar 2022 14:22:24 +0100
Message-Id: <patch-05.10-8dc478460ee-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indent various hook setup code in the test suite that's using a manual
"cat && chmod" pattern.

These should also consistently use "#!$SHELL_PATH" instead of
"#!/bin/sh", i.e. "test_script". Let's fix that in a subsequent
commit, which will be easier to review after this smaller change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3412-rebase-root.sh       | 16 ++++----
 t/t3413-rebase-hook.sh       | 16 ++++----
 t/t5401-update-hooks.sh      | 76 ++++++++++++++++++------------------
 t/t5407-post-rewrite-hook.sh | 16 ++++----
 t/t5541-http-push-smart.sh   | 24 ++++++------
 5 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 1e9f7833dd6..239a9343d34 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -32,10 +32,10 @@ test_expect_success 'rebase --root fails with too many args' '
 
 test_expect_success 'setup pre-rebase hook' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-echo "\$1,\$2" >.git/PRE-REBASE-INPUT
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 cat > expect <<EOF
@@ -142,10 +142,10 @@ EOF
 
 test_expect_success 'setup pre-rebase hook that fails' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-false
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	false
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index b4acb3be5cf..bb241b26b2e 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -42,10 +42,10 @@ test_expect_success 'rebase -i' '
 
 test_expect_success 'setup pre-rebase hook' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-echo "\$1,\$2" >.git/PRE-REBASE-INPUT
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 
@@ -103,10 +103,10 @@ test_expect_success 'pre-rebase hook gets correct input (6)' '
 
 test_expect_success 'setup pre-rebase hook that fails' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-false
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	false
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 6012cc8172a..6392f71795d 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -20,46 +20,46 @@ test_expect_success setup '
 	git clone --bare ./. victim.git &&
 	GIT_DIR=victim.git git update-ref refs/heads/tofail $commit1 &&
 	git update-ref refs/heads/main $commit1 &&
-	git update-ref refs/heads/tofail $commit0
+	git update-ref refs/heads/tofail $commit0 &&
+
+	cat >victim.git/hooks/pre-receive <<-\EOF &&
+	#!/bin/sh
+	printf %s "$@" >>$GIT_DIR/pre-receive.args
+	cat - >$GIT_DIR/pre-receive.stdin
+	echo STDOUT pre-receive
+	echo STDERR pre-receive >&2
+	EOF
+	chmod u+x victim.git/hooks/pre-receive &&
+
+	cat >victim.git/hooks/update <<-\EOF &&
+	#!/bin/sh
+	echo "$@" >>$GIT_DIR/update.args
+	read x; printf %s "$x" >$GIT_DIR/update.stdin
+	echo STDOUT update $1
+	echo STDERR update $1 >&2
+	test "$1" = refs/heads/main || exit
+	EOF
+	chmod u+x victim.git/hooks/update &&
+
+	cat >victim.git/hooks/post-receive <<-\EOF &&
+	#!/bin/sh
+	printf %s "$@" >>$GIT_DIR/post-receive.args
+	cat - >$GIT_DIR/post-receive.stdin
+	echo STDOUT post-receive
+	echo STDERR post-receive >&2
+	EOF
+	chmod u+x victim.git/hooks/post-receive &&
+
+	cat >victim.git/hooks/post-update <<-\EOF &&
+	#!/bin/sh
+	echo "$@" >>$GIT_DIR/post-update.args
+	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
+	echo STDOUT post-update
+	echo STDERR post-update >&2
+	EOF
+	chmod u+x victim.git/hooks/post-update
 '
 
-cat >victim.git/hooks/pre-receive <<'EOF'
-#!/bin/sh
-printf %s "$@" >>$GIT_DIR/pre-receive.args
-cat - >$GIT_DIR/pre-receive.stdin
-echo STDOUT pre-receive
-echo STDERR pre-receive >&2
-EOF
-chmod u+x victim.git/hooks/pre-receive
-
-cat >victim.git/hooks/update <<'EOF'
-#!/bin/sh
-echo "$@" >>$GIT_DIR/update.args
-read x; printf %s "$x" >$GIT_DIR/update.stdin
-echo STDOUT update $1
-echo STDERR update $1 >&2
-test "$1" = refs/heads/main || exit
-EOF
-chmod u+x victim.git/hooks/update
-
-cat >victim.git/hooks/post-receive <<'EOF'
-#!/bin/sh
-printf %s "$@" >>$GIT_DIR/post-receive.args
-cat - >$GIT_DIR/post-receive.stdin
-echo STDOUT post-receive
-echo STDERR post-receive >&2
-EOF
-chmod u+x victim.git/hooks/post-receive
-
-cat >victim.git/hooks/post-update <<'EOF'
-#!/bin/sh
-echo "$@" >>$GIT_DIR/post-update.args
-read x; printf %s "$x" >$GIT_DIR/post-update.stdin
-echo STDOUT post-update
-echo STDERR post-update >&2
-EOF
-chmod u+x victim.git/hooks/post-update
-
 test_expect_success push '
 	test_must_fail git send-pack --force ./victim.git \
 		main tofail >send.out 2>send.err
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 6da8d760e28..64f40ff7776 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -17,15 +17,15 @@ test_expect_success 'setup' '
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
+	cat >.git/hooks/post-rewrite <<-EOF &&
+	#!/bin/sh
+	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
+	cat > "$TRASH_DIRECTORY"/post-rewrite.data
+	EOF
+	chmod u+x .git/hooks/post-rewrite
+'
 
 clear_hook_input () {
 	rm -f post-rewrite.args post-rewrite.data
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ca50f8b18c..0043b718f08 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -96,18 +96,20 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
-cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
-#!/bin/sh
-exit 1
-EOF
-chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
+test_expect_success 'setup rejected update hook' '
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-EOF &&
+	#!/bin/sh
+	exit 1
+	EOF
+	chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" &&
 
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
2.35.1.1228.g56895c6ee86

