Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922DC433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186FB64E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhB1UZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 15:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhB1UZt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 15:25:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D128C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 12:25:09 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ci14so5434754ejc.7
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 12:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GOJjJhx6AzDlgn5udE+DYxKvRu79gVASsO8exBg+G2M=;
        b=JT4Mp+yI9B1Fa/dYQWUbkKpfnGaI1rA6h/I25uORkIaCmb6U3a5i76ESPGoLUqqYxi
         V29Z4GP++wjZ7mCfECe0FuaZlAPNz404DYgAOnqU6KuOr+JJA79VyvRBIOlv/DNIHvmm
         qOL4ModtDUWRYemFM1AKI5hDxEWdYkq2olyNDZp/1WyvZZAMDp8UPFuIL/E4f+rnIvZ2
         Y9VnYsECJnc8WxFMDzi5oEI6xtL97VV3c3NiLN092yRhunul4WpBzs0udSQN3ZRtgWf2
         +d2Mf2VogJtNrFEXLSc3ULrQlQYENOu1hXZGBHP9zHAxtMZe7evx7j+I+oNKVhN8T7Dv
         55nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GOJjJhx6AzDlgn5udE+DYxKvRu79gVASsO8exBg+G2M=;
        b=KamcYjEN1paXY0SSyZcuN1gkiAmtP8IZ5BfoYHBYC1D0wp0Ogo12unvua/0aJTe9Ib
         ev/c6MXQE/YG5z5MIcFRnRav15Qemk3xRGjvZv4oCJ5q2wRvrNn96XscHxnrqgyp2anL
         /8S2vUM+6kuyt1fgh/LExjQTq8BIw7LXU8zxj3kXzg97sWZ4J6Md2iJ/i0cd+ayDn20I
         iF9iYxwAqJzzdKLhAPTW9meob02dbOiLB+Wxtw8btiCri9a/DHjPdA2Jd+D47NrzqVau
         GPHGbndN19bym5QHxkbFIETN+zMueIIXeXz8blvBN0lpEZpJILGOBIKbGwk/FGBG0hwJ
         ZGYw==
X-Gm-Message-State: AOAM531d5a6Y72DjoF+l5qYqDOjgMeG8cqoB4xrRrLQRI3j1LQp4SjJU
        5eDUGqoW6TY4AhdVccRoZ+S/ph0P/oVTKg==
X-Google-Smtp-Source: ABdhPJzb3qAuAPRX+/A1Vqc3+mOKQmzuuHiY2ewAUewXlI3qk+JPAJOLMY2lmK2vv84PbJfndnmgGg==
X-Received: by 2002:a17:906:2795:: with SMTP id j21mr12326291ejc.283.1614543907510;
        Sun, 28 Feb 2021 12:25:07 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l18sm2390275ejk.86.2021.02.28.12.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 12:25:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH/RFC] test-lib: make --verbose work under prove
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
 <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net>
Date:   Sun, 28 Feb 2021 21:25:06 +0100
Message-ID: <87tupwj5y5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


As explained in 452320f1f5 (test-lib: add --verbose-log option,
2016-10-21) combining the "--verbose" option with the TAP-parsing
"prove" utility would result in broken tests.

This is because "prove" expects valid TAP on stdout, and if there's a
stray line starting with "ok", or other invalid TAP syntax it will
error on the test.

In 452320f1f5 numerous potential methods are discussed for dealing
with this problem, but not the one implemented here, which I think is
a much simpler approach.

When we detect that we're running under "prove" we prefix all
legitimate TAP directives with "GIT_TEST_TEE_STARTED":

    $ GIT_TEST_TEE_STARTED=3D1 ./t5547-push-quarantine.sh
    GIT_TEST_TEE_STARTED ok 1 - create picky dest repo
    GIT_TEST_TEE_STARTED ok 2 - accepted objects work
    [...]
    GIT_TEST_TEE_STARTED 1..6

Then, instead of piping the output to "tee -a" we pipe it to a helper
which first converts "ok" and other TAP syntax to e.g. "\ok", and then
strips that "GIT_TEST_TEE_STARTED " prefix from the start of the line.

The end result is that we're guaranteed to have valid TAP syntax on
stdout. We can thus get rid of the --verbose-log special-case. Since
that option was meant to get around the TAP issue let's simply make it
an alias for "--verbose --tee".

We can also revert relevant parts of 88c6e9d31c (test-lib: --valgrind
should not override --verbose-log, 2017-09-05) and
f5ba2de6bc (test-lib: make "-x" work with "--verbose-log",
2017-12-08), which were follow-up changes to work around the previous
--verbose-log implementation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---

On Fri, Oct 21 2016, Jeff King wrote:

