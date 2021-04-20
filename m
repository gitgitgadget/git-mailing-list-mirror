Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DA3C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5461613C1
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhDTMW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhDTMWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA79FC061343
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p6so30695067wrn.9
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYRYMNUQTSuyeIHpKLJ/CAznQPac7DR8nZ1PoBFK+5E=;
        b=LRVonTqBOmK/U92hl3wVJ6QFKJdY0XrVdbj0l3f06jWJgauYYSZDguo9dkHz6Hre8B
         HiVkcBTxLYXtLYq8EGkQR7Z9PMdMueAtVa+zWMgbwiXgpVY2RLAvwmKP96CExf7vycU8
         T5cIJ3dfUwHB8ZmCgeQQ1DRcOluQHacV6YmrOgjM8SfkXrX68ot/XV7VhmshV8wNxyOk
         EsnxBfXoqIAOGlXJnWKSRiNkFKkQK5I40lEXSxL30tfJjL+h9kQWaV19d00vOarEEdVC
         orRTnz8R/H+6+MVR5KLGZyDi59+FhogDj8B1wDG0aK2azrmeljQQUeT4SMwBo4tAwmew
         +v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYRYMNUQTSuyeIHpKLJ/CAznQPac7DR8nZ1PoBFK+5E=;
        b=MlFt5YhbfZF9NEfQo7XevPnBKqeuxBA/js/s9+jqbx788a712HfII7InK9xFJGM8TP
         2iRhgBg8k8ZTjEeUo5ajGfTg42DAULWttwyB9hEyUX0N4euxWT4c6CVi4LVS9b/34vCC
         aMVfPITToZ0DTMiCyG+5k8zn0DdZIT7ROPI1Qq+Qf/1Fc4pEoZGT39isUUp222ot+Mp5
         QUo0u2GP2jgXdOIjTfh3F74xG+H+X/W0IVs18PEu9YkmHb79S0hOyLOoMk40IsKqB90d
         xBVacr47M50ndQdyX5ei7G0zUP/icEXeVZXx+PQvencnTRtQi1E04FMzwUgumr1IptbN
         V8oQ==
X-Gm-Message-State: AOAM5322voFRyEdjSASg9fmq+O4ajehd5A91VrJ+W4PXEERZ4nMpqWCS
        VvviyW4whnbKOs9i2Bt0C56QMzOlbl5qOA==
X-Google-Smtp-Source: ABdhPJxQ9qFcihSar+9LmS0ljkmGVxQdtK49E2YL40XnAFMv5r9P2Ie37yq5QUTooEc3nx7PdIpi8w==
X-Received: by 2002:a5d:568f:: with SMTP id f15mr20597681wrv.346.1618921338305;
        Tue, 20 Apr 2021 05:22:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/12] test-lib: split up and deprecate test_create_repo()
Date:   Tue, 20 Apr 2021 14:22:03 +0200
Message-Id: <patch-12.12-0dc0da9490-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove various redundant or obsolete code from the test_create_repo()
function, and split up its use in test-lib.sh from what tests need
from it.

This leave us with a pass-through wrapper for "git init" in
test-lib-functions.sh, in test-lib.sh we have the same, except for
needing to redirect stdout/stderr, and emitting an error ourselves if
it fails. We don't need to error() ourselves when test_create_repo()
is invoked, as the invocation will be a part of a test's "&&"-chain.

