Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18409C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiLBLyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiLBLxn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD0DA20B
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so11002178ejc.4
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi8iuuk0rywVWdRT179rkZRZo0tAqZnale+pE20tPNc=;
        b=m17v5xoCOCXC69RD/sK8c2to5aQ8gbaPFB3LULEGjjvIRIg+v568WUZJaI6FQZxMyX
         yuN+6+eM8fnIU8ApdRV8WScFRvCb4KTpZC7E5v5KGizXqhomsSiq0qy/iD2oHygCJI4v
         WUay13oQAXnlxaQ3n3ime7I30HNKLQmUDDbYsDQVKikS03eIbxn86dc4Y9g8Yy5xLsb3
         LaXn8krvJZ52bV8usXMkPPSOVAvpdg5TixvOerjHxJPVcEZk2CD0obfZtRJvvw/oJUWf
         57YPcBtjd7540KxgrNP9+gFLU5GSxfSsH+s34iaHbFhtuBLPPtSot7hydvxaKiIFg3jl
         x+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi8iuuk0rywVWdRT179rkZRZo0tAqZnale+pE20tPNc=;
        b=TboVV9P/lvYGjW8uSJhCMo6+jYc+Lc2QCRFFrg7Qf+OICDaoAO1pqKSFWlmQamDSoU
         GzPDdpH6oEXbXBMpivObwX+erevdTZypWg8VsR6E69w/+16ChFxp7urJB9d7WI2tN9er
         L6eCj3acIjqy8JjYN1Mr5TFWsZx+i1dLemp7cgHLZQV78V/bRDeCdtgaLTO5Nvek3XkH
         bp5eFTX6lF2cswliXqJC/g9B6aWOQNpH/kq1/vaLuxyXH/OsI+1PzDxINOH7dAkpKZnn
         JpUCp99dCS0ighpPj8NOzBKuiJnvjCeN28HO6rlWeFqA6D6Nw3/XC3J6ycAma1woLMxd
         3fKg==
X-Gm-Message-State: ANoB5pk0P8mJFZkg8f8dhgcGwKWLxA2I/2UeKh2bt0Y7SC8g83uYtkzm
        tNU1816o2Vt7NXl7CP2eS0CCCXh9dIdEDQ==
X-Google-Smtp-Source: AA0mqf5nLf2qvw+lA1Ht9XTFHsVrbp9H3vbJuyMxKt+2ZT6E00IG7I4guP8nRQJ21QA+Zx5ISIHYQA==
X-Received: by 2002:a17:906:f2cb:b0:78d:e645:9f7d with SMTP id gz11-20020a170906f2cb00b0078de6459f7dmr12854213ejb.572.1669981990049;
        Fri, 02 Dec 2022 03:53:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/8] tests: use "test_cmp" instead of "test" in sub-shells
Date:   Fri,  2 Dec 2022 12:52:38 +0100
Message-Id: <patch-v3-5.8-58ac6fe5604-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert a few cases where we were using "test" inside a sub-shell, and
were losing the exit code of "git".

In the case of "t3200-branch.sh" some adjacent code outside of a
sub-shell that was losing the exit code is also being converted, as
it's within the same hunk.

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
2.39.0.rc1.981.gf846af54b4b

