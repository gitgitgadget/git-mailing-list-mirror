Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FEB1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBWXkM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:12 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41476 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeBWXkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:11 -0500
Received: by mail-wr0-f171.google.com with SMTP id f14so15665881wre.8
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WH44ZdVR7fbRKjmaJQ73/595vv6bM9spOn0U7zr0z1o=;
        b=o5VZbFR3K7Mc+DeyBT6JgEEmQBVuOz3l/4bgF1iI7nGM26AgYdVnoV97xf7dmd62E0
         cxMuc0jFjz6+1vDl7/p2u3SKDeRcISfL2zhIMR2gmpi0OtDu4E2+CSItstJ6mNxuQA9O
         OF+qt7ir8jnPb4jUPEP84jJzSmTy+7ImeAhSW2iw+Wr46OLChe1N/wLXw2zO8QxP5zDi
         xh/ZhK8KkFh03cHnIlAQrJuDQflMnowQ8QdzrqdcNG829DgmFuvuif6SCEqsGitqXS/C
         Hmd3wETc8e6HUOZnSLY2ooZcNgKwhbKqdFCYx5rjO7TIcwUxdb4CzGRbFSvXtOGuPiUd
         NcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WH44ZdVR7fbRKjmaJQ73/595vv6bM9spOn0U7zr0z1o=;
        b=PtVu35zbI3Uvqly6VU9Wxj7XbyuMDozpv0D5ROEzdHzBHBg3qCxZXhzQcaeLE5pNeD
         nR37w/suCHR/gjHmTE5dr/QlEpwRqYHah/9qYkLEYewhX4qTr3q7znhQr3Ftn+5B+vNA
         fXOSrqxvoivwQdzSW/JJUPFeD4Sp1Jhzkew2VVOrchRzykkfEnwMPF1QMrp5/8o97+gb
         yulVj64Hn5Dp3Ni7MC5biJqLIjZ1h2BljKmIe2+3Mah6P9HH9X70QaJ++IofdPik6nWC
         KrjarCWUNatTSvxgzWQz6Fi4pvuGHWVdWF/yQRBwKnTHOzcmybsjXMi4XRxLIvkHEdN6
         dmyQ==
X-Gm-Message-State: APf1xPB/+NnEGLohKX5ahjib9Fi/KijDt9+e502TCpl7tKbxwU7JSOmQ
        tvwkeXKZptSz8fISPaKjKB/BDA==
X-Google-Smtp-Source: AH8x2257t2HcpSvANpRDXf2JnOAdyCLz5k5JI4+cl4hn6YJT8Lh9wGWqhDmYVpsf6mEYdBJzjnIoAQ==
X-Received: by 10.223.179.194 with SMTP id x2mr3275495wrd.94.1519429209659;
        Fri, 23 Feb 2018 15:40:09 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:09 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/11] t: prevent '-x' tracing from interfering with test helpers' stderr
Date:   Sat, 24 Feb 2018 00:39:41 +0100
Message-Id: <20180223233951.11154-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running a test script with '-x' turns on 'set -x' tracing, the output
of which is normally sent to stderr.  This causes a lot of
test failures, because many tests redirect and verify the stderr
of shell functions, most frequently that of 'test_must_fail'.
These issues were worked around somewhat in d88785e424 (test-lib: set
BASH_XTRACEFD automatically, 2016-05-11), so at least we could
reliably run tests with '-x' tracing under a Bash version supporting
BASH_XTRACEFD, i.e. v4.1 and later.

This patch makes it safe to redirect and verify the stderr of those
test helper functions which are meant to run the tested command given
as argument, even when running tests with '-x' and /bin/sh.  This is
achieved through a couple of file descriptor redirections:

  - Duplicate stderr of the tested command executed in the test helper
    function from the function's fd 7 (see next point), to ensure that
    the tested command's error messages go to a different fd than the
    '-x' trace of the commands executed in the function.

  - Duplicate the test helper function's fd 7 from the function's
    original stderr, meaning that, after taking a detour through fd 7,
    the error messages of the tested command do end up on the
    function's original stderr.

  - Duplicate stderr of the test helper function from fd 4, i.e. the
    fd connected to the test script's original stderr and the fd used
    for BASH_XTRACEFD.  This ensures that the '-x' trace of the
    commands executed in the function

      - doesn't go to the function's original stderr, so it won't mess
	with callers who want to save and verify the tested command's
	stderr.

      - does go to the same fd independently from the shell running
        the test script, be it /bin/sh, an older Bash without
        BASH_XTRACEFD, or a more recent Bash already supporting
        BASH_XTRACEFD.

  - Specify the latter two redirections above in the test helper
    function's definition, so they are performed every time the
    function is invoked, without the need to modify the callsites of
    the function.

