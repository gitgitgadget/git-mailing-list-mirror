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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94474C43331
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAB465295
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhCIQCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhCIQCi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B83C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d15so16674584wrv.5
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YXwATKGLbwdszIbTkmJkGKn03Q4N71xSsaIjabpWuo=;
        b=fNZO6Vios/Up2JV2uPN/Q41fc2tLwRWKLhe6YWC8SAm1hWf9fjBOtuMaHgCa+TYqJv
         NL7VHg8h7xScOnqQ9FACgol9iuLtdxpYGuD9nD1MAsORGj6KVh9tKmheAQiS7Ws8ynX1
         tslWntu8q2s6LjVbNv41Y+7YHVmw5zP7UYXWn+6E9EX/wefgsWzn4hRODP/0xw1NISfE
         W7QU8bVEw15BncChHFrvFVVfbcPaj/0DxSHdYtwcMA8NPsBlM4nhZOWR65rNIZgHfcLc
         DSUY1l/E16cEzDnIv8+cY1tkr5mAIp28GDRn53oHPoqzFdt65GDEC3MnlPt+zuYqTR2h
         8LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YXwATKGLbwdszIbTkmJkGKn03Q4N71xSsaIjabpWuo=;
        b=gM82czQWsdYNfK5SYfxSrAXueI9RmJr3eJ1Zf3gOIVp0oUO+RCbV2294M6U6KxGF0z
         /tPs3nb35xb2fQu+ZX2Z49zh7Fl7mb/mQ+W0UBZuYFz/zWS6jQ6wRUXwkAmJ4Km9YGr5
         oD91f65wm1DMGUji7kSGbPnu7oYnCuQ8wWPGrfSkltPVlEA7bUUcg+/ICBF9eZW63nAQ
         1lCSjIXJNIm5teDuuiCuJMpd4WnvLFVNe/sPAKFFPLb9gcEv8xOzm5eqgb4LP7lyyc0t
         ERmIXgf+FNndpv1KbHGQ4dv5UQC9/0IEXf9O8HqEKU7IGxC04CZU+gJopjqaIIE0DDWS
         Nmig==
X-Gm-Message-State: AOAM531T4WBLtCTAsDgoIsSCLZRkgd00lLBJULZD29TutYe3iKdlNZQ0
        OLPHnOP+BPXv/wKXsThIP9mP5FR6S26ymQ==
X-Google-Smtp-Source: ABdhPJz3034JMCHeVumMfueJJYfNvXVfsaXV2tu0B1xVV+2HLGUSDXJdnAZAPBIMfLEEMvln/qsBew==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr28856982wra.47.1615305756740;
        Tue, 09 Mar 2021 08:02:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] test-lib: make --verbose output valid TAP
Date:   Tue,  9 Mar 2021 17:02:18 +0100
Message-Id: <20210309160219.13779-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the --verbose output be valid TAP, making it machine-readable for
TAP parsers again.

Both the verbose and non-verbose test outputs were valid TAP back when
I added support for TAP in 5099b99d25f (test-lib: Adjust output to be
valid TAP format, 2010-06-24).

Sometime after that the --verbose output broke due to some tests
emitting their own lines starting "ok" (or otherwise invalidate the
TAP). That was noticed and fixed in 452320f1f5 (test-lib: add
--verbose-log option, 2016-10-21) and "fixed" by simply turning off
the verbose mode when we were running under TAP::Harness (e.g. under
"prove").

That solution worked for running under Travis CI. After that fix it
was made to use the --verbose-log option in 041c72de109 (travis: use
--verbose-log test option, 2016-10-21), see 522354d70f4 (Add Travis CI
support, 2015-11-27) for the "cat t/test-results/*.out" code that was
aimed at.

But that solution and others discussed in 452320f1f5 closed the door
on us having reliable machine-readable TAP output.

Let's instead revert the work done in 452320f1f5 and, as well as the
follow-up commits 88c6e9d31c (test-lib: --valgrind should not override
--verbose-log, 2017-09-05) and f5ba2de6bc (test-lib: make "-x" work
with "--verbose-log", 2017-12-08), which were only needed to work
around bugs in the the previous --verbose-log implementation.

Replace it with a simple method for ensuring that we have valid TAP
both on stdout, and in any verbose output we write. When we detect
that we're running under "prove" we prefix all legitimate TAP
directives with "GIT_TEST_TEE_STARTED":

    $ GIT_TEST_TEE_STARTED=1 ./t5547-push-quarantine.sh
    GIT_TEST_TEE_STARTED ok 1 - create picky dest repo
    GIT_TEST_TEE_STARTED ok 2 - accepted objects work
    [...]
    GIT_TEST_TEE_STARTED 1..6

Then, instead of piping the output to "tee -a" we pipe it to a helper
which first converts "ok" and other TAP syntax to e.g. "\ok", and then
strips that "GIT_TEST_TEE_STARTED " prefix from the start of the line.

