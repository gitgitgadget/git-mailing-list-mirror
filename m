Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E6C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5EB64F72
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhBCVZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhBCVZE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:25:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C011C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:24:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e15so1083983wme.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V9a4cupgkOaKBjQzZVdeBF5BNmIhywzfT8K/VvvMzzQ=;
        b=V/QjnB2MgZSbH1I7qwA5uNTu4s2KADCaHp71yyJ1A8v5nKMtdxT2S2E7+lMCDazsy5
         GfAFsV/PicCQbEkVR1/9NZYggf8OZthQVH1EpXm4x1hNFZ+mTJAUiE3ZAOrcWiAxompq
         f0TjRR4SgT5vXCcwoilBBi7u9jWmphALf0ZkEjs2agYWAa3gcqn6//s7dlA1QguAkNnX
         q7BkuLi9rsPI8SZmgoT1jWOA6qDX8MWPf7xEqPu8xTpY6Jy0qz/UBOBrMrsFLJhfDfjV
         elU66GlvhfpKBQT34dH6biaoNvPcTMrWIYppdUsZlVleUviNeeOU/d/fGc9ZcDi2YkZr
         bJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V9a4cupgkOaKBjQzZVdeBF5BNmIhywzfT8K/VvvMzzQ=;
        b=H6CeQSuBQODXGFws5TbjxCgnpeMNjGOoGSANd50xU782bbP1EayQO3UbGuWHZnboZq
         JDY+/gKLqOeTowM54a8MTtYUouuF1amR4x95vWHY+xNuzpPs94TyvkacKgbDBExW7bYI
         S/7GmjAN42+JdDTx36b2v5uJ7kc84/Kcn3wyjtOLAfIh/FdKTCZ3o+5izgXdFQsQUVPl
         jjhLz6pIbjD5p32ux/BATn+7osi2nt+DyYdUXdAxMLacrM2tRUFvA03FPzhmq0Mfw0C7
         FxebOt4hSZFqYPMhwU7fUY4wYnfneuJ443ZJ1WgjtttZxqjmC070j9ycNDnZZiFZ4dGs
         umpw==
X-Gm-Message-State: AOAM531CbPqoadV8oe/sK0Z34KNjei8C+Y2TYRW6K+zKQXfAvBZlwlk1
        jh3TtxjovhjsbdZeKMx2+ow=
X-Google-Smtp-Source: ABdhPJxZ5ERCLXout2253QRciPIvw0liAyU4Es8gDmU7PgX1CUgrkM4YSuMksO9vUj1k1UGL1RU1XQ==
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr4620175wmf.82.1612387462120;
        Wed, 03 Feb 2021 13:24:22 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id f7sm4889495wre.78.2021.02.03.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:24:21 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:24:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/6] ci: remove GETTEXT_POISON jobs
Message-ID: <20210203212419.GF2091@szeder.dev>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-2-avarab@gmail.com>
 <20210112085051.GV8396@szeder.dev>
 <87a6t38p71.fsf@evledraar.gmail.com>
 <20210120191406.GE8396@szeder.dev>
 <87pn1rp5nk.fsf@evledraar.gmail.com>
 <20210201220437.GB2091@szeder.dev>
 <87ft2de4cz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ft2de4cz.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 01:13:32PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 01 2021, SZEDER Gábor wrote:
> 
> > On Wed, Jan 27, 2021 at 01:47:27AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> On Wed, Jan 20 2021, SZEDER Gábor wrote:
> >> 
> >> > On Wed, Jan 20, 2021 at 06:59:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> >> 
> >> >> On Tue, Jan 12 2021, SZEDER Gábor wrote:
> >> >> 
> >> >> > On Mon, Jan 11, 2021 at 03:47:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> >> >> A subsequent commit will remove GETTEXT_POISON entirely, let's start
> >> >> >> by removing the CI jobs that enable the option.
> >> >> >> 
> >> >> >> We cannot just remove the job because the CI is implicitly depending
> >> >> >> on the "poison" job being a sort of "default" job.
> >> >> >
> >> >> > I don't understand what you mean here with a "default job" that the CI
> >> >> > is implicitly depending on.  There is certainly no such default job on
> >> >> > Travis CI, and I don't think there is one on the GitHub thing.
> >> >> 
> >> >> I'll reword this. I meant that the poison job was using the default
> >> >> compiler etc., whereas the other ones were setting custom values.
> >> >> 
> >> >> I vaguely remember some list traffic about this in the past, i.e. the
> >> >> reliance on the poison job not just for that, but also as "the default
> >> >> OS image" setup.
> >> >
> >> > Oh, I didn't mean that the commit message should be clarified.  I
> >> > meant that the GETTEXT_POISON job can simply be deleted.  Sorry for
> >> > not being clear enough.
> >> 
> >> I still don't get it, and my patch still seems fine as it is to me. But
> >> I'm probably missing something.
> >> 
> >> I'm looking at these, both pointing at e6362826a04 (The fourth batch,
> >> 2021-01-25):
> >> 
> >>     # Currently says "Please be aware travis-ci.org will be shutting
> >>     # down in several weeks"
> >
> > ... and continues with:
> >
> >   "with all accounts migrating to travis-ci.com.  Please stay tuned
> >    here for more information."
> >
> > FWIW, I recently migrated manually, and apart from the different TLD
> > haven't noticed anything different (though somehow the jobs in my .org
> > builds sometimes took a while to start lately, but on .com they all
> > started real fast so far, as they should).
> >
> >>     https://www.travis-ci.org/github/git/git/builds/756176098
> >> 
> >>     https://github.com/git/git/actions/runs/510676142
> >> 
> >> For the GitHub one, there's only two things that are linux && gcc. The
> >> linux-gcc job, and GETTEXT_POISON (renamed to linux-gcc-default in this
> >> series).
> >> 
> >> In ci/install-dependencies.sh we install GCC 8 for linux-gcc, but also
> >> perforce, apache, git-lfs etc.
> >> 
> >> Then in ci/lib.sh we set CC=gcc-8 on linux-gcc, but retain the default
> >> on GETTEXT_POISON. We also set GIT_TEST_HTTPD=true.
> >> 
> >> So hence "linux-gcc-default", we're running as close to a default set of
> >> packages we can get and build/run git at all. I.e. just "apt install
> >> $UBUNTU_COMMON_PKGS".
> >
> > We started installing newer compilers, because we wanted to benefit
> > from their better error reporting and improved warnings.  The reason
> > we did that in existing CI jobs without adding a "default" job was
> > that we don't care enough about the default compiler and configuration
> > to justify its additional runtime, because we run the test suite
> > enough times already.
> 
> So in summary, you'd like it removed because the combination of
> GETTEXT_POISON + old compiler is no longer worth it, but while we were
> running with GETTEXT_POISON anyway we might as well run it on the old
> compiler?

