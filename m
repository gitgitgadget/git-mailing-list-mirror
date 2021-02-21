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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029CAC433DB
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8536186A
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 19:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhBUT0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 14:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBUT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 14:26:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6307C061574
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 11:25:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so19223911edb.9
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 11:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PiqnFNfp+rKIiYbtoxUhzYA3vFsPWEr8Fm1O2rPxxE=;
        b=B7ERFhkEDApLLtrdIoLX11JdfxYnAL912Iln9MAmFQgLBhttj2gtoe7x1WF9EO1BO2
         r3g2tZlVoqrfJcdC9+wHS1tbVfb28b3g0XTMDEhsppXoBLkzgTnWF6RFVMvlFt1Zdoxw
         r30Vyy6B43NftYaGn1+++jfbx3o2JK8rIJTMkRIonNugCM3kG5rFNlOaHiYYhdFlwrFY
         ghinMaFhYOPeilsRdtTzR2CPT9cax0w7P0Ah2FiIFJzLGFapfETrTdtz2AEsA3+gi+IX
         tuu1BiniRgU5kytuRjK0/XI8tKQDHTfu4rONkCFQ6cPfXTpnufkE28ZLwug1bH4s2rrY
         L2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PiqnFNfp+rKIiYbtoxUhzYA3vFsPWEr8Fm1O2rPxxE=;
        b=S70fDRJk2hkmnIH0+/eurFOvH/goXIuWCJkHH/dsh/h0OYCc/V6C2QsIx3tR5KJVEt
         RImuY5BOQFZDeLWXrGdEW2Fq7BcTiF7cdWI5ss1Bl+t/idGf181hzVWaLQ+sI8rXWmEW
         pNZ54L4gDOELbb4eC7CxG71mA8YtN7hB/o2+O5XVWpz1ZadHeQEZnp93izvnga6IEypH
         CVKceinkbOyBHukGU2VmW/ZF1yEhYLeGgdr70owihs/EwruvtoYdaevppRgS9Bz2rBOi
         rNMtRwUDGvFj/fFpPfXXL9mh/S15lDqqaM4YSAObxrExpQFoUF1lDH7gSQ7dGOgdgAEc
         hpyg==
X-Gm-Message-State: AOAM531n8+lU0AqgrmWzkoE69CGgEdKYZFXlHd+4z+/bOKWjN4lodnBR
        ZhHy23uuSihXHdapeLhF+voQHAw4uFM=
X-Google-Smtp-Source: ABdhPJyI6dOMWAG1jr5lcDGKVFOXV4m42L1jZRfN/q2FyllrH0nQKylYwLaY+hyBygP7EYX5ZYunIw==
X-Received: by 2002:a05:6402:1383:: with SMTP id b3mr18678120edv.131.1613935521679;
        Sun, 21 Feb 2021 11:25:21 -0800 (PST)
Received: from localhost.localdomain (94-21-146-126.pool.digikabel.hu. [94.21.146.126])
        by smtp.gmail.com with ESMTPSA id hd9sm7982026ejc.30.2021.02.21.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 11:25:21 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] tests: don't mess with fd 7 of test helper functions
Date:   Sun, 21 Feb 2021 20:25:11 +0100
Message-Id: <20210221192512.3096291-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.30.1.940.gce394404de
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In test helper functions exercising git commands, e.g.
'test_must_fail', 'test_env' and friends, we can't access the test
script's original standard error, and, consequently, BUG() doesn't
work as expected.

The root of the issue stems from a5bf824f3b (t: prevent '-x' tracing
from interfering with test helpers' stderr, 2018-02-25), where we
started to use a couple of file descriptor duplications and
redirections to separate the standard error of git commands exercised
in test helper functions from the stderr containing the '-x' trace
output of said helper functions.  To achieve that the git command's
stderr is redirected to the test helper function's fd 7, which was
previously duplicated from the helper's stderr.  Alas, fd 7 was not
the right choice for this purpose, because fd 7 is the original
standard error of the test script, and, consequently, we now can't
send error messages from within such test helper functions directly to
the test script's stderr.  Since BUG() does want to send its error
message there it doesn't work as expected in such test helper
functions, because:

  - If the test helper's stderr were redirected to a file (as is often
    the case e.g. with 'test_must_fail'), then the "bug in the test
    script" error message would end up in that file.

  - If the test script is invoked without any of the verbose options,
    then that error message would get lost to /dev/null, leaving no
    clues about why the test script aborted so suddenly.

