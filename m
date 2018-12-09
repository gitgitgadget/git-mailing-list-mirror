Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD1B20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLIW4j (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:39 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42873 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLIW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:39 -0500
Received: by mail-wr1-f52.google.com with SMTP id q18so8646073wrx.9
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDLL2QSB/v8dlZuHUfBjwDYM/XPjPGoxWGgWSeKHNCo=;
        b=SeRWyeNtzLNu9bBPuccgzKJcQdp6Ig7odCHvwKnL/xfme149Z0+Q+ne6npwaKkiNPd
         Vvx92Khbip6Lnkztje88T2gnv1TsRbyZV7tvxgIsdQ3y/DNRp1hGoKLuBEJLP9RLoXY0
         wH4uxmv0+2DjutnWye/BGduRpLD5vJbUj2AVWzu/7xn6Nt2uYH+ylXezdZi0tgteIRiL
         ZW8jJ8jhOZM9yCyhVMtYBpIWDbIIK/rC4a2rPDiXx29VCPPYQsKBwk1Wy4FnICjF/Tew
         /toNSTglW/ukvfL/gtMLG5sTbLE+t2AfSFAWoMXQ++n5sbWT6ZegDPahnhaH4fWSV/27
         9hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDLL2QSB/v8dlZuHUfBjwDYM/XPjPGoxWGgWSeKHNCo=;
        b=donFrpB7sN/W63ZxEuQO7qfXp9PzNXvO5xXaotsBXjUsPijMzTXOaupMolvFzsMQQ1
         cni8kd1aYFCXx2J9Nbb0tCt96iuMyt+owhAnX20Jq7Up9V5iOXqXCqG1NldWn+sXDAAE
         fGGIVxZIS6GIDrZrrfj4il3yyJC6lBX2Fa7hXvxzFcGXsvRPRnoE3gf1rlfvxE4TeJSI
         Jy+HJf9/GAdbKH+y0IQKce8LEwX0UzJkLzrCOYqwxTnf5FOVm+m1xwRqm9DSoiGTKGtc
         dry0hRxJFFdhtLLG+iet05SpNv3GLM19PwAvZ1ECv2/v6O+n9uGr+B12VDvwCnuDyKdX
         tCaw==
X-Gm-Message-State: AA+aEWYPrYf9sr2uyYgyxemI/OoxwQVTeFl2MdygyFPr6q4r2x2MrXKt
        sUaGwYluhyvcVatlwW+GOVITLe8N
X-Google-Smtp-Source: AFSGD/X/VeN2yvJ9v6R95kPHvOQY0HfVeQmVVxPam3JeEGHtke9fJuXOI6POONbGYhSEe+qrtxC8Bg==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr8472290wrj.58.1544396196014;
        Sun, 09 Dec 2018 14:56:36 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:35 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/7] test-lib: add the '--stress' option to help reproduce occasional failures in flaky tests
Date:   Sun,  9 Dec 2018 23:56:21 +0100
Message-Id: <20181209225628.22216-1-szeder.dev@gmail.com>
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


This patch series tries to make reproducing rare failures in flaky
tests easier: it adds the '--stress' option to our test library to run
the test script repeatedly in multiple parallel jobs, in the hope that
the increased load creates enough variance in the timing of the test's
commands that such a failure is eventually triggered.


Notable changes since v1:

  - Made it more Peff-friendly :), namely it will now show the log of
    the failed test and will rename its trash directory.

    Furthermore, '--stress' will now imply '--verbose -x --immediate'.

  - Improved abort handling based on the discussion of the previous
    version.  (As a result, the patch is so heavily modified, that
    'range-diff' with default parameters consideres it a different
    patch; increasing the creation factor then results in one big ugly
    diff of a diff, so I left it as-is.)

  - Added a few new patches, mostly preparatory refactorings, though
    the first one might be considered a bugfix.

  - Other minor cleanups suggested in the previous discussion.


v1: https://public-inbox.org/git/20181204163457.15717-1-szeder.dev@gmail.com/T/


SZEDER Gábor (7):
  test-lib: translate SIGTERM and SIGHUP to an exit
  test-lib: parse some --options earlier
  test-lib: consolidate naming of test-results paths
  test-lib: set $TRASH_DIRECTORY earlier
  test-lib: extract Bash version check for '-x' tracing
  test-lib-functions: introduce the 'test_set_port' helper function
  test-lib: add the '--stress' option to run a test repeatedly under
    load

 t/README                 |  19 +++-
 t/lib-git-daemon.sh      |   2 +-
 t/lib-git-p4.sh          |   9 +-
 t/lib-git-svn.sh         |   2 +-
 t/lib-httpd.sh           |   2 +-
 t/t0410-partial-clone.sh |   1 -
 t/t5512-ls-remote.sh     |   2 +-
 t/test-lib-functions.sh  |  39 +++++++
 t/test-lib.sh            | 227 +++++++++++++++++++++++++++++----------
 9 files changed, 230 insertions(+), 73 deletions(-)

