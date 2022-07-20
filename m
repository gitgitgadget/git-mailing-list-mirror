Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC131C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiGTVWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiGTVWV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727B5A8B7
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv24so3988360wrb.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAXPWpbUUl7YugwoWoAkCwhGTuGd/z8IXhtjybx6L/I=;
        b=qE75CWhBCVGqX/22fb+eOLL1IyPIL4emryqD+/0QzM1Q/uTyjK/OaFoquDC7P82veF
         Rtbx6hKAROuwUQxgcu4xqZD4kvtT2BeKMRT3o5ksEhQqNjHmV6f7L7xfHqspPoe7U3qm
         KW0ea2DUOtzfZGwKhGXEaHqH2OlrUMiphBrlXhFY+Q8Z3gESPsl5IQQSzixWlV8RmkE8
         LvjWgdWUfQDbyeGmg6HTMNLvA98PfALBP4B9RGAaZSaWhs8CkcVDA+W3UJDiY+4wvJ4D
         eDklC8j3GGrIFGWqnmVFYG4KwrWIJzvOsRgF1rb7OdQMlknPP3Df0nr65VzE3IsZSBQD
         R8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAXPWpbUUl7YugwoWoAkCwhGTuGd/z8IXhtjybx6L/I=;
        b=3IiZMBXRSLxIQ/DZPM1LY3gAolv2gUpiKlKzTVYX6QWexm9myt47HCGS3Elm6ZjXPD
         xTSK7Qxynskt/sg8mf7enk9F2WwXEuzpTeJz7uE6tq7GIKFagl+A5dTyi7m2qP8Gd/23
         R9BmVCIfKOwOTKiKWIfjnS5ayB+UcnSmmjyHzbfnyCgg1DRFJnK5u/0SXJa/0ZMBUwu6
         t/lBBMjHncV7n+D115IjzDnXhHbxRiGfmem+DS1FaJAbppOgZbPnT698w3u+rcBBQ4l0
         0s5U7bGG/ecE+Sv6ZepHiRe40utQ00/x7+EDT0O2ZyCYMWD9tDZzrAGIDmJCqLJKzhsi
         QCNQ==
X-Gm-Message-State: AJIora/wBzmGr3F/DBoFAtXFOgXnoe261pX4nfB9u6lKyZM2uYk1veCB
        Dd2nOfyBUv8luqfRi0ugXGd4Kn2sH29qmw==
X-Google-Smtp-Source: AGRyM1uEwtQq9x8MtjyAg12wjy32rsqtu2/68ow8bbiRZMRJd9JLZGg2rdyjH9safab8wy64feCOqQ==
X-Received: by 2002:a5d:64cc:0:b0:21d:a4bd:fdbe with SMTP id f12-20020a5d64cc000000b0021da4bdfdbemr31971852wri.580.1658352136537;
        Wed, 20 Jul 2022 14:22:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/14] test-lib: simplify by removing test_external
Date:   Wed, 20 Jul 2022 23:21:47 +0200
Message-Id: <patch-v2-09.14-20bd31615e4-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "test_external" function added in [1]. This arguably makes
the output of t9700-perl-git.sh and friends worse. But as we'll argue
below the trade-off is worth it, since "chaining" to another TAP
emitter in test-lib.sh is more trouble than it's worth.

The new output of t9700-perl-git.sh is now:

	$ ./t9700-perl-git.sh
	ok 1 - set up test repository
	ok 2 - use t9700/test.pl to test Git.pm
	# passed all 2 test(s)
	1..2

Whereas before this change it would be:

	$ ./t9700-perl-git.sh
	ok 1 - set up test repository
	# run 1: Perl API (perl /home/avar/g/git/t/t9700/test.pl)
	ok 2 - use Git;
	[... omitting tests 3..46 from t/t9700/test.pl ...]
	ok 47 - unquote escape sequences
	1..47
	# test_external test Perl API was ok
	# test_external_without_stderr test no stderr: Perl API was ok

At the time of its addition supporting "test_external" was easy, but
when test-lib.sh itself started to emit TAP in [2] we needed to make
everything surrounding the emission of the plan consider
"test_external". I added that support in [2] so that we could run:

	prove ./t9700-perl-git.sh :: -v

But since then in [3] the door has been closed on combining
$HARNESS_ACTIVE and -v, we'll now just die:

	$ prove ./t9700-perl-git.sh :: -v
	Bailout called.  Further testing stopped:  verbose mode forbidden under TAP harness; try --verbose-log
	FAILED--Further testing stopped: verbose mode forbidden under TAP harness; try --verbose-log

So the only use of this has been that *if* we had failure in one of
these tests we could e.g. in CI see which test failed based on the
test number. Now we'll need to look at the full verbose logs to get
that same information.

I think this trade-off is acceptable given the reduction in
complexity, and it brings these tests in line with other similar
tests, e.g. the reftable tests added in [4] will be condensed down to
just one test, which invokes the C helper:

	$ ./t0032-reftable-unittest.sh
	ok 1 - unittests
	# passed all 1 test(s)
	1..1