The end result is that we're guaranteed to have valid TAP syntax on
stdout.

We can thus get rid of the --verbose-log special-case. Since that
option was meant to get around the TAP issue let's simply make it an
alias for "--verbose --tee".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README         |  9 ++++++---
 t/t0000-basic.sh |  8 ++++++++
 t/test-lib.sh    | 43 +++++++++++++++++++++----------------------
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/t/README b/t/README
index 2cc8cbc7185..f09d94e754e 100644
--- a/t/README
+++ b/t/README
@@ -157,10 +157,13 @@ appropriately before running "make". Short options can be bundled, i.e.
 
 -V::
 --verbose-log::
-	Write verbose output to the same logfile as `--tee`, but do
-	_not_ write it to stdout. Unlike `--tee --verbose`, this option
+	An alias for `--verbose --tee`. This option
 	is safe to use when stdout is being consumed by a TAP parser
-	like `prove`. Implies `--tee` and `--verbose`.
+	like `prove`.
+	Historically this option was different from `--verbose --tee`
+	and would not write any verbose output to stdout to ensure the
+	TAP-correctness of the output. The TAP-correctness of the
+	output is now sanity checked by the test library,
 
 --with-dashes::
 	By default tests are run without dashed forms of
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27a..2a95a612fb0 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -76,6 +76,14 @@ _run_sub_test_lib_test_common () {
 		# this variable, so we need a stable setting under which to run
 		# the sub-test.
 		sane_unset HARNESS_ACTIVE &&
+
+		# When under --tee pretend we're not as far as
+		# emitting the "GIT_TEST_TEE_STARTED " TAP sanity
+		# prefix goes. This means we promise not to emit
+		# invalid TAP, least this test fails under --tee under
+		# prove(1).
+		sane_unset GIT_TEST_TEE_STARTED &&
+
 		cd "$name" &&
 		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
 		test_description='$descr (run in sub test-lib)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index aa7068b06b6..0070d05234b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -146,9 +146,11 @@ parse_option () {
 	--no-chain-lint)
 		GIT_TEST_CHAIN_LINT=0 ;;
 	-x)
-		trace=t ;;
+		trace=t
+		verbose=t
+		;;
 	-V|--verbose-log)
-		verbose_log=t
+		verbose=t
 		tee=t
 		;;
 	--write-junit-xml)
@@ -233,7 +235,7 @@ then
 	test -z "$verbose" && verbose_only="$valgrind_only"
 elif test -n "$valgrind"
 then
-	test -z "$verbose_log" && verbose=t
+	verbose=t
 fi
 
 if test -n "$stress"
@@ -364,9 +366,22 @@ then
 	(
 		GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1
 		echo $? >"$TEST_RESULTS_BASE.exit"
-	) | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	) | "$GIT_BUILD_DIR"/t/helper/test-tool tee \
+		--tap --prefix="GIT_TEST_TEE_STARTED " \
+		--escape-stdout ${HARNESS_ACTIVE+--escape-file} \
+		"$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
+elif test -n "$verbose" -a -n "$HARNESS_ACTIVE"
+then
+	ret=
+	(
+		GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1
+		ret=$?
+	) | "$GIT_BUILD_DIR"/t/helper/test-tool tee \
+		--tap --prefix="GIT_TEST_TEE_STARTED " \
+		--escape-stdout
+	exit $ret
 fi
 
 if test -n "$trace" && test -n "$test_untraceable"
@@ -392,10 +407,6 @@ then
 		trace=
 	fi
 fi
-if test -n "$trace" && test -z "$verbose_log"
-then
-	verbose=t
-fi
 
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
@@ -569,7 +580,7 @@ say_color_tap() {
 	test "$#" = 2 ||
 	BUG "not 2 parameters to say_color_tap"
 
-	say_color "$1" "$2"
+	say_color "$1" "${GIT_TEST_TEE_STARTED:+GIT_TEST_TEE_STARTED }$2"
 }
 
 TERM=dumb
@@ -590,16 +601,6 @@ say () {
 	say_color info "$*"
 }
 
-if test -n "$HARNESS_ACTIVE"
-then
-	if test "$verbose" = t || test -n "$verbose_only"
-	then
-		printf 'Bail out! %s\n' \
-		 'verbose mode forbidden under TAP harness; try --verbose-log'
-		exit 1
-	fi
-fi
-
 test "${test_description}" != "" ||
 error "Test script did not set test_description."
 
@@ -887,9 +888,7 @@ maybe_setup_valgrind () {
 
 trace_level_=0
 want_trace () {
-	test "$trace" = t && {
-		test "$verbose" = t || test "$verbose_log" = t
-	}
+	test "$trace" = t && test "$verbose" = t
 }
 
 # This is a separate function because some tests use
-- 
2.31.0.rc1.210.g0f8085a843c

