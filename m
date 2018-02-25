Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E861F404
	for <e@80x24.org>; Sun, 25 Feb 2018 13:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBYNk3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 08:40:29 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:50643 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeBYNk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 08:40:27 -0500
Received: by mail-wm0-f53.google.com with SMTP id w128so6685432wmw.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9tt/b8mQk93A0HUTJDks1sG1VUZqnnWmriMM8D8vEck=;
        b=JXYaxQ6/XhnW3jAgZbNhG4SLKnrZ6urKRdijebK4Pfx953qssKPY1a5TNBTfPD0Ei5
         po5KExc+68ex/cYb3p4fYoIG7bnGI4iw7raGIQrPAm2ng73WzXNO5dnauSv5vjoeS0VK
         1+sUUqrmC0bQGKj9t435/JgVntvTcwTqodnOuvIq+PMofHUz29rjhQMOQslY6OwfC5jM
         pRGlmDTWEYvybvo6m2RS6zJIizOMgxplwGMtJo5w2QLpMhR+Sb6zOpgnXCRukIGTZEDI
         glNmjiyjDm9wP6nA0EInida8k8cWoFtlMTSPqqxFC7WIor4e+0uzNoR9qRObr4sh5MeR
         uoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tt/b8mQk93A0HUTJDks1sG1VUZqnnWmriMM8D8vEck=;
        b=qpvS1dDtpSAToyD3je/ycV0jWfVTAfvmHZS+IippmRwURoKghle3mFBEJ5DUk4hUBF
         tIxDYS1wzlUIm4hgo5jyXcdpVpkxSc7UrNQpT5TVf+nEwiUQZyu5a58xeeNlU68iIGNZ
         iwoifZZIiDaUxpDZBMUDGcww9zjXSKJj7QJEzN59ZDit+u55ShTP5EKHYErxYJSM9Zef
         Ky0gCdxjsL7vwYODVZyFRtqAZe26wVc0/ezGIEQN3pKS69zTwMTEz1gRisitkrT7O/20
         hOGoxlR+WXLQ+5V4lkz0UeIesYZhHjERY10Ky0zceD1dU7nAN07vg7CNlv7HlyjNHpzz
         66og==
X-Gm-Message-State: APf1xPBEEa6Jl/f+noxWe9C+ayHhB1QoE0XBOPy8QP4ir8ddmHqX3cDH
        ZydgnXlfetplE5am0/V1zq32jg==
X-Google-Smtp-Source: AG47ELu/z2hSz4FymnRaBjzvjlftimbx900fPUa+XGNjAoA5wMnGWzAqfCER3rGhi2TepYYYdA9WpA==
X-Received: by 10.28.29.209 with SMTP id d200mr6511492wmd.149.1519566026117;
        Sun, 25 Feb 2018 05:40:26 -0800 (PST)
Received: from localhost.localdomain (x4db04091.dyn.telefonica.de. [77.176.64.145])
        by smtp.gmail.com with ESMTPSA id r70sm6985769wmg.30.2018.02.25.05.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Feb 2018 05:40:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1.1] t: prevent '-x' tracing from interfering with test helpers' stderr
Date:   Sun, 25 Feb 2018 14:40:15 +0100
Message-Id: <20180225134015.26964-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.409.g7f85f628cc
In-Reply-To: <20180223233951.11154-2-szeder.dev@gmail.com>
References: <20180223233951.11154-2-szeder.dev@gmail.com>
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

Futhermore, redirecting the stderr of test helper functions like
'test_must_fail' or 'test_expect_code' is the cause of a different
issue as well.  If these functions detect something unexpected, they
will write their error messages intended to the user to thier stderr.
However, if their stderr is redirected in order to save and verify the
stderr of the tested git command invoked in the function, then the
function's error messages will be redirected as well.  Consequently,
those messages won't reach the user, making the test's verbose output
less useful.

This patch makes it safe to redirect and verify the stderr of those
test helper functions which are meant to run the tested command given
as argument, even when running tests with '-x' and /bin/sh.  This is
achieved through a couple of file descriptor redirections:

  - Duplicate stderr of the tested command executed in the test helper
    function from the function's fd 7 (see next point), to ensure that
    the tested command's error messages go to a different fd than the
    '-x' trace of the commands executed in the function or the
    function's error messages.

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

    Furthermore, this also makes sure that the function's error
    messages go to this fd 4, meaning that the user will be able to
    see them even if the function's stderr is redirected in the test.

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

Changes:

  - Duplicate from/to fd 7 instead of fd 9 in 'test_terminal'.

  - Talk about the issue that redirecting stderr of test helper
    functions affect their error messages as well, and how this patch
    resolves that issue as well.

 t/lib-terminal.sh       |  4 ++--
 t/test-lib-functions.sh | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index cd220e378e..e3809dcead 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -9,8 +9,8 @@ test_terminal () {
 		echo >&4 "test_terminal: need to declare TTY prerequisite"
 		return 127
 	fi
-	perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
-}
+	perl "$TEST_DIRECTORY"/test-terminal.perl "$@" 2>&7
+} 7>&2 2>&4
 
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
2.16.2.409.g7f85f628cc