It would still be nice to have that ":: -v" form work again, it
never *really* worked, but even though we've had edge cases test
output screwing up the TAP it mostly worked between d998bd4ab67 and
[3], so we may have been overzealous in forbidding it outright.

I have local patches which I'm planning to submit sooner than later
that get us to that goal, and in a way that isn't buggy. In the
meantime getting rid of this special case makes hacking on this area
of test-lib.sh easier, as we'll do in subsequent commits.

The switch from "perl" to "$PERL_PATH" here is because "perl" is
defined as a shell function in the test suite, see a5bf824f3b4 (t:
prevent '-x' tracing from interfering with test helpers' stderr,
2018-02-25). On e.g. the OSX CI the "command perl"... will be part of
the emitted stderr.

1. fb32c410087 (t/test-lib.sh: add test_external and
   test_external_without_stderr, 2008-06-19)
2. d998bd4ab67 (test-lib: Make the test_external_* functions
   TAP-aware, 2010-06-24)
3. 614fe015212 (test-lib: bail out when "-v" used under
   "prove", 2016-10-22)
4. ef8a6c62687 (reftable: utility functions, 2021-10-07)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../netrc/t-git-credential-netrc.sh           |  7 +-
 t/README                                      | 26 ------
 t/t0202-gettext-perl.sh                       | 10 +--
 t/t9700-perl-git.sh                           | 10 +--
 t/test-lib-functions.sh                       | 89 +------------------
 t/test-lib.sh                                 | 40 ++++-----
 6 files changed, 28 insertions(+), 154 deletions(-)

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index ff17a9460cd..bf2777308a5 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -13,13 +13,10 @@
 		'set up test repository' \
 		'git config --add gpg.program test.git-config-gpg'
 
-	# The external test will outputs its own plan
-	test_external_has_tap=1
-
 	export PERL5LIB="$GITPERLLIB"
-	test_external \
-		'git-credential-netrc' \
+	test_expect_success 'git-credential-netrc' '
 		perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl
+	'
 
 	test_done
 )
diff --git a/t/README b/t/README
index 0664aee7ed9..98f69ed13d2 100644
--- a/t/README
+++ b/t/README
@@ -938,32 +938,6 @@ see test-lib-functions.sh for the full list and their options.
 	    test_done
 	fi
 
- - test_external [<prereq>] <message> <external> <script>
-
-   Execute a <script> with an <external> interpreter (like perl). This
-   was added for tests like t9700-perl-git.sh which do most of their
-   work in an external test script.
-
-	test_external \
-	    'GitwebCache::*FileCache*' \
-	    perl "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
-
-   If the test is outputting its own TAP you should set the
-   test_external_has_tap variable somewhere before calling the first
-   test_external* function. See t9700-perl-git.sh for an example.
-
-	# The external test will outputs its own plan
-	test_external_has_tap=1
-
- - test_external_without_stderr [<prereq>] <message> <external> <script>
-
-   Like test_external but fail if there's any output on stderr,
-   instead of checking the exit code.
-
-	test_external_without_stderr \
-	    'Perl API' \
-	    perl "$TEST_DIRECTORY"/t9700/test.pl
-
  - test_expect_code <exit-code> <command>
 
    Run a command and ensure that it exits with the given exit code.
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
index 043b190626c..5a6f28051bd 100755
--- a/t/t0202-gettext-perl.sh
+++ b/t/t0202-gettext-perl.sh
@@ -10,11 +10,9 @@ TEST_PASSES_SANITIZE_LEAK=true
 . "$TEST_DIRECTORY"/lib-perl.sh
 skip_all_if_no_Test_More
 
-# The external test will outputs its own plan
-test_external_has_tap=1
-
-test_external_without_stderr \
-    'Perl Git::I18N API' \
-    perl "$TEST_DIRECTORY"/t0202/test.pl
+test_expect_success 'run t0202/test.pl to test Git::I18N.pm' '
+	"$PERL_PATH" "$TEST_DIRECTORY"/t0202/test.pl 2>stderr &&
+	test_must_be_empty stderr
+'
 
 test_done
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 17fc43f6e57..a48fac6f07a 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -43,11 +43,9 @@ test_expect_success \
      git config --add test.pathmulti bar
      '
 
