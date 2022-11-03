Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B1C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiKCQmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiKCQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1371C90A
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i21so3872952edj.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rkn/SwK4td60L0FdqLnG/44Bt/JcBPsan0DHlD3WM2g=;
        b=ZCNWLvStKELL/pVUBp6fGc5BpXX5mz8wLFdEj6oHDtGPW1hzVNSTGNFHIOiyjBjGI3
         +7OY9G+YyamedrUAHkwFge5LAPSIV5LNTRixszqPEqJxtM934WSRrfA3myBZloGJTI0t
         kbWddxKyLkx9o+aTpxnSjbR859noU4dXcaa+LC1/EMICVlPuh9/RxTg6UBRO7OdbM8rM
         FwbohXzxwWTserDKcqPzF2Dj/9Y4FP2RqBV8u1qLkajuHTCXQE8FHChBNm+eX14SlHYR
         rrnD9WIiqIIUaRdVB3gyh9NnDQIJmYoeiH79mqR8BtnAoATw8zWWzrqCQgXp/lJDovcY
         fi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rkn/SwK4td60L0FdqLnG/44Bt/JcBPsan0DHlD3WM2g=;
        b=Z2EdwYGE1HzwLPeslvNdNwfVXg63799jQrwonjqottnzTvksbGh3fWlDhKh611HRFl
         6SLoOOKWc4kLIrFA+P1FaONBDhBIxAyWQ7r7gPEoLOvGXXbEYtJati1u8mEuwi7Rw1fW
         fZFzYvg7K7TNrHi8miCYXPMKo8ptxNgtSg5W0+C88DpJ6+ovP2Kx3FcJzM3Es4fNl3mB
         4bvPCWmhEyJPfKoSGycyo+M/2rQpvujtn3R0y0K3g4CHXE+FNajO7GgzswGTjegc0t7z
         WiLdcOzmAeQWmqh7mqFRsVm4c69+FTcW7zYZKAsXuOLO+HYu7vsIiAWhqFCaAJ6Zmx4/
         iBDQ==
X-Gm-Message-State: ACrzQf2dbFfwbZwOr4b9rdkwLWgLBdDP/p+r4382ycxwmi4YFs9rodVy
        P4bWLqv/2wz6JMGksFdKbmxoa0MJIw7bNA==
X-Google-Smtp-Source: AMsMyM5MCWmjPgmrnCxd00ns3vFCRzePEFabz7TQABkgDJb1kK7vlL4RnNPhevmaVOfOU0dChwqXSQ==
X-Received: by 2002:aa7:cf83:0:b0:463:1b7d:e318 with SMTP id z3-20020aa7cf83000000b004631b7de318mr26331127edx.4.1667493492415;
        Thu, 03 Nov 2022 09:38:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/14] cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
Date:   Thu,  3 Nov 2022 17:37:56 +0100
Message-Id: <patch-v4-06.14-6c254f8cb9f-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git is built and tested with cmake & ctest we usually do that
outside of the top-level source directory. E.g.

	cmake -S contrib/buildsystems -B contrib/buildsystems/out
	make -C contrib/buildsystems/out
	ctest -j$(nproc) --test-dir contrib/buildsystems/out

Since the test-lib.sh makes assumptions about the TEST_DIRECTORY being
the "t" subdirectory of the top-level "$GIT_BUILD_DIR", the cmake
recipe has needed to copy various assets to that
"contrib/buildsystems/out" directory.

But we've only been doing this for the subsets of tests that run on
Windows, and which have otherwise been covered by that CI target. The
CI target builds (among other things) with "-DPERL_TESTS=OFF
-DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON", see [1]. Furthermore, the
CI isn't testing from the "contrib/buildsystems/out" directory,
instead it clobbers the top-level MAkefile.

There was a recent commit to fix a subset of these issues, see
6a83b5f0810 (cmake: copy the merge tools for testing, 2022-10-18).

Let's stop going for that approach, and instead teach the test-lib.sh
that there's such a thing as the "$GIT_SOURCE_DIR" distinct from the
"$GIT_BUILD_DIR".

Just as the "$TEST_DIRECTORY" always points to our actual "t"
directory (not the "[...]/out/t" cmake creates), this new
"$GIT_SOURCE_DIR" will always be the top-level source directory.

With this change we now pass 3/5 of the tests that we still had
failing with the fixes in the preceding commit.

