Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A34C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiLBAHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiLBAHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF006C5E16
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id td2so8030167ejc.5
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfakrQ20rATcL/ko51eRpDGYAdUQ6CF6XlPz3JlM53U=;
        b=e5jvPuiU3zHVm1zgvpprP/cg2i6gqwIW7n061sXAXoIs/3nmfHcJ+67LyJ0JcBsQqc
         1pBh2aJgU3LpDwnBeiPYqvtM3ORTRunX5q82YWehbibzSOxdRRCxVaZ7NbMyB4QJX6z4
         KBBIsqhlzKJ9lysPwp1cPHUe7JegmtnDBESBhUkAW+rLg7HIwC/UPQBSTxvMYCoQtQ2E
         cREcSmRKZ+tPwVSyBeuasyRwAfiyHRp2rlkegj0vTxHcNR1+7H42KE/l1koI8mm2vOKZ
         pAPYEzCIiV+RuWirQOcF7+Wgv46O+VJ5zi0tk+CEhiny1snES4Zf7FI9q9MDiVAASonE
         tRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfakrQ20rATcL/ko51eRpDGYAdUQ6CF6XlPz3JlM53U=;
        b=fh0gP13Lt6JGdQIWWADWbb+5DtRI3aept/4KSfg9tBcip+N2SGCkXu4Cb0QFsS/7fU
         tnqIKF8jAmDetJTNtK+z+prqEmep0nAOIgAf/ejWQ3SUWtjHV0C1Pjlq9bYcZuluh4Dh
         kFuGMvsuijgZpq45FJdRnHKA3TrIL0bCj2G2bBWNJ1mVDiojV11/a7oYSX4xRC2b48Zk
         XitzDhz1odMyhhoyYQdCwZsvzecXeBeIb1Ih+vP0M1mLVXE6mfL3TpaIXYI9mWPfIkv4
         X9DL+d8TCW3lYNjxp1MbgDtZSQ+rdgt2QSZBViMiaQTqiRRzC+FqRp6r+0xJ0jafBUCI
         jyZA==
X-Gm-Message-State: ANoB5pkDuEV1IZ/fsuOVoYg7np/PvwG7edqXwSnsoiw42Yssvjj92rEN
        r801NndhTxfn/ddm6bot6N7OirarPHtcPA==
X-Google-Smtp-Source: AA0mqf4WOKbXunOcrkbo46fnZZbTA51I29pkYJbKdTmnzh95tKAZ31pvLSjb9lj6hbH44+aIezmMYQ==
X-Received: by 2002:a17:906:794b:b0:7bb:a098:988c with SMTP id l11-20020a170906794b00b007bba098988cmr32679516ejo.11.1669939642053;
        Thu, 01 Dec 2022 16:07:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] test-lib-functions: add and use test_cmp_cmd
Date:   Fri,  2 Dec 2022 01:06:30 +0100
Message-Id: <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "test_cmp_cmd" helper for the common pattern discussed in the
documentation being added here to "t/test-lib-functions.sh".

This implementation leaves the door open for extending this helper
past its obvious limitations, such as:

	test_cmp_cmd "some" "lines" -- <some-cmd>
	test_cmp_cmd --stdin <some-cmd> <expect
	test_cmp_cmd --ignore-stderr "output" <some-cmd>

By using this in we'll catch cases where "git" or "test-tool"
errors (such as segfaults or abort()) were previously hidden, and we'd
either pass the test, or fail in some subsequent assertion.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh |  2 +-
 t/t0001-init.sh           |  4 +--
 t/t0002-gitfile.sh        |  2 +-
 t/t0060-path-utils.sh     | 57 ++++++++++++++++++++-------------------
 t/t0100-previous.sh       |  4 +--
 t/t1504-ceiling-dirs.sh   |  6 +++--
 t/test-lib-functions.sh   | 18 +++++++++++++
 7 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 2d31fcfda1f..d5d98714b4e 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -189,7 +189,7 @@ test_git_directory_exists () {
 	if test -f sub1/.git
 	then
 		# does core.worktree point at the right place?
-		test "$(git -C .git/modules/$1 config core.worktree)" = "../../../$1"
+		test_cmp_cmd "../../../$1" git -C ".git/modules/$1" config core.worktree
 	fi
 }
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d479303efa0..a3b902bcd8f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -598,9 +598,9 @@ test_expect_success 'invalid default branch name' '
 test_expect_success 'branch -m with the initial branch' '
 	git init rename-initial &&
 	git -C rename-initial branch -m renamed &&
