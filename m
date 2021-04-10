Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A18C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B512561105
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhDJIaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDJIaX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 04:30:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854B3C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 01:30:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ba6so9165851edb.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bzyIMPI4igP4JeCJNGXy7x1SkKU0tzU6cQ52lhQRedQ=;
        b=sui9Hdmu7cE3KqkTP5/bszBr+12NOZsFQrN96z11Y7Dltg08f52cfICFXf8CLmKcZQ
         /OHIIqG0uy4ESSCefA72267Fc5J3ljMkGAb7+pHPGhH80r2uK+E1sBVGF8BpdUlM11gG
         a9FBfu9l6pforAsQ7VODJ+VrnABihB385qzWpEuxlLTFSgK5AohMxDk/t8d+JLQY9hkz
         pPtg7uECvtR642Eazm5+tIn1Tn99hrqJMz3dvaxuhz4NGS8UmlCo1wFiVr5+KP9Q4Cem
         RghT3X0daqcuETRmZzPqX7SkVyNEGkDn/VeQOi5CKV5m8+ZQDL1bKY0zkE0s8lAKxP8w
         K7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bzyIMPI4igP4JeCJNGXy7x1SkKU0tzU6cQ52lhQRedQ=;
        b=Y+0NG+YpaumBkYIy69zw2/Uct7xUr1Knag1toLMXUKMu0hFjp6eFvkwqrTO0JCjVQ7
         FHY2IFxpgVQxi790ElAYY6eLXL09aVARdBHTDqhPXP/Pi/DvtuGx9++T9CxI3aBFIOxN
         9A5hVL1N2tOdik6wdsDNCq+Q9Mwh0Fj6DXFQttyV2jIsJ/GAs+X6u6LRbhHLxhWy9qnF
         ovbRw5HS9y9GdsVJAr3v1h7Mxp1gczU54Rb36l3oQIO0rXlxZrk/V7QxGpmheQAcpQy+
         d36gy6iohy93pTyt5TEE20jJ9khQ7qwldohJCdTSbjuEB2qf1W1NR0vsl1GKjFZr5GeS
         IXQQ==
X-Gm-Message-State: AOAM532Pu3cQsnHX0Uju74j5HRTdjo/6Hl1gfI8juwIJgpm8NFsMrO00
        DmIMGBiWMpvkl6dyQdvCkII=
X-Google-Smtp-Source: ABdhPJyXulf0FeGr71Zh6dSsAEli4yqyG7Snt5pdcV5U+hEBfv+x6S6woKOw2GB3BMSdH+lFDwyXNw==
X-Received: by 2002:a50:fd16:: with SMTP id i22mr20822475eds.239.1618043407002;
        Sat, 10 Apr 2021 01:30:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id by25sm2346525ejc.49.2021.04.10.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 01:30:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
 <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
Date:   Sat, 10 Apr 2021 10:30:05 +0200
Message-ID: <87a6q6h78y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, Jeff King wrote:

> Most test snippets are wrapped in single quotes, like:
>
>   test_expect_success 'some description' '
>           do_something
>   '
>
> This sometimes makes the snippets awkward to write, because you can't
> easily use single quotes. We sometimes work around this with $SQ, or by
> loosening regexes to use "." instead of a literal quote, or by using
> double quotes when we'd prefer to use single-quotes (and just adding
> extra backslash-escapes to avoid interpolation).
>
> This commit adds another option: feeding the snippet on the function's
> stdin. This doesn't conflict with anything the snippet would want to do,
> because we always redirect its stdin from /dev/null anyway (which we'll
> continue to do).

I like this, and not having to write $SQ, '"'"' etc.

> A few notes on the implementation:
>
>   - it would be nice to push this down into test_run_, but we can't, as
>     test_expect_success and test_expect_failure want to see the actual
>     script content to report it for verbose-mode. A helper function
>     limits the amount of duplication in those callers here.

I've got an unsubmitted series (a bigger part of the -V rewrite) which
conflicted with this one, because I'd moved that message into those
helper functions.

But in that case I end up having to have this in
test_expect_{success,failure} anyway, because the change I had was to
move it into test_{ok,failure}_, i.e. to color the emitted body under
verbose differently depending on test ok/failure (which means deferring
the "this is our test body" until after the run).

It got slightly awkward because before I could pass "$@" to those (they
pass "$1" now), but with your change there's a "-" left on the argument
list, so we need to pass "$1" and "$test_body".

