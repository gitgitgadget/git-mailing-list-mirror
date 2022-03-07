Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57090C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242464AbiCGMpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiCGMo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5804238792
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r65so9118764wma.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdyXVFHakEDhTzGEwWmf/XPnQQZ1PN4Pw5Aa/T7U4d0=;
        b=CNXlDAetHu0zJlQj/ImbUJqnIvR9qbcrG50fdXcp0yc432DIWMxMNCCCfaa/y0Bg19
         V9yIgxuM6/YmPo8tCsLNkxitXpw4x1CAxzksM/Ep7q6W3TYNhmJV0Ty+8SteK2Yg8WpI
         tgRtiGG/4ZJD3QsajUWmbHwP2BOn2/CWwvEz4Zu6keWkperGe4RAK1QBgsEggZUnqTkb
         VCuKBtTQBKCT1/36nDnphl3k/9Wt4k2nnB9pXR551w8miVZ7KZzNAGcRYexQUGXnT/4T
         6tLyLNbyWhHqJoVdFn2LAIHwl1htvfwlAhL0MzhgXqF/2chgEtZ+q62NCixQMC078MQT
         NaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdyXVFHakEDhTzGEwWmf/XPnQQZ1PN4Pw5Aa/T7U4d0=;
        b=olDwi6VmIJw3K+RP5pv+PTujSKkSAeR91aVT9yXJ+/MRHd6Y2Ng96j0S2YnEP6xNIu
         07fHRjCUPNw1Rjmi+uuBlpNHy5Q0SzBgoy01N2T5qSSojUqGcKoT/B4PAmrObs0fpJZB
         JW+2bvY3Pf4wF5ZeoD84yXPBNxVqJXiOwiQsKiqKKMaabGq1zRDwHbArY3sCULUXxDjB
         uKVqs7lgUvB2BEHnLNeOsPd6BY/iI3NK98zmuK/m8oemjOXbrgZ/6AQ4dnkYPgUoHm10
         x6euKszyKAbVaICuQst+7T5/Gq7qQzkw+QC2NER3Gv6E+h5cK60M31dUeWOMPvOCfxUj
         6bGA==
X-Gm-Message-State: AOAM531IQtBftt388n4qP2qEtir21DkJUj1dFQpqlns0rHD6ExDF450c
        6CXdK31fKRBe8jSCjW21M5GbS7gb0R4fkQ==
X-Google-Smtp-Source: ABdhPJxjkmnBja+JPQm3u66XUTJSCG+l5/Kicz1gHhtYJNtB/iYmfo6BHmbRd7O/Xp8Z9Yn3mzL0/Q==
X-Received: by 2002:a7b:c001:0:b0:37d:409d:624d with SMTP id c1-20020a7bc001000000b0037d409d624dmr8861414wmb.64.1646657037641;
        Mon, 07 Mar 2022 04:43:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] tests: change "cat && chmod +x" to use "test_hook"
Date:   Mon,  7 Mar 2022 13:43:41 +0100
Message-Id: <patch-v2-10.10-db27fa32bbd-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor various test code to use the "test_hook" helper. This change:

 - Fixes the long-standing issues with those tests using "#!/bin/sh"
   instead of "#!$SHELL_PATH". Using "#!/bin/sh" here happened to work
   because this code was so simple that it e.g. worked on Solaris
   /bin/sh.

 - Removes the "mkdir .git/hooks" invocation, as explained in a
   preceding commit we'll rely on the default templates to create that
   directory for us.

For the test in "t5402-post-merge-hook.sh" it's easier and more
correct to unroll the for-loop into a test_expect_success, so let's do
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3412-rebase-root.sh       | 12 +++---------
 t/t3413-rebase-hook.sh       | 12 +++---------
 t/t5401-update-hooks.sh      | 16 ++++------------
 t/t5402-post-merge-hook.sh   | 16 +++++++++-------
 t/t5407-post-rewrite-hook.sh |  4 +---
 t/t5516-fetch-push.sh        | 19 ++++---------------
 t/t5541-http-push-smart.sh   |  4 +---
 t/t5601-clone.sh             |  4 +---
 8 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 239a9343d34..58371d8a547 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -31,12 +31,9 @@ test_expect_success 'rebase --root fails with too many args' '
 '
 
 test_expect_success 'setup pre-rebase hook' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	test_hook --setup pre-rebase <<-\EOF
+	echo "$1,$2" >.git/PRE-REBASE-INPUT
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 cat > expect <<EOF
 4
@@ -141,12 +138,9 @@ commit work7~5
 EOF
 
 test_expect_success 'setup pre-rebase hook that fails' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
+	test_hook --setup --clobber pre-rebase <<-\EOF
 	false
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 
 test_expect_success 'pre-rebase hook stops rebase' '
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index bb241b26b2e..9fab0d779bb 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -41,12 +41,9 @@ test_expect_success 'rebase -i' '
 '
 
 test_expect_success 'setup pre-rebase hook' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	test_hook --setup pre-rebase <<-\EOF
+	echo "$1,$2" >.git/PRE-REBASE-INPUT
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 
 test_expect_success 'pre-rebase hook gets correct input (1)' '
