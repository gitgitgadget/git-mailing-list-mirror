Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F231F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeL3TQk (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:16:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36197 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeL3TQk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:16:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so25098836wrp.3
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CAQ2A4iJgP3En+BukjezaKNx7gIx6TFLJDubdtxwEbY=;
        b=dczQiz1ClXB2CyibjRwhxGG+gd5TRXQt04HToyu+Nd8vdVZxltXDT8AmYpyGciee2V
         UGXPvGvkt7Zvdv/vPTh5iiFYzag1V6YOcjJCGb5JEWu5oV+9XElXP8IQupjimgxjvs8w
         TWx+ZVGZKu9f+hdZu3Ow8bBJ2OKPKfK6Dwbl2np0MxBREBBecVxTtT+YyXdvObVB/bLk
         aVnhCF9TiYb+k64NXSQcYHQt6W1sBSn6MMs8j/qN5OC0d6cdKfOPZYIyq1PFbW1d4My2
         PdliQvEcES8agKn0RaN5EvD3bUg8rOo0G67M7Lugws3m5PXwxLoiZYNL3x5kxByxS21L
         HRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAQ2A4iJgP3En+BukjezaKNx7gIx6TFLJDubdtxwEbY=;
        b=jazD+WbEuMDXDN2MmF8HFYblTOjMks5h/YD6UZiK67Jh3ahLd2ty3jhvjP7Acvaica
         S56Thn9rWb9OVd1XNSKJPIPjuaSuQtd89bJYlF4mU659b46ysOHiEClqPzraGOaVk7lc
         R+VkDP0uB/CJPBhsHageN4DgzzdzsFhQSJrysHbD2cvXZzbZdM0bdjEb8o43yn/kNFbr
         +u5yCy0pqHhcWHkXQLhiwYcbLqhMtOCeuh/KUl3OAFK/xzKxkJhYNEzCKKTcR9V/aqiI
         wIr/gXqh9ZOPD0xKGEiG2+GbMDgd9IRMr4WWupgOtCtPaLxs6TBx7DpkfeHwEh7BK/wE
         k4RQ==
X-Gm-Message-State: AJcUukfIIr9LSn3Bh44sua10ipgOoi2ZDRxS7cSJ6y6QE40j1ODqNMwG
        tPy3nfaz0lUzJCJEhKyy/6vZ7caQ
X-Google-Smtp-Source: ALg8bN7PHSU/bdTPUWnJ4VEAn+WHWgAOhqYGAFIxef/5Auod1tV8aLjc6nba3T6JLbGRXGl3kXFcmQ==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr32494573wrj.58.1546197397757;
        Sun, 30 Dec 2018 11:16:37 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id h62sm28954226wmf.11.2018.12.30.11.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 11:16:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/8] test-lib: add the '--stress' option to help reproduce occasional failures in flaky tests
Date:   Sun, 30 Dec 2018 20:16:21 +0100
Message-Id: <20181230191629.3232-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To recap: this patch series tries to make reproducing rare failures in
flaky tests easier: it adds the '--stress' option to our test library
to run the test script repeatedly in multiple parallel jobs, in the
hope that the increased load creates enough variance in the timing of
the test's commands that such a failure is eventually triggered.

Changes since v2:

  - Most importantly, parse all options before handling '--tee',
    '--verbose-log' or '--stress'.  This constitutes the bulk of the
    range diff.

  - Add a bit of sanity check for the argument of '--stress=123'.

  - Minor commit message updates.

v2 was quickly followed up with a fixup! patch; the range-diff below
includes that fixup! already squashed in.

Previous versions:

  v2: https://public-inbox.org/git/20181209225628.22216-1-szeder.dev@gmail.com/T/#u
  v1: https://public-inbox.org/git/20181204163457.15717-1-szeder.dev@gmail.com/T/

SZEDER Gábor (8):
  test-lib: translate SIGTERM and SIGHUP to an exit
  test-lib: parse options in a for loop to keep $@ intact
  test-lib: parse command line options earlier
  test-lib: consolidate naming of test-results paths
  test-lib: set $TRASH_DIRECTORY earlier
  test-lib: extract Bash version check for '-x' tracing
  test-lib-functions: introduce the 'test_set_port' helper function
  test-lib: add the '--stress' option to run a test repeatedly under
    load

 t/README                 |  19 ++-
 t/lib-git-daemon.sh      |   2 +-
 t/lib-git-p4.sh          |   9 +-
 t/lib-git-svn.sh         |   2 +-
 t/lib-httpd.sh           |   2 +-
 t/t0410-partial-clone.sh |   1 -
 t/t5512-ls-remote.sh     |   2 +-
 t/test-lib-functions.sh  |  39 +++++
 t/test-lib.sh            | 360 ++++++++++++++++++++++++++-------------
 9 files changed, 303 insertions(+), 133 deletions(-)

