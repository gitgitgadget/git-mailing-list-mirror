Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF621ADC7
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776499275; cv=none; b=a8HcxU/gTscJCksG/H5s53AQAl2GjQ2m8MDr5qEkTNMPyknuekwTwhuwmx9VR0aqBBw14kFYLz7vW37X6OKWw7hDowL8sv6D4AORayGXqy6QlFvl5u9kKxofrpIf7iNCAki34eoWKXq4n88Y/qoj/CS6XQu39n42JlFNedFhyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776499275; c=relaxed/simple;
	bh=lEW03jM9stSmBUI7zLOHjVuGpVnroCPP2ruvCC0uVyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9JadhUnCkCqns54OU0bPAD60us3ew3DblPPQxFXQX/qQmRuI/Ce1OkDbrKlVuZnxcDGTe7mAl58fo4dpEhEypn3qwqcBh3hanrpysnjtbh2RkB5iKWKCc84Oqq0W+UhSvuWE/TqYjet8UJqjCpGMNc6aeSbYI7b/mAEnaBCvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fCNGFiq8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fCNGFiq8"
Received: (qmail 388590 invoked by uid 106); 18 Apr 2026 08:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lEW03jM9stSmBUI7zLOHjVuGpVnroCPP2ruvCC0uVyY=; b=fCNGFiq8eE988XHmU+pE/bCMruchyPPzEHytSWo43VAy0bdMbXzrQH6PSrVjhJH7eHls1pIlm7yrJsC2gvtIegU6VqNet5Ya2tblKQIcjFOFJBYphqRXP8C68YypsSosqhD7li/YQORWXatTEcsMgIUkLU2kskNxe5s1dWdGhe24LyO9l8GTawyxHPYBTIbM76/5yJfiNX1K+fzVumjpBDKsWVW531ny+cd+IyQ+GtVsRm9BYVJG7Y1DVJbbSGc6L0g4HvltPAZYBsT2EMU9fjwbB1lFCe1UzTr9CuCgQ/dM9/2ENyzziagQ6pUZ70MDPuizaGSOIA4PrIXDPuk5cg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Apr 2026 08:01:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 650459 invoked by uid 111); 18 Apr 2026 08:01:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Apr 2026 04:01:12 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Apr 2026 04:01:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <20260418080111.GA3187789@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
 <ad3rgbgadjIZRgaz@pks.im>
 <20260414220347.GA3475127@coredump.intra.peff.net>
 <20260414225206.GA3486072@coredump.intra.peff.net>
 <20260414230810.GA3528448@coredump.intra.peff.net>
 <ad80r_oY-uAV2zVt@pks.im>
 <20260416054924.GB646814@coredump.intra.peff.net>
 <xmqqtstb3rf1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtstb3rf1.fsf@gitster.g>

On Thu, Apr 16, 2026 at 07:34:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm still concerned that this approach is going to create extra friction
> > for test writers down the road. This series needed to clean up several
> > spots to avoid false positives, and some of the spots were non-trivial.
> >
> > Now that was the accumulated cruft of 20 years of test-writing, so it's
> > not clear to me how often new test-writers will run into this. But when
> > they do, I worry that it may be hard to even figure out what is going
> > on.
> >
> > But I've said as much in earlier rounds, and I'm not sure Junio agrees.
> > So we can note my dissent in the captain's log, and I can reserve the
> > right to told-you-so later if need be. ;)
> 
> The alternatigve to allow us to be sloppy is alluring from the point
> of view of a test writer in me.  But do we have an easy/canned way
> to run tests and see the unexpected failures outside test_expect_foo
> while ignoring all the noises from passing tests?  Perhaps running
> tests (with and without prove) while redirecting the standard output
> stream to /dev/null or something?

I took a stab at this. It's easy to do it hackily, but it proved a
little trickier than I'd hoped to get something elegant.