-	test renamed = $(git -C rename-initial symbolic-ref --short HEAD) &&
+	test_cmp_cmd renamed git -C rename-initial symbolic-ref --short HEAD &&
 	git -C rename-initial branch -m renamed again &&
-	test again = $(git -C rename-initial symbolic-ref --short HEAD)
+	test_cmp_cmd again git -C rename-initial symbolic-ref --short HEAD
 '
 
 test_done
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 26eaca095a2..aca847512c4 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -33,7 +33,7 @@ test_expect_success 'bad setup: invalid .git file path' '
 
 test_expect_success 'final setup + check rev-parse --git-dir' '
 	echo "gitdir: $REAL" >.git &&
-	test "$REAL" = "$(git rev-parse --git-dir)"
+	test_cmp_cmd "$REAL" git rev-parse --git-dir
 '
 
 test_expect_success 'check hash-object' '
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 68e29c904a6..c90d2e4d2b1 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -10,20 +10,21 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 norm_path() {
 	expected=$(test-tool path-utils print_path "$2")
-	test_expect_success $3 "normalize path: $1 => $2" \
-	"test \"\$(test-tool path-utils normalize_path_copy '$1')\" = '$expected'"
+	test_expect_success $3 "normalize path: $1 => $2" "
+		test_cmp_cmd '$expected' test-tool path-utils normalize_path_copy '$1'
+	"
 }
 
 relative_path() {
 	expected=$(test-tool path-utils print_path "$3")
-	test_expect_success $4 "relative path: $1 $2 => $3" \
-	"test \"\$(test-tool path-utils relative_path '$1' '$2')\" = '$expected'"
+	test_expect_success $4 "relative path: $1 $2 => $3" "
+		test_cmp_cmd '$expected' test-tool path-utils relative_path '$1' '$2'
+	"
 }
 
 test_submodule_relative_url() {
 	test_expect_success "test_submodule_relative_url: $1 $2 $3 => $4" "
-		actual=\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &&
-		test \"\$actual\" = '$4'
+		test_cmp_cmd '$4' test-tool submodule resolve-relative-url '$1' '$2' '$3'
 	"
 }
 
@@ -64,9 +65,9 @@ ancestor() {
 		expected=$(($expected-$rootslash+$rootoff))
 		;;
 	esac
-	test_expect_success $4 "longest ancestor: $1 $2 => $expected" \
-	"actual=\$(test-tool path-utils longest_ancestor_length '$1' '$2') &&
-	 test \"\$actual\" = '$expected'"
+	test_expect_success $4 "longest ancestor: $1 $2 => $expected" "
+		test_cmp_cmd '$expected' test-tool path-utils longest_ancestor_length '$1' '$2'
+	"
 }
 
 # Some absolute path tests should be skipped on Windows due to path mangling
@@ -166,8 +167,10 @@ ancestor D:/Users/me C:/ -1 MINGW
 ancestor //server/share/my-directory //server/share/ 14 MINGW
 
 test_expect_success 'strip_path_suffix' '
-	test c:/msysgit = $(test-tool path-utils strip_path_suffix \
-		c:/msysgit/libexec//git-core libexec/git-core)
+	echo c:/msysgit >expect &&
+	test-tool path-utils strip_path_suffix \
+		c:/msysgit/libexec//git-core libexec/git-core >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'absolute path rejects the empty string' '
@@ -189,34 +192,34 @@ test_expect_success 'real path rejects the empty string' '
 
 test_expect_success POSIX 'real path works on absolute paths 1' '
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-tool path-utils real_path "/")" &&
-	test "/$nopath" = "$(test-tool path-utils real_path "/$nopath")"
+	test_cmp_cmd / test-tool path-utils real_path "/" &&
+	test_cmp_cmd "/$nopath" test-tool path-utils real_path "/$nopath"
 '
 
 test_expect_success 'real path works on absolute paths 2' '
 	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "$d")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "$d/$nopath")"
