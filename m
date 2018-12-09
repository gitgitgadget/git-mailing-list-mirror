Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C0220A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeLIW4t (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:49 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52329 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeLIW4r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:47 -0500
Received: by mail-wm1-f42.google.com with SMTP id r11-v6so9082327wmb.2
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7eJpaoHSRBAMDumxdVEtJNmH2u3gReiAbpieYVbTPYI=;
        b=f0VTv/atCGs58f1kKrCrsX+QcLtR2GVynVF8RNaTsSKgGJdQAhCmtMUwbBaiNMb9nv
         c7KixGF1qz09FmBseimm/BGHaTxefx7EhUYf/m1xUd8xA3uGle3s5v7dwEAfedJJsl/z
         jRdLKe+aQkZiVDYpXNwesCgmLT1LspWMUjfYzQGRR56JG0JgSS9AP7TrSG2zvhYU+UYH
         zV97tpIiu4vHOMlrT+gwHPC2ix/A/K2W1BJQSJQcuaCFG//GrIwund3eNJJQyqt5uPlt
         g+9LfxmFHcR8k+LiRVgys8xRflAxFtHLUzE/x6jik7EIIAXXWHKNLO03vEINqGNIvgen
         xH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7eJpaoHSRBAMDumxdVEtJNmH2u3gReiAbpieYVbTPYI=;
        b=sQaMM5VqDsiL/BVaXtUVSG0F2dcYYtZ0dVK/W0+nLikllZ8z+yDJMLNL2UN9fOV/w8
         unnoSoBQz6DfnDn98sL1Pg1EjUwdtXiX1sr52iHLrVKnHn5fqW+bTHz2riySrSYY+5p/
         BsNnOhQCD0U7PdyaCKG5ECytbLJRu32U0RJA1IOgXydSLDEpcK31hxvEFHd7NpAKSbCD
         UwZxdjccAy5gU7Irg53cIEAti9uyMTXmKDkdaXuPhqv7Q4EVzocliBG7HFE0IfIM1K1f
         ac9M9lw8qDcy8OJUaxIW34XYG5Iu1qYYBTLCcqUXguAbgnVQ9WO42qxAXNHmWvAhPmSq
         pGaA==
X-Gm-Message-State: AA+aEWYcgKvkILDYbgYeJduCE1nh5ktGhRND1oI9x58WCKZFN1sKh5L2
        hKrbG9wEfmLLNc7J5eiLNKwPq2A8
X-Google-Smtp-Source: AFSGD/V+ZAB83kUSp4eHUu/rB4x2+u7XlIIQeyODzmBRz9u5WTjU2vQlWOtfDkr5nTuZDHLoJ8peYw==
X-Received: by 2002:a1c:934b:: with SMTP id v72mr9079725wmd.5.1544396205150;
        Sun, 09 Dec 2018 14:56:45 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:44 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 7/7] test-lib: add the '--stress' option to run a test repeatedly under load
Date:   Sun,  9 Dec 2018 23:56:28 +0100
Message-Id: <20181209225628.22216-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unfortunately, we have a few flaky tests, whose failures tend to be
hard to reproduce.  We've found that the best we can do to reproduce
such a failure is to run the test repeatedly while the machine is
under load, and wait in the hope that the load creates enough variance
in the timing of the test's commands that a failure is evenually
triggered.  I have a command to do that, and I noticed that two other
contributors have rolled their own scripts to do the same, all
choosing slightly different approaches.

To help reproduce failures in flaky tests, introduce the '--stress'
option to run a test script repeatedly in multiple parallel jobs until
one of them fails, thereby using the test script itself to increase
the load on the machine.

The number of parallel jobs is determined by, in order of precedence:
the number specified as '--stress=<N>', or the value of the
GIT_TEST_STRESS_LOAD environment variable, or twice the number of
available processors (as reported by the 'getconf' utility), or 8.

Make '--stress' imply '--verbose -x --immediate' to get the most
information about rare failures; there is really no point in spending
all the extra effort to reproduce such a failure, and then not know
which command failed and why.

To prevent the several parallel invocations of the same test from
interfering with each other:

  - Include the parallel job's number in the name of the trash
    directory and the various output files under 't/test-results/' as
    a '.stress-<Nr>' suffix.

  - Add the parallel job's number to the port number specified by the
    user or to the test number, so even tests involving daemons
    listening on a TCP socket can be stressed.

  - Redirect each parallel test run's output to
    't/test-results/$TEST_NAME.stress-<nr>.out', because dumping the
    output of several parallel running tests to the terminal would
    create a big ugly mess.

For convenience, print the output of the failed test job at the end,
and rename its trash directory to end with the '.stress-failed'
suffix, so it's easy to find in a predictable path.  If, in an
unlikely case, more than one jobs were to fail nearly at the same
time, then print the output of all failed jobs, and rename the trash
directory of only the last one (i.e. with the highest job number), as
it is the trash directory of the test whose output will be at the
bottom of the user's terminal.

Based on Jeff King's 'stress' script.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/README                |  19 +++++++-
 t/test-lib-functions.sh |   7 ++-
 t/test-lib.sh           | 103 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 123 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index 28711cc508..11ce7675e3 100644
--- a/t/README
+++ b/t/README
@@ -186,6 +186,22 @@ appropriately before running "make".
 	this feature by setting the GIT_TEST_CHAIN_LINT environment
 	variable to "1" or "0", respectively.
 
