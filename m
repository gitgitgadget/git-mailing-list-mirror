Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDCCC4332D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2D165285
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhCIQCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhCIQCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C81C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w11so16656577wrr.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+Ksm+YXLDSylV2IZUtt9+e7WSzRLpN5BWoBT21KnyA=;
        b=pVEmHyfDS4z+eQPCzJGFzGexRhB9eU0wlQLBsDSp3dkVIWg4HCRdNwi0TS0ZMDtr7O
         0WS8zlyO1wO7FPGEX/2tOYVE1iRSOWbRmFRw3cEMPF8VaS/hXch22JpEh/oMyCneG/5v
         /RhlqX2AT7PesdUe+igezSvoqRS8sa80hU7/Sp+24W6PYye8C9mevOlHQ1X5gwjP26CY
         97FcnsyEdTB/5wdiJf/OBCloAUZfIeZKr+kRgaQdrDHB1To33pkGgdw6fcSKdRGyJQi5
         56FPM+iGQD0HEeHs5ycjTX+QoNIzcO5v55o5Cf9w9oIz04ZaJvLvFCxw7m8xSUryakbk
         UzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+Ksm+YXLDSylV2IZUtt9+e7WSzRLpN5BWoBT21KnyA=;
        b=SGneAPqbumakhSULQMYS+JHiMrfeN/7bvJtOOm4e1VnSq2tknYBIE9HjKtUpHmZ2hc
         BwUQtziBWtI59EfWG3Pu6iRE/hXOfrtAy6GrBOP3h0uWJeoM/m59JL/YQdW/b5Xb6anu
         OozCH/4QqosH2fV53AYA7PzzWnOdqiicd39jdpqK2ESzDETAiKs7wDx47pRx9TD0AllE
         pFphaLn8LgJePCgG8fBJ62C+3qICaITZfYv0YxiQsNuLbSMRqOsp7I+vKDvIRfkohixZ
         DnuAUEyGiqfT9N7trnloC4gcD4C2LKM+eUax/NyQjY6QxhF6gkdhK7WSsoFktn8whBAT
         m29Q==
X-Gm-Message-State: AOAM533QhI8d/fOtHCswyu9ehcvpPgTnYyyRwD61+4DFNE9wAjgozP/r
        fyo/IQ5jrxTlqH00Vv3PaOj5AT/+/VL8VQ==
X-Google-Smtp-Source: ABdhPJy9HrWgT2YSlGeofV9xpEwg1ZyF/23Zox8bNlanarlW8su/CAMc3uaKpVijkPCH1MPSTXYZpQ==
X-Received: by 2002:a5d:591a:: with SMTP id v26mr5042971wrd.172.1615305752424;
        Tue, 09 Mar 2021 08:02:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] test-lib: remove test_external
Date:   Tue,  9 Mar 2021 17:02:13 +0100
Message-Id: <20210309160219.13779-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the test_external function(s) in favor of running the Perl
tests with a test_expect_success.

The only advantage of this wrapper added in
fb32c410087 (t/test-lib.sh: add test_external and
test_external_without_stderr, 2008-06-19) was that we got the
Test::More output as-is from the two wrapped scripts.

Now we'll instead hang until the script is finished, and report on its
exit code. The Test::More framework ensures that we exit with non-zero
exit code on failure.

My motivation for this is to eliminate a special case where things
that aren't test-lib.sh are going to produce TAP, for reasons that'll
be clear in subsequent commits.

This also eliminates special cases I added in d998bd4ab67 (test-lib:
Make the test_external_* functions TAP-aware, 2010-06-24) from
test-lib.sh itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../netrc/t-git-credential-netrc.sh           |  7 +-
 t/README                                      | 26 ------
 t/t0202-gettext-perl.sh                       | 10 +--
 t/t9700-perl-git.sh                           | 10 +--
 t/test-lib-functions.sh                       | 89 +------------------
 t/test-lib.sh                                 | 42 ++++-----
 6 files changed, 28 insertions(+), 156 deletions(-)

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index 07227d02287..28118a9e194 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -20,13 +20,10 @@
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
index 593d4a4e270..2cc8cbc7185 100644
--- a/t/README
+++ b/t/README
@@ -844,32 +844,6 @@ library for your script to use.
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
index a29d166e007..06a93b36790 100755
--- a/t/t0202-gettext-perl.sh
+++ b/t/t0202-gettext-perl.sh
@@ -17,11 +17,9 @@ perl -MTest::More -e 0 2>/dev/null || {
 	test_done
 }
 
-# The external test will outputs its own plan
-test_external_has_tap=1
-
-test_external_without_stderr \
-    'Perl Git::I18N API' \
-    perl "$TEST_DIRECTORY"/t0202/test.pl
+test_expect_success 'run t0202/test.pl to test Git::I18N.pm' '
+	perl "$TEST_DIRECTORY"/t0202/test.pl 2>stderr &&
+	test_must_be_empty stderr
+'
 
 test_done
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 102c133112c..574c57b17f1 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -50,11 +50,9 @@ test_expect_success \
      git config --add test.pathmulti bar
      '
 
-# The external test will outputs its own plan
-test_external_has_tap=1
-
-test_external_without_stderr \
-    'Perl API' \
-    perl "$TEST_DIRECTORY"/t9700/test.pl
+test_expect_success 'use t9700/test.pl to test Git.pm' '
+	perl "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
+	test_must_be_empty stderr
+'
 
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3dd68091bbf..ead3afb36b3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -468,7 +468,7 @@ write_script () {
 # - Explicitly using test_have_prereq.
 #
 # - Implicitly by specifying the prerequisite tag in the calls to
-#   test_expect_{success,failure} and test_external{,_without_stderr}.
+#   test_expect_{success,failure}
 #
 # The single parameter is the prerequisite tag (a simple word, in all
 # capital letters by convention).
@@ -660,93 +660,6 @@ test_expect_success () {
 	return 1
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
index d3f6af6a654..b0a8bc42510 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -631,8 +631,6 @@ test_fixed=0
 test_broken=0
 test_success=0
 
-test_external_has_tap=0
-
 die () {
 	code=$?
 	# This is responsible for running the atexit commands even when a
@@ -1146,27 +1144,24 @@ test_done () {
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
 		if test -z "$debug"
 		then
 			test -d "$TRASH_DIRECTORY" ||
@@ -1185,11 +1180,8 @@ test_done () {
 		exit 0 ;;
 
 	*)
-		if test $test_external_has_tap -eq 0
-		then
-			say_color error "# failed $test_failure among $msg"
-			say "1..$test_count"
-		fi
+		say_color error "# failed $test_failure among $msg"
+		say "1..$test_count"
 
 		exit 1 ;;
 
-- 
2.31.0.rc1.210.g0f8085a843c