> The "--verbose" option redirects output from arbitrary
> test commands to stdout. This is useful for examining the
> output manually, like:
>
>   ./t5547-push-quarantine.sh -v | less
>
> But it also means that the output is intermingled with the
> TAP directives, which can confuse a TAP parser like "prove".
> This has always been a potential problem, but became an
> issue recently when one test happened to output the word
> "ok" on a line by itself, which prove interprets as a test
> success:
>
>   $ prove t5547-push-quarantine.sh :: -v
>   t5547-push-quarantine.sh .. 1/? To dest.git
>    * [new branch]      HEAD -> master
>   To dest.git
>    ! [remote rejected] reject -> reject (pre-receive hook declined)
>   error: failed to push some refs to 'dest.git'
>   fatal: git cat-file d08c8eba97f4e683ece08654c7c8d2ba0c03b129: bad file
>   t5547-push-quarantine.sh .. Failed -1/4 subtests
>
>   Test Summary Report
>   -------------------
>   t5547-push-quarantine.sh (Wstat: 0 Tests: 5 Failed: 0)
>     Parse errors: Tests out of sequence.  Found (2) but expected (3)
>                   Tests out of sequence.  Found (3) but expected (4)
>                   Tests out of sequence.  Found (4) but expected (5)
>                   Bad plan.  You planned 4 tests but ran 5.
>   Files=3D1, Tests=3D5,  0 wallclock secs ( 0.01 usr +  0.01 sys =3D  0.0=
2 CPU)
>   Result: FAIL
>
> One answer is "if it hurts, don't do it", but that's not
> quite the whole story. The Travis tests use "--verbose
> --tee" so that they can get the benefit of prove's parallel
> options, along with a verbose log in case there is a
> failure. We just need the verbose output to go to the log,
> but keep stdout clean.
>
> Getting this right turns out to be surprisingly difficult.
> Here's the progression of alternatives I considered:
>
>  1. Add an option to write verbose output to stderr. This is
>     hard to capture, though, because we want each test to
>     have its own log (because they're all run in parallel
>     and the jumbled output would be useless).
>
>  2. Add an option to write verbose output to a file in
>     test-results. This works, but the log is missing all of
>     the non-verbose output, which gives context.
>
>  3. Like (2), but teach say_color() to additionally output
>     to the log. This mostly works, but misses any output
>     that happens outside of the say() functions (which isn't
>     a lot, but is a potential maintenance headache).
>
>  4. Like (2), but make the log file the same as the "--tee"
>     file. That almost works, but now we have two processes
>     opening the same file. That gives us two separate
>     descriptors, each with their own idea of the current
>     position. They'll each start writing at offset 0, and
>     overwrite each other's data.
>
>  5. Like (4), but in each case open the file for appending.
>     That atomically positions each write at the end of the
>     file.
>
>     It's possible we may still get sheared writes between
>     the two processes, but this is already the case when
>     writing to stdout. It's not a problem in practice
>     because the test harness generally waits for snippets to
>     finish before writing the TAP output.
>
>     We can ignore buffering issues with tee, because POSIX
>     mandates that it does not buffer. Likewise, POSIX
>     specifies "tee -a", so it should be available
>     everywhere.
>
> This patch implements option (5), which seems to work well
> in practice.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Arguably we don't need a new option for this, and could just do it
> automatically. I wasn't sure when, though:
>
>   - if "--tee --verbose" triggers it, then somebody running that outside
>     of "prove" who _wants_ the verbose output on stdout (because they're
>     looking at it, but also want to save a copy to the log) would be
>     regressed
>
>   - possibly "--tee" could just always write verbose output to the
>     logfile (but not stdout). That's kind of weirdly magical, and we'd
>     have to update the travis invocation anyway.
>
> So I went with a new option which implies the other ones. No chance of
> regression, and it's easy to explain.

I came up with a #6 for this which I found much simpler: We control the
TAP output, so instead of emitting "ok" and having it be corrupted,
let's emit "<some unique string> ok", and then have our own "tee -a" and
search-replace it back & forth.

The above RFC is in the middle of a topic branch I have locally, so it
doesn't apply cleanly to anything.

I just thought I'd send it as an RFC to see if anyone had issues with
the approach, and to simply make --verbose-log a synonym for --verbose
--tee with this fix. Having the verbose output under "prove" doesn't
matter, it will only report on the TAP, so quieting the output had no UI
impact.

