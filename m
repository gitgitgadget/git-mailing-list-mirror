Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E3EC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF64720714
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9nXQrpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfKVNOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:14:45 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38583 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKVNOp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 08:14:45 -0500
Received: by mail-wm1-f53.google.com with SMTP id z19so7568305wmk.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 05:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGTqyl601weAuS9OiyOPfoiIyk4MhCfpTE/IFBK/ky0=;
        b=J9nXQrpJyE7Y4uQH53qCysQp/lUYnz6WZeDLBEFhuykVqlWXmeTSKv3rX91MsqIhwx
         AJh72VVHsii+sgAf0u6uiII38PupM2l4Yr0uhzpCdDgT+1gOMyNllMrrGGZXQrD4RX6j
         LAcQl0y06Yf625rYCRQf5CKeBdijAqeFZQDFErCNOf4f552qxu1z2la4nMv/jPBd4wjq
         3QNNPn2akQFB0YOe/sYEuo/+4klyg6rw34jHa/VsUrqAtXoVheTfIaI27YKCw97QKxdW
         aLO50te1SU5/eUGGEJ2r2LBWtInw9/6RNVWKARpL9tCtxoJs+/YAjwsBItRUDoXgRY3N
         Pgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGTqyl601weAuS9OiyOPfoiIyk4MhCfpTE/IFBK/ky0=;
        b=GbXeqz4eK7XSo4DeXg/B+8NRN1fhB1lEH2YRUVOwScrzGmZjsfAgicbLgfeVqQGLbz
         cI4FaFvBuYcOnDmwRYOGQdO9MmzpNJDMwi88o14Sq/qH/WpEvLG0OwFOQAI1CscAe11V
         sc0AzVCGyzqJ75Cfnjyo8XNvOh9XWcGSBc9eDDLO7vjE40MRJThpyhlmkDkCHQLAkcKZ
         e1VQ4DfLK9FuXIyoyTbwenciqkEuwC6v1eTLJKGRZqvn7H3DgZ7BnZ6ONmG4mS/iEnhh
         tTYWvSxhiP71xQLJrFpJKWqgvsi/aSrEuI6STjfSTzeruzX/l1K1sSZBb8DtPBj4LrNC
         +/fw==
X-Gm-Message-State: APjAAAXnDL0RdMoby+BAvg5IHDq5ZBuXMRqi6wM6sAECak7+rSYYxQf+
        5WvdgUH6gaLLrGyznPKFNSY=
X-Google-Smtp-Source: APXvYqyiYJI4byvJQRGdFoIkggAUO1n2rE2+XbdTnqCm1hP6u/rTdeQNu7ByLUB3PGMQRxuTbNBBdg==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr5345056wmb.40.1574428482059;
        Fri, 22 Nov 2019 05:14:42 -0800 (PST)
Received: from localhost.localdomain (x4db9604a.dyn.telefonica.de. [77.185.96.74])
        by smtp.gmail.com with ESMTPSA id u4sm7407934wrq.22.2019.11.22.05.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 05:14:41 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Wong <e@80x24.org>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] tests: add 'test_bool_env' to catch non-bool GIT_TEST_* values
Date:   Fri, 22 Nov 2019 14:14:36 +0100
Message-Id: <20191122131437.25849-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.532.ge18579ded8
In-Reply-To: <20191122131437.25849-1-szeder.dev@gmail.com>
References: <20190907101637.GE32087@szeder.dev>
 <20191122131437.25849-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 3b072c577b (tests: replace test_tristate with "git env--helper",
2019-06-21) we get the normalized bool values of various GIT_TEST_*
environment variables via 'git env--helper'.  Now, while the 'git
env--helper' command itself does catch invalid values in the
environment variable or in the given --default and exits with error
(exit code 128 or 129, respectively), it's invoked in conditions like
'if ! git env--helper ...', which means that all invalid bool values
are interpreted the same as the ordinary 'false' (exit code 1).  This
has led to inadvertently skipped httpd tests in our CI builds for a
couple of weeks, see 3960290675 (ci: restore running httpd tests,
2019-09-06).