Anyway, it's no problem, just musings on having re-arranged this code
you're pointing out needs/could be re-arranged.

Maybe it would be easier to pass test_run arguments saying whether we
expect failure or not, and then move the whole if/else after it into its
own body. It already takes the "expecting_failure" parameter, so this on
top of master:

	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
	index 6348e8d733..9e20bd607d 100644
	--- a/t/test-lib-functions.sh
	+++ b/t/test-lib-functions.sh
	@@ -611,8 +611,7 @@ test_expect_failure () {
	 	export test_prereq
	 	if ! test_skip "$@"
	 	then
	-		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
	-		if test_run_ "$2" expecting_failure
	+		if test_run_ "$1" "$2" expecting_failure
	 		then
	 			test_known_broken_ok_ "$1"
	 		else
	@@ -631,8 +630,7 @@ test_expect_success () {
	 	export test_prereq
	 	if ! test_skip "$@"
	 	then
	-		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
	-		if test_run_ "$2"
	+		if test_run_ "$1" "$2"
	 		then
	 			test_ok_ "$1"
	 		else
	diff --git a/t/test-lib.sh b/t/test-lib.sh
	index d3f6af6a65..5a1192e80c 100644
	--- a/t/test-lib.sh
	+++ b/t/test-lib.sh
	@@ -935,9 +935,20 @@ test_eval_ () {
	 }
	 
	 test_run_ () {
	+	local description
	+	description="$1"
	+	shift
	+
	 	test_cleanup=:
	 	expecting_failure=$2
	 
	+	if test -n "$expecting_failure"
	+	then
	+		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$description': $1"
	+	else
	+		say >&3 "expecting success of $TEST_NUMBER.$test_count '$description': $1"
	+	fi
	+
	 	if test "${GIT_TEST_CHAIN_LINT:-1}" != 0; then
	 		# turn off tracing for this test-eval, as it simply creates
	 		# confusing noise in the "-x" output

... or maybe not, but in any case, if the verbose mode was what was
stopping you from moving this down to "test_run_" just that seems like
an easy change.

I like your current implementation better, i.e. to have the stdin
consumption happen ASAP and have the others be low-level utility
functions, but I don't care much, but if you wanted it the other way
maybe the above diff helps.
	
>   - The helper function is a little awkward to call, as you feed it the
>     name of the variable you want to set. The more natural thing in
>     shell would be command substitution like:
>
>       body=$(body_or_stdin "$2")
>
>     but that loses trailing whitespace. There are tricks around this,
>     like:
>
>       body=$(body_or_stdin "$2"; printf '.)
>       body=${body%.}
>
>     but we'd prefer to keep such tricks in the helper, not in each
>     caller.

I see why you did this, and for a narrow change it's a good thing.

FWIW having spent some more time on making the TAP format more pruttah
in a parallel WIP series I think this is ultimately a losing
game. You're inserting the extra LF because you don't want to have the
"checking..." and the first line of the test body on the same line;

But we have all of:

    test_expect_success 'foo' 'true'
    test_expect_success 'foo' '
        true
    '

And now:

    test_expect_success 'foo' - <<\EOT
        true
    '

So if (definitely not needed for your change) wanted to always make this
pretty/indented we'd need to push that logic down to the formatter,
which would insert a leading LF and/or indentation as appropriate.

I just declared that if you use the first form you don't get
indentation :)

>   - I implemented the helper using a sequence of "read" calls. Together
>     with "-r" and unsetting the IFS, this preserves incoming whitespace.
>     An alternative is to use "cat" (which then requires the gross "."
>     trick above). But this saves us a process, which is probably a good
>     thing. The "read" builtin does use more read() syscalls than
>     necessary (one per byte), but that is almost certainly a win over a
>     separate process.
>
>     Both are probably slower than passing a single-quoted string, but
>     the difference is lost in the noise for a script that I converted as
>     an experiment.
>
>   - I handle test_expect_success and test_expect_failure here. If we
>     like this style, we could easily extend it to other spots (e.g.,
>     lazy_prereq bodies) on top of this patch.
>
>   - even though we are using "local", we have to be careful about our
>     variable names. Within test_expect_success, any variable we declare
>     with local will be seen by the test snippets themselves (so it won't
>     persist between tests like normal variables would).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
