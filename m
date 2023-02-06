Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BDC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBFWo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBFWos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:44:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16669302A0
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:44:47 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so10130591wms.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndc7gU7r9F7uPIbwc+0pB+nRAnJCu1gz5sdRLD/LQBw=;
        b=nxz1DZte9pO/7s1TNves2Q8OLUOzlVA+KcsWfnesKj0UBY11KLvPPwAJLUHSUAEhGS
         BgyusAIs+azXUwI8i7DvjVX4/Z8Tm1Q3bKO1ayZCScT7hb+4sfZ0FyKKy36IW1roQZCR
         rpFCQk5O5KKLe6S+MWJuFTLse1FiAOs2abLD9sJpvza4Owc3phiWCGdO0l55SMGP5feL
         yCOQ2LR1G79f8hu4NsUkCRxAdqjingWuwiHcmRT4fHBXF+BVZiUNzmv83zy04vpxdi2z
         QcF6Enmg3G5V2SDbXTcMeWau63TUiQPQMyqFlEFrEltfOFjPNcS5EazruyORaot834OW
         ZoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndc7gU7r9F7uPIbwc+0pB+nRAnJCu1gz5sdRLD/LQBw=;
        b=tSsf6E+bwOG/v//lL82nwFTfvT8n7X56d+zc5EAhZBuLoBA7lPcRdi1gdyYaqmNp45
         MPvEqb5jVX0dQ8ntAJ5FrsihYd4TIn8h8uEdBlt5BdV9C+s/KP81aj5UhWlFc3U6wi1c
         LRf5Kk5agY37MO5VHVRDVzOduBPOVxOwJv2N83FPC/HLahucnQO2QOn0llp/nBIvgg2b
         Dg+CSJn/QPj+cg78R0lB4pD+SqboCo/60WkgSlBgyjta8+b/B617GMU/9MBvISCtgeK2
         Pj6r/okziL2s7rHO5866BmxTdUpIgpDmGsv7/3/H/qEI6cLDF4Le6ENxuRRYGKeviDdJ
         wTnA==
X-Gm-Message-State: AO0yUKVjavSRbbMEcHdJj81UdSuVH3W+hKP6d49DX/PtP8GKV6ZyrR28
        ERNZMMVu3XabU8s4g7wyMsQAgtWVbYV7+cc+
X-Google-Smtp-Source: AK7set9/49yvd+zrNoHQyqJ0ZmIIMvf6dNoYYyG2lqBhydJZ9WSAIbr5eItouoln8ALZomgqRcm5Lg==
X-Received: by 2002:a05:600c:1716:b0:3df:f7cc:4da2 with SMTP id c22-20020a05600c171600b003dff7cc4da2mr1167759wmn.16.1675723485334;
        Mon, 06 Feb 2023 14:44:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm6657643wrx.48.2023.02.06.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:44:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/6] tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
Date:   Mon,  6 Feb 2023 23:44:30 +0100
Message-Id: <patch-v5-3.6-d8f4c4a6d9e-20230206T224200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
References: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite tests that ran "git" inside command substitution and lost the
exit status of "git" so that we notice the failing "git".

Have them use modern patterns such as a "test_cmp" of the expected
outputs instead.

We'll fix more of these these in the subsequent commit, for now we're
only converting the cases where this loss of exit code was combined
with spawning a sub-shell.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-httpd.sh              |  8 ++++++--
 t/lib-submodule-update.sh   | 22 +++++++++-------------
 t/t0060-path-utils.sh       |  5 ++++-
 t/t3200-branch.sh           |  8 ++++++--
 t/t5605-clone-local.sh      | 12 +++++++++---
 t/t7402-submodule-rebase.sh | 14 +++++++++++---
 6 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 608949ea80b..b8b1d044e8b 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -217,8 +217,12 @@ test_http_push_nonff () {
 		git commit -a -m path2 --amend &&
 
 		test_must_fail git push -v origin >output 2>&1 &&
-		(cd "$REMOTE_REPO" &&
-		 test $HEAD = $(git rev-parse --verify HEAD))
+		(
+			cd "$REMOTE_REPO" &&
+			echo "$HEAD" >expect &&
+			git rev-parse --verify HEAD >actual &&
+			test_cmp expect actual
+		)
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
index 68e29c904a6..dcc78fb6a7b 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -255,7 +255,10 @@ test_expect_success 'prefix_path rejects absolute path to dir with same beginnin
 test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
 	git init repo &&
 	ln -s repo repolink &&
-	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
+	echo "a" >expect &&
+	repo_path="$(cd repo && pwd)" &&
+	test-tool -C repo path-utils prefix_path prefix "$repo_path/../repolink/a" >actual &&
+	test_cmp expect actual
 '
 
 relative_path /foo/a/b/c/	/foo/a/b/	c/
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6a..5a8a48287c1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -245,9 +245,13 @@ test_expect_success 'git branch -M baz bam should succeed within a worktree in w
 	(
 		cd bazdir &&
 		git branch -M baz bam &&
-		test $(git rev-parse --abbrev-ref HEAD) = bam
+		echo bam >expect &&
+		git rev-parse --abbrev-ref HEAD >actual &&
+		test_cmp expect actual
 	) &&
-	test $(git rev-parse --abbrev-ref HEAD) = bam &&
+	echo bam >expect &&
+	git rev-parse --abbrev-ref HEAD >actual &&
+	test_cmp expect actual &&
 	rm -r bazdir &&
 	git worktree prune
 '
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 38b850c10ef..1d7b1abda1a 100755
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
@@ -29,7 +33,9 @@ test_expect_success 'preparing origin repository' '
 test_expect_success 'local clone without .git suffix' '
 	git clone -l -s a b &&
 	(cd b &&
-	test "$(git config --bool core.bare)" = false &&
+	echo false >expect &&
+	git config --bool core.bare >actual &&
+	test_cmp expect actual &&
 	git fetch)
 '
 
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
2.39.1.1425.gac85d95d48c

