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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0CC43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D1A61241
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhDLLJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbhDLLJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049EC06138D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso6651268wmi.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPHwDC58iYFxN7sMvoKI/ERAJbHI3mRXaODvcOSrqTc=;
        b=ULGJh1cq4/tDf2VviyCI9V80j844du8vsYyxzhtWkOq5R6H1wZAB4yXuH3OiMtOrse
         u1z2J/1V6q2rQwfEgUlWLyRRo2aOepg2xn+dO/8clgaO5q6uXxs37yhflbO+oFdThEAi
         YctflO6JUlGmXyxWKBr2S0TZwwtT7RiyoQ5rJhd7c92etHIpgz/C8bNvRrrz7R+vTrKY
         EWL3DdM23/Kz8CqZIXJZ/PSNYCbWmt0Pch8ndbqv6eqNgCLtMLgHj7HqtQbYEX306jfj
         bA/yGz5cgKIKWh+Bz0Ja5uWXHjuW49QsSxtD12Wx/TQdOINWO8OexSOPKEWvzLyEjxrH
         eKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPHwDC58iYFxN7sMvoKI/ERAJbHI3mRXaODvcOSrqTc=;
        b=LzPqLozRG4rnv2/4X77763R5bZcnD1a5ytDGyOgpawgATrSIQHxdx19SsQyCcnZVwe
         u+AeHDpmfJ/NUFKiwUYgp97V4WfKmVlyfFV/cxyIJtYffcMMN88lKW30q9Iql1ACLpDm
         KSO1HrxGCBzB90q/+FB8Bw14sZ4Z/dbzd3bhtRTnSY3nSke1PcCTXwHj42lgssIZ3qOO
         K2NigsPhycuthIOk7H47Yaxe4sIyfcK1Hkcig1FuwDo4MLCP7WJtFyQsI4C3tUUjUMNA
         9vinmhgsyI2f2/rUlPIe59tGNvDfiRU0EAq38TnqBTxNgl7quOHTfR4w74cYVyM/FnXE
         itqg==
X-Gm-Message-State: AOAM532dnsxWCmgGAf4EYSSlz+LWXO854Nt+BCAkKGBmHYyO9O/sit6f
        OfR3Ceqx4PlH03hdUvdxDKTAxSJLVP7MDw==
X-Google-Smtp-Source: ABdhPJwvKNOV9SxOyNAALplLVRrOfUyNmbCwtP8aRuipqJ5nzH9Rx3meQNiMLdiMzHG+q3++PdRpcg==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr7706885wmo.185.1618225759692;
        Mon, 12 Apr 2021 04:09:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/16] test-lib: modernize test_create_repo() function
Date:   Mon, 12 Apr 2021 13:09:01 +0200
Message-Id: <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove redundant "mkdir -p", argument number checking', test
environment sanity checking, and disabling of hooks from
test_create_repo(). As we'll see below these were all either redundant
to other test other framework code, or to changes in git itself.

Respectively:

 1. "mkdir -p" isn't needed because "git init" itself will create
    leading directories if needed.

 2. We don't need to check the number of arguments anymore, instead
    we'll feed "git init" with "$@". It will die if given too many
    arguments.

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

In the end it turns out that all we needed was a plain "git init"
invocation with a custom --template directory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5406-remote-rejects.sh           |  1 -
 t/t5407-post-rewrite-hook.sh        |  2 --
 t/t5409-colorize-remote-messages.sh |  1 -
 t/test-lib-functions.sh             | 15 +++------------
 4 files changed, 3 insertions(+), 16 deletions(-)

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
index c81726acb9e..1258329fdd8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1252,18 +1252,9 @@ test_atexit () {
 # Most tests can use the created repository, but some may need to create more.
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
+	"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
+		init \
+		"--template=$GIT_BUILD_DIR/templates/blt/" "$@" >&3 2>&4
 }
 
 # This function helps on symlink challenged file systems when it is not
-- 
2.31.1.634.gb41287a30b0

