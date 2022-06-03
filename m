Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D71C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiFCLPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbiFCLPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E73C484
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso4184017wmp.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88x2QsLj5/nAjPYcWAsIRM1UYqn9yuuLON7teCmH9vs=;
        b=cL9c+3v5l0rAPLsE+5X0kEmMeahi9MhJRYO8KiHVViZ/uvQBIdQxJTNvNwhWZiV/dz
         Y32F5KPNcU4Xex8X26G8jvbHa2H+H8E9cy43mcU5/Hk90ZxE/x8fUBGHzf65Fe9Ruyuy
         Y8/jxCyURdPjD/qVQYzHev2jk6AitvZlg+YAraXsi9nfKwuSZrYOY115POlNHt0hY4GK
         OL3MoCdCMolTO0NPgtm7wDLnsOXbo8AP9EqMPCDFJEhw2yL0nqhdAWtFgr0h38PfSFPN
         qQtUG8uzNAmdbPUktwQ6Od8YaKnwU7SeXiG5+4AiYYwqn6Y67qDerblNM+cZFAcz5fsk
         bIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88x2QsLj5/nAjPYcWAsIRM1UYqn9yuuLON7teCmH9vs=;
        b=kOrsQNvjIEfOki1Zp5LqDQD7BQ3FXG58G6u9eI2eZO7TbZlQFSglrmv+9xAakTWuHF
         0xJFgqjbbzcMZo6vt1agqzGtpHqXdazetYj5Ea7OfdwmuzowElQrDPgsAW9g33PmS3x0
         mmAIo3exsMBat1V0yuAMyT9Nghb1jM3iZphrpDXgMWDkAJgOl/ua/2DIUYJ/IwD1Al5B
         HYLBEPaZhxpRLQvIQ7g+hh1oUnD85j4P7zK/wabcp5a1mcKm9Q4XRhgJgRj+LHaR92Tf
         YC6rB1jLAGN7ZPK+fWYlMXBlvIPFgvq0ZWQRGJNODu6jC2+tnIvMEocOUxZhbbh3RHwD
         lkHg==
X-Gm-Message-State: AOAM5300qYduaSXx87VWFN3EIcd7RbaNZJXHQnKHNZaP+ecAAvPFfKUA
        CVzpbVY8m9evvj4+b8wRQnkUwXyGW7dKpA==