+--stress::
+--stress=<N>::
+	Run the test script repeatedly in multiple parallel jobs until
+	one of them fails.  Useful for reproducing rare failures in
+	flaky tests.  The number of parallel jobs is, in order of
+	precedence: <N>, or the value of the GIT_TEST_STRESS_LOAD
+	environment variable, or twice the number of available
+	processors (as shown by the 'getconf' utility),	or 8.
+	Implies `--verbose -x --immediate` to get the most information
+	about the failure.  Note that the verbose output of each test
+	job is saved to 't/test-results/$TEST_NAME.stress-<nr>.out',
+	and only the output of the failed test job is shown on the
+	terminal.  The names of the trash directories get a
+	'.stress-<nr>' suffix, and the trash directory of the failed
+	test job is renamed to end with a '.stress-failed' suffix.
+
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
 You still need to have built this git sandbox, from which various
@@ -425,7 +441,8 @@ This test harness library does the following things:
  - Creates an empty test directory with an empty .git/objects database
    and chdir(2) into it.  This directory is 't/trash
    directory.$test_name_without_dotsh', with t/ subject to change by
-   the --root option documented above.
+   the --root option documented above, and a '.stress-<N>' suffix
+   appended by the --stress option.
 
  - Defines standard test helper functions for your scripts to
    use.  These functions are designed to make all scripts behave
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3746327bde..ee3435c6df 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1288,8 +1288,6 @@ test_set_port () {
 			# root-only port, use a larger one instead.
 			port=$(($port + 10000))
 		fi
-
-		eval $var=$port
 		;;
 	*[^0-9]*)
 		error >&7 "invalid port number: $port"
@@ -1298,4 +1296,9 @@ test_set_port () {
 		# The user has specified the port.
 		;;
 	esac
+
+	# Make sure that parallel '--stress' test jobs get different
+	# ports.
+	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
+	eval $var=$port
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d55d158580..e405191164 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -87,21 +87,110 @@ do
 		valgrind_only=${opt#--*=} ;;
 	--root=*)
 		root=${opt#--*=} ;;
+	--stress)
+		stress=t ;;
+	--stress=*)
+		stress=${opt#--*=} ;;
 	*)
 		# Other options will be handled later.
 	esac
 done
 
+TEST_STRESS_JOB_SFX="${GIT_TEST_STRESS_JOB_NR:+.stress-$GIT_TEST_STRESS_JOB_NR}"
 TEST_NAME="$(basename "$0" .sh)"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
-TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
-TRASH_DIRECTORY="trash directory.$TEST_NAME"
+TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
+TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
 
+# If --stress was passed, run this test repeatedly in several parallel loops.
+if test "$GIT_TEST_STRESS_STARTED" = "done"
+then
+	: # Don't stress test again.
+elif test -n "$stress"
+then
+	if test "$stress" != t
+	then
+		job_count=$stress
+	elif test -n "$GIT_TEST_STRESS_LOAD"
+	then
+		job_count="$GIT_TEST_STRESS_LOAD"
+	elif job_count=$(getconf _NPROCESSORS_ONLN 2>/dev/null) &&
+	     test -n "$job_count"
+	then
+		job_count=$((2 * $job_count))
+	else
+		job_count=8
+	fi
+
+	mkdir -p "$TEST_RESULTS_DIR"
+	stressfail="$TEST_RESULTS_BASE.stress-failed"
+	rm -f "$stressfail"
+
+	stress_exit=0
+	trap '
+		kill $job_pids 2>/dev/null
+		wait
+		stress_exit=1
+	' TERM INT HUP
+
+	job_pids=
+	job_nr=0
+	while test $job_nr -lt "$job_count"
+	do
+		(
+			GIT_TEST_STRESS_STARTED=done
+			GIT_TEST_STRESS_JOB_NR=$job_nr
+			export GIT_TEST_STRESS_STARTED GIT_TEST_STRESS_JOB_NR
+
+			trap '
+				kill $test_pid 2>/dev/null
+				wait
+				exit 1
+			' TERM INT
+
+			cnt=0
+			while ! test -e "$stressfail"
+			do
+				$TEST_SHELL_PATH "$0" "$@" >"$TEST_RESULTS_BASE.stress-$job_nr.out" 2>&1 &
+				test_pid=$!
+
+				if wait $test_pid
+				then
+					printf "OK   %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
+				else
+					echo $GIT_TEST_STRESS_JOB_NR >>"$stressfail"
+					printf "FAIL %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
+				fi
+				cnt=$(($cnt + 1))
+			done
+		) &
+		job_pids="$job_pids $!"
+		job_nr=$(($job_nr + 1))
+	done
+
+	wait
+
+	if test -f "$stressfail"
+	then
+		echo "Log(s) of failed test run(s):"
+		for failed_job_nr in $(sort -n "$stressfail")
+		do
+			echo "Contents of '$TEST_RESULTS_BASE.stress-$failed_job_nr.out':"
+			cat "$TEST_RESULTS_BASE.stress-$failed_job_nr.out"
+		done
+		rm -rf "$TRASH_DIRECTORY.stress-failed"
+		# Move the last one.
+		mv "$TRASH_DIRECTORY.stress-$failed_job_nr" "$TRASH_DIRECTORY.stress-failed"
+	fi
+
+	exit $stress_exit
+fi
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 if test "$GIT_TEST_TEE_STARTED" = "done"
@@ -340,7 +429,8 @@ do
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind|\
 	--valgrind=*|\
 	--valgrind-only=*|\
-	--root=*)
+	--root=*|\
+	--stress|--stress=*)
 		shift ;; # These options were handled already.
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
@@ -379,6 +469,13 @@ then
 	verbose=t
 fi
 
+if test -n "$stress"
+then
+	verbose=t
+	trace=t
+	immediate=t
+fi
+
 if test -n "$color"
 then
 	# Save the color control sequences now rather than run tput
-- 
2.20.0.rc2.156.g5a9fd2ce9c