My main goals were that you would still get good output to either the
terminal or the test-results/*.out files (so we can't just redirect
stderr for all runs), and that we wouldn't spend too much extra CPU (so
just running the tests an extra time with stderr redirected is right
out).

My first attempt was to teach test-lib.sh a mode where all of the test
snippets are noops, stderr goes to a file in test-results/, and at the
end of the script we complain if our stderr file is non-empty. And then
we have a "test-lint-stderr" make target that runs each script in the
special mode. That works, but:

  1. Quite a few scripts do stuff inside their test snippets that affect
     the environment, and then do stuff outside of a test snippet that
     depends on that. Some of it is questionable, like running git
     commands outside of test snippets to generate expected output. But
     there's reasonable stuff like t0012 generating the list of builtin
     inside a test snippet and expecting:

       while read builtin
       do
               test_expect_success "$builtin..." ...
       done <builtins

     So I think the test suite is a little too free-form for this kind
     of trickery.

  2. It's way too slow, anyway. Even with all of the snippets as noops,
     it still takes ~13s to run all of the scripts in parallel on my
     machine. The real test suite only takes ~90 seconds! There's
     probably low-hanging fruit to fix there, but it's still an order of
     magnitude off what I'd hope the cost would be.

So I think that's probably a dead end.

The next obvious choice is redirecting stderr via tee or similar, which
is easy-ish. We already do it for --verbose-log, but we combine it with
stdout there (and we turn on verbose mode for the tests, which is going
to generate a bunch of extra output).

I think there's probably a way to do this with an extra tee for stderr.
But actually...do we even need tee? The idea is that we are not
expecting any output here, so if there is any, we'd bail and show it
along with an error.

So I think we might able able to get by with just redirecting descriptor
2, and then making sure that test snippets stderr goes to the original
stderr (which we already save as descriptor 7). And we catch only errors
outside of the snippet.

Something like this seems to work:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f7868c537..6657d56e52 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -728,7 +728,7 @@ then
 	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
 elif test "$verbose" = "t"
 then
-	exec 4>&2 3>&2
+	exec 4>&7 3>&7
 else
 	exec 4>/dev/null 3>/dev/null
 fi
@@ -970,7 +970,7 @@ maybe_setup_verbose () {
 	test -z "$verbose_only" && return
 	if match_pattern_list $test_count "$verbose_only"
 	then
-		exec 4>&2 3>&2
+		exec 4>&7 3>&7
 		# Emit a delimiting blank line when going from
 		# non-verbose to verbose.  Within verbose mode the
 		# delimiter is printed by test_expect_*.  The choice
@@ -1052,7 +1052,7 @@ test_eval_ () {
 			test 1 = $trace_level_ && set +x
 			trace_level_=$(($trace_level_-1))
 		fi
-	} 2>/dev/null 4>&2
+	} 2>/dev/null 4>&7
 
 	if test "$test_eval_ret_" != 0 && want_trace
 	then
@@ -1234,6 +1234,14 @@ test_done () {
 		EOF
 	fi
 
+	if test -s "$TEST_RESULTS_BASE.stderr"
+	then
+		say_color >&5 error "FATAL: Unexpected output on stderr"
+		sed >&5 's/^/# /' "$TEST_RESULTS_BASE.stderr"
+		GIT_EXIT_OK=1
+		exit 1
+	fi
+
 	if test "$test_fixed" != 0
 	then
 		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
@@ -1982,3 +1990,9 @@ test_lazy_prereq FSMONITOR_DAEMON '
 	git version --build-options >output &&
 	grep "feature: fsmonitor--daemon" output
 '
+
+# Now that test-lib setup is done, direct our stderr to a file, as we want to
+# catch and complain if anything ends up here. We can always access the
+# original via descriptor 7.
+mkdir -p "$TEST_RESULTS_DIR"
+exec 2>"$TEST_RESULTS_BASE.stderr"


If I stick a "test_expect_foobar" into a test script, it is found:

  $ ./t0001-init.sh
  ok 1 - plain
  [...]
  ok 102 - re-init reads matching includeIf.onbranch
  FATAL: Unexpected output on stderr
  # ./t0001-init.sh: 983: test_expect_foobar: not found

And if I run scripts with "-v" or "-x", that output still goes to the
terminal and does not trigger the stderr checker. Likewise with
--verbose-log, the log gets the verbose bits.

It _almost_ passes a full "make test", but there's one lingering
problem: random bits of code which want to output to stderr and bail,
and use "echo >&2" to do so. But with our redirect, that stderr goes to
the log file. t0000-basic notices this, because it is testing the test
suite itself. And it notices that:

  ./t0000-basic.sh --run=bogus

should complain to stderr, but now doesn't (it's swallowed by our log
file). We can fix that with;

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6657d56e52..aa6415b308 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -902,13 +902,13 @@ match_test_selector_list () {
 				if expr "z${selector%%-*}" : "z[0-9]*[^0-9]" >/dev/null
 				then
 					echo "error: $operation: invalid non-numeric in range" \
-						"start: '$orig_selector'" >&2
+						"start: '$orig_selector'" >&7
 					exit 1
 				fi
 				if expr "z${selector#*-}" : "z[0-9]*[^0-9]" >/dev/null
 				then
 					echo "error: $operation: invalid non-numeric in range" \
-						"end: '$orig_selector'" >&2
+						"end: '$orig_selector'" >&7
 					exit 1
 				fi
 				;;

but the same problem doubtless exists elsewhere. We could fix that
globally like this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6657d56e52..72d60d9dac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -762,6 +762,15 @@ die () {
 	# test script run with '--immediate' fails, or when the user hits
 	# ctrl-C, i.e. when 'test_done' is not invoked at all.
 	test_atexit_handler || code=$?
+
+	# Dump the stderr log if we saw anything, since otherwise random
+	# errors will never make it to the user when we do not have
+	# a clean exit.
+	if test -s "$TEST_RESULTS_BASE.stderr"
+	then
+		cat >&7 "$TEST_RESULTS_BASE.stderr"
+	fi
+
 	if test -n "$GIT_EXIT_OK"
 	then
 		exit $code

It's a little weird because the stderr message is delayed until we cat
it out, but it makes sense. If we are bailing immediately, then the time
between "echo" and "cat" is small. And if we are not bailing, then that
is exactly the kind of bug our stderr log is trying to catch (and we
will complain during test_done).

I am not quite sure if this is an elegant solution or a terrible hack.

-Peff