We don't have any BUG() calls in such test helper functions yet, but
6a67c75948 (test-lib-functions: restrict test_must_fail usage,
2020-07-07) did start to verify the parameters of 'test_must_fail' and
report the error with:

    echo >&7 "test_must_fail: only 'git' is allowed: $*"
    return 1

instead of BUG() that we usually use to bail out in case of bogus
parameters.

Use fd 6 instead of fd 7 for these '-x' tracing related duplications
and redirections.  It is a better choice for this purpose, because fd
6 is the test script's original standard input, and neither these test
helper functions not the git commands exercised by them should ever
read from the test scipt's stdin, see 781f76b158 (test-lib: redirect
stdin of tests, 2011-12-15).  Update the aforementioned error
reporting in 'test_must_fail' to send the error message to fd 6 as
well; the next patch will update it to use BUG() instead.

The only two other functions that want to directly write to the test
script's stderr are 'test_pause' and 'debug', but they are not
affected by this issue, because, being special "interactive" debug
aids, their fd 7 were not redirected in a5bf824f3b.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-terminal.sh       |  4 ++--
 t/test-lib-functions.sh | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index e3809dcead..454909c087 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -9,8 +9,8 @@ test_terminal () {
 		echo >&4 "test_terminal: need to declare TTY prerequisite"
 		return 127
 	fi
-	perl "$TEST_DIRECTORY"/test-terminal.perl "$@" 2>&7
-} 7>&2 2>&4
+	perl "$TEST_DIRECTORY"/test-terminal.perl "$@" 2>&6
+} 6>&2 2>&4
 
 test_lazy_prereq TTY '
 	test_have_prereq PERL &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 05dc2cc6be..a40c1c5d83 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -910,10 +910,10 @@ test_must_fail () {
 	esac
 	if ! test_must_fail_acceptable "$@"
 	then
-		echo >&7 "test_must_fail: only 'git' is allowed: $*"
+		echo >&6 "test_must_fail: only 'git' is allowed: $*"
 		return 1
 	fi
-	"$@" 2>&7
+	"$@" 2>&6
 	exit_code=$?
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
@@ -936,7 +936,7 @@ test_must_fail () {
 		return 1
 	fi
 	return 0
-} 7>&2 2>&4
+} 6>&2 2>&4
 
 # Similar to test_must_fail, but tolerates success, too.  This is
 # meant to be used in contexts like:
@@ -952,8 +952,8 @@ test_must_fail () {
 # Accepts the same options as test_must_fail.
 
 test_might_fail () {
-	test_must_fail ok=success "$@" 2>&7
-} 7>&2 2>&4
+	test_must_fail ok=success "$@" 2>&6
+} 6>&2 2>&4
 
 # Similar to test_must_fail and test_might_fail, but check that a
 # given command exited with a given exit code. Meant to be used as:
@@ -965,7 +965,7 @@ test_might_fail () {
 test_expect_code () {
 	want_code=$1
 	shift
-	"$@" 2>&7
+	"$@" 2>&6
 	exit_code=$?
 	if test $exit_code = $want_code
 	then
@@ -974,7 +974,7 @@ test_expect_code () {
 
 	echo >&4 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
 	return 1
-} 7>&2 2>&4
+} 6>&2 2>&4
 
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
@@ -1261,8 +1261,8 @@ test_write_lines () {
 }
 
 perl () {
-	command "$PERL_PATH" "$@" 2>&7
-} 7>&2 2>&4
+	command "$PERL_PATH" "$@" 2>&6
+} 6>&2 2>&4
 
 # Given the name of an environment variable with a bool value, normalize
 # its value to a 0 (true) or 1 (false or empty string) return code.
@@ -1388,13 +1388,13 @@ test_env () {
 				shift
 				;;
 			*)
-				"$@" 2>&7
+				"$@" 2>&6
 				exit
 				;;
 			esac
 		done
 	)
-} 7>&2 2>&4
+} 6>&2 2>&4
 
 # Returns true if the numeric exit code in "$2" represents the expected signal
 # in "$1". Signals should be given numerically.
@@ -1436,9 +1436,9 @@ nongit () {
 		GIT_CEILING_DIRECTORIES=$(pwd) &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non-repo &&
-		"$@" 2>&7
+		"$@" 2>&6
 	)
-} 7>&2 2>&4
+} 6>&2 2>&4
 
 # convert function arguments or stdin (if not arguments given) to pktline
 # representation. If multiple arguments are given, they are separated by
-- 
2.30.1.940.gce394404de

