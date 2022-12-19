Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7775C4167B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiLSKTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiLSKTj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:19:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC38B7E0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h7so8116030wrs.6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUrYoS0wOB/V2BpCrffVbI6jLKNh9rYPyZtgXkmnSM4=;
        b=EzysXQ3cbwvcvHEJpJpP7o2SwkL6ADRshm+1at9c5urFMyufercjI/+1xjjIs9Ekmr
         +Te2Ae3Lq5W+OP5/rsPlT9jMT63CAw09MKB6rsqLwQ1hbMu4gCzAIwm6hxUoA4rNdUTG
         eZO7iG2pHPLVeuqOBQEOofPt4dO+iVOI9d/BN/TQa8HjmnYeUyX8qewV1gLtS3BOCnc2
         rbV5NbpmvcEzgAwF/go5hMom5ruZ711ja2ULUhY33Xx9wLjoly8P+altjoxei9HJVJxT
         6DtueeTzdRVsaRaCnTUW0s4HASSIV0DuCTIITB16swQwOMrxWds8CbJZYvDyOhPz8U1c
         YKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUrYoS0wOB/V2BpCrffVbI6jLKNh9rYPyZtgXkmnSM4=;
        b=VUA+q76xDZvqLoB3kmyv0dOE4TB245zcHGUBR6aSbeiF9ChRgF4mdU3DyEbBytZc3/
         glnsHsrOo3d3IbI6PjxwvnDlo/MTeCu6OTAHP9Rv0VnV9iu83+kPDICdhecd5yKkjgdJ
         rgRaqwLxgMzWYysY9+5ATqkl3F3SwW7chgQczyJRPH1CIKW8THELYdL52ChV94uJt5dS
         qEy0SaWjI7L7pM1h0q+kmnLBKihY4w0KUCEOGLANzAYlMf5i3Lcl1K2dA7u+0SJOMXQm
         fWN1AAUmSPMqCrrzOvv0EMtRMyFORnl8/ikkm+A22hGIAACoVe61IA4xnKiHDDZEjd+O
         y7Sg==
X-Gm-Message-State: ANoB5pnzYaZacGJyBNYyU8ok35c3KwWPAFxaVfRM7uAEn55huf+wp7ye
        IyJO27RngzGZo3FHZSLCbViq2zoiarLbow==
X-Google-Smtp-Source: AA0mqf5DhVfRxZFT35t/l1VuFIAEU+qOaPLLEQPcS6fNG6VMAYloTlM4klu98Eul4Ij4bfkqEEDXCQ==
X-Received: by 2002:a5d:678d:0:b0:242:241c:1f97 with SMTP id v13-20020a5d678d000000b00242241c1f97mr25818819wru.52.1671445176665;
        Mon, 19 Dec 2022 02:19:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bx25-20020a5d5b19000000b00225307f43fbsm9632672wrb.44.2022.12.19.02.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:19:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/6] tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
Date:   Mon, 19 Dec 2022 11:19:26 +0100
Message-Id: <patch-v4-3.6-f5b2489609c-20221219T101240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite tests that ran "git" inside command substitution and lost the
exit status of "git" so that we notice the failing "git".

Have them use modern patterns such as a "test_cmp" of the expected
outputs instead, and avoid needlessly spawning sub-shell in favor of
using "git -C <dir>".