-# The external test will outputs its own plan
-test_external_has_tap=1
-
-test_external_without_stderr \
-    'Perl API' \
-    perl "$TEST_DIRECTORY"/t9700/test.pl
+test_expect_success 'use t9700/test.pl to test Git.pm' '
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
+	test_must_be_empty stderr
+'
 
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5..869595d4cee 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -633,7 +633,7 @@ test_hook () {
 # - Explicitly using test_have_prereq.
 #
 # - Implicitly by specifying the prerequisite tag in the calls to
-#   test_expect_{success,failure} and test_external{,_without_stderr}.
+#   test_expect_{success,failure}
 #
 # The single parameter is the prerequisite tag (a simple word, in all
 # capital letters by convention).
@@ -836,93 +836,6 @@ test_expect_success () {
 	test_finish_
 }
 
-# test_external runs external test scripts that provide continuous
-# test output about their progress, and succeeds/fails on
-# zero/non-zero exit code.  It outputs the test output on stdout even
-# in non-verbose mode, and announces the external script with "# run
-# <n>: ..." before running it.  When providing relative paths, keep in
-# mind that all scripts run in "trash directory".
-# Usage: test_external description command arguments...
-# Example: test_external 'Perl API' perl ../path/to/test.pl
-test_external () {
-	test "$#" = 4 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 3 ||
-	BUG "not 3 or 4 parameters to test_external"
-	descr="$1"
-	shift
-	test_verify_prereq
-	export test_prereq
-	if ! test_skip "$descr" "$@"
-	then
-		# Announce the script to reduce confusion about the
-		# test output that follows.
-		say_color "" "# run $test_count: $descr ($*)"
-		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
-		# to be able to use them in script
-		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
-		# Run command; redirect its stderr to &4 as in
-		# test_run_, but keep its stdout on our stdout even in
-		# non-verbose mode.
-		"$@" 2>&4
-		if test "$?" = 0
-		then
-			if test $test_external_has_tap -eq 0; then
-				test_ok_ "$descr"
-			else
-				say_color "" "# test_external test $descr was ok"
-				test_success=$(($test_success + 1))
-			fi
-		else
-			if test $test_external_has_tap -eq 0; then
-				test_failure_ "$descr" "$@"
-			else
-				say_color error "# test_external test $descr failed: $@"
-				test_failure=$(($test_failure + 1))
-			fi
-		fi
-	fi
-}
-
-# Like test_external, but in addition tests that the command generated
-# no output on stderr.
-test_external_without_stderr () {
-	# The temporary file has no (and must have no) security
-	# implications.
-	tmp=${TMPDIR:-/tmp}
-	stderr="$tmp/git-external-stderr.$$.tmp"
-	test_external "$@" 4> "$stderr"
-	test -f "$stderr" || error "Internal error: $stderr disappeared."
-	descr="no stderr: $1"
-	shift
-	say >&3 "# expecting no stderr from previous command"
-	if test ! -s "$stderr"
-	then
-		rm "$stderr"
-
-		if test $test_external_has_tap -eq 0; then
-			test_ok_ "$descr"
-		else
-			say_color "" "# test_external_without_stderr test $descr was ok"
-			test_success=$(($test_success + 1))
-		fi
-	else
-		if test "$verbose" = t
-		then
-			output=$(echo; echo "# Stderr is:"; cat "$stderr")
-		else
-			output=
-		fi
-		# rm first in case test_failure exits.
-		rm "$stderr"
-		if test $test_external_has_tap -eq 0; then
-			test_failure_ "$descr" "$@" "$output"
-		else
-			say_color error "# test_external_without_stderr test $descr failed: $@: $output"
-			test_failure=$(($test_failure + 1))
-		fi
-	fi
-}
-
 # debugging-friendly alternatives to "test [-f|-d|-e]"
 # The commands test the existence or non-existence of $1
 test_path_is_file () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f5150400c14..453d980bcf7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1231,27 +1231,24 @@ test_done () {
 	fi
 	case "$test_failure" in
 	0)
-		if test $test_external_has_tap -eq 0
+		if test $test_remaining -gt 0
 		then
-			if test $test_remaining -gt 0
-			then
-				say_color pass "# passed all $msg"
-			fi
-
-			# Maybe print SKIP message
-			test -z "$skip_all" || skip_all="# SKIP $skip_all"
-			case "$test_count" in
-			0)
-				say "1..$test_count${skip_all:+ $skip_all}"
-				;;
-			*)
-				test -z "$skip_all" ||
-				say_color warn "$skip_all"
-				say "1..$test_count"
-				;;
-			esac
+			say_color pass "# passed all $msg"
 		fi
 
+		# Maybe print SKIP message
+		test -z "$skip_all" || skip_all="# SKIP $skip_all"
+		case "$test_count" in
+		0)
+			say "1..$test_count${skip_all:+ $skip_all}"
+			;;
+		*)
+			test -z "$skip_all" ||
+			say_color warn "$skip_all"
+			say "1..$test_count"
+			;;
+		esac
+
 		if test -n "$stress" && test -n "$invert_exit_code"
 		then
 			# We're about to move our "$TRASH_DIRECTORY"
@@ -1286,11 +1283,8 @@ test_done () {
 		exit 0 ;;
 
 	*)
-		if test $test_external_has_tap -eq 0
-		then
-			say_color error "# failed $test_failure among $msg"
-			say "1..$test_count"
-		fi
+		say_color error "# failed $test_failure among $msg"
+		say "1..$test_count"
 
 		if test -n "$invert_exit_code"
 		then
-- 
2.37.1.1064.gc96144cf387