Everything below this paragraph is a detailed summary of the history
of test_create_repo() explaining why it's safe to remove the various
things it was doing:

 1. "mkdir -p" isn't needed because "git init" itself will create
    leading directories if needed.

 2. Since we're now a simple wrapper for "git init" we don't need to
    check that we have only one argument. If someone wants to run
    "test_create_repo --bare x" that's OK.

 3. We won't ever hit that "Cannot setup test environment"
    error.

    Checking the test environment sanity when doing "git init" dates
    back to eea420693be (t0000: catch trivial pilot errors.,
    2005-12-10) and 2ccd2027b01 (trivial: check, if t/trash directory
    was successfully created, 2006-01-05).

    We can also see it in another form a bit later in my own
    0d314ce834d (test-lib: use subshell instead of cd $new && .. && cd
    $old, 2010-08-30).

    But since 2006f0adaee (t/test-lib: make sure Git has already been
    built, 2012-09-17) we already check if we have a built git
    earlier.

    The one thing this was testing after that 2012 change was that
    we'd just built "git", but not "git-init", but since
    3af4c7156c4 (tests: respect GIT_TEST_INSTALLED when initializing
    repositories, 2018-11-12) we invoke "git", not "git-init".

    So all of that's been checked already, and we don't need to
    re-check it here.

 4. We don't need to move .git/hooks out of the way.

    That dates back to c09a69a83e3 (Disable hooks during tests.,
    2005-10-16), since then hooks became disabled by default in
    f98f8cbac01 (Ship sample hooks with .sample suffix, 2008-06-24).

    So the hooks were already disabled by default, but as can be seen
    from "mkdir .git/hooks" changes various tests needed to re-setup
    that directory. Now they no longer do.

 5. Since we don't need to move the .git/hooks directory we don't need
    the subshell here either.

    See 0d314ce834 for when the subshell use got introduced for the
    convenience of not having to "cd" back and forth while setting up
    the hooks.

 6. We can drop the --template argument and instead rely on the
    GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh. See
    8683a45d669 (Introduce GIT_TEMPLATE_DIR, 2006-12-19)

 7. We only needed that ">&3 2>&4" redirection when invoked from
    test-lib.sh.

    We could still invoke test_create_repo() there, but as the
    invocation is now trivial and we don't have a good reason to use
    test_create_repo() elsewhere let's call "git init" there
    ourselves.

 8. We didn't need to resolve "git" as
    "${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" in test_create_repo(),
    even for the use of test-lib.sh

    PATH is already set up in test-lib.sh to start with
    GIT_TEST_INSTALLED and/or GIT_EXEC_PATH before
    test_create_repo() (now "git init") is called.. So we can simply
    run "git" and rely on the PATH lookup choosing the right
    executable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5406-remote-rejects.sh           |  1 -
 t/t5407-post-rewrite-hook.sh        |  2 --
 t/t5409-colorize-remote-messages.sh |  1 -
 t/test-lib-functions.sh             | 15 ++-------------
 t/test-lib.sh                       |  3 ++-
 5 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index ff06f99649..5c509db6fc 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -5,7 +5,6 @@ test_description='remote push rejects are reported by client'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	mkdir .git/hooks &&
 	write_script .git/hooks/update <<-\EOF &&
 	exit 1
 	EOF
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 5bb23cc3a4..6da8d760e2 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -20,8 +20,6 @@ test_expect_success 'setup' '
 	git checkout main
 '
 
-mkdir .git/hooks
-
 cat >.git/hooks/post-rewrite <<EOF
 #!/bin/sh
 echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 5d8f401d8e..9f1a483f42 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -5,7 +5,6 @@ test_description='remote messages are colorized on the client'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	mkdir .git/hooks &&
 	write_script .git/hooks/update <<-\EOF &&
 	echo error: error
 	echo ERROR: also highlighted
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8e75a013a4..bd64a15c73 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1248,21 +1248,10 @@ test_atexit () {
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
 }
 
-# Most tests can use the created repository, but some may need to create more.
+# Deprecated wrapper for "git init", use "git init" directly instead
 # Usage: test_create_repo <directory>
 test_create_repo () {
-	test "$#" = 1 ||
-	BUG "not 1 parameter to test-create-repo"
-	repo="$1"
-	mkdir -p "$repo"
-	(
-		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
-			init \
-			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
-		error "cannot run git init -- have you built things yet?"
-		mv .git/hooks .git/hooks-disabled
-	) || exit
+	git init "$@"
 }
 
 # This function helps on symlink challenged file systems when it is not
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9ebb595c33..06026bbe75 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1364,7 +1364,8 @@ rm -fr "$TRASH_DIRECTORY" || {
 remove_trash=t
 if test -z "$TEST_NO_CREATE_REPO"
 then
-	test_create_repo "$TRASH_DIRECTORY"
+	git init "$TRASH_DIRECTORY" >&3 2>&4 ||
+	error "cannot run git init"
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
-- 
2.31.1.723.gf6bad1b9ba1

