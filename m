Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE05AC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbiFCLQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiFCLPi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD953C48A
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so6170597wme.5
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAv6lAg7sKUz+/pFWOIuppgESitv5ZMgum1Z0Fx0E9w=;
        b=ZepS/c23oTZlcKtLIyXvNlQqSDbj7xdLSQE5+zacP3SIUnDO4uECsYEJJmpNH7ATIO
         gBpAdvO1rYd5R/V5FT5HyCGoa6G1QbNOAuKrLXiEvJt8/iOeY+cKmQwjsWpDaPaZ+oY7
         0/H9+qgwvVGJjka+Kp9gW7rXc6ep9fy9Y/CNwHpCc+UBV+2sQcP/9IzJMJh1abNq/ZcR
         +YfwhSJjOVWR9BmnQrhrShhO9ePi7M3+Nw3x4krTKJWB9cORTsZrakWtjSljIJ8/0Fxz
         4t49I6c9xpWWeRiWTBjzpLT+an4WQcwUgjX909k+piBHt/uZG1VClWCtJ4NVfqURMzNn
         uJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAv6lAg7sKUz+/pFWOIuppgESitv5ZMgum1Z0Fx0E9w=;
        b=UgeimIsqrsGJFqlgTu7L1G73wvYVQOgLL5yxqOjypjh15pV7YM+HqJ/LHeoK9BDC2Y
         7jGfcGmpKItTCrKEE+dtUr5ez8j8+qKVbM1+4nl1XfLWgT1KdR4fldngi7qj3kqopk/h
         d97Q0kZHECfa0XHN+EgGDM5s5R/dlAcNpNvez7QLhsWYDfhE371w2wqUlkWFfIL1F/nC
         wXkdUcAxkyiQZosfGXqTGndjilwEYA3XiABbA5dLqnvDa/Q/zH8GdJ3h1zk0+a5zFDUL
         7Sms1svVnFTCmOIuPj4ZvIBbPQyn+P1ti5DbnOwT3qJnrHKRt3bs8HGNeaMUk2SDYA8M
         ZvkQ==
X-Gm-Message-State: AOAM5334J6ELwBh/tGXUiwTNOnc53kBV5mwSja1pBGnMfj1Cbnb2W/rb
        pXEpAkyzCFQFkKA0N9mLBG7Ru1JN6I9ADQ==
X-Google-Smtp-Source: ABdhPJzOaoGl8mBvnM5h+Uas5HiKEEoWF0RZCZyxVejwgPvqCCsYDNLiNk/oXM65m6p5NbXq3yhxUg==
X-Received: by 2002:a05:600c:3583:b0:397:3d93:75b8 with SMTP id p3-20020a05600c358300b003973d9375b8mr36279527wmq.76.1654254935362;
        Fri, 03 Jun 2022 04:15:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] tests: don't assume a .git/info for .git/info/exclude
Date:   Fri,  3 Jun 2022 13:15:08 +0200
Message-Id: <patch-v2-6.7-29da5a3d431-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those tests that assumed that a .git/info directory would be
created for them when writing .git/info/exclude to explicitly create
the directory by setting "TEST_CREATE_REPO_NO_TEMPLATE=1" before
sourcing test-lib.sh, and using the "--template=" argument to "git
clone" and "git init".

In the case of ".git/modules/sub1/info" we deviate from the
established pattern in this and preceding commits of passing a
"--template=" and doing a "mkdir .git/info".

In that case "git checkout" will run the "submodule--helper clone",
and both e.g. "git submodule update --init" and "git checkout" do not
have a way to pass down options to the eventual "git init" or "git
clone". Let's instead assume that the submodule was populated with our
default templates, remove them, and then run the "mkdir".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh         | 7 +++++--
 t/t0008-ignores.sh                | 2 ++
 t/t3426-rebase-submodule.sh       | 1 +
 t/t7063-status-untracked-cache.sh | 3 ++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index f7c7df0ca42..03e0abbdb83 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -207,7 +207,7 @@ prolog () {
 # should be updated to an existing commit.
 reset_work_tree_to () {
 	rm -rf submodule_update &&
-	git clone submodule_update_repo submodule_update &&
+	git clone --template= submodule_update_repo submodule_update &&
 	(
 		cd submodule_update &&
 		rm -rf sub1 &&
@@ -902,13 +902,14 @@ test_submodule_switch_recursing_with_args () {
 	'
 	# ... but an ignored file is fine.
 	test_expect_$RESULTOI "$command: added submodule removes an untracked ignored file" '
-		test_when_finished "rm submodule_update/.git/info/exclude" &&
+		test_when_finished "rm -rf submodule_update/.git/info" &&
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			: >sub1 &&
+			mkdir .git/info &&
 			echo sub1 >.git/info/exclude &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
@@ -951,7 +952,9 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
+			rm -rf .git/modules/sub1/info &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			mkdir .git/modules/sub1/info &&
 			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
 			$command replace_sub1_with_file &&
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index c3655a0c53e..c70d11bc914 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -3,6 +3,7 @@
 test_description=check-ignore
 
 TEST_PASSES_SANITIZE_LEAK=true
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 init_vars () {
@@ -225,6 +226,7 @@ test_expect_success 'setup' '
 		!globaltwo
 		globalthree
 	EOF
+	mkdir .git/info &&
 	cat <<-\EOF >.git/info/exclude
 		per-repo
 	EOF
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index 0ad3a07bf47..7a9f1127a4b 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -35,6 +35,7 @@ git_rebase_interactive () {
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
 	set_fake_editor &&
+	mkdir .git/info &&
 	echo "fake-editor.sh" >.git/info/exclude &&
 	may_only_be_test_must_fail "$2" &&
 	$2 git rebase -i "$1"
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 9936cc329ec..f5050b75b29 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -86,7 +86,7 @@ test_expect_success 'core.untrackedCache is unset' '
 '
 
 test_expect_success 'setup' '
-	git init worktree &&
+	git init --template= worktree &&
 	cd worktree &&
 	mkdir done dtwo dthree &&
 	touch one two three done/one dtwo/two dthree/three &&
@@ -94,6 +94,7 @@ test_expect_success 'setup' '
 	test-tool chmtime =-300 done dtwo dthree &&
 	test-tool chmtime =-300 . &&
 	git add one two done/one &&
+	mkdir .git/info &&
 	: >.git/info/exclude &&
 	git update-index --untracked-cache &&
 	test_oid_cache <<-EOF
-- 
2.36.1.1119.g5a713b43bd4

