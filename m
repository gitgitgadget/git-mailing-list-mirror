Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25349C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiLBAHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiLBAH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA0CAFA8
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fy37so7978618ejc.11
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+QvEsVnJmW8QE43e1iISyaVNyquKvjsIJPBChtGd54=;
        b=fVwvU+qyOKKtxoszLGeobZQHIzb0u7luTGH35ZW3k4IdTamkNiGxS1n9qJLDZ21YXK
         QzQIbqYfk1MgKDRcCWEIiayNoFtIKvQ3m6rn3hOnA/DsDCht1EUVf/HrRS3HTQ12pARe
         fOdRnO9zS1Y/Wg+LnzmV6P/zLkeU0BaCC/u5enJHlz0owcY8STN2YWwlGX2mOi0JgP23
         sMu6Mj5b6g3BiCSCDEE5Sy7GYTxxp6Yqqky30DILIyC0HfJdRSFueF5HQVUsRp+RY2AV
         pZQZUKmCKpS+ALteMpDrwrsGk/bsTYqgZFPNtFJYJKAhRGEfqkX9B20cg+dNM6IKMfsM
         kNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+QvEsVnJmW8QE43e1iISyaVNyquKvjsIJPBChtGd54=;
        b=p6yXNo16NaMoSC0jjEFkm5CeNVPh7KNCjZQjyqM9BnJiQOcm2YjV1L3JoIjTe28pkM
         qs4CyC5CXVUhx78bvJFpqzzu4aLqSr3j8TABuqekeQH/TUwoWk6t1aD4Dnq9qvfMm8Yt
         uwX02ogY8FbyiG/si10gY+U2bL5GCz2ag4/f/uGvVZa7ukJ5yM06/S/I5WMd63QY+wvz
         961NtPIYV0vogNJS/Aor3bxVzx2T+m4IYcyWU69SjmhNr17F9oa7tKlKr3VhSFxBle05
         KSyXv/f2/w39k7PzLH0Z28UEWOt8Ps1GRmIQLC2zSOMGAD41wDPc2Dl/Eyyhz+Fiapvb
         X+Rg==
X-Gm-Message-State: ANoB5plDeouz78b4+rM1H/DqmCNBT5uWy/5soZyluUHr3mBqP2UoQHAn
        sKUPssGRgJLkLNc0kVWpc73fvFLPWglADA==
X-Google-Smtp-Source: AA0mqf4W3Pn2wMF4Jq2+OQEQRVv1csbDAyscx3YHkNjUKJ3CW1il6bNkyq1myKP10n8F5uAuKTFvLA==
X-Received: by 2002:a17:906:68a:b0:78d:3188:9116 with SMTP id u10-20020a170906068a00b0078d31889116mr58878673ejb.176.1669939645039;
        Thu, 01 Dec 2022 16:07:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] tests: use "test_cmp_cmd" instead of "test" in sub-shells
Date:   Fri,  2 Dec 2022 01:06:33 +0100
Message-Id: <patch-v2-7.8-d090478aa84-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
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
 t/lib-httpd.sh              |  3 +--
 t/lib-submodule-update.sh   | 20 +++++++-------------
 t/t3200-branch.sh           |  9 +++------
 t/t5605-clone-local.sh      |  9 ++++-----
 t/t7402-submodule-rebase.sh |  6 +++---
 5 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 608949ea80b..082496d6535 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -217,8 +217,7 @@ test_http_push_nonff () {
 		git commit -a -m path2 --amend &&
 
 		test_must_fail git push -v origin >output 2>&1 &&
-		(cd "$REMOTE_REPO" &&
-		 test $HEAD = $(git rev-parse --verify HEAD))
+		test_cmp_cmd "$HEAD" git -C "$REMOTE_REPO" rev-parse --verify HEAD
 	'
 
 	test_expect_success 'non-fast-forward push show ref status' '
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index d5d98714b4e..207fab77bd3 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -168,20 +168,14 @@ replace_gitfile_with_git_dir () {
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
+	test_cmp_cmd "../../../$1" git -C ".git/modules/$1" config core.worktree
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
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6a..c31036b49be 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -242,12 +242,9 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
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
+	test_cmp_cmd "bam" git -C "$bazdir" rev-parse --abbrev-ref HEAD &&
+	test_cmp_cmd "bam" git rev-parse --abbrev-ref HEAD &&
 	rm -r bazdir &&
 	git worktree prune
 '
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 38b850c10ef..55bda2c0aa9 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -15,8 +15,8 @@ test_expect_success 'preparing origin repository' '
 	: >file && git add . && git commit -m1 &&
 	git clone --bare . a.git &&
 	git clone --bare . x &&
-	test "$(cd a.git && git config --bool core.bare)" = true &&
-	test "$(cd x && git config --bool core.bare)" = true &&
+	test_cmp_cmd true git -C a.git config --bool core.bare &&
+	test_cmp_cmd true git -C x config --bool core.bare &&
 	git bundle create b1.bundle --all &&
 	git bundle create b2.bundle main &&
 	mkdir dir &&
@@ -28,9 +28,8 @@ test_expect_success 'preparing origin repository' '
 
 test_expect_success 'local clone without .git suffix' '
 	git clone -l -s a b &&
-	(cd b &&
-	test "$(git config --bool core.bare)" = false &&
-	git fetch)
+	test_cmp_cmd false git -C b config --bool core.bare &&
+	git -C b fetch
 '
 
 test_expect_success 'local clone with .git suffix' '
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index ebeca12a711..277bb8ae520 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -82,11 +82,11 @@ test_expect_success 'stash with a dirty submodule' '
 	CURRENT=$(cd submodule && git rev-parse HEAD) &&
 	git stash &&
 	test new != $(cat file) &&
-	test submodule = $(git diff --name-only) &&
-	test $CURRENT = $(cd submodule && git rev-parse HEAD) &&
+	test_cmp_cmd submodule git diff --name-only &&
+	test_cmp_cmd "$CURRENT" git -C submodule rev-parse HEAD &&
 	git stash apply &&
 	test new = $(cat file) &&
-	test $CURRENT = $(cd submodule && git rev-parse HEAD)
+	test_cmp_cmd "$CURRENT" git -C submodule rev-parse HEAD
 
 '
 
-- 
2.39.0.rc1.980.g92d3d4579ad

