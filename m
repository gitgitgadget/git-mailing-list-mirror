Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FC2C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FC861404
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhDWHWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbhDWHWL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77ACC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd23so63799771ejb.12
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNRErmwQsIsJTNbAqkJj+bC35uHmpctkSS4NZgP7hs4=;
        b=ef8CZPl893MsQ8cCxByHqy1dYs6A1udAEbAoxZFSPwqbT51bZDnJ0THcvVRa5iDFsn
         42lRZsXSjMLTwpPVeGl/1Gwra5jSgzIloViEDh3Iq91/53/QWxTYcil/H5YLRT9Eg5U/
         XEV5rjaFC6p64MhICUn/VoD5JDDr8kVFSpx5+paoDKcT+/+y86WTB8PopBqwEyBu22fs
         LKgphZc6bmy3JFUgB7q/Q2cq3zjitKzXkysOGjVQsLCF9h5jrK2kf4rqJn86OIZZjKFo
         xNo3DML3qGUy5op7iSIQE6o6ZPo/Zgi59wTgK86EMLS36dT37OmqjWIPlp7qd6XyudkM
         lmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNRErmwQsIsJTNbAqkJj+bC35uHmpctkSS4NZgP7hs4=;
        b=mgSG56y4AWuBQPrrO1NUYuKXcBbNNQ0sNFlO+F1JWp8vpBXoeoZjN63SRyRSDT2jKS
         0zooKNc5RtWub9SUf2OxzgvD9gQ6B4YmYX6m21VmFq5E2khQa0eA7F7IdLJ6qWQlOpM3
         qaTEn9TreYq+mPn232SFHo1t8+Hfs8vhqjzTgVWfXUM7b8k3v8S5UrRLvsEwF1rZcTOR
         NcIjJEXi8Rp2n96nkmOrxeMX0wivX3jlTuQkABLLmTnm+qHDVuAvhVITJiswm/ypNMq4
         J6RQEbXUmeHUD6f1cGfJ2HAM+C8UE0n+UB2g9Ec4/iCRkqIut9Ohdm8wjDF0NGqZKnlM
         d2Ag==
X-Gm-Message-State: AOAM531gxIjAiSYjmjev1fnxOAPQ3TCEQkk7oxgEj42OFnm5Bzwr2Uzo
        0nMsByBorV8KiSxSpfCO5xllLDRubfoshw==
X-Google-Smtp-Source: ABdhPJwTgVTXF43uCmIuEGj/c7PF5pot30I7bg3/yznM6QoyRg/YX0v228fgegZy+UEnR5Cx5jpEQQ==
X-Received: by 2002:a17:907:1c08:: with SMTP id nc8mr2726075ejc.378.1619162492126;
        Fri, 23 Apr 2021 00:21:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:31 -0700 (PDT)
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
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/11] test-lib: split up and deprecate test_create_repo()
Date:   Fri, 23 Apr 2021 09:21:15 +0200
Message-Id: <patch-11.11-7793311e5f1-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
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

    This makes us implicitly depend on the default hooks being
    disabled, which is a good thing. If and when we'd have any
    on-by-default hooks (I see no reason we ever would) we'd want to
    see the subtle and not so subtle ways that would break the test
    suite.

 5. We don't need to "cd" to the "$repo" directory at all anymore.

    In the code being removed here we both "cd"'d to the repository
    before calling "init", and did so in a subshell.

    It's not important to do either, so both of those can be
    removed. We cd'd because this code grew from test-lib.sh code
    where we'd have done so already, see eedf8f97e58 (Abstract
    test_create_repo out for use in tests., 2006-02-17), and later
    "cd"'d inside a subshell since 0d314ce834d to avoid having to keep
    track of an "old pwd" variable to cd back after the setup.

    Being in the repository directory made moving the hooks around
    easier (we wouldn't have to fully qualify the path). Since we're
    not moving the hooks per #4 above we don't need to "cd" for that
    reason either.

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
index ff06f99649e..5c509db6fc3 100755
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
index 5bb23cc3a4e..6da8d760e28 100755
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
index 5d8f401d8ec..9f1a483f426 100755
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
index c9f33b79151..213b1988aa4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1241,21 +1241,10 @@ test_atexit () {
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
index ab1fe98ccce..5fd968d11b2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1365,7 +1365,8 @@ rm -fr "$TRASH_DIRECTORY" || {
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
2.31.1.737.g98b508eba36