@@ -102,12 +99,9 @@ test_expect_success 'pre-rebase hook gets correct input (6)' '
 '
 
 test_expect_success 'setup pre-rebase hook that fails' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
+	test_hook --setup --clobber pre-rebase <<-\EOF
 	false
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 
 test_expect_success 'pre-rebase hook stops rebase (1)' '
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 6392f71795d..d5771b96114 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -22,42 +22,34 @@ test_expect_success setup '
 	git update-ref refs/heads/main $commit1 &&
 	git update-ref refs/heads/tofail $commit0 &&
 
-	cat >victim.git/hooks/pre-receive <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git pre-receive <<-\EOF &&
 	printf %s "$@" >>$GIT_DIR/pre-receive.args
 	cat - >$GIT_DIR/pre-receive.stdin
 	echo STDOUT pre-receive
 	echo STDERR pre-receive >&2
 	EOF
-	chmod u+x victim.git/hooks/pre-receive &&
 
-	cat >victim.git/hooks/update <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git update <<-\EOF &&
 	echo "$@" >>$GIT_DIR/update.args
 	read x; printf %s "$x" >$GIT_DIR/update.stdin
 	echo STDOUT update $1
 	echo STDERR update $1 >&2
 	test "$1" = refs/heads/main || exit
 	EOF
-	chmod u+x victim.git/hooks/update &&
 
-	cat >victim.git/hooks/post-receive <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git post-receive <<-\EOF &&
 	printf %s "$@" >>$GIT_DIR/post-receive.args
 	cat - >$GIT_DIR/post-receive.stdin
 	echo STDOUT post-receive
 	echo STDERR post-receive >&2
 	EOF
-	chmod u+x victim.git/hooks/post-receive &&
 
-	cat >victim.git/hooks/post-update <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git post-update <<-\EOF
 	echo "$@" >>$GIT_DIR/post-update.args
 	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
 	echo STDOUT post-update
 	echo STDERR post-update >&2
 	EOF
-	chmod u+x victim.git/hooks/post-update
 '
 
 test_expect_success push '
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 3e5e19c7191..915af2de95e 100755
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
+	echo $@ >>$GIT_DIR/post-merge.args
+	EOF
+
+	test_hook --setup -C clone1 post-merge <hook &&
+	test_hook --setup -C clone2 post-merge <hook
+'
 
 test_expect_success 'post-merge does not run for up-to-date ' '
 	GIT_DIR=clone1/.git git merge $commit0 &&
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 64f40ff7776..5f3ff051ca2 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -19,12 +19,10 @@ test_expect_success 'setup' '
 	test_commit F foo F &&
 	git checkout main &&
 
-	cat >.git/hooks/post-rewrite <<-EOF &&
-	#!/bin/sh
+	test_hook --setup post-rewrite <<-EOF
 	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
 	cat > "$TRASH_DIRECTORY"/post-rewrite.data
 	EOF
-	chmod u+x .git/hooks/post-rewrite
 '
 
 clear_hook_input () {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b689baf01a9..4dfb080433e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -55,35 +55,24 @@ mk_test () {
 mk_test_with_hooks() {
 	repo_name=$1
 	mk_test "$@" &&
-
-	cat >"$repo_name"/.git/hooks/pre-receive <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" pre-receive <<-'EOF' &&
 	cat - >>pre-receive.actual
 	EOF
 
-	cat >"$repo_name"/.git/hooks/update <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" update <<-'EOF' &&
 	printf "%s %s %s\n" "$@" >>update.actual
 	EOF
 
-	cat >"$repo_name"/.git/hooks/post-receive <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" post-receive <<-'EOF' &&
 	cat - >>post-receive.actual
 	EOF
 
-	cat >"$repo_name"/.git/hooks/post-update <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" post-update <<-'EOF'
 	for ref in "$@"
 	do
 		printf "%s\n" "$ref" >>post-update.actual
 	done
 	EOF
-
-	chmod +x \
-	      "$repo_name"/.git/hooks/pre-receive \
-	      "$repo_name"/.git/hooks/update \
-	      "$repo_name"/.git/hooks/post-receive \
-	      "$repo_name"/.git/hooks/post-update
 }
 
 mk_child() {
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 0043b718f08..ab4b5cfcd11 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -97,11 +97,9 @@ test_expect_success 'create and delete remote branch' '
 '
 
 test_expect_success 'setup rejected update hook' '
-	cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-EOF &&
-	#!/bin/sh
+	test_hook --setup -C "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" update <<-\EOF &&
 	exit 1
 	EOF
-	chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" &&
 
 	cat >exp <<-EOF
 	remote: error: hook declined to update refs/heads/dev2
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 83c24fc97a7..4a61f2c901e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -79,12 +79,10 @@ test_expect_success 'clone from hooks' '
 	cd .. &&
 	git init r1 &&
 	cd r1 &&
-	cat >.git/hooks/pre-commit <<-\EOF &&
-	#!/bin/sh
+	test_hook pre-commit <<-\EOF &&
 	git clone ../r0 ../r2
 	exit 1
 	EOF
-	chmod u+x .git/hooks/pre-commit &&
 	: >file &&
 	git add file &&
 	test_must_fail git commit -m invoke-hook &&
-- 
2.35.1.1242.gfeba0eae32b

