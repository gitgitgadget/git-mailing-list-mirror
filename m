Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FAD209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 22:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdFCWNt (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 18:13:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34257 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdFCWNs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 18:13:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so24146575wmf.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6SOVBdeYWzV16YUkglzF0eSLFl9bMDE7ZUPtUJo20GA=;
        b=JssDtPbTt1+HwN3XBztMf9WuZgV72MGaJLgZTV5dXy6u2oxYIch7OCqqxbsl946VMS
         g1W6AEx0hGPWpE14nQXErVlc/P7B5A22/zm2b2DUe2SeatONIGsU7QNaoIZwGlBAiL7k
         NFPpUBQXDwOSM++P0IrMF2QqQT2vuvF0qNvzlqEN8bfIdfr6raCBy4CtW/MBH6bGGWjj
         xtjvcF3/RFOZ/DBOqVPP71zfx3yUi4iahzNFMLfzn4ADhEZdFIzyfdcVaqzK+Rbp11TL
         +lKW3UIpXlMDjPpEZPLLAvaxWT9CpnfPIKoHmuCsJ+DoLqxcsJRCABnPSjAfvhQlnkvS
         Yqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6SOVBdeYWzV16YUkglzF0eSLFl9bMDE7ZUPtUJo20GA=;
        b=qwaiD7fColm+U44fmZTNYiXVzF1ziYXloSRufPSyHE1kg2LMGUGFKmWxhvnCRmy0jt
         e7SvQD+AB5rAdlyKdpLzT+9VxOvbKA9WUFNWXkhodx4X1TB9bKc3vUvdAzwVnxsD8l6F
         pVQv+egLvk9CURcIsHE/C0KzVh4sUHUlDGZq4Zm6m4xKO8fUCQ7NwIn4u1JPP6Dcl3os
         lLyRS9eIdP7uhDDQtgt23BF687UeHADARa7wQsoIgCI/+iFImKLeiFoO8wiYFFiDRqFA
         x0/RrpRuGElzAK07XK7Fu2MwN+3ek41KlrJytY77EENvuN1me4UHgEv6BiVEEh1WKKgs
         K6HQ==
X-Gm-Message-State: AODbwcDxr06fr2xmuCpmzBvEhSM0/X6Qr2Iye7vvtK0RtSwcQ6BcA4gZ
        qftZNHlnBrdOvtN/pFU=
X-Received: by 10.80.183.195 with SMTP id i3mr10761728ede.159.1496528026426;
        Sat, 03 Jun 2017 15:13:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k33sm10459284edb.11.2017.06.03.15.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jun 2017 15:13:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib: add ability to cap the runtime of tests
Date:   Sat,  3 Jun 2017 22:13:35 +0000
Message-Id: <20170603221335.3038-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_TEST_TIMEOUT environment variable which optimistically sets
an approximate upper limit on how long any one test is allowed to
run.

Once the timeout is exceeded all remaining tests are skipped, no
attempt is made to stop a long running test in-progress, or deal with
the edge case of the epoch changing the epoch from under us by
e.g. ntpd.

On my machine median runtime for a test is around 150ms, but 8 tests
take more than 10 seconds to run, with t3404-rebase-interactive.sh
taking 18 seconds.

On a machine with a large number of cores these long-tail tests become
the limiting factor in how long it takes to run the entire test suite,
even if it's run with "prove --state=slow,save". This is because the
first long-running tests started at the very beginning will still be
running by the time the rest of the test suite finishes.

Speeding up the test suite by simply cataloging and skipping tests
that take longer than N seconds is a hassle to maintain, and entirely
skips some tests which would be nice to at least partially run,
e.g. instead of entirely skipping t3404-rebase-interactive.sh we can
run it for N seconds and get at least some "git rebase -i" test
coverage in a fast test run.

On a 56 core Xeon E5-2690 v4 @ 2.60GHz the runtime for the test suite
is cut in half with GIT_TEST_TIMEOUT=10 under prove -j56
t[0-9]*.sh. Approximate time to run all the tests with various
GIT_TEST_TIMEOUT settings[1]:

    N/A     30s
    20      20s
    10      15s
    5       12s
    1       12s

Setting a timeout lower than 5-10 seconds or so starts to reach
diminishing returns, e.g. t7063-status-untracked-cache.sh always takes
at least 6 seconds to run since it's blocking on a single
"update-index --test-untracked-cache" command. So there's room for
improvement, but this simple facility gives us most of the benefits.

The number of tests on the aforementioned machine which are run with
the various timeouts[2]:

    N/A     16261
    20      16037
    10      14972
    5       13952
    1       8409

While running with a timeout of 10 seconds cuts the runtime in half,
over 92% of the tests are still run. The test coverage is higher than
that number indicates, just taking into account the many similar tests
t0027-auto-crlf.sh runs brings it up to 95%.

1. for t in '' 20 10; do printf "%s\t" $t && (time GIT_TEST_TIMEOUT=$t prove -j$(parallel --number-of-cores) --state=slow,save t[0-9]*.sh) 2>&1 | grep ^real | grep -E -o '[0-9].*'; done
2. for t in '' 20 10 5 1; do printf "%s\t" $t && (time GIT_TEST_TIMEOUT=$t prove -j$(parallel --number-of-cores) --state=slow,save -v t[0-9]*.sh) 2>&1 | grep -e ^real -e '^1\.\.' | sed 's/^1\.\.//' | awk '{s+=$1} END {print s}'; done

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4936725c67..0353e73873 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,13 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+# If we have a set max runtime record the startup time before anything
+# else is done.
+if test -n "$GIT_TEST_TIMEOUT"
+then
+	TEST_STARTUP_TIME=$(date +%s)
+fi
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
@@ -689,11 +696,22 @@ test_skip () {
 		to_skip=t
 		skipped_reason="--run"
 	fi
+	if test -n "$GIT_TEST_TIMEOUT" &&
+		test "$(($(date +%s) - $TEST_STARTUP_TIME))" -ge "$GIT_TEST_TIMEOUT"
+	then
+		to_skip=all
+		skipped_reason="Exceeded GIT_TEST_TIMEOUT in runtime"
+	fi
 
 	case "$to_skip" in
-	t)
+	all|t)
 		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
+		if test "$to_skip" = all
+		then
+			skip_all="$skipped_reason"
+			test_done
+		fi
 		: true
 		;;
 	*)
-- 
2.13.0.506.g27d5fe0cd