X-Google-Smtp-Source: ABdhPJwpM5ewRinzzOWm6jbeztiK9GVKjE6M3Hq6yfJipood2PalI0L62jQV3OIOkdRRd/k+7ux8lQ==
X-Received: by 2002:a7b:c041:0:b0:394:44a9:b017 with SMTP id u1-20020a7bc041000000b0039444a9b017mr8272788wmc.169.1654254930720;
        Fri, 03 Jun 2022 04:15:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:29 -0700 (PDT)
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
Subject: [PATCH v2 2/7] tests: don't depend on template-created .git/branches
Date:   Fri,  3 Jun 2022 13:15:04 +0200
Message-Id: <patch-v2-2.7-c4d0e6c684b-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in c8a58ac5a52 (Revert "Don't create the $GIT_DIR/branches
directory on init", 2009-10-31) there was an attempt long ago in
0cc5691a8b0 (Don't create the $GIT_DIR/branches directory on init,
2009-10-30) to get rid of the legacy "branches" directory.

We should probably get rid of its creation by removing the
"templates/branches--" file. But whatever our default behavior, our
tests should be tightened up to explicitly create the .git/branches
directory if they rely on our default templates, to make the
dependency on those templates clear.

So let's amend the two tests that would fail if .git/branches wasn't
created. To do this introduce a new "TEST_CREATE_REPO_NO_TEMPLATE"
variable, which we'll set before sourcing test-lib.sh, and change the
"git clone" and "git init" commands in the tests themselves to
explicitly pass "--template=".

This way they won't get a .git/branches in either their top-level
.git, or in the ones they create. We can then amend the tests that
rely on the ".git/branches" directory existing to create it
explicitly, and to remove it after its creation.

This new "TEST_CREATE_REPO_NO_TEMPLATE" variable is a less
heavy-handed version of the "NO_SET_GIT_TEMPLATE_DIR" variable. See
a94d305bf80 (t/t0001-init.sh: add test for 'init with init.templatedir
set', 2010-02-26) for its implementation.

Unlike "TEST_CREATE_REPO_NO_TEMPLATE", this new
"TEST_CREATE_REPO_NO_TEMPLATE" variable is narrowly scoped to what the
"git init" in test-lib.sh does, as opposed to the global effect of
"NO_SET_GIT_TEMPLATE_DIR" and the setting of "GIT_TEMPLATE_DIR" in
wrap-for-bin.sh.

I experimented with adding a new "GIT_WRAP_FOR_BIN_VIA_TEST_LIB"
variable set in test-lib.sh, which would cause wrap-for-bin.sh to not
set GIT_TEMPLATE_DIR, GITPERLLIB etc, as we set those in
test-lib.sh. I think that's a viable approach, but it would interact
e.g. with the appending feature of GITPERLLIB added in
8bade1e12e2 (wrap-for-bin: make bin-wrappers chainable, 2013-07-04).

Doing so would allow us to convert the tests in t0001-init.sh that now
use "NO_SET_GIT_TEMPLATE_DIR" to simply unset "GIT_TEMPLATE_DIR" in a
sub-shell before invoking "git init" or "git clone". I think that
approach is worth pursuing, but let's table it for now. Some future
wrap-for-bin.sh refactoring can try to address it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5505-remote.sh     |  6 ++++--
 t/t5516-fetch-push.sh | 16 ++++++++++++++--
 t/test-lib.sh         |  4 +++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index fff14e13ed4..cfb47509e3f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -957,11 +957,12 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 '
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
-	git clone one six &&
+	git clone --template= one six &&
 	origin_url=$(pwd)/one &&
 	(
 		cd six &&
 		git remote rm origin &&
+		mkdir .git/branches &&
 		echo "$origin_url#main" >.git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
@@ -972,10 +973,11 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 '
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
-	git clone one seven &&
+	git clone --template= one seven &&
 	(
 		cd seven &&
 		git remote rm origin &&
+		mkdir .git/branches &&
 		echo "quux#foom" > .git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4dfb080433e..5d3054eeb89 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -17,6 +17,7 @@ This test checks the following functionality:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 D=$(pwd)
@@ -25,7 +26,8 @@ mk_empty () {
 	repo_name="$1"
 	test_when_finished "rm -rf \"$repo_name\"" &&
 	test_path_is_missing "$repo_name" &&
-	git init "$repo_name" &&
+	git init --template= "$repo_name" &&
+	mkdir "$repo_name"/.git/hooks &&
 	git -C "$repo_name" config receive.denyCurrentBranch warn
 }
 
@@ -77,7 +79,7 @@ mk_test_with_hooks() {
 
 mk_child() {
 	test_when_finished "rm -rf \"$2\"" &&
-	git clone "$1" "$2"
+	git clone --template= "$1" "$2"
 }
 
 check_push_result () {
@@ -916,6 +918,7 @@ test_expect_success 'fetch with branches' '
 	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
+	mkdir testrepo/.git/branches &&
 	echo ".." > testrepo/.git/branches/branch1 &&
 	(
 		cd testrepo &&
@@ -929,6 +932,7 @@ test_expect_success 'fetch with branches' '
 
 test_expect_success 'fetch with branches containing #' '
 	mk_empty testrepo &&
+	mkdir testrepo/.git/branches &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
@@ -943,7 +947,11 @@ test_expect_success 'fetch with branches containing #' '
 test_expect_success 'push with branches' '
 	mk_empty testrepo &&
 	git checkout second &&
+
+	test_when_finished "rm -rf .git/branches" &&
+	mkdir .git/branches &&
 	echo "testrepo" > .git/branches/branch1 &&
+
 	git push branch1 &&
 	(
 		cd testrepo &&
@@ -955,7 +963,11 @@ test_expect_success 'push with branches' '
 
 test_expect_success 'push with branches containing #' '
 	mk_empty testrepo &&
+
+	test_when_finished "rm -rf .git/branches" &&
+	mkdir .git/branches &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
+
 	git push branch2 &&
 	(
 		cd testrepo &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8ba5ca15345..144f14cc142 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1529,7 +1529,9 @@ remove_trash_directory "$TRASH_DIRECTORY" || {
 remove_trash=t
 if test -z "$TEST_NO_CREATE_REPO"
 then
-	git init "$TRASH_DIRECTORY" >&3 2>&4 ||
+	git init \
+	    ${TEST_CREATE_REPO_NO_TEMPLATE:+--template=} \
+	    "$TRASH_DIRECTORY" >&3 2>&4 ||
 	error "cannot run git init"
 else
 	mkdir -p "$TRASH_DIRECTORY"
-- 
2.36.1.1119.g5a713b43bd4