Let's be more careful about what the test suite accepts as bool values
in GIT_TEST_* environment variables, and error out loud and clear on
invalid values instead of simply skipping tests.  Add the
'test_bool_env' helper function to encapsulate the invocation of 'git
env--helper' and the verification of its exit code, and replace all
invocations of that command in our test framework and test suite with
a call to this new helper (except in 't0017-env-helper.sh', of
course).

  $ GIT_TEST_GIT_DAEMON=YesPlease ./t5570-git-daemon.sh
  fatal: bad numeric config value 'YesPlease' for 'GIT_TEST_GIT_DAEMON': invalid unit
  error: test_bool_env requires bool values both for $GIT_TEST_GIT_DAEMON and for the default fallback

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/README                |  9 +++++++++
 t/lib-git-daemon.sh     |  2 +-
 t/lib-git-svn.sh        |  4 ++--
 t/lib-httpd.sh          |  2 +-
 t/t0000-basic.sh        | 34 ++++++++++++++++++++++++++++++++++
 t/t5512-ls-remote.sh    |  2 +-
 t/test-lib-functions.sh | 30 +++++++++++++++++++++++++++++-
 t/test-lib.sh           | 10 +++++-----
 8 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/t/README b/t/README
index 60d5b77bcc..94e09d025e 100644
--- a/t/README
+++ b/t/README
@@ -978,6 +978,15 @@ library for your script to use.
    output to the downstream---unlike the real version, it generates
    only up to 99 lines.
 
+ - test_bool_env <env-variable-name> <default-value>
+
+   Given the name of an environment variable with a bool value,
+   normalize its value to a 0 (true) or 1 (false or empty string)
+   return code.  Return with code corresponding to the given default
+   value if the variable is unset.
+   Abort the test script if either the value of the variable or the
+   default are not valid bool values.
+
 
 Prerequisites
 -------------
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index fb8f887080..e62569222b 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -15,7 +15,7 @@
 #
 #	test_done
 
-if ! git env--helper --type=bool --default=true --exit-code GIT_TEST_GIT_DAEMON
+if ! test_bool_env GIT_TEST_GIT_DAEMON true
 then
 	skip_all="git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)"
 	test_done
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index bc0b9c71f8..7d248e6588 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -69,7 +69,7 @@ svn_cmd () {
 maybe_start_httpd () {
 	loc=${1-svn}
 
-	if git env--helper --type=bool --default=false --exit-code GIT_TEST_SVN_HTTPD
+	if test_bool_env GIT_TEST_SVN_HTTPD false
 	then
 		. "$TEST_DIRECTORY"/lib-httpd.sh
 		LIB_HTTPD_SVN="$loc"
@@ -104,7 +104,7 @@ EOF
 }
 
 require_svnserve () {
-	if ! git env--helper --type=bool --default=false --exit-code GIT_TEST_SVNSERVE
+	if ! test_bool_env GIT_TEST_SVNSERVE false
 	then
 		skip_all='skipping svnserve test. (set $GIT_TEST_SVNSERVE to enable)'
 		test_done
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 0d985758c6..656997b4d6 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -41,7 +41,7 @@ then
 	test_done
 fi
 
-if ! git env--helper --type=bool --default=true --exit-code GIT_TEST_HTTPD
+if ! test_bool_env GIT_TEST_HTTPD true
 then
 	skip_all="Network testing disabled (unset GIT_TEST_HTTPD to enable)"
 	test_done
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 9ca0818cbe..a297170915 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -878,6 +878,40 @@ test_expect_success 'test_oid can look up data for SHA-256' '
 	test "$hexsz" -eq 64
 '
 
+test_expect_success 'test_bool_env' '
+	(
+		sane_unset envvar &&
+
+		test_bool_env envvar true &&
+		! test_bool_env envvar false &&
+
+		envvar= &&
+		export envvar &&
+		! test_bool_env envvar true &&
+		! test_bool_env envvar false &&
+
+		envvar=true &&
+		test_bool_env envvar true &&
+		test_bool_env envvar false &&
+
+		envvar=false &&
+		! test_bool_env envvar true &&
+		! test_bool_env envvar false &&
+
+		envvar=invalid &&
+		# When encountering an invalid bool value, test_bool_env
+		# prints its error message to the original stderr of the
+		# test script, hence the redirection of fd 7, and aborts
+		# with "exit 1", hence the subshell.
+		! ( test_bool_env envvar true ) 7>err &&
+		grep "error: test_bool_env requires bool values" err &&
+
+		envvar=true &&
+		! ( test_bool_env envvar invalid ) 7>err &&
+		grep "error: test_bool_env requires bool values" err
+	)
+'
+
 ################################################################
 # Basics of the basics
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 43e1d8d4d2..d7b9f9078f 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -267,7 +267,7 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 '
 
 test_lazy_prereq GIT_DAEMON '
-	git env--helper --type=bool --default=true --exit-code GIT_TEST_GIT_DAEMON
+	test_bool_env GIT_TEST_GIT_DAEMON true
 '
 
 # This test spawns a daemon, so run it only if the user would be OK with
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e0b3f28d3a..bf5080cb9b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1173,6 +1173,34 @@ perl () {
 	command "$PERL_PATH" "$@" 2>&7
 } 7>&2 2>&4
 
+# Given the name of an environment variable with a bool value, normalize
+# its value to a 0 (true) or 1 (false or empty string) return code.
+#
+#   test_bool_env GIT_TEST_HTTPD <default-value>
+#
+# Return with code corresponding to the given default value if the variable
+# is unset.
+# Abort the test script if either the value of the variable or the default
+# are not valid bool values.
+
+test_bool_env () {
+	if test $# != 2
+	then
+		BUG "test_bool_env requires two parameters (variable name and default value)"
+	fi
+
+	git env--helper --type=bool --default="$2" --exit-code "$1"
+	ret=$?
+	case $ret in
+	0|1)	# unset or valid bool value
+		;;
+	*)	# invalid bool value or something unexpected
+		error >&7 "test_bool_env requires bool values both for \$$1 and for the default fallback"
+		;;
+	esac
+	return $ret
+}
+
 # Exit the test suite, either by skipping all remaining tests or by
 # exiting with an error. If our prerequisite variable $1 falls back
 # on a default assume we were opportunistically trying to set up some