Perform these redirections in those test helper functions which can be
expected to have their stderr redirected, i.e. in the functions
'test_must_fail', 'test_might_fail', 'test_expect_code', 'test_env',
'nongit', 'test_terminal' and 'perl'.  Note that 'test_might_fail',
'test_env', and 'nongit' are not involved in any test failures when
running tests with '-x' and /bin/sh.

The other test helper functions are left unchanged, because they
either don't run commands specified as their arguments, or redirecting
their stderr wouldn't make sense, or both.

With this change the number of failures when running the test suite
with '-x' tracing and /bin/sh goes down from 340 failed tests in 43
test scripts to 22 failed tests in 6 scripts (or 23 in 7, if the
system (OSX) uses an older Bash version without BASH_XTRACEFD to run
't9903-bash-prompt.sh').

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-terminal.sh       |  4 ++--
 t/test-lib-functions.sh | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index cd220e378e..b3acb4c6f8 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -9,8 +9,8 @@ test_terminal () {
 		echo >&4 "test_terminal: need to declare TTY prerequisite"
 		return 127
 	fi
-	perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
-}
+	perl "$TEST_DIRECTORY"/test-terminal.perl "$@" 2>&9
+} 9>&2 2>&4
 
 test_lazy_prereq TTY '
 	test_have_prereq PERL &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 67b5994afb..37eb34044a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -621,7 +621,7 @@ test_must_fail () {
 		_test_ok=
 		;;
 	esac
-	"$@"
+	"$@" 2>&7
 	exit_code=$?
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
@@ -644,7 +644,7 @@ test_must_fail () {
 		return 1
 	fi
 	return 0
-}
+} 7>&2 2>&4
 
 # Similar to test_must_fail, but tolerates success, too.  This is
 # meant to be used in contexts like:
@@ -658,8 +658,8 @@ test_must_fail () {
 # because we want to notice if it fails due to segv.
 
 test_might_fail () {
-	test_must_fail ok=success "$@"
-}
+	test_must_fail ok=success "$@" 2>&7
+} 7>&2 2>&4
 
 # Similar to test_must_fail and test_might_fail, but check that a
 # given command exited with a given exit code. Meant to be used as:
@@ -671,7 +671,7 @@ test_might_fail () {
 test_expect_code () {
 	want_code=$1
 	shift
-	"$@"
+	"$@" 2>&7
 	exit_code=$?
 	if test $exit_code = $want_code
 	then
@@ -680,7 +680,7 @@ test_expect_code () {
 
 	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
 	return 1
-}
+} 7>&2 2>&4
 
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
@@ -882,8 +882,8 @@ test_write_lines () {
 }
 
 perl () {
-	command "$PERL_PATH" "$@"
-}
+	command "$PERL_PATH" "$@" 2>&7
+} 7>&2 2>&4
 
 # Is the value one of the various ways to spell a boolean true/false?
 test_normalize_bool () {
@@ -1023,13 +1023,13 @@ test_env () {
 				shift
 				;;
 			*)
-				"$@"
+				"$@" 2>&7
 				exit
 				;;
 			esac
 		done
 	)
-}
+} 7>&2 2>&4
 
 # Returns true if the numeric exit code in "$2" represents the expected signal
 # in "$1". Signals should be given numerically.
@@ -1071,9 +1071,9 @@ nongit () {
 		GIT_CEILING_DIRECTORIES=$(pwd) &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non-repo &&
-		"$@"
+		"$@" 2>&7
 	)
-}
+} 7>&2 2>&4
 
 # convert stdin to pktline representation; note that empty input becomes an
 # empty packet, not a flush packet (for that you can just print 0000 yourself).
-- 
2.16.2.400.g911b7cc0da