+	test_cmp_cmd "$d" test-tool path-utils real_path "$d" &&
+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "$d/$nopath"
 '
 
 test_expect_success POSIX 'real path removes extra leading slashes' '
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-tool path-utils real_path "///")" &&
-	test "/$nopath" = "$(test-tool path-utils real_path "///$nopath")" &&
+	test_cmp_cmd "/" test-tool path-utils real_path "///" &&
+	test_cmp_cmd "/$nopath" test-tool path-utils real_path "///$nopath" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "//$d")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "//$d/$nopath")"
+	test_cmp_cmd "$d" test-tool path-utils real_path "//$d" &&
+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "//$d/$nopath"
 '
 
 test_expect_success 'real path removes other extra slashes' '
 	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "$d///")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "$d///$nopath")"
+	test_cmp_cmd "$d" test-tool path-utils real_path "$d///" &&
+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "$d///$nopath"
 '
 
 test_expect_success SYMLINKS 'real path works on symlinks' '
@@ -227,19 +230,19 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir third &&
 	dir="$(cd .git && pwd -P)" &&
 	dir2=third/../second/other/.git &&
-	test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
+	test_cmp_cmd "$dir" test-tool path-utils real_path $dir2 &&
 	file="$dir"/index &&
-	test "$file" = "$(test-tool path-utils real_path $dir2/index)" &&
+	test_cmp_cmd "$file" test-tool path-utils real_path $dir2/index &&
 	basename=blub &&
-	test "$dir/$basename" = "$(cd .git && test-tool path-utils real_path "$basename")" &&
+	test_cmp_cmd "$dir/$basename" test-tool -C .git path-utils real_path "$basename" &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first && pwd -P)"/file &&
-	test "$sym" = "$(test-tool path-utils real_path "$dir2/syml")"
+	test_cmp_cmd "$sym" test-tool path-utils real_path "$dir2/syml"
 '
 
 test_expect_success SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
 	ln -s target symlink &&
-	test "$(test-tool path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+	test_cmp_cmd "symlink" test-tool path-utils prefix_path prefix "$(pwd)/symlink"
 '
 
 test_expect_success 'prefix_path works with only absolute path to work tree' '
@@ -255,7 +258,7 @@ test_expect_success 'prefix_path rejects absolute path to dir with same beginnin
 test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
 	git init repo &&
 	ln -s repo repolink &&
-	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
+	test_cmp_cmd "a" test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a"
 '
 
 relative_path /foo/a/b/c/	/foo/a/b/	c/
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index a16cc3d2983..e315283cccd 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -12,7 +12,7 @@ test_expect_success 'branch -d @{-1}' '
 	test_commit A &&
 	git checkout -b junk &&
 	git checkout - &&
-	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
+	test_cmp_cmd refs/heads/main git symbolic-ref HEAD &&
 	git branch -d @{-1} &&
 	test_must_fail git rev-parse --verify refs/heads/junk
 '
@@ -21,7 +21,7 @@ test_expect_success 'branch -d @{-12} when there is not enough switches yet' '
 	git reflog expire --expire=now &&
 	git checkout -b junk2 &&
 	git checkout - &&
-	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
+	test_cmp_cmd refs/heads/main git symbolic-ref HEAD &&
 	test_must_fail git branch -d @{-12} &&
 	git rev-parse --verify refs/heads/main
 '
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index 0fafcf9dde3..2c73869235d 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -6,8 +6,10 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_prefix() {
-	test_expect_success "$1" \
-	"test '$2' = \"\$(git rev-parse --show-prefix)\""
+	local expect="$2" &&
+	test_expect_success "$1: git rev-parse --show-prefix is '$2'" '
+		test_cmp_cmd "$expect" git rev-parse --show-prefix
+	'
 }
 
 test_fail() {
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b32..0e8e0f808e3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1274,6 +1274,24 @@ test_cmp_rev () {
 	fi
 }
 
+# test_cmp_cmd is a convenience helper for doing the more verbose:
+#
+#	echo something >expect &&
+#	<some-command-and-args> >actual &&
+#	test_cmp expect actual
+#
+# As:
+#
+#	test_cmp_cmd something <some-command-and-args>
+test_cmp_cmd () {
+	local expect="$1" &&
+	shift &&
+	printf "%s\n" "$expect" >expect &&
+	"$@" >actual 2>err &&
+	test_must_be_empty err
+	test_cmp expect actual
+}
+
 # Compare paths respecting core.ignoreCase
 test_cmp_fspath () {
 	if test "x$1" = "x$2"
-- 
2.39.0.rc1.980.g92d3d4579ad