Range-diff:
1:  3a5c926167 = 1:  48a2b19218 test-lib: translate SIGTERM and SIGHUP to an exit
2:  8eee8d7fba < -:  ---------- test-lib: parse some --options earlier
-:  ---------- > 2:  adc5e8a86e test-lib: parse options in a for loop to keep $@ intact
-:  ---------- > 3:  89748074db test-lib: parse command line options earlier
3:  dd20ae5e9a ! 4:  5a6d17f54a test-lib: consolidate naming of test-results paths
    @@ -16,8 +16,8 @@
      --- a/t/test-lib.sh
      +++ b/t/test-lib.sh
     @@
    - 	esac
    - done
    + 	verbose=t
    + fi
      
     +TEST_NAME="$(basename "$0" .sh)"
     +TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
    @@ -27,8 +27,8 @@
      # additionally to the file test-results/$BASENAME.out, too.
      if test "$GIT_TEST_TEE_STARTED" = "done"
     @@
    - elif test -n "$tee" || test -n "$verbose_log" ||
    -      test -n "$valgrind" || test -n "$valgrind_only"
    + 	: # do not redirect again
    + elif test -n "$tee"
      then
     -	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
     -	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
4:  f6e56c91c4 ! 5:  cd7626b782 test-lib: set $TRASH_DIRECTORY earlier
    @@ -15,15 +15,6 @@
      diff --git a/t/test-lib.sh b/t/test-lib.sh
      --- a/t/test-lib.sh
      +++ b/t/test-lib.sh
    -@@
    - 		valgrind=${opt#--*=} ;;
    - 	--valgrind-only=*)
    - 		valgrind_only=${opt#--*=} ;;
    -+	--root=*)
    -+		root=${opt#--*=} ;;
    - 	*)
    - 		# Other options will be handled later.
    - 	esac
     @@
      TEST_NAME="$(basename "$0" .sh)"
      TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
    @@ -37,26 +28,6 @@
      
      # if --tee was passed, write the output not only to the terminal, but
      # additionally to the file test-results/$BASENAME.out, too.
    -@@
    - 		with_dashes=t; shift ;;
    - 	--no-color)
    - 		color=; shift ;;
    --	--root=*)
    --		root=${1#--*=}
    --		shift ;;
    - 	--chain-lint)
    - 		GIT_TEST_CHAIN_LINT=1
    - 		shift ;;
    -@@
    - 	-V|--verbose-log|\
    - 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind|\
    - 	--valgrind=*|\
    --	--valgrind-only=*)
    -+	--valgrind-only=*|\
    -+	--root=*)
    - 		shift ;; # These options were handled already.
    - 	*)
    - 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
     @@
      fi
      
5:  99ecd2902e ! 6:  90296ac776 test-lib: extract Bash version check for '-x' tracing
    @@ -2,23 +2,30 @@
     
         test-lib: extract Bash version check for '-x' tracing
     
    -    Some of our test scripts can't be reliably run with '-x' tracing
    -    enabled unless executed with a Bash version supporting BASH_XTRACEFD
    -    (since v4.1), and we have a lengthy condition to disable tracing if
    -    such a test script is not executed with a suitable Bash version.
    +    One of our test scripts, 't1510-repo-setup.sh' [1], still can't be
    +    reliably run with '-x' tracing enabled, unless it's executed with a
    +    Bash version supporting BASH_XTRACEFD (since v4.1).  We have a lengthy
    +    condition to check the version of the shell running the test script,
    +    and disable tracing if it's not executed with a suitable Bash version
    +    [2].
     
         Move this check out from the option parsing loop, so other options can
         imply '-x' by setting 'trace=t', without missing this Bash version
         check.
     
    +    [1] 5827506928 (t1510-repo-setup: mark as untraceable with '-x',
    +        2018-02-24)
    +    [2] 5fc98e79fc (t: add means to disable '-x' tracing for individual
    +        test scripts, 2018-02-24)
    +
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      diff --git a/t/test-lib.sh b/t/test-lib.sh
      --- a/t/test-lib.sh
      +++ b/t/test-lib.sh
     @@
    - 		GIT_TEST_CHAIN_LINT=0
    - 		shift ;;
    + 	--no-chain-lint)
    + 		GIT_TEST_CHAIN_LINT=0 ;;
      	-x)
     -		# Some test scripts can't be reliably traced  with '-x',
     -		# unless the test is run with a Bash version supporting
    @@ -38,10 +45,11 @@
     -		else
     -			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
     -		fi
    -+		trace=t
    - 		shift ;;
    - 	--tee|\
    - 	-V|--verbose-log|\
    +-		;;
    ++		trace=t ;;
    + 	-V|--verbose-log)
    + 		verbose_log=t
    + 		tee=t
     @@
      	test -z "$verbose_log" && verbose=t
      fi
6:  dcf7d2a397 ! 7:  a4a3e7cefa test-lib-functions: introduce the 'test_set_port' helper function
    @@ -178,7 +178,7 @@
     +
     +		eval $var=$port
     +		;;
    -+	*[^0-9]*)
    ++	*[^0-9]*|0*)
     +		error >&7 "invalid port number: $port"
     +		;;
     +	*)