1. 4c2c38e800f (ci: modification of main.yml to use cmake for vs-build
   job, 2020-06-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt |  6 ------
 t/lib-gettext.sh                    |  2 +-
 t/lib-gitweb.sh                     |  2 +-
 t/t7609-mergetool--lib.sh           |  2 +-
 t/t9902-completion.sh               | 14 +++++++-------
 t/t9903-bash-prompt.sh              |  2 +-
 t/test-lib.sh                       |  8 +++++++-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 27c939641e0..812365e1dd8 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1120,12 +1120,6 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	#Setting the build directory in test-lib.sh before running tests
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
 		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
-	#misc copies
-	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
-	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
-	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
-	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
-	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
 endif()
 
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index cc6bb2cdeaa..dcd6e9c3f75 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -7,7 +7,7 @@
 . ./test-lib.sh
 
 GIT_TEXTDOMAINDIR="$GIT_BUILD_DIR/po/build/locale"
-GIT_PO_PATH="$GIT_BUILD_DIR/po"
+GIT_PO_PATH="$GIT_SOURCE_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
 if test -n "$GIT_TEST_INSTALLED"
diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 1f32ca66ea5..6f68df247af 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -49,7 +49,7 @@ EOF
 		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
 		say "# Testing $SCRIPT_NAME"
 	else # normal case, use source version of gitweb
-		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+		SCRIPT_NAME="$GIT_SOURCE_DIR/gitweb/gitweb.perl"
 	fi
 	export SCRIPT_NAME
 }
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
index 8b1c3bd39f2..2090d12a489 100755
--- a/t/t7609-mergetool--lib.sh
+++ b/t/t7609-mergetool--lib.sh
@@ -8,7 +8,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
-	. "$GIT_BUILD_DIR"/mergetools/vimdiff &&
+	. "$GIT_SOURCE_DIR"/mergetools/vimdiff &&
 	run_unit_tests
 '
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43de868b800..1bd4cae92fe 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -33,7 +33,7 @@ complete ()
 GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr rebase ls-files'
 GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash"
 
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
@@ -2567,7 +2567,7 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 	(
 		__git_compute_all_commands &&
 		verbose test -n "$__git_all_commands" &&
-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 		verbose test -z "$__git_all_commands"
 	)
 '
@@ -2576,7 +2576,7 @@ test_expect_success 'sourcing the completion script clears cached merge strategi
 	(
 		__git_compute_merge_strategies &&
 		verbose test -n "$__git_merge_strategies" &&
-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 		verbose test -z "$__git_merge_strategies"
 	)
 '
@@ -2587,7 +2587,7 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 		verbose test -n "$__gitcomp_builtin_checkout" &&
 		__gitcomp_builtin notes_edit &&
 		verbose test -n "$__gitcomp_builtin_notes_edit" &&
-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 		verbose test -z "$__gitcomp_builtin_checkout" &&
 		verbose test -z "$__gitcomp_builtin_notes_edit"
 	)
@@ -2599,7 +2599,7 @@ test_expect_success 'option aliases are not shown by default' '
 
 test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
 	(
-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 		GIT_COMPLETION_SHOW_ALL=1 && export GIT_COMPLETION_SHOW_ALL &&
 		test_completion "git clone --recurs" <<-\EOF
 		--recurse-submodules Z
@@ -2610,7 +2610,7 @@ test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
 
 test_expect_success 'plumbing commands are excluded without GIT_COMPLETION_SHOW_ALL_COMMANDS' '
 	(
-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
 
 		# Just mainporcelain, not plumbing commands
@@ -2622,7 +2622,7 @@ test_expect_success 'plumbing commands are excluded without GIT_COMPLETION_SHOW_
 
 test_expect_success 'all commands are shown with GIT_COMPLETION_SHOW_ALL_COMMANDS (also main non-builtin)' '
 	(
-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 		GIT_COMPLETION_SHOW_ALL_COMMANDS=1 &&
 		export GIT_COMPLETION_SHOW_ALL_COMMANDS &&
 		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d459fae6551..06f0abfc294 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-bash.sh
 
-. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+. "$GIT_SOURCE_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
 c_red='\\[\\e[31m\\]'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6db377f68b8..36358811a0f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -47,6 +47,10 @@ then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
 	exit 1
 fi
+
+# For CMake the top-level source directory is different from our build
+# directory. With the top-level Makefile they're the same.
+GIT_SOURCE_DIR="$GIT_BUILD_DIR"
 if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
 then
 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
@@ -1447,7 +1451,7 @@ then
 		make_valgrind_symlink $file
 	done
 	# special-case the mergetools loadables
-	make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
+	make_symlink "$GIT_SOURCE_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
 	OLDIFS=$IFS
 	IFS=:
 	for path in $PATH
@@ -1500,6 +1504,8 @@ GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
+MERGE_TOOLS_DIR="$GIT_SOURCE_DIR/mergetools"
+export MERGE_TOOLS_DIR
 
 if test -z "$GIT_TEST_CMP"
 then
-- 
2.38.0.1451.g86b35f4140a

