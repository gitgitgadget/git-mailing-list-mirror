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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B68CC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98E861442
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhDUKQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbhDUKQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E4C061342
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g9so24738120wrx.0
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWZ8AuwpBmSqqSy45/amQXRpYgp/jnCCcV9RH6ku3OI=;
        b=spXSCYgc5xS4iJlCOZs7uToFYMWI0/FdRSV5grvcxMChfpDmvZ9ToZvXfsF7l31QAD
         xwnpNd1BlNzEslo92XLGEkUhsWfNvhl6d2v+uL63Y8+Q4CBjL2dH+Ztv25tPRrBT8rRr
         KDmvD+UC+n3sH8ImDW+mODzhvdDAD94frzkjVZI6HC1PNxl3/AMNUBaU1plTl/w65dOv
         MrpkY+eU5R320HFjaTVbxpuDb36QAN+aOm7Mk2Kex9Gett//siJXZfBreVpucU+I6tKY
         90ZcLtRv+nfHmLVjkNHK27R/5+X0EDM7GvfjvjQe7ZvJnu4Ns0RVIXmaIKAvI5e5WtjM
         wjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWZ8AuwpBmSqqSy45/amQXRpYgp/jnCCcV9RH6ku3OI=;
        b=r1wWWZWozntc3sHgCVWDf8Qph8iiuFT5gIS8AvbtkA4fYQBhe/MGRVOMma1ZMDNlWZ
         EXq0eeU0aSdXWqJg5/XVOvhwM7X+Pe6cykbWLD4Ne1lt5ZRyXnAfiXDP9CETCKI23P5f
         XqquSlv+Si+pXrrRRDnyj7bzxLhaBaDrR6iFa3kr1ou9yzcNzaYqBLZA282tfFuf7Z6A
         52vJhrVuSDCxfvpe0EnexqsKv6rN5bkLYNzqBqxH8Oim1OgEj7kYIiqz9kJP6oZWOhWz
         dwGw2OUYl9Hc7EXFztad41f+qiLqdpnCyICed+Rdid0k+kdYOcfz0/5TI6w0B7MURgo+
         N4bw==
X-Gm-Message-State: AOAM530prshzM11N2IOsdhEphYIxtD/KvcptdU23Rfec6LHZK0AwjNWv
        NsBqkHPk2DnRQIPsvlY4cUwii3Q3SxWKxA==
X-Google-Smtp-Source: ABdhPJw9HpqVUr1ILRDwmLzG+JS6sj4nZ/xTL3N9/+laqY3cMHVL/HmOCaakEJES9EzRObKI/N4Tow==
X-Received: by 2002:adf:d1e6:: with SMTP id g6mr25574781wrd.130.1619000129033;
        Wed, 21 Apr 2021 03:15:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:28 -0700 (PDT)
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
Subject: [PATCH v4 11/11] test-lib: split up and deprecate test_create_repo()
Date:   Wed, 21 Apr 2021 12:15:16 +0200
Message-Id: <patch-11.11-311a9dba36-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
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
index ab1fe98ccc..5fd968d11b 100644
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
2.31.1.721.gbeb6a21927

