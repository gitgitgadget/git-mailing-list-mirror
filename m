Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7B11F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeL3TRA (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:17:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53000 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeL3TQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:16:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so22374754wml.2
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8/r0oO6eHoGg3cpv4xPGFA40s7qMfU0r7XkY4txoUk=;
        b=ujMUbaf7c3HV35w5eseVHYl2y9y9auzYTG+ZGt7MfIobxHGYq+o8kBsFbqhH3uaoA2
         1EGlMrh8Hem7KTxazNtpkAAw1MXkU3gkqhT8hiuXHxioOmpnaEcOIVdlmRVgaPfgpboC
         Bl4I0JirvSnoVw81jETRziW9czglXFZKhyG9H5UDMkhvWw7dKuCUS0EIQENdD/oqDB9M
         pTQKNbtqB6pDEyb4tLqN7aPdKGHIwZ9praeg5lnS9wPf+o4DWPu+oV7iHGnN5urZI1UL
         Gh0NT+5WQ33VXaRJ7YafZ+5+VfypZZMNb6a5TdO6F9j9NFOjuRn58cjA84HzPqsDmh3F
         Rz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8/r0oO6eHoGg3cpv4xPGFA40s7qMfU0r7XkY4txoUk=;
        b=CsKEMUJrwv/ythv+FwGBSkN1LAL75s/Nvhiz3si6m+wbO/OIjCBYUkefYYCjmyt3NI
         KsUnbeDQnCM1WV2A/WXzka6mn4QCgJW3REA+DnHDI0+XNabPIFtYxiNrEqxJE92UZjT+
         OEDb3Zm8H3LxBvFZxmongpXEBpoaJJGnyWwaoNVAOg6aavehLGZaA8MBo562pT0aTPu0
         Tw4W2b2sYRFzgZH0C60IObnnbS8dHS7HNoeVv1QcQzuEXy9cUtVR2MDsaTyDtIIlgTeQ
         DI/LLx+AFDC9GweUHcBlztpE7e/eDyWuyUZMAxbQ8qI8GGs1dBFbjKq8hHWVFH+iM5Jy
         w49Q==
X-Gm-Message-State: AA+aEWb5CLU7waJbMhbNpAUfHs4QV4d31jxzFwik4/9FswGJ7bEE7cjC
        bdvV/ixcoCiRRAtFf9mQwxI=
X-Google-Smtp-Source: AFSGD/UDG/japE6LlNpCeXgPW2BnZghgrYmyeLYi27ztBpWzBLR07otFKihNyCsPsExgdTidguGBew==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr30577712wme.6.1546197414567;
        Sun, 30 Dec 2018 11:16:54 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id h62sm28954226wmf.11.2018.12.30.11.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 11:16:53 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/8] test-lib: parse command line options earlier
Date:   Sun, 30 Dec 2018 20:16:24 +0100
Message-Id: <20181230191629.3232-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230191629.3232-1-szeder.dev@gmail.com>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181230191629.3232-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'test-lib.sh' looks for the presence of certain options like '--tee'
and '--verbose-log', so it can execute the test script again to save
its standard output and error.  It looks for '--valgrind' as well, to
set up some Valgrind-specific stuff.  These all happen before the
actual option parsing loop, and the conditions looking for these
options look a bit odd, too.  They are not completely correct, either,
because in a bogus invocation like './t1234-foo.sh -r --tee' they
recognize '--tee', although it should be handled as the required
argument of the '-r' option.  This patch series will add two more
options to look out for early, and, in addition, will have to extract
these options' stuck arguments (i.e. '--opt=arg') as well.

So let's move the option parsing loop and the couple of related
conditions following it earlier in 'test-lib.sh', before the place
where the test script is executed again for '--tee' and its friends.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 228 ++++++++++++++++++++++++++------------------------
 1 file changed, 119 insertions(+), 109 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ed7267962f..fcc04afdff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -71,13 +71,125 @@ then
 	exit 1
 fi
 
