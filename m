Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F7C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C464ECF
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhCIVbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhCIVbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:31:20 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E3C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:31:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v15so18711094wrx.4
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KaeZJM1/WH1rCcHz4q9prIWXgiRP3E15ofuRDcCTB1g=;
        b=ATJiDA1Cft0dIo3O6QmLxdm+vQD8u7vi3HePLUZJCe9OllL7sm3+g1o2QjG4swYcYJ
         Y6S9RC5emQdTwlNhUfegnKSBT5QhXfqaIVnEUZ+67CYkpuVOTHgJosjw894U4/wfrgJ2
         QeeBobTpLCwfmHo3wFjexlwgbDwaHRy8QjHS4uIWccnlAWKb9psSIkOLuJ4cZBsuWQyn
         O+e5ex3N3tbCwPusmR2gMl9eHz658vgqDonwoEiK5NsbiQKQwP17NZgLZz+uz8H6aM1O
         tOGPmoJ463K8HW0BPqkNzqw9BhyYAE5tXdapzBo+Tpal6VfpYdr1eT1S6WSK32iBm1lI
         0ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KaeZJM1/WH1rCcHz4q9prIWXgiRP3E15ofuRDcCTB1g=;
        b=ot2XbOKb7AvBfHD2GBuwxpj0qKT411lZWXCT4Namk0RChLofbJOEh38Ri1+0d1bTYU
         aw1ft0ZONjRYKaRGFMz9H4x55m1CItDgAbdp7IkmzdKzhJIJPNlhc23l4k5l1LUCiDzI
         4VSbYDfTfm3KsCSIAkhuDKhZs2LszmeXA5iKSncoNmiplyPjI9yLbC769cx8RMFKXiii
         tvTvBLK2H3HZUDcu8HNd6zBg1QWGW934/MjUiQzjpCjnTpu495V5+JEy8eXvfUi3Nimy
         oHKJaVpQfRDhZAbYBr4Urej6CFjsTqfPPlP1M6RD7LPXHuphQsEOWZSO7CPje8ncrAPO
         RApQ==
X-Gm-Message-State: AOAM532rzVK2bV9Z/OnVNU9VmFQiXfJlYRNCasNpEOBQKaICZU8wutUG
        QACsQy+14zLlAAO4tNJiZH0=
X-Google-Smtp-Source: ABdhPJxbTFg21yJp/uELHqCdQ9PpNoPSJndH23MCQ6GDCy/iYpPC6bmG5dDOA5PPJQnOO+kO2HMN1w==
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr30352223wrh.50.1615325479010;
        Tue, 09 Mar 2021 13:31:19 -0800 (PST)
Received: from szeder.dev (94-21-29-148.pool.digikabel.hu. [94.21.29.148])
        by smtp.gmail.com with ESMTPSA id a8sm5993028wmm.46.2021.03.09.13.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:31:18 -0800 (PST)
Date:   Tue, 9 Mar 2021 22:31:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
Message-ID: <20210309213117.GB1016223@szeder.dev>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-7-avarab@gmail.com>
 <20210309185911.GF3590451@szeder.dev>
 <87k0qghwps.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0qghwps.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 09, 2021 at 09:57:03PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> diff --git a/t/README b/t/README
> >> index 2cc8cbc7185..f09d94e754e 100644
> >> --- a/t/README
> >> +++ b/t/README
> >> @@ -157,10 +157,13 @@ appropriately before running "make". Short options can be bundled, i.e.
> >>  
> >>  -V::
> >>  --verbose-log::
> >> -	Write verbose output to the same logfile as `--tee`, but do
> >> -	_not_ write it to stdout. Unlike `--tee --verbose`, this option
> >> +	An alias for `--verbose --tee`. This option
> >>  	is safe to use when stdout is being consumed by a TAP parser
> >> -	like `prove`. Implies `--tee` and `--verbose`.
> >> +	like `prove`.
> >> +	Historically this option was different from `--verbose --tee`
> >> +	and would not write any verbose output to stdout to ensure the
> >> +	TAP-correctness of the output. The TAP-correctness of the
> >> +	output is now sanity checked by the test library,
> >
> > Not everyone is using a TAP harness to run the tests, and, therefore,
> > '--verbose-log' should not spew out verbose output to the terminal.
> 
> IOW even though --verbose-log was meant as a hack to make prove happy,
> you've since come to like the "verbose in log, but not stdout" mode and
> want that kept?

Yes, '--verbose-log' proved to be really convenient, even if it was
meant to solve a different issue.

> Yes, this patch takes that mode away.
> 
> Yes, I can change it.
> 
> Would your use-case for this be satisfied by having prove(1) just emit
> different output for you in this scenario, so you'd need to invoke this
> as something like:
> 
>     prove <test> :: --verbose --tee # or --verbose-log

I use prove to run the test suite, but I don't and won't use prove to
run a single test.

The behavior of './t1234-foo.sh -V' with or without '-x' should not
change without _very_ convincing reasons.  "We now output valid TAP
even with --verbose, so we don't need it for the TAP harness" is
definitely not convincing.

> Becuse the advantage of this series is that that sort of thing becomes
> really trivial without everything needing to be hardcoded in
> test-lib.sh, observe (this is with my series):
> 
>     
>     0 $ PERL5LIB=. prove -v --formatter=SZEDERVerboseLog ./t0201-gettext-fallbacks.sh :: --verbose-log

Well, this doesn't look trivial at all, does it?  In fact, I consider
this unusably convoluted.

>     # lib-gettext: No is_IS UTF-8 locale available
>     # lib-gettext: No is_IS ISO-8859-1 locale available
>     ok 1 - sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to fallthrough)
>     ok 2 - sanity: $GIT_INTERNAL_GETTEXT_TEST_FALLBACKS is set
>     ok 3 - sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallthrough
>     ok 4 - gettext: our gettext() fallback has pass-through semantics
>     ok 5 - eval_gettext: our eval_gettext() fallback has pass-through semantics
>     ok 6 - eval_gettext: our eval_gettext() fallback can interpolate variables
>     ok 7 - eval_gettext: our eval_gettext() fallback can interpolate variables with spaces
>     ok 8 - eval_gettext: our eval_gettext() fallback can interpolate variables with spaces and quotes
>     # passed all 8 test(s)
>     1..8
>     ok
>     All tests successful.
>     Files=1, Tests=8,  1 wallclock secs ( 0.01 usr  0.01 sys +  0.07 cusr  0.01 csys =  0.10 CPU)
>     Result: PASS
>     $ wc -l test-results/t0201-gettext-fallbacks.out 
>     75 test-results/t0201-gettext-fallbacks.out
> 
> All without any patching on top to the test-lib.sh, just:
>     
>     $ cat SZEDERVerboseLog.pm 
>     package SZEDERVerboseLog::Session;
>     use base 'TAP::Formatter::Console::Session';
>     
>     sub result {
>         my ($self, $result) = @_;
>         return if $result->is_unknown;
>         return $self->SUPER::result($result);
>     }
>     
>     package SZEDERVerboseLog;
>     use strict;
>     use warnings;
>     use base 'TAP::Formatter::Console';
>     
>     sub open_test {
>         my ($self, $test, $parser) = @_;
>         my $session = SZEDERVerboseLog::Session->new( {
>             name            => $test,
>             formatter       => $self,
>             parser          => $parser,
>         } );
>         return $session;
>     }
>     
>     1;
> 
> The "is_unknown" is everything that's not TAP syntax.
> 