Range-diff:
-:  ---------- > 1:  3a5c926167 test-lib: translate SIGTERM and SIGHUP to an exit
-:  ---------- > 2:  8eee8d7fba test-lib: parse some --options earlier
1:  f4bb53e676 ! 3:  dd20ae5e9a test-lib: consolidate naming of test-results paths
    @@ -4,8 +4,9 @@
     
         There are two places where we strip off any leading path components
         and the '.sh' suffix from the test script's pathname, and there are
    -    two places where we construct the filename of test output files in
    -    't/test-results/'.  The last patch in this series will add even more.
    +    four places where we construct the name of the 't/test-results'
    +    directory or the name of various test-specific files in there.  The
    +    last patch in this series will add even more.
     
         Factor these out into helper variables to avoid repeating ourselves.
     
    @@ -15,22 +16,23 @@
      --- a/t/test-lib.sh
      +++ b/t/test-lib.sh
     @@
    - 	exit 1
    - fi
    + 	esac
    + done
      
     +TEST_NAME="$(basename "$0" .sh)"
    -+TEST_RESULTS_BASE="$TEST_OUTPUT_DIRECTORY/test-results/$TEST_NAME"
    ++TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
    ++TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
     +
      # if --tee was passed, write the output not only to the terminal, but
      # additionally to the file test-results/$BASENAME.out, too.
    - case "$GIT_TEST_TEE_STARTED, $* " in
    + if test "$GIT_TEST_TEE_STARTED" = "done"
     @@
    - 	# do not redirect again
    - 	;;
    - *' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)
    + elif test -n "$tee" || test -n "$verbose_log" ||
    +      test -n "$valgrind" || test -n "$valgrind_only"
    + then
     -	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
     -	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
    -+	mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
    ++	mkdir -p "$TEST_RESULTS_DIR"
      
      	# Make this filename available to the sub-process in case it is using
      	# --verbose-log.
    @@ -48,8 +50,8 @@
     +	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
     +	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
      	exit
    - 	;;
    - esac
    + fi
    + 
     @@
      
      	if test -z "$HARNESS_ACTIVE"
    @@ -58,7 +60,7 @@
     -		mkdir -p "$test_results_dir"
     -		base=${0##*/}
     -		test_results_path="$test_results_dir/${base%.sh}.counts"
    -+		mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
    ++		mkdir -p "$TEST_RESULTS_DIR"
      
     -		cat >"$test_results_path" <<-EOF
     +		cat >"$TEST_RESULTS_BASE.counts" <<-EOF
-:  ---------- > 4:  f3941077e6 test-lib: set $TRASH_DIRECTORY earlier
-:  ---------- > 5:  fefbca96ee test-lib: extract Bash version check for '-x' tracing
2:  9aec8662f9 ! 6:  b4b6844a3e test-lib-functions: introduce the 'test_set_port' helper function
    @@ -27,7 +27,7 @@
             containing the digits 8 or 9 will trigger an error.  Remove all
             leading zeros from the test numbers to prevent this.
     
    -    Note that the Perforce tests are unlike the other tests involving
    +    Note that the 'git p4' tests are unlike the other tests involving
         daemons in that:
     
           - 'lib-git-p4.sh' doesn't use the test's number for unique port as
    @@ -35,7 +35,7 @@
     
           - The port is not overridable via an environment variable.
     
    -    With this patch even Perforce tests will use the test's number as
    +    With this patch even 'git p4' tests will use the test's number as
         default port, and it will be overridable via the P4DPORT environment
         variable.
     
    @@ -161,7 +161,7 @@
     +		BUG "test_set_port requires a variable name"
     +	fi
     +
    -+	eval port=\"\${$var}\"
    ++	eval port=\$$var
     +	case "$port" in
     +	"")
     +		# No port is set in the given env var, use the test
3:  a5aa71f20c < -:  ---------- test-lib: add the '--stress' option to run a test repeatedly under load
-:  ---------- > 7:  8470b55f65 test-lib: add the '--stress' option to run a test repeatedly under load
-- 
2.20.0.rc2.156.g5a9fd2ce9c

