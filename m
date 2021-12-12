Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE6C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhLLUO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:57 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:34747 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhLLUOp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:45 -0500
Received: by mail-wm1-f46.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so9937967wmi.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KfuewcgY2/LyaMU6RoByaIPl0rwHcXCTnmWVkFtBr4=;
        b=DpIFCyLuFxScvMJuKLp0WinkWpgv0XkG4exQPqCfZ26GNOUwRmZywieVpLxwonAu8y
         Ymzo1G3QAsJW0VEAsh7ShjsN57gmYdO2i7lS/rS8wHrA7b8wl8gz4O1jNwfcHh01rtzf
         NGrpgImmKcvOX6/4ky3Q6ZrYlPzgK6c06mdOhUgnXCTlkt5pq2dS3Knc5o9QczFY5aZU
         P6b/4hbeOFausFKIbJ4gUXyJeUZYh76lO+H8rFAGiB6Jx428hsdH6GG0XsC5Kzdc7kMG
         JsfBgyutBw8pny9rbHCjQPxgLSyQy/AboWkxDDpxXXq8gJStRwHh1JWawu7/u17jj4BF
         +Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KfuewcgY2/LyaMU6RoByaIPl0rwHcXCTnmWVkFtBr4=;
        b=WmjISMwNxgl6XWpmlaOXBW4UVFvMZhshL7dEyaFtzBW8u260pMMryHEHVToWMB1OkU
         LioRXiT3AO4tSabl4PB/+WeacayjOa+2Ek7yfliEbxJYm3jdqUgMaNXGw7A7c5fOPRJK
         FgK1y69fy6Lx9RRwgiwPgSb2B2K8h0k2+7oYpU384+eafrpJ+fMTdP2boGcJ/C8UMGXp
         aB4T/nkU9WlPLNarnFOktQBQCPHE35P7TJuk/Ue0eH1AZFQWl4TRzqLevFHZDbidUgPr
         vsgeDq0zeMcV9t5oRuhD6cmdKKoD2bxgCczWwn1JSJW+oxXcVctDn8PRxjExcWLQpWIk
         szTw==
X-Gm-Message-State: AOAM531wNrxeiGzl840epCf6Q8Z5eLN3G79ebSB+aY2YnFiTYwSBEgBG
        efIOuPqOU11KpoqP9cfePSiXCA2a93PGeA==
X-Google-Smtp-Source: ABdhPJzfgOvV/soPddrnya/eKnAOV0HK7Sc6qDT1VyzdPeqqdiI0FgAdBe1wDs8wQoPnDb4g2QDwNw==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr32038087wmh.115.1639340023914;
        Sun, 12 Dec 2021 12:13:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/13] tests: change "cat && chmod +x" to use "write_hook"
Date:   Sun, 12 Dec 2021 21:13:21 +0100
Message-Id: <patch-11.13-6f805f7ebac-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor various test code to use the "write_hook()" helper. Let's
indent this code and add it to "test_expect_success" while we're at
it.

As in a preceding commit some of this code drops the explicit "mkdir
-p", but as noted we'll be having the "write_hook" wrapper handle that
soon anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3412-rebase-root.sh       | 18 ++++-------
 t/t3413-rebase-hook.sh       | 18 ++++-------
 t/t5401-update-hooks.sh      | 62 ++++++++++++++++--------------------
 t/t5402-post-merge-hook.sh   | 16 ++++++----
 t/t5407-post-rewrite-hook.sh | 14 ++++----
 t/t5516-fetch-push.sh        | 15 +++------
 t/t5541-http-push-smart.sh   |  4 +--
 t/t5601-clone.sh             |  4 +--
 8 files changed, 60 insertions(+), 91 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 19c6f4acbf6..c2dfb562961 100755
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
+	write_hook pre-rebase <<-\EOF
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
+	write_hook pre-rebase <<-\EOF
+	false
+	EOF
 '
 
 test_expect_success 'pre-rebase hook stops rebase' '
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index b4acb3be5cf..100157aa0ab 100755
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
+	write_hook pre-rebase <<-\EOF
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
+	write_hook pre-rebase <<-\EOF
+	false
+	EOF
 '
 
 test_expect_success 'pre-rebase hook stops rebase (1)' '
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 6012cc8172a..1bd656d35ce 100755
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
+	write_hook -C victim.git pre-receive <<-\EOF &&
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
+	write_hook -C victim.git update <<-\EOF &&
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
+	write_hook -C victim.git post-receive <<-\EOF &&
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
+	write_hook -C victim.git post-update <<-\EOF
+	echo "$@" >>$GIT_DIR/post-update.args
+	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
+	echo STDOUT post-update
+	echo STDERR post-update >&2
+	EOF
+'
 
 test_expect_success push '
 	test_must_fail git send-pack --force ./victim.git \
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 3e5e19c7191..c425a807efe 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -25,13 +25,15 @@ test_expect_success setup '
 	GIT_DIR=clone2/.git git update-index --add a
 '
 