@@ -1181,7 +1209,7 @@ perl () {
 # The error/skip message should be given by $2.
 #
 test_skip_or_die () {
-	if ! git env--helper --type=bool --default=false --exit-code $1
+	if ! test_bool_env "$1" false
 	then
 		skip_all=$2
 		test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 30b07e310f..959568fa43 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1391,19 +1391,19 @@ yes () {
 # The GIT_TEST_FAIL_PREREQS code hooks into test_set_prereq(), and
 # thus needs to be set up really early, and set an internal variable
 # for convenience so the hot test_set_prereq() codepath doesn't need
-# to call "git env--helper". Only do that work if needed by seeing if
-# GIT_TEST_FAIL_PREREQS is set at all.
+# to call "git env--helper" (via test_bool_env). Only do that work
+# if needed by seeing if GIT_TEST_FAIL_PREREQS is set at all.
 GIT_TEST_FAIL_PREREQS_INTERNAL=
 if test -n "$GIT_TEST_FAIL_PREREQS"
 then
-	if git env--helper --type=bool --default=0 --exit-code GIT_TEST_FAIL_PREREQS
+	if test_bool_env GIT_TEST_FAIL_PREREQS false
 	then
 		GIT_TEST_FAIL_PREREQS_INTERNAL=true
 		test_set_prereq FAIL_PREREQS
 	fi
 else
 	test_lazy_prereq FAIL_PREREQS '
-		git env--helper --type=bool --default=0 --exit-code GIT_TEST_FAIL_PREREQS
+		test_bool_env GIT_TEST_FAIL_PREREQS false
 	'
 fi
 
@@ -1462,7 +1462,7 @@ then
 fi
 
 test_lazy_prereq C_LOCALE_OUTPUT '
-	! git env--helper --type=bool --default=0 --exit-code GIT_TEST_GETTEXT_POISON
+	! test_bool_env GIT_TEST_GETTEXT_POISON false
 '
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
-- 
2.24.0.532.ge18579ded8

