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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C7AC43460
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882A8611C2
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhDQMyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbhDQMyP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953AFC061763
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p6so22535489wrn.9
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWMbwnhuy4+0ETrn3mDsHQ1PepPIU8ojeC+DVW9BhkE=;
        b=MpzpM+9VWbfdBKwpKmwuAfg+RxQdWO+4eHq9T4Od8ftGzFwAnEkD9+yraY0rvcVTiz
         Jtg8WmK2VVhS4yqwBgQeS4bZp5RmkD4wSAFE85TdUqF93+HlLZlcrEK9HZCw/0TEI19s
         0fnUwPNqhaxbiCcAM2HSvLYAlL0JjvEqOkBKg0jnq+SwlwqhEGg05ATEMa8NRCeF2uuM
         TLQk/I1OhUMI7mlf9PoYHBzvbYA2pgZgEbuzBdr8tA2B+ksRx5SJdKqx7+Otfo+Q7JLp
         pyzVQQc74qfBOVbDQz/YLoex6rXcxXLWnGS/mFODXBjrNcGcy5Bw2IbsSrMy4pNB1XIK
         nbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWMbwnhuy4+0ETrn3mDsHQ1PepPIU8ojeC+DVW9BhkE=;
        b=DGJp19IdAuFk2Cv8CHYlIWlaPbKGvgHDNGjei7j7wqfFcAc3jnph5Tad1vLPI2+geY
         j4dc1A+GYrboLN3XTJj8alD7CCoclhNpoLLt8ai340wzxOezR4QH6y35/T2HWBhdgrw9
         Vmnto5K7PlrqctsTDEmUHy/hv/41JuRK6vZ0D4IA45rSlCBMJIomzrXjbOpCML141fco
         1goXPfykobK4uDjGSBkkCkaqM09LIKqkdVuS7XMd1XbWdVd+mJdMMEAZYVBqrGPII5ZQ
         XXabYhzhzU5aFcUUR3jk6kuAZkmElsOVlO90oE29lHZkniST0/+/Kd3K9PJpiyp/VHVr
         jlTw==
X-Gm-Message-State: AOAM530lqLORP8tqULov9hwUqX/8QMIt8QZJxAEqjWcG3FzxLQnZBf/2
        INoo2VC/Otq2fMDAriOJ70uj6gFIvyuW9Q==
X-Google-Smtp-Source: ABdhPJzCeyzeBtVRAuv7P4qjez1MnD9cic94skrDD/WwSSSrKKcxZpOAXyS2QhCH9XI6fhEDK2ihVQ==
X-Received: by 2002:a05:6000:25c:: with SMTP id m28mr4244726wrz.325.1618664026021;
        Sat, 17 Apr 2021 05:53:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:45 -0700 (PDT)
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
Subject: [PATCH v2 12/12] test-lib: split up and deprecate test_create_repo()
Date:   Sat, 17 Apr 2021 14:52:45 +0200
Message-Id: <patch-12.12-a3e20ef18f7-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove various redundant or obsolete code from the test_create_repo()
function, and split up its use in test-lib.sh from what tests need
from it, leaving us with a pass-through wrapper for "git init" in
test-lib-functions.sh

Reasons for why we can remove various code from test_create_repo():

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

    That wasn't really needed for the .git/hooks either, but was being
    done for the convenience of not having to quote the path to the
    repository as we moved the hooks.

 6. We can drop the --template argument and instead rely on the
    GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh. See
    8683a45d669 (Introduce GIT_TEMPLATE_DIR, 2006-12-19)

 7. We only needed that ">&3 2>&4" redirection when invoked from
    test-lib.sh, and the same goes for needing the full path to "git".

    Let's move that special behavior into test-lib.sh itself.

In the end it turns out that all we needed was a plain "git init"
invocation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5406-remote-rejects.sh           |  1 -
 t/t5407-post-rewrite-hook.sh        |  2 --
 t/t5409-colorize-remote-messages.sh |  1 -
 t/test-lib-functions.sh             | 15 ++-------------
 t/test-lib.sh                       |  5 ++++-
 5 files changed, 6 insertions(+), 18 deletions(-)

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
index 8e75a013a43..bd64a15c731 100644
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
index 9ebb595c335..f73c3c6fc72 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1364,7 +1364,10 @@ rm -fr "$TRASH_DIRECTORY" || {
 remove_trash=t
 if test -z "$TEST_NO_CREATE_REPO"
 then
-	test_create_repo "$TRASH_DIRECTORY"
+	"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" \
+		init \
+		"$TRASH_DIRECTORY" >&3 2>&4 ||
+	error "cannot run git init"
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
-- 
2.31.1.722.g788886f50a2