-for clone in 1 2; do
-	cat >clone${clone}/.git/hooks/post-merge <<'EOF'
-#!/bin/sh
-echo $@ >> $GIT_DIR/post-merge.args
-EOF
-	chmod u+x clone${clone}/.git/hooks/post-merge
-done
+test_expect_success 'setup clone hooks' '
+	test_when_finished "rm -f hook" &&
+	cat >hook <<-\EOF &&
+	echo $@ >> $GIT_DIR/post-merge.args
+	EOF
+
+	write_hook -C clone1 post-merge <hook &&
+	write_hook -C clone2 post-merge <hook
+'
 
 test_expect_success 'post-merge does not run for up-to-date ' '
 	GIT_DIR=clone1/.git git merge $commit0 &&
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 6da8d760e28..7a2bf55d8e2 100755
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
+	write_hook post-rewrite <<-EOF
+	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
+	cat > "$TRASH_DIRECTORY"/post-rewrite.data
+	EOF
+'
 
 clear_hook_input () {
 	rm -f post-rewrite.args post-rewrite.data
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 11458052cb4..fd355ae48c6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -62,32 +62,25 @@ mk_test_with_hooks() {
 	(
 		cd "$repo_name" &&
 		mkdir .git/hooks &&
-		cd .git/hooks &&
 
-		cat >pre-receive <<-'EOF' &&
-		#!/bin/sh
+		write_hook pre-receive <<-'EOF' &&
 		cat - >>pre-receive.actual
 		EOF
 
-		cat >update <<-'EOF' &&
-		#!/bin/sh
+		write_hook update <<-'EOF' &&
 		printf "%s %s %s\n" "$@" >>update.actual
 		EOF
 
-		cat >post-receive <<-'EOF' &&
-		#!/bin/sh
+		write_hook post-receive <<-'EOF' &&
 		cat - >>post-receive.actual
 		EOF
 
-		cat >post-update <<-'EOF' &&
-		#!/bin/sh
+		write_hook post-update <<-'EOF'
 		for ref in "$@"
 		do
 			printf "%s\n" "$ref" >>post-update.actual
 		done
 		EOF
-
-		chmod +x pre-receive update post-receive post-update
 	)
 }
 
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ca50f8b18c..11da2325c6d 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -96,11 +96,9 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
-cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
-#!/bin/sh
+write_hook -C "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" update <<\EOF
 exit 1
 EOF
-chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
 cat >exp <<EOF
 remote: error: hook declined to update refs/heads/dev2
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 83c24fc97a7..6fd041e7d3e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -79,12 +79,10 @@ test_expect_success 'clone from hooks' '
 	cd .. &&
 	git init r1 &&
 	cd r1 &&
-	cat >.git/hooks/pre-commit <<-\EOF &&
-	#!/bin/sh
+	write_hook pre-commit <<-\EOF &&
 	git clone ../r0 ../r2
 	exit 1
 	EOF
-	chmod u+x .git/hooks/pre-commit &&
 	: >file &&
 	git add file &&
 	test_must_fail git commit -m invoke-hook &&
-- 
2.34.1.1020.gb1392dd1877

