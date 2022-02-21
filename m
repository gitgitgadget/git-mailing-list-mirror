Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7AC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiBUVDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 16:03:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiBUVDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 16:03:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E0A23BCD
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 13:03:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s14so14551149edw.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 13:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GqI5YVb+bUDafcfGgsU9s4OLJy72YQ0j0PSw4c9ALJo=;
        b=m9/olB76A3BDPHYCMddy6dghEtTmZjsts/4a1BDNgJ/YU+u5Vpmrxbnv0V6U3HaKBr
         9YLWJE2f8JB6Az0DgCFXEeG7KQA0aVnLDGu6d3AJMIlEvVT7S1wTi5KmJLlIv/FEAPbd
         oBFrjRhssNjsikwCAnDXFpu6W1KWzpHQUt6nlERHel0WpBg1XNv5UI4kklkyalPakcCR
         L9dCG8e1v+jK3LWoZrYr7gk8XqcNbklVRhhsuChPxs0Xs/8Mj+WuRymQdUGTOIAe9ywv
         MynKh9wqZlfnkGkIvXHn2fW6coRFW4i7/9B2wkMlFA7/IFQZjeYO+FMeXPGg0ILH9jex
         K5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GqI5YVb+bUDafcfGgsU9s4OLJy72YQ0j0PSw4c9ALJo=;
        b=BkIZhISW6gtVmstjJjYoEPEFXiDW5E6NMVeA3zblSGBCPww+oG7/0BKOyqhSKO35NY
         nUdrVWtdCPdfQ5VspkcfWRxetYzU5zWf2EzFYaIQoj8B0HyhojeP1jbq9Dk73aESRdfx
         woDJNLmXajfnN8Tm3yRbeUbJDqh8K3Y9r5c1EEq3fbvZe+AN6/8mXHPNJPH+Axe6Kd8B
         xo8UcCmKFJMJl1u4d939BevoeGshXT/RIGEEGT3hYnYo+wyD/7tjvwxXLM5jsGvUGM90
         gEKLBotEcrI7HO34vYlQ7kjFLm6wB3f7DkNduuvWzK0oTPg/PDgjowvmujUUlKugyZp0
         4Zjg==
X-Gm-Message-State: AOAM530IQ+PnHFNlgxaJQD52EpxS1YVLTAJx+iL+gkyVEYykvdxg4nRs
        2Gf66haggcjhokIv6dfwF/Dbg1GaUWk=
X-Google-Smtp-Source: ABdhPJyaD579S7kAeeDE3VwhsBClv2rObNBV1DHBXmvnbS/RNdH+yir0n3ZvyPtkNIaHbt8CuFe3Xw==
X-Received: by 2002:a05:6402:5ce:b0:412:be81:a9d6 with SMTP id n14-20020a05640205ce00b00412be81a9d6mr19289099edx.272.1645477405168;
        Mon, 21 Feb 2022 13:03:25 -0800 (PST)
Received: from szeder.dev (84-236-78-183.pool.digikabel.hu. [84.236.78.183])
        by smtp.gmail.com with ESMTPSA id m12sm5947247edl.74.2022.02.21.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:03:24 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:03:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/3] test-lib.sh: have all tests pass under "-x",
 remove BASH_XTRACEFD
Message-ID: <20220221210319.GA1658@szeder.dev>
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
 <20211213054353.GC3400@szeder.dev>
 <220221.86v8x89ebo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220221.86v8x89ebo.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 08:52:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> [Junio: If you'd like to pick up this series it still cleanly applies,
> and merges cleanly with "seen"]
> 
> On Mon, Dec 13 2021, SZEDER Gábor wrote:
> 
> Sorry about the late reply, things getting lost around the holidays
> etc.
> 
> > On Mon, Dec 13, 2021 at 02:38:33AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> A re-arrangement-only change to v3[1]. The previous 2/2 is now split
> >> into two commits, as requested by SZEDER[2] in the removal of
> >> BASH_XTRACEFD is now its own commit & the rationale for doing so is
> >> outlined in detail.
> >
> > I'm afraid I wasn't clear.  What I meant was that if we were to remove
> > BASH_XTRACEFD, then it should be done its own commit.
> 
> Aside from whether you think removing it is a good idea, isn't that what
> this v4 does?

