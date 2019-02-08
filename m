Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CB11F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBHLux (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:50:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41555 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBHLux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:50:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so3232733wrs.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 03:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nXw+Ehxyd0r9v0XZJJzpHwpPoQ8mr33BOZR5vTjTy8=;
        b=K+kFsbH32JTPV6cYcm+QdbNl1S4+lddQo1wVH5xC5eZ8YKQABo6z1HpnqElXuNTKrw
         HKEcFv2NrXTld2oDpMznr7dQKSCuJzwkWTymUZRwsyZtcUHGL95DdkW7aHrfY66Yfy2L
         hvvSEWcB6iBcLbdNnfpI8/JMm4fqX4GD30Guuy3rLNDlVJ2V8JT7FpYb38KgFohMDu7l
         vSstqDjiM8lCCfjFxRWMbDP1/16/qg5tbuicDm36y5WjczDHPGXKoX64QAgpZ5ccBvij
         SMwL3XM9a3GN2exiFZTylc/VCorm1SOgzEBZAO+z+9fkJKxyARkiuKFYcRYcyFAOcSn8
         Cm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nXw+Ehxyd0r9v0XZJJzpHwpPoQ8mr33BOZR5vTjTy8=;
        b=KLA1OsUwNGWo4BWQHTb37pv7SaMZToeEw2p6sC3ORstCNFPtjzP+G1eunXjYIthr0P
         17FZJP9QIX9vxcsGOgTutB5sM9iTdCsLqV9W+m2YUgIi5UMKu6jmAF/ZJJqKQ/8uRlMk
         8cNv/p9v3aWxHQg+9OV2NaMp/FyWaNhtd1cWrGMpGUaYYRwKBj9BRw2tzCMi20K6zRgU
         giK4bwvXPDcgwbqmr41L0QocA9GXg3B6MA+8f7sKnPZLDmA40vYu+6wnffcrQwSo+xr9
         WY4m/nM6C+DH2cM6CiB5vdH7PwnajUHzmaz5zkLfpBOV4PNvGsgc2iUCmDK18AgkVZuA
         z4UQ==
X-Gm-Message-State: AHQUAuYk4cEnFlvNeAxpmdRGjfdoy81c6voD3ngrJj7UK3zSgEz2ZhRN
        tyqMzhtLdu4Y3qM8smau9cg=
X-Google-Smtp-Source: AHgI3IaAVXRlQtadXi/ndF7Sm1C5WPfDeCiYw3USQLsenp5+6mzTfgmGScOQp/DzPfJs5hI7GQ474g==
X-Received: by 2002:adf:e746:: with SMTP id c6mr16925831wrn.218.1549626651310;
        Fri, 08 Feb 2019 03:50:51 -0800 (PST)
Received: from localhost.localdomain (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id w12sm1243600wrr.23.2019.02.08.03.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 03:50:50 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: make '--stress' more bisect-friendly
Date:   Fri,  8 Feb 2019 12:50:45 +0100
Message-Id: <20190208115045.13256-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.940.g8404bb2d1a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's suppose that a test somehow becomes flaky between 'master' and
'pu', and tends to fail within the first 50 repetitions when run with
'--stress'.  In such a case we could use 'git bisect' to find the
culprit: if the test script fails with '--stress', then the commit is
definitely bad, but if it survives, say, 300 repetitions, then we could
consider it good with reasonable confidence.

Unfortunately, all this could only be done manually, because
'--stress' would run the test script repeatedly for all eternity on a
good commit, and it would exit with success even when it found a
failure on a bad commit.

So let's make '--stress' usable with 'git bisect run':

  - Make it exit with failure if a failure is found.

  - Add the '--stress-limit=<N>' option to repeat the test script
    at most N times in each of the parallel jobs, and exit with
    success when the limit is reached.

And then we could simply run something like:

  $ git bisect start origin/pu master
  $ git bisect run sh -c 'make && cd t &&
                          ./t1234-foo.sh --stress --stress-limit=300'

Sure, as a brand new feature it won't be any useful right now, but in
a release or three most cooking topics will already contain this, so
we could automatically bisect at least newly introduced flakiness.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This is a case when an external stress script works better, as it can
easily check commits in the past...  if someone has such a script,
that is.

Anyway, the approach works:

  https://public-inbox.org/git/20190129213533.GE13764@szeder.dev/
  https://public-inbox.org/git/20190208113059.GV10587@szeder.dev/

 t/README      |  5 +++++
 t/test-lib.sh | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 11ce7675e3..3aed321248 100644
--- a/t/README
+++ b/t/README
@@ -202,6 +202,11 @@ appropriately before running "make".
 	'.stress-<nr>' suffix, and the trash directory of the failed
 	test job is renamed to end with a '.stress-failed' suffix.
 
+--stress-limit=<N>::
+	When combined with --stress run the test script repeatedly
+	this many times in each of the parallel jobs or until one of
+	them fails, whichever comes first.
+
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
 You still need to have built this git sandbox, from which various
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a1abb1177a..77eff04c92 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -152,6 +152,17 @@ do
 			;;
 		esac
 		;;
+	--stress-limit=*)
+		stress_limit=${opt#--*=}
+		case "$stress_limit" in
+		*[^0-9]*|0*|"")
+			echo "error: --stress-limit=<N> requires the number of repetitions" >&2
+			exit 1
+			;;
+		*)	# Good.
+			;;
+		esac
+		;;
 	*)
 		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
 	esac
@@ -237,8 +248,10 @@ then
 				exit 1
 			' TERM INT
 
-			cnt=0
-			while ! test -e "$stressfail"
+			cnt=1
+			while ! test -e "$stressfail" &&
+			      { test -z "$stress_limit" ||
+				test $cnt -le $stress_limit ; }
 			do
 				$TEST_SHELL_PATH "$0" "$@" >"$TEST_RESULTS_BASE.stress-$job_nr.out" 2>&1 &
 				test_pid=$!
@@ -261,6 +274,7 @@ then
 
 	if test -f "$stressfail"
 	then
+		stress_exit=1
 		echo "Log(s) of failed test run(s):"
 		for failed_job_nr in $(sort -n "$stressfail")
 		do
-- 
2.20.1.940.g8404bb2d1a