The t/lib-test/* changes of calling "sed" once per-line under --tee are
relatively inefficient. But it would be rather trivial to convert this
to a our own "tee -a"-alike t/helper/* using strbuf_getline() and wrote
to stdout and a file if anyone saw a practical issue with that part of
the implementation (e.g. maybe it's very slow on Windows or something).

 t/README                   |  9 ++++++---
 t/lib-test/tapify-tee-a.sh | 10 ++++++++++
 t/lib-test/tapify.sh       |  5 +++++
 t/t0000-basic.sh           |  8 ++++++++
 t/test-lib.sh              | 40 +++++++++++++++++---------------------
 5 files changed, 47 insertions(+), 25 deletions(-)
 create mode 100644 t/lib-test/tapify-tee-a.sh
 create mode 100644 t/lib-test/tapify.sh

diff --git a/t/README b/t/README
index 593d4a4e27..bf1f3313ac 100644
--- a/t/README
+++ b/t/README
@@ -157,10 +157,13 @@ appropriately before running "make". Short options ca=
n be bundled, i.e.
=20
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
=20
 --with-dashes::
 	By default tests are run without dashed forms of
diff --git a/t/lib-test/tapify-tee-a.sh b/t/lib-test/tapify-tee-a.sh
new file mode 100644
index 0000000000..f90f9a89c2
--- /dev/null
+++ b/t/lib-test/tapify-tee-a.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+# A 'tee -a'-alike that protects the sanity of the TAP output, for
+# test-lib.sh's --tee option
+
+while read -r line
+do
+      printf "%s\n" "$line"
+      printf "%s\n" "$line" | sed 's/^GIT_TEST_TEE_STARTED //' >>"$1"
+done | $TEST_SHELL_PATH "$TEST_DIRECTORY/lib-test/tapify.sh"
diff --git a/t/lib-test/tapify.sh b/t/lib-test/tapify.sh
new file mode 100644
index 0000000000..bfa66d33b4
--- /dev/null
+++ b/t/lib-test/tapify.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+sed \
+    -e 's/^\(ok\|not ok\|1\.\.\)/\\\1/' \
+    -e 's/^GIT_TEST_TEE_STARTED //'
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27..2a95a612fb 100755
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
 		test_description=3D'$descr (run in sub test-lib)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index af7a16fddd..f533cc02e9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -146,9 +146,11 @@ parse_option () {
 	--no-chain-lint)
 		GIT_TEST_CHAIN_LINT=3D0 ;;
 	-x)
-		trace=3Dt ;;
+		trace=3Dt
+		verbose=3Dt
+		;;
 	-V|--verbose-log)
-		verbose_log=3Dt
+		verbose=3Dt
 		tee=3Dt
 		;;
 	--write-junit-xml)
@@ -233,7 +235,7 @@ then
 	test -z "$verbose" && verbose_only=3D"$valgrind_only"
 elif test -n "$valgrind"
 then
-	test -z "$verbose_log" && verbose=3Dt
+	verbose=3Dt
 fi
=20
 if test -n "$stress"
@@ -364,9 +366,19 @@ then
 	(
 		GIT_TEST_TEE_STARTED=3Ddone ${TEST_SHELL_PATH} "$0" "$@" 2>&1
 		echo $? >"$TEST_RESULTS_BASE.exit"
-	) | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	) | $TEST_SHELL_PATH \
+		"$TEST_DIRECTORY/lib-test/tapify-tee-a.sh" \
+		"$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$TEST_RESULTS_BASE.exit")" =3D 0
 	exit
+elif test -n "$verbose" -a -n "$HARNESS_ACTIVE"
+then
+	ret=3D
+	(
+		GIT_TEST_TEE_STARTED=3Ddone ${TEST_SHELL_PATH} "$0" "$@" 2>&1
+		ret=3D$?
+	) | $TEST_SHELL_PATH "$TEST_DIRECTORY/lib-test/tapify.sh"
+	exit $ret
 fi
=20
 if test -n "$trace" && test -n "$test_untraceable"
@@ -392,10 +404,6 @@ then
 		trace=3D
 	fi
 fi
-if test -n "$trace" && test -z "$verbose_log"
-then
-	verbose=3Dt
-fi
=20
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
@@ -569,7 +577,7 @@ say_color_tap() {
 	test "$#" =3D 2 ||
 	BUG "not 2 parameters to say_color_tap"
=20
-	say_color "$1" "$2"
+	say_color "$1" "${GIT_TEST_TEE_STARTED:+GIT_TEST_TEE_STARTED }$2"
 }
=20
 TERM=3Ddumb
@@ -590,16 +598,6 @@ say () {
 	say_color info "$*"
 }
=20
-if test -n "$HARNESS_ACTIVE"
-then
-	if test "$verbose" =3D t || test -n "$verbose_only"
-	then
-		printf 'Bail out! %s\n' \
-		 'verbose mode forbidden under TAP harness; try --verbose-log'
-		exit 1
-	fi
-fi
-
 test "${test_description}" !=3D "" ||
 error "Test script did not set test_description."
=20
@@ -889,9 +887,7 @@ maybe_setup_valgrind () {
=20
 trace_level_=3D0
 want_trace () {
-	test "$trace" =3D t && {
-		test "$verbose" =3D t || test "$verbose_log" =3D t
-	}
+	test "$trace" =3D t && test "$verbose" =3D t
 }
=20
 # This is a separate function because some tests use
--=20
2.31.0.rc0.126.g04f22c5b82