We'll fix more of these these in the subsequent commit, for now we're
only converting the cases where this loss of exit code was combined
with spawning a sub-shell. The one exception to that is the casein
"t3200-branch.sh" where adjacent code didn't use a sub-shell, let's
convert that here as it's within the same hunk.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-httpd.sh              |  5 +++--
 t/lib-submodule-update.sh   | 22 +++++++++-------------
 t/t0060-path-utils.sh       |  4 +++-
 t/t3200-branch.sh           | 13 +++++++------
 t/t5605-clone-local.sh      | 15 ++++++++++-----
 t/t7402-submodule-rebase.sh | 14 +++++++++++---
 6 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 608949ea80b..31e7fa3010c 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -217,8 +217,9 @@ test_http_push_nonff () {
 		git commit -a -m path2 --amend &&
 
 		test_must_fail git push -v origin >output 2>&1 &&
-		(cd "$REMOTE_REPO" &&
-		 test $HEAD = $(git rev-parse --verify HEAD))
+		echo "$HEAD" >expect &&
+		git -C "$REMOTE_REPO" rev-parse --verify HEAD >actual &&
+		test_cmp expect actual
 	'
 
 	test_expect_success 'non-fast-forward push show ref status' '
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 2d31fcfda1f..d7c2b670b4a 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -168,20 +168,16 @@ replace_gitfile_with_git_dir () {
 # Note that this only supports submodules at the root level of the
 # superproject, with the default name, i.e. same as its path.
 test_git_directory_is_unchanged () {
-	(
-		cd ".git/modules/$1" &&
-		# does core.worktree point at the right place?
-		test "$(git config core.worktree)" = "../../../$1" &&
-		# remove it temporarily before comparing, as
-		# "$1/.git/config" lacks it...
-		git config --unset core.worktree
-	) &&
+	# does core.worktree point at the right place?
+	echo "../../../$1" >expect &&
+	git -C ".git/modules/$1" config core.worktree >actual &&
+	test_cmp expect actual &&
+	# remove it temporarily before comparing, as
+	# "$1/.git/config" lacks it...
+	git -C ".git/modules/$1" config --unset core.worktree &&
 	diff -r ".git/modules/$1" "$1/.git" &&
-	(
-		# ... and then restore.
-		cd ".git/modules/$1" &&
-		git config core.worktree "../../../$1"
-	)
+	# ... and then restore.
+	git -C ".git/modules/$1" config core.worktree "../../../$1"
 }
 
 test_git_directory_exists () {
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 68e29c904a6..53ec717cbca 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -255,7 +255,9 @@ test_expect_success 'prefix_path rejects absolute path to dir with same beginnin
 test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
 	git init repo &&
 	ln -s repo repolink &&
-	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
+	echo "a" >expect &&
+	test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a" >actual &&
+	test_cmp expect actual
 '
 
 relative_path /foo/a/b/c/	/foo/a/b/	c/
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6a..f5fbb84262b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -242,12 +242,13 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 test_expect_success 'git branch -M baz bam should succeed within a worktree in which baz is checked out' '
 	git checkout -b baz &&
 	git worktree add -f bazdir baz &&
-	(
-		cd bazdir &&
-		git branch -M baz bam &&
-		test $(git rev-parse --abbrev-ref HEAD) = bam
-	) &&
-	test $(git rev-parse --abbrev-ref HEAD) = bam &&
+	git -C "$bazdir" branch -M baz bam &&
+	echo "bam" >expect &&
+	git -C "$bazdir" rev-parse --abbrev-ref HEAD >actual &&
+	test_cmp expect actual &&
+	echo "bam" >expect &&
+	git rev-parse --abbrev-ref HEAD >actual &&
+	test_cmp expect actual &&
 	rm -r bazdir &&
 	git worktree prune
 '
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 38b850c10ef..61a2342bc2c 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -15,8 +15,12 @@ test_expect_success 'preparing origin repository' '
 	: >file && git add . && git commit -m1 &&
 	git clone --bare . a.git &&
 	git clone --bare . x &&
-	test "$(cd a.git && git config --bool core.bare)" = true &&
-	test "$(cd x && git config --bool core.bare)" = true &&
+	echo true >expect &&
+	git -C a.git config --bool core.bare >actual &&
+	test_cmp expect actual &&
+	echo true >expect &&
+	git -C x config --bool core.bare >actual &&
+	test_cmp expect actual &&
 	git bundle create b1.bundle --all &&
 	git bundle create b2.bundle main &&
 	mkdir dir &&
@@ -28,9 +32,10 @@ test_expect_success 'preparing origin repository' '
 
 test_expect_success 'local clone without .git suffix' '
 	git clone -l -s a b &&
-	(cd b &&
-	test "$(git config --bool core.bare)" = false &&
-	git fetch)
+	echo false >expect &&
+	git -C b config --bool core.bare >actual &&
+	test_cmp expect actual &&
+	git -C b fetch
 '
 
 test_expect_success 'local clone with .git suffix' '
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index ebeca12a711..1927a862839 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -82,11 +82,19 @@ test_expect_success 'stash with a dirty submodule' '
 	CURRENT=$(cd submodule && git rev-parse HEAD) &&
 	git stash &&
 	test new != $(cat file) &&
-	test submodule = $(git diff --name-only) &&
-	test $CURRENT = $(cd submodule && git rev-parse HEAD) &&
+	echo submodule >expect &&
+	git diff --name-only >actual &&
+	test_cmp expect actual &&
+
+	echo "$CURRENT" >expect &&
+	git -C submodule rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+
 	git stash apply &&
 	test new = $(cat file) &&
-	test $CURRENT = $(cd submodule && git rev-parse HEAD)
+	echo "$CURRENT" >expect &&
+	git -C submodule rev-parse HEAD >actual &&
+	test_cmp expect actual
 
 '
 
-- 
2.39.0.1071.g97ce8966538