Well, yes, but I now realize that I wasn't sufficiently clear the
second time around, either, and emphasis doesn't travel well over
email.  What I meant was that: _if_ at all we were to remove it, then
it should be a separate patch, but since we should most definitely
keep it, those hunks should be simply dropped.

> In 1/3 I fix -x under non-BASH_XTRACEFD, 2/3 removes test_untraceable,
> and 3/3 the use of BASH_XTRACEFD.
> 
> > But again: BASH_XTRACEFD is the only simple yet reliable and robust
> > way to get -x trace from our tests, so do not remove it.
> 
> Just to tie off this loose end, I re-read the thread ending in [1] (sent
> after this reply of yours) and I think my [1] addresses this.

It doesn't at all; "if CI passes without it, then we can remove it" is
not a convincing argument.

> Maybe you still disagree, but I don't see how that squares with
> "reliable and robust" here.
> 
> I.e. unless we're talking about carrying bash-specific code in the test
> suite we can't make any real use of the feature, as our tests will need
> to be compatible with other POSIX shells.
> 
> I mean, the code changed in 1/3 *was* that bash-specific code, but as
> that change shows it was rather easily made non-bash-specific. And
> unless we think we'll add other bash-specific tests (I don't see why,
> the cross-shell -x support is rather easy to do) ....
> 
> 1. https://lore.kernel.org/git/211216.864k78bsjs.gmgdl@evledraar.gmail.com/
> 
> >> 1. https://lore.kernel.org/git/cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com/
> >> 2. https://lore.kernel.org/git/20211212201441.GB3400@szeder.dev/
> >> 
> >> Ævar Arnfjörð Bjarmason (3):
> >>   t1510: remove need for "test_untraceable", retain coverage
> >>   test-lib.sh: remove the now-unused "test_untraceable" facility
> >>   test-lib.sh: remove "BASH_XTRACEFD"
> >> 
> >>  t/README              |  3 --
> >>  t/t1510-repo-setup.sh | 85 +++++++++++++++++++++----------------------
> >>  t/test-lib.sh         | 66 ++++-----------------------------
> >>  3 files changed, 49 insertions(+), 105 deletions(-)
> >> 
> >> Range-diff against v3:
> >> 1:  7876202c5b0 = 1:  9e7b089dc50 t1510: remove need for "test_untraceable", retain coverage
> >> -:  ----------- > 2:  60883fd95cb test-lib.sh: remove the now-unused "test_untraceable" facility
> >> 2:  a7fc794e20d ! 3:  8b5ae33376e test-lib.sh: remove the now-unused "test_untraceable" facility
> >>     @@ Metadata
> >>      Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >>      
> >>       ## Commit message ##
> >>     -    test-lib.sh: remove the now-unused "test_untraceable" facility
> >>     +    test-lib.sh: remove "BASH_XTRACEFD"
> >>      
> >>     -    In the preceding commit the use of "test_untraceable=UnfortunatelyYes"
> >>     -    was removed from "t1510-repo-setup.sh" in favor of more narrow
> >>     -    redirections of the output of specific commands (and not entire
> >>     -    sub-shells or functions).
> >>     +    Stop setting "BASH_XTRACEFD=4" to direct "-x" output to file
> >>     +    descriptor 4 under bash.
> >>      
> >>     -    This is in line with the fixes in the series that introduced the
> >>     -    "test_untraceable" facility. See 571e472dc43 (Merge branch
> >>     -    'sg/test-x', 2018-03-14) for the series as a whole, and
> >>     -    e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
> >>     -    subshell, 2018-02-24) for a commit that's in line with the changes in
> >>     -    the preceding commit.
> >>     +    When it was added in d88785e424a (test-lib: set BASH_XTRACEFD
> >>     +    automatically, 2016-05-11) it was needed as a workaround for various
> >>     +    tests that didn't pass cleanly under "-x".
> >>      
> >>     -    We've thus solved the TODO item noted when "test_untraceable" was
> >>     -    added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup: mark
> >>     -    as untraceable with '-x', 2018-02-24).
> >>     +    Most of those were later fixed in 71e472dc43 (Merge branch
> >>     +    'sg/test-x', 2018-03-14), and in the preceding commits we've fixed the
> >>     +    final remaining and removed the "test_untraceable" facility.
> >>      
> >>     -    So let's remove the feature entirely. Not only is it currently unused,
> >>     -    but it actively encourages an anti-pattern in our tests. We should be
> >>     -    testing the output of specific commands, not entire subshells or
> >>     -    functions.
> >>     +    The reason we don't need this anymore is becomes clear from reading
> >>     +    the rationale in d88785e424a and applying those arguments to the
> >>     +    current state of the codebase. In particular it said (with "this" and
> >>     +    "it" referring to the problem of tests failing under "-x"):
> >>      
> >>     -    That the "-x" output had to be disabled as a result is only one
> >>     -    symptom, but even under bash those tests will be harder to debug as
> >>     -    the subsequent check of the redirected file will be far removed from
> >>     -    the command that emitted the output.
> >>     +        "there here isn't a portable or scalable solution to this [...] we
> >>     +        can work around it by pointing the "set -x" output to our
> >>     +        descriptor 4"
> >>      
> >>     -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >>     +    And finally that:
> >>      
> >>     - ## t/README ##
> >>     -@@ t/README: appropriately before running "make". Short options can be bundled, i.e.
> >>     - -x::
> >>     - 	Turn on shell tracing (i.e., `set -x`) during the tests
> >>     - 	themselves. Implies `--verbose`.
> >>     --	Ignored in test scripts that set the variable 'test_untraceable'
> >>     --	to a non-empty value, unless it's run with a Bash version
> >>     --	supporting BASH_XTRACEFD, i.e. v4.1 or later.
> >>     - 
> >>     - -d::
> >>     - --debug::
> >>     +        "Automatic tests for our "-x" option may be a bit too meta"
> >>     +
> >>     +    Those tests are exactly what we've had since aedffe95250 (travis-ci:
> >>     +    run tests with '-x' tracing, 2018-02-24), so punting on fixing issues
> >>     +    with "-x" by using "BASH_XTRACEFD=4" isn't needed anymore, we're now
> >>     +    committing to maintaining the test suite in a way that won't break
> >>     +    under "-x".
> >>     +
> >>     +    We could retain "BASH_XTRACEFD=4" anyway, but doing so is bad because:
> >>     +
> >>     +     1) Since we're caring about "-x" passing in CI under "dash" on Ubuntu
> >>     +        using "BASH_XTRACEFD=4" will amount to hiding an error we'll run
> >>     +        into eventually. Tests will pass locally with "bash", but fail in
> >>     +        CI with "dash" (or under other non-"bash" shells).
> >>     +
> >>     +     2) As the amended code in "test_eval_" shows (an amended revert to
> >>     +        the pre-image of d88785e424a) it's simpler to not have to take
> >>     +        this "bash" special-case into account.
> >>     +
> >>     +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >>      
> >>       ## t/test-lib.sh ##
> >>     -@@ t/test-lib.sh: then
> >>     - 	exit
> >>     - fi
> >>     - 
> >>     --if test -n "$trace" && test -n "$test_untraceable"
> >>     --then
> >>     --	# '-x' tracing requested, but this test script can't be reliably
> >>     --	# traced, unless it is run with a Bash version supporting
> >>     --	# BASH_XTRACEFD (introduced in Bash v4.1).
> >>     --	#
> >>     --	# Perform this version check _after_ the test script was
> >>     --	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
> >>     --	# '--verbose-log', so the right shell is checked and the
> >>     --	# warning is issued only once.
> >>     --	if test -n "$BASH_VERSION" && eval '
> >>     --	     test ${BASH_VERSINFO[0]} -gt 4 || {
> >>     --	       test ${BASH_VERSINFO[0]} -eq 4 &&
> >>     --	       test ${BASH_VERSINFO[1]} -ge 1
> >>     --	     }
> >>     --	   '
> >>     --	then
> >>     --		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
> >>     --	else
> >>     --		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
> >>     --		trace=
> >>     --	fi
> >>     --fi
> >>     - if test -n "$trace" && test -z "$verbose_log"
> >>     - then
> >>     - 	verbose=t
> >>      @@ t/test-lib.sh: else
> >>       	exec 4>/dev/null 3>/dev/null
> >>       fi
> >> -- 
> >> 2.34.1.1024.g573f2f4b767
> >> 
> 
> o