+# Parse options while taking care to leave $@ intact, so we will still
+# have all the original command line options when executing the test
+# script again for '--tee' and '--verbose-log' below.
+store_arg_to=
+prev_opt=
+for opt
+do
+	if test -n "$store_arg_to"
+	then
+		eval $store_arg_to=\$opt
+		store_arg_to=
+		prev_opt=
+		continue
+	fi
+
+	case "$opt" in
+	-d|--d|--de|--deb|--debu|--debug)
+		debug=t ;;
+	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
+		immediate=t ;;
+	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
+		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
+	-r)
+		store_arg_to=run_list
+		;;
+	--run=*)
+		run_list=${opt#--*=} ;;
+	-h|--h|--he|--hel|--help)
+		help=t ;;
+	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
+		verbose=t ;;
+	--verbose-only=*)
+		verbose_only=${opt#--*=}
+		;;
+	-q|--q|--qu|--qui|--quie|--quiet)
+		# Ignore --quiet under a TAP::Harness. Saying how many tests
+		# passed without the ok/not ok details is always an error.
+		test -z "$HARNESS_ACTIVE" && quiet=t ;;
+	--with-dashes)
+		with_dashes=t ;;
+	--no-color)
+		color= ;;
+	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
+		valgrind=memcheck
+		tee=t
+		;;
+	--valgrind=*)
+		valgrind=${opt#--*=}
+		tee=t
+		;;
+	--valgrind-only=*)
+		valgrind_only=${opt#--*=}
+		tee=t
+		;;
+	--tee)
+		tee=t ;;
+	--root=*)
+		root=${opt#--*=} ;;
+	--chain-lint)
+		GIT_TEST_CHAIN_LINT=1 ;;
+	--no-chain-lint)
+		GIT_TEST_CHAIN_LINT=0 ;;
+	-x)
+		# Some test scripts can't be reliably traced  with '-x',
+		# unless the test is run with a Bash version supporting
+		# BASH_XTRACEFD (introduced in Bash v4.1).  Check whether
+		# this test is marked as such, and ignore '-x' if it
+		# isn't executed with a suitable Bash version.
+		if test -z "$test_untraceable" || {
+		     test -n "$BASH_VERSION" && {
+		       test ${BASH_VERSINFO[0]} -gt 4 || {
+			 test ${BASH_VERSINFO[0]} -eq 4 &&
+			 test ${BASH_VERSINFO[1]} -ge 1
+		       }
+		     }
+		   }
+		then
+			trace=t
+		else
+			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		fi
+		;;
+	-V|--verbose-log)
+		verbose_log=t
+		tee=t
+		;;
+	*)
+		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
+	esac
+
+	prev_opt=$opt
+done
+if test -n "$store_arg_to"
+then
+	echo "error: $prev_opt requires an argument" >&2
+	exit 1
+fi
+
+if test -n "$valgrind_only"
+then
+	test -z "$valgrind" && valgrind=memcheck
+	test -z "$verbose" && verbose_only="$valgrind_only"
+elif test -n "$valgrind"
+then
+	test -z "$verbose_log" && verbose=t
+fi
+
+if test -n "$trace" && test -z "$verbose_log"
+then
+	verbose=t
+fi
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
-case "$GIT_TEST_TEE_STARTED, $* " in
-done,*)
-	# do not redirect again
-	;;
-*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)
+if test "$GIT_TEST_TEE_STARTED" = "done"
+then
+	: # do not redirect again
+elif test -n "$tee"
+then
 	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
 	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
 
@@ -94,8 +206,7 @@ done,*)
 	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$BASE.exit")" = 0
 	exit
-	;;
-esac
+fi
 
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
@@ -193,7 +304,7 @@ fi
 
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
-if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
+if test -n "$valgrind" ||
    test -n "$TEST_NO_MALLOC_CHECK"
 then
 	setup_malloc_check () {
@@ -264,107 +375,6 @@ test "x$TERM" != "xdumb" && (
 	) &&
 	color=t
 
-store_arg_to=
-prev_opt=
-for opt
-do
-	if test -n "$store_arg_to"
-	then
-		eval $store_arg_to=\$opt
-		store_arg_to=
-		prev_opt=
-		continue
-	fi
-
-	case "$opt" in
-	-d|--d|--de|--deb|--debu|--debug)
-		debug=t ;;
-	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
-		immediate=t ;;
-	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
-	-r)
-		store_arg_to=run_list
-		;;
-	--run=*)
-		run_list=${opt#--*=} ;;
-	-h|--h|--he|--hel|--help)
-		help=t ;;
-	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-		verbose=t ;;
-	--verbose-only=*)
-		verbose_only=${opt#--*=}
-		;;
-	-q|--q|--qu|--qui|--quie|--quiet)
-		# Ignore --quiet under a TAP::Harness. Saying how many tests
-		# passed without the ok/not ok details is always an error.
-		test -z "$HARNESS_ACTIVE" && quiet=t ;;
-	--with-dashes)
-		with_dashes=t ;;
-	--no-color)
-		color= ;;
-	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
-		valgrind=memcheck ;;
-	--valgrind=*)
-		valgrind=${opt#--*=} ;;
-	--valgrind-only=*)
-		valgrind_only=${opt#--*=} ;;
-	--tee)
-		;; # was handled already
-	--root=*)
-		root=${opt#--*=} ;;
-	--chain-lint)
-		GIT_TEST_CHAIN_LINT=1 ;;
-	--no-chain-lint)
-		GIT_TEST_CHAIN_LINT=0 ;;
-	-x)
-		# Some test scripts can't be reliably traced  with '-x',
-		# unless the test is run with a Bash version supporting
-		# BASH_XTRACEFD (introduced in Bash v4.1).  Check whether
-		# this test is marked as such, and ignore '-x' if it
-		# isn't executed with a suitable Bash version.
-		if test -z "$test_untraceable" || {
-		     test -n "$BASH_VERSION" && {
-		       test ${BASH_VERSINFO[0]} -gt 4 || {
-			 test ${BASH_VERSINFO[0]} -eq 4 &&
-			 test ${BASH_VERSINFO[1]} -ge 1
-		       }
-		     }
-		   }
-		then
-			trace=t
-		else
-			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
-		fi
-		;;
-	-V|--verbose-log)
-		verbose_log=t ;;
-	*)
-		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
-	esac
-
-	prev_opt=$opt
-done
-if test -n "$store_arg_to"
-then
-	echo "error: $prev_opt requires an argument" >&2
-	exit 1
-fi
-
-if test -n "$valgrind_only"
-then
-	test -z "$valgrind" && valgrind=memcheck
-	test -z "$verbose" && verbose_only="$valgrind_only"
-elif test -n "$valgrind"
-then
-	test -z "$verbose_log" && verbose=t
-fi
-
-if test -n "$trace" && test -z "$verbose_log"
-then
-	verbose=t
-fi
-
 if test -n "$color"
 then
 	# Save the color control sequences now rather than run tput
-- 
2.20.1.151.gec613c4b75