Yes, though I suspect that "no one gave a damn about the compiler used
in the GETTEXT_POISON job" might be closer to the truth.  Or even "no
one gave a damn about the GETTEXT_POISON job"...

And apart from the occasional translation-related failure (i.e. 'grep
"<translated message>" actual') and one flaky test that happened to
fail in the GETTEXT_POISON job I can't recall a single case where
building and testing with the default compiler discovered an issue
that the other jobs didn't.

> > Considering that the number of CI jobs has grown since then, I would
> > rather see the build complete faster than a default job running the
> > test suite for the N+1th time.
> 
> [...]
> 
> >> Then in ci/run-build-and-tests.sh the "linux-gcc" job is also our "let's
> >> turn on every GIT_TEST_* option you've heard of" job. Whereas on the
> >> GETTEXT_POISON job we just ran "make test", well, with
> >> GIT_TEST_GETTEXT_POISON=true before this series, but that was the only
> >> non-default, now we've got no non-defaults.
> >> 
> >> I can see why we'd want this on top:
> >>     
> >>     diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> >>     index 50e0b90073f..3071099eaca 100755
> >>     --- a/ci/run-build-and-tests.sh
> >>     +++ b/ci/run-build-and-tests.sh
> >>     @@ -32,11 +32,6 @@ linux-clang)
> >>             export GIT_TEST_DEFAULT_HASH=sha256
> >>             make test
> >>             ;;
> >>     -linux-gcc-4.8)
> >>     -       # Don't run the tests; we only care about whether Git can be
> >>     -       # built with GCC 4.8, as it errors out on some undesired (C99)
> >>     -       # constructs that newer compilers seem to quietly accept.
> >>     -       ;;
> >>      *)
> >>             make test
> >>             ;;
> >> 
> >> Because there we're skipping tests on linux-gcc-4.8, but on travis it's
> >> the only Ubuntu Trusty image (default is Xenial), so yes we build with
> >> gcc 4.8, but we're also missing out in seeing if our tests are working
> >> on a slightly older Ubuntu.
> >
> > The above comment you propose to remove explains why you should not
> > remove it...  And, again, running the test suite doesn't seem to worth
> > the extra runtime.
> 
> How is it extra runtime in any meaningful sense?
> 
> Yes, we spend more CPU time, but as far as I can tell (and I'm looking
> at an ongoing run on GitHub now)

(Well, I'm looking at eight ongoing builds now...)

> these jobs are run concurrently. Some
> of that was covered in the quoted paragraph below that you didn't reply
> to.
> 
> I.e. if I push a commit I don't care if 10 minutes of CPU time are being
> wasted by a machine sitting in some rack somewhere, the important part
> is that I may be saving 20 minutes of my time, since the faster 10
> minute test (running concurrently with the ~30m tests) might fail
> earlier.
> 
> Or are there some job limits involved here that I'm missing?

Travis CI usually runs 3 Linux and 2 OSX jobs in parallel, and I doubt
that GitHub would be foolish enough to run all my jobs parallel if I
were to use it.

> As I was writing this the CI job for GETTEXT_POISON just finished in
> 10m16s showing OK=green, and the rest are still churning.

Indeed, but you should also consider that:

  - At 10m16s that job is notably slower than even my tiny old laptop,
    even though it runs less tests.  If you really want to save time,
    then run 'make test' locally.

  - Without the GETTEXT_POISON job the whole build would be finished
    ~10 minutes earlier.  With six builds that's an hour.


> >> Also on GitHub's page the GETTEXT_POISON job finishes in ~10m but all
> >> the other ones in ~30m, I see some run "make test" twice, as an aside is
> >> there some limit on jobs but not overall CPU? Otherwise those would
> >> finish faster if that was split up.
> >> 
> >> But "make test" twice doesn't account for a ~3x increase, so it's got to
> >> be the extra tests we're running, i.e. svn tests, httpd etc.
> >> 
> >> It seems to me to provide value in itself to run some shorter version of
> >> the CI for people using it as a poor man's edit/push/ci/edit loop.
> 
