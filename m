Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA46C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJUJpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJUJou (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77684D4E0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so4646287wms.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz0cCGYVraKe+/v8uEtLjpfkjbjbNPYRObn3gUUIYtM=;
        b=KMyXh7EbNQ5Yo2Lgg+cfjE0g9A8MmQIJJVvGjc8Cjc6DuVn6MjZs89nBCa/NrT1AeF
         Sw9dZjXCPxSuhVWGtmXvLRfyDVC4ttuUwdgdR6Oh6xixHmVe6cFOFCz5zu2cAPoWtFHf
         xeCSFzeG987RZDDJut83RzWDwmgtbFjXQydAs4E5Ji/wMr5rn+VkQJjj0k7R+wi4SF+H
         yVs+czMAIWCILoi48ddlOPRBq+uciAVvI3z6nw0njHpBfxQFvMJXn3yBe0zUAS54Ky01
         3Y9LHKa3yu9Md2Hal3CslDi0OKLvBIv3ga8QHzm0X0BWC1OOtDftHb9zZLesvma9VNEq
         uOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cz0cCGYVraKe+/v8uEtLjpfkjbjbNPYRObn3gUUIYtM=;
        b=yBIMy1Gz1vjdjtWr/S4tu6ltq0nLJ0qFxA/Yk3b46ozp9Li7ZQwImSpBvDTagqmet+
         sO7+OtKvdOw5l+a/WlHZMvtK7AZQ47ZzkNKmAs3dGY11xaysFjhoOlxhFui/b9ilg9HP
         NBGDVlH+8TmYPVGwgWbSOwqLJYtPLV0pyzDIA98ViRdu0tyz/2z5CaQdfrryYlmsyc7d
         kMpBAKBHnHQydANvMB0hIauRVJlqG/y0rR7BKf5MFmoyvaF4TsLdeObv5nDO8GuJkVNb
         K6A6DG0VMFd4YBLY1KIwtyHiZ0ua9iUK99HZxkryXSbvi622fogQCn+E6re5u25e3x0f
         +Z+g==
X-Gm-Message-State: ACrzQf0sAKzYmtErohyA+1+MYkHsq6jgJbANQs+uVIDyYrJS+xV3uCxQ
        UBiJNVsKqqJEfo9JHv7CKUCfmXn4LYS1YA==
X-Google-Smtp-Source: AMsMyM42q4ZpEyly674ALUUam4u26WoIbhbMPhnKtRAbbOP4nht9rdCM2ao0wNbp1PW300HK51W6ug==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr32724610wmr.27.1666345485218;
        Fri, 21 Oct 2022 02:44:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:44 -0700 (PDT)
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
Subject: [PATCH 3/9] cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
Date:   Fri, 21 Oct 2022 11:44:16 +0200
Message-Id: <patch-3.9-addaf73992f-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
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

Let's instead teach the test-lib.sh that there's such a thing as the
"$GIT_SOURCE_DIR" distinct from the "$GIT_BUILD_DIR".

Just as the "$TEST_DIRECTORY" always points to our actual "t"
directory (not the "[...]/out/t" cmake creates), this new
"$GIT_SOURCE_DIR" will always be the top-level source directory.

So even though the "GIT_BUILD_DIR=(.*)" line in t/test-lib.sh will
still be altered by CMakeLists.txt, that recipe will no longer need to
copy over various things from our source directory, as the tests now
know where to find those assets.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt |  5 -----
 t/lib-gettext.sh                    |  2 +-
 t/lib-gitweb.sh                     |  2 +-
 t/t7609-mergetool--lib.sh           |  2 +-
 t/t9902-completion.sh               | 14 +++++++-------
 t/t9903-bash-prompt.sh              |  2 +-
 t/test-lib.sh                       | 12 ++++++++++--
 7 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 464c41a1fdf..84f5132f1ee 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1088,11 +1088,6 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
 		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
 		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
-	#misc copies
-	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
-	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
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
index 6ca68311eb9..d2e5dee6c89 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -41,7 +41,13 @@ then
 	# elsewhere
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
-GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
+
+# The GIT_{SOURCE,BUILD}_DIR is always the same, except when
+# CMakeLists.txt replaces the "GIT_BUILD_DIR" line with the path to
+# its build directory.
+GIT_SOURCE_DIR="${TEST_DIRECTORY%/t}"
+GIT_BUILD_DIR="$GIT_SOURCE_DIR"
+
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
@@ -1437,7 +1443,7 @@ then
 		make_valgrind_symlink $file
 	done
 	# special-case the mergetools loadables
-	make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
+	make_symlink "$GIT_SOURCE_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
 	OLDIFS=$IFS
 	IFS=:
 	for path in $PATH
@@ -1490,6 +1496,8 @@ GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
+MERGE_TOOLS_DIR="$GIT_SOURCE_DIR/mergetools"
+export MERGE_TOOLS_DIR
 
 if test -z "$GIT_TEST_CMP"
 then
-- 
2.38.0.1205.gcea0601d673

