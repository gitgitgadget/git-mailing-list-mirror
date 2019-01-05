Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5981F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 01:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfAEBJW (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 20:09:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33757 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfAEBJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 20:09:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so38108918wrr.0
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 17:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpHao84H9jzB6k+Yhqwj2y5rALT+/4x6sISC+BRZi4o=;
        b=fGmE5sY20iU+RwxG0C8rUHgV3PMhKVtcl8yzy72soD3jWME+N9yhNUe7bNdx/xk6qd
         kNGRQLXKjDVqwoBPXLbGmkfgPnm1Fvv9OVHKT7Yf/x7f7Or8I1up6hCjnOdQJnG5v3Pd
         Qj28hHQQVvM1E6eV599kSTKJp8MwbP1ZUcisWelB5QP8JW3cdxxZLQ2WbZGijmJSbaTq
         u5rgzJlDkWQGddWT9HrEfznPk2nqQ3xR0Tj/w1H3hxciYXZ4PuZc6o0Il+IDWYI526ZV
         kneYgOUkg0YtAi0TgPde0+TSClrl6tnqX9kPrtgYBDUvHAChdsn8nh/Mr6B3SM3ticAn
         Ryjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpHao84H9jzB6k+Yhqwj2y5rALT+/4x6sISC+BRZi4o=;
        b=IKWN1MvvQFcxeCtzU1YT3j+eBOYpq3kRdji064pW5VDwxL4o6DAv8Z+fwo7g72pZgD
         nhtI1cRkkhgtz43G+eVFXIKRe5ME7CrlwsCO7nSER+2hIh41yi4RFCzC4saStmsyA+/z
         vP2o7gKFmDuiuknT2mdqNLdHoaEAnpc1ob/vmWc01G+R1V2WnnltEDvDOo8mpKC3TV9p
         P4jOpFbrbsaIbmRnhW6oH/iuOFU7cwP2WLUJ/kuA371cdVNt+eBAx8CkVzLee0jVQHb2
         HdDCfequXeZwAsh0fbX0LfThXJP6g58iX93QGwqjCFytZZJvlSpSzUtPbeFihYQqEXcd
         DOJw==
X-Gm-Message-State: AJcUukeAag+j9U2/TgcW/HMo4tdAAq9k8PyCgrM5TE6zrvGv2siA99bE
        q2HpVJFcc1gththViSN0+f0=
X-Google-Smtp-Source: ALg8bN4G+pC8ZlK1JWdamMr0GsidsfkYB17dHZKD3ycEzWXJ4S9ebsh4zVjMUwaQu2ogOn5kNVBSpQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr43814461wrm.328.1546650558212;
        Fri, 04 Jan 2019 17:09:18 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id c15sm1851353wml.27.2019.01.04.17.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 17:09:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 4/8] test-lib: parse command line options earlier
Date:   Sat,  5 Jan 2019 02:08:55 +0100
Message-Id: <20190105010859.11031-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20190105010859.11031-1-szeder.dev@gmail.com>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
 <20190105010859.11031-1-szeder.dev@gmail.com>
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
 t/test-lib.sh | 233 +++++++++++++++++++++++++++-----------------------
 1 file changed, 124 insertions(+), 109 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3cf59a92f0..14ccb60838 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -71,13 +71,102 @@ then
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
+		trace=t ;;
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
 
@@ -94,8 +183,35 @@ done,*)
 	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$BASE.exit")" = 0
 	exit
-	;;
-esac
+fi
+
+if test -n "$trace" && test -n "$test_untraceable"
+then
+	# '-x' tracing requested, but this test script can't be reliably
+	# traced, unless it is run with a Bash version supporting
+	# BASH_XTRACEFD (introduced in Bash v4.1).
+	#
+	# Perform this version check _after_ the test script was
+	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
+	# '--verbose-log', so the right shell is checked and the
+	# warning is issued only once.
+	if test -n "$BASH_VERSION" && eval '
+	     test ${BASH_VERSINFO[0]} -gt 4 || {
+	       test ${BASH_VERSINFO[0]} -eq 4 &&
+	       test ${BASH_VERSINFO[1]} -ge 1
+	     }
+	   '
+	then
+		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
+	else
+		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		trace=
+	fi
+fi
+if test -n "$trace" && test -z "$verbose_log"
+then
+	verbose=t
+fi
 
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
@@ -193,7 +309,7 @@ fi
 
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
-if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
+if test -n "$valgrind" ||
    test -n "$TEST_NO_MALLOC_CHECK"
 then
 	setup_malloc_check () {
@@ -264,107 +380,6 @@ test "x$TERM" != "xdumb" && (
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
-		trace=t ;;
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
-if test -n "$trace" && test -n "$test_untraceable"
-then
-	# '-x' tracing requested, but this test script can't be reliably
-	# traced, unless it is run with a Bash version supporting
-	# BASH_XTRACEFD (introduced in Bash v4.1).
-	if test -n "$BASH_VERSION" && eval '
-	     test ${BASH_VERSINFO[0]} -gt 4 || {
-	       test ${BASH_VERSINFO[0]} -eq 4 &&
-	       test ${BASH_VERSINFO[1]} -ge 1
-	     }
-	   '
-	then
-		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
-	else
-		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
-		trace=
-	fi
-fi
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