7:  f27f2fc1d0 ! 8:  b0dcff0d3f test-lib: add the '--stress' option to run a test repeatedly under load
    @@ -4,12 +4,12 @@
     
         Unfortunately, we have a few flaky tests, whose failures tend to be
         hard to reproduce.  We've found that the best we can do to reproduce
    -    such a failure is to run the test repeatedly while the machine is
    -    under load, and wait in the hope that the load creates enough variance
    -    in the timing of the test's commands that a failure is evenually
    -    triggered.  I have a command to do that, and I noticed that two other
    -    contributors have rolled their own scripts to do the same, all
    -    choosing slightly different approaches.
    +    such a failure is to run the test script repeatedly while the machine
    +    is under load, and wait in the hope that the load creates enough
    +    variance in the timing of the test's commands that a failure is
    +    evenually triggered.  I have a command to do that, and I noticed that
    +    two other contributors have rolled their own scripts to do the same,
    +    all choosing slightly different approaches.
     
         To help reproduce failures in flaky tests, introduce the '--stress'
         option to run a test script repeatedly in multiple parallel jobs until
    @@ -37,19 +37,21 @@
             user or to the test number, so even tests involving daemons
             listening on a TCP socket can be stressed.
     
    -      - Redirect each parallel test run's output to
    +      - Redirect each parallel test run's verbose output to
             't/test-results/$TEST_NAME.stress-<nr>.out', because dumping the
             output of several parallel running tests to the terminal would
             create a big ugly mess.
     
         For convenience, print the output of the failed test job at the end,
         and rename its trash directory to end with the '.stress-failed'
    -    suffix, so it's easy to find in a predictable path.  If, in an
    -    unlikely case, more than one jobs were to fail nearly at the same
    -    time, then print the output of all failed jobs, and rename the trash
    -    directory of only the last one (i.e. with the highest job number), as
    -    it is the trash directory of the test whose output will be at the
    -    bottom of the user's terminal.
    +    suffix, so it's easy to find in a predictable path (OTOH, all absolute
    +    paths recorded in the trash directory become invalid; we'll see
    +    whether this causes any issues in practice).  If, in an unlikely case,
    +    more than one jobs were to fail nearly at the same time, then print
    +    the output of all failed jobs, and rename the trash directory of only
    +    the last one (i.e. with the highest job number), as it is the trash
    +    directory of the test whose output will be at the bottom of the user's
    +    terminal.
     
         Based on Jeff King's 'stress' script.
     
    @@ -102,7 +104,7 @@
     -
     -		eval $var=$port
      		;;
    - 	*[^0-9]*)
    + 	*[^0-9]*|0*)
      		error >&7 "invalid port number: $port"
     @@
      		# The user has specified the port.
    @@ -119,17 +121,42 @@
      --- a/t/test-lib.sh
      +++ b/t/test-lib.sh
     @@
    - 		valgrind_only=${opt#--*=} ;;
    - 	--root=*)
    - 		root=${opt#--*=} ;;
    + 		verbose_log=t
    + 		tee=t
    + 		;;
     +	--stress)
     +		stress=t ;;
     +	--stress=*)
    -+		stress=${opt#--*=} ;;
    ++		stress=${opt#--*=}
    ++		case "$stress" in
    ++		*[^0-9]*|0*|"")
    ++			echo "error: --stress=<N> requires the number of jobs to run" >&2
    ++			exit 1
    ++			;;
    ++		*)	# Good.
    ++			;;
    ++		esac
    ++		;;
      	*)
    - 		# Other options will be handled later.
    + 		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
      	esac
    - done
    +@@
    + 	test -z "$verbose_log" && verbose=t
    + fi
    + 
    ++if test -n "$stress"
    ++then
    ++	verbose=t
    ++	trace=t
    ++	immediate=t
    ++fi
    ++
    + if test -n "$trace" && test -n "$test_untraceable"
    + then
    + 	# '-x' tracing requested, but this test script can't be reliably
    +@@
    + 	verbose=t
    + fi
      
     +TEST_STRESS_JOB_SFX="${GIT_TEST_STRESS_JOB_NR:+.stress-$GIT_TEST_STRESS_JOB_NR}"
      TEST_NAME="$(basename "$0" .sh)"
    @@ -231,27 +258,3 @@
      # if --tee was passed, write the output not only to the terminal, but
      # additionally to the file test-results/$BASENAME.out, too.
      if test "$GIT_TEST_TEE_STARTED" = "done"
    -@@
    - 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind|\
    - 	--valgrind=*|\
    - 	--valgrind-only=*|\
    --	--root=*)
    -+	--root=*|\
    -+	--stress|--stress=*)
    - 		shift ;; # These options were handled already.
    - 	*)
    - 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
    -@@
    - 	verbose=t
    - fi
    - 
    -+if test -n "$stress"
    -+then
    -+	verbose=t
    -+	trace=t
    -+	immediate=t
    -+fi
    -+
    - if test -n "$color"
    - then
    - 	# Save the color control sequences now rather than run tput
-- 
2.20.1.151.gec613c4b75

