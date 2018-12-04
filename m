Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CB9211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeLDQfX (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 11:35:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39162 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeLDQfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 11:35:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so16653766wra.6
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 08:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w58PMGn4SLRiyo26Kr0Dk6mfpv+H5IHC8GaJGajSU+0=;
        b=HFQPQPNu94tJrjpdke5soQlXFe+LbeayT5W+lJt0mPuuaEsvOmOkshRm2+x17vVp+M
         qpRWe90eP+Bw2yAtf2QMqH8w6GJEihcaY56DEncI800AU/I9wNAmghfD83gZVF0x1QKz
         K2NKaMg76rV3R5NjvQLnoRG6F1Hj8vPvZulaqEVJWeK5j9RmZ8KNsSoFuVWxK0YD1kmO
         5yB5Ey3wB2MnKkiteqF16y1NsVGmN+WYaYx6QnDHs/vzgsSoFFas/Q1XU8rWWjf42aMC
         dsIpjypx2KJ0wCWrPl7I1PKh4dPaABlrBVU4krUNAszdmRMIW/rrxlwqWkE5G7//XvGE
         nTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w58PMGn4SLRiyo26Kr0Dk6mfpv+H5IHC8GaJGajSU+0=;
        b=V0VQ/QNgNvOI96HuyOzcX0d7PsRW75M8uzGDRPp6HxlwSeuii+IVG+HPaHkRc2AgEE
         0rlE5jV78LBPJIvGaSWq7s9vv80zy70T6jxKz1ipPj8bmK5BWBxc/w9cl/V9uUaL/8ZP
         dtD/URU9qYxrlav+q3UneW1ckPilk+iW5cTQp2IMWqi5Ux3lbHY49x+4havmSjFHS2UP
         c2XiZRszfCmNYWRMJOLs5p9pFNFIR+pyGnuLsUs0wJ+tESLUSeK33J1+YZ0rp5HFx7H6
         4FhfTY+rMqjMHGA6f0cCNvS/WqBnokokxBTzSODOyOxm1fTqRMp3Aao7KIJKtSy5UyN8
         IgwA==
X-Gm-Message-State: AA+aEWaVtrSHLSt/FDgcBDmSZtuh6ioVP/j7D9prTu+OG4RbQTDD0YJ6
        MknNYSEg1NdrZf2pNCPnq0kIBVIQ
X-Google-Smtp-Source: AFSGD/WeBGggPLB3j0WgT0IhRGWwweYZrCaLC4g5coqj4AlW6jBWIC/KM35P+tsKI1cQQc4LAlLbHQ==
X-Received: by 2002:adf:f449:: with SMTP id f9mr19197070wrp.40.1543941319083;
        Tue, 04 Dec 2018 08:35:19 -0800 (PST)
Received: from localhost.localdomain (x4db19e3e.dyn.telefonica.de. [77.177.158.62])
        by smtp.gmail.com with ESMTPSA id f130sm7911389wme.41.2018.12.04.08.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 08:35:18 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a test repeatedly under load
Date:   Tue,  4 Dec 2018 17:34:57 +0100
Message-Id: <20181204163457.15717-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181204163457.15717-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
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
option to run a test script repeatedly in multiple parallel
invocations until one of them fails, thereby using the test script
itself to increase the load on the machine.

The number of parallel invocations is determined by, in order of
precedence: the number specified as '--stress=<N>', or the value of
the GIT_TEST_STRESS_LOAD environment variable, or twice the number of
available processors in '/proc/cpuinfo', or 8.

To prevent the several parallel invocations of the same test from
interfering with each other:

  - Include the parallel job's number in the name of the trash
    directory and the various output files under 't/test-results/' as
    a '.stress-<Nr>' suffix.

  - Add the parallel job's number to the port number specified by the
    user or to the test number, so even tests involving daemons
    listening on a TCP socket can be stressed.

  - Make '--stress' imply '--verbose-log' and discard the test's
    standard ouput and error; dumping the output of several parallel
    tests to the terminal would create a big ugly mess.

'wait' for all parallel jobs before exiting (either because a failure
was found or because the user lost patience and aborted the stress
test), allowing the still running tests to finish.  Otherwise the "OK
X.Y" progress output from the last iteration would likely arrive after
the user got back the shell prompt, interfering with typing in the
next command.  OTOH, this waiting might induce a considerable delay
between hitting ctrl-C and the test actually exiting; I'm not sure
this is the right tradeoff.

Based on Jeff King's 'stress' script.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/README                | 13 ++++++-
 t/test-lib-functions.sh |  7 +++-
 t/test-lib.sh           | 82 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index 28711cc508..9851de25c2 100644
--- a/t/README
+++ b/t/README
@@ -186,6 +186,16 @@ appropriately before running "make".
 	this feature by setting the GIT_TEST_CHAIN_LINT environment
 	variable to "1" or "0", respectively.
 
+--stress::
+--stress=<N>::
+	Run the test script repeatedly in multiple parallel
+	invocations until one of them fails.  Useful for reproducing
+	rare failures in flaky tests.  The number of parallel
+	invocations is, in order of precedence: <N>, or the value of
+	the GIT_TEST_STRESS_LOAD environment variable, or twice the
+	number of available processors in '/proc/cpuinfo', or 8.
+	Implies `--verbose-log`.
+
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
 You still need to have built this git sandbox, from which various
@@ -425,7 +435,8 @@ This test harness library does the following things:
  - Creates an empty test directory with an empty .git/objects database
    and chdir(2) into it.  This directory is 't/trash
    directory.$test_name_without_dotsh', with t/ subject to change by
-   the --root option documented above.
+   the --root option documented above, and a '.stress-<N>' suffix
+   appended by the --stress option.
 
  - Defines standard test helper functions for your scripts to
    use.  These functions are designed to make all scripts behave
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d9a602cd0f..9af11e3eed 100644
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
index 49e4563405..9b7f687396 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -71,8 +71,81 @@ then
 	exit 1
 fi
 
+TEST_STRESS_SFX="${GIT_TEST_STRESS_JOB_NR:+.stress-$GIT_TEST_STRESS_JOB_NR}"
 TEST_NAME="$(basename "$0" .sh)"
-TEST_RESULTS_BASE="$TEST_OUTPUT_DIRECTORY/test-results/$TEST_NAME"
+TEST_RESULTS_BASE="$TEST_OUTPUT_DIRECTORY/test-results/$TEST_NAME$TEST_STRESS_SFX"
+
+# If --stress was passed, run this test repeatedly in several parallel loops.
+case "$GIT_TEST_STRESS_STARTED, $* " in
+done,*)
+	# Don't stress test again.
+	;;
+*' --stress '*|*' '--stress=*' '*)
+	job_count=${*##*--stress=}
+	if test "$job_count" != "$*"
+	then
+		job_count=${job_count%% *}
+	elif test -n "$GIT_TEST_STRESS_LOAD"
+	then
+		job_count="$GIT_TEST_STRESS_LOAD"
+	elif test -r /proc/cpuinfo
+	then
+		job_count=$((2 * $(grep -c ^processor /proc/cpuinfo)))
+	else
+		job_count=8
+	fi
+
+	mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
+	stressfail="$TEST_RESULTS_BASE.stress-failed"
+	rm -f "$stressfail"
+	trap 'echo aborted >"$stressfail"' TERM INT HUP
+
+	job_nr=0
+	while test $job_nr -lt "$job_count"
+	do
+		(
+			GIT_TEST_STRESS_STARTED=done
+			GIT_TEST_STRESS_JOB_NR=$job_nr
+			export GIT_TEST_STRESS_STARTED GIT_TEST_STRESS_JOB_NR
+
+			cnt=0
+			while ! test -e "$stressfail"
+			do
+				if $TEST_SHELL_PATH "$0" "$@" >/dev/null 2>&1
+				then
+					printf >&2 "OK   %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
+				elif test -f "$stressfail" &&
+				     test "$(cat "$stressfail")" = "aborted"
+				then
+					printf >&2 "ABORTED %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
+				else
+					printf >&2 "FAIL %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
+					echo $GIT_TEST_STRESS_JOB_NR >>"$stressfail"
+				fi
+				cnt=$(($cnt + 1))
+			done
+		) &
+		job_nr=$(($job_nr + 1))
+	done
+
+	job_nr=0
+	while test $job_nr -lt "$job_count"
+	do
+		wait
+		job_nr=$(($job_nr + 1))
+	done
+
+	if test -f "$stressfail" && test "$(cat "$stressfail")" != "aborted"
+	then
+		echo "Log(s) of failed test run(s) be found in:"
+		for f in $(cat "$stressfail")
+		do
+			echo "  $TEST_RESULTS_BASE.stress-$f.out"
+		done
+	fi
+	exit
+	;;
+esac
 
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
@@ -80,7 +153,7 @@ case "$GIT_TEST_TEE_STARTED, $* " in
 done,*)
 	# do not redirect again
 	;;
-*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)
+*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*|*' --stress '*|*' '--stress=*' '*)
 	mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
 
 	# Make this filename available to the sub-process in case it is using
@@ -341,6 +414,9 @@ do
 	-V|--verbose-log)
 		verbose_log=t
 		shift ;;
+	--stress|--stress=*)
+		verbose_log=t
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -1028,7 +1104,7 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$TEST_NAME"
+TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
-- 
2.20.0.rc2.156.g5a9fd2ce9c

