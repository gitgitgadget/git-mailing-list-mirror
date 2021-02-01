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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33113C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D8964E2C
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBAWI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhBAWFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:05:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D180C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:04:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id i8so10332200ejc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vwix5Jh15bJoczAbopu4MKe0s6YGBKy8e2GaPZtXEPI=;
        b=cFPkNJ4g49/gFK4NvzUDDWlq9G90zM+q0cPIJSpzGgcxItAjeXu+Jnq68eepxwfWp3
         hIFzg2fusxqFE8d/IBQ+9uPKjJaM27sPdsJCWdQV44XYszNfiYuEkgbOD94Q6cv0mL/i
         kr2Rt8ibrxxdQe5NSRZ7ulR2dvSiKYS0u0aS2sGWf9J1+7F5eT9hr70hkEj42TVZnVYK
         KssJFwfIxCAQga3D4wg4cBjHJO7gK40zcG7Ncp7pgrkGz0whciXDiXwcqYnDLDuUxIKt
         q0C30FaXjtI3TwJDkFKruATkFLjtG/PRouWJMBPkaYUzGca7y39xcs+NYfHFX4Zhkzls
         m8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vwix5Jh15bJoczAbopu4MKe0s6YGBKy8e2GaPZtXEPI=;
        b=g1NeY1fkxuTk9OnzwfpqWPKgVCaMETTjBt0p7+MvM+IgPxKH6itqFwbRnUVfHdUIHz
         1UIyQKjkL1bE62Ijfnk2HtEqIPkYfRCJ4JxZiHbXDq5OuEU11Zqqyl1s69+Tls9yNmZt
         A+2exwoGhijD9U2ThCSr49TiqUUcwo+djwJUoQp1rba3v6gMWqlmtujspcguLRoSAIiw
         4QhQ4RAEqwtkvg5sipdyOREnjI0sTLL6vkt6xYzRKh4MCrsffw+HG/vjBtRFvYgPpTyS
         oMvjosoFGAGFwqbw2ifg3wI7kg9LWSUz6q2U8031E2jyH/g2gx4lqBQqM8rI9WZXt/5e
         fnBg==
X-Gm-Message-State: AOAM531WqKCry0nHEu3po++ae4l38Xg0CJUc7Jkvb47Z9KOdL2Y2gCcN
        h7oLbj3X3Qo/H0Q3OQsvt6A=
X-Google-Smtp-Source: ABdhPJyBNPVi4yuquM/aqJMfH9htj3eI5F34KSkdc1nFqRzqAwmNTnEHWqctKBemaHcmeidPSHq93Q==
X-Received: by 2002:a17:906:c049:: with SMTP id bm9mr19015660ejb.535.1612217079778;
        Mon, 01 Feb 2021 14:04:39 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id zk6sm3546029ejb.119.2021.02.01.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:04:39 -0800 (PST)
Date:   Mon, 1 Feb 2021 23:04:37 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/6] ci: remove GETTEXT_POISON jobs
Message-ID: <20210201220437.GB2091@szeder.dev>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-2-avarab@gmail.com>
 <20210112085051.GV8396@szeder.dev>
 <87a6t38p71.fsf@evledraar.gmail.com>
 <20210120191406.GE8396@szeder.dev>
 <87pn1rp5nk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pn1rp5nk.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 01:47:27AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jan 20 2021, SZEDER Gábor wrote:
> 
> > On Wed, Jan 20, 2021 at 06:59:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> On Tue, Jan 12 2021, SZEDER Gábor wrote:
> >> 
> >> > On Mon, Jan 11, 2021 at 03:47:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> >> A subsequent commit will remove GETTEXT_POISON entirely, let's start
> >> >> by removing the CI jobs that enable the option.
> >> >> 
> >> >> We cannot just remove the job because the CI is implicitly depending
> >> >> on the "poison" job being a sort of "default" job.
> >> >
> >> > I don't understand what you mean here with a "default job" that the CI
> >> > is implicitly depending on.  There is certainly no such default job on
> >> > Travis CI, and I don't think there is one on the GitHub thing.
> >> 
> >> I'll reword this. I meant that the poison job was using the default
> >> compiler etc., whereas the other ones were setting custom values.
> >> 
> >> I vaguely remember some list traffic about this in the past, i.e. the
> >> reliance on the poison job not just for that, but also as "the default
> >> OS image" setup.
> >
> > Oh, I didn't mean that the commit message should be clarified.  I
> > meant that the GETTEXT_POISON job can simply be deleted.  Sorry for
> > not being clear enough.
> 
> I still don't get it, and my patch still seems fine as it is to me. But
> I'm probably missing something.
> 
> I'm looking at these, both pointing at e6362826a04 (The fourth batch,
> 2021-01-25):
> 
>     # Currently says "Please be aware travis-ci.org will be shutting
>     # down in several weeks"

... and continues with:

  "with all accounts migrating to travis-ci.com.  Please stay tuned
   here for more information."

FWIW, I recently migrated manually, and apart from the different TLD
haven't noticed anything different (though somehow the jobs in my .org
builds sometimes took a while to start lately, but on .com they all
started real fast so far, as they should).

>     https://www.travis-ci.org/github/git/git/builds/756176098
> 
>     https://github.com/git/git/actions/runs/510676142
> 
> For the GitHub one, there's only two things that are linux && gcc. The
> linux-gcc job, and GETTEXT_POISON (renamed to linux-gcc-default in this
> series).
> 
> In ci/install-dependencies.sh we install GCC 8 for linux-gcc, but also
> perforce, apache, git-lfs etc.
> 
> Then in ci/lib.sh we set CC=gcc-8 on linux-gcc, but retain the default
> on GETTEXT_POISON. We also set GIT_TEST_HTTPD=true.
> 
> So hence "linux-gcc-default", we're running as close to a default set of
> packages we can get and build/run git at all. I.e. just "apt install
> $UBUNTU_COMMON_PKGS".

We started installing newer compilers, because we wanted to benefit
from their better error reporting and improved warnings.  The reason
we did that in existing CI jobs without adding a "default" job was
that we don't care enough about the default compiler and configuration
to justify its additional runtime, because we run the test suite
enough times already.

Considering that the number of CI jobs has grown since then, I would
rather see the build complete faster than a default job running the
test suite for the N+1th time.

> Then in ci/run-build-and-tests.sh the "linux-gcc" job is also our "let's
> turn on every GIT_TEST_* option you've heard of" job. Whereas on the
> GETTEXT_POISON job we just ran "make test", well, with
> GIT_TEST_GETTEXT_POISON=true before this series, but that was the only
> non-default, now we've got no non-defaults.
> 
> I can see why we'd want this on top:
>     
>     diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>     index 50e0b90073f..3071099eaca 100755
>     --- a/ci/run-build-and-tests.sh
>     +++ b/ci/run-build-and-tests.sh
>     @@ -32,11 +32,6 @@ linux-clang)
>             export GIT_TEST_DEFAULT_HASH=sha256
>             make test
>             ;;
>     -linux-gcc-4.8)
>     -       # Don't run the tests; we only care about whether Git can be
>     -       # built with GCC 4.8, as it errors out on some undesired (C99)
>     -       # constructs that newer compilers seem to quietly accept.
>     -       ;;
>      *)
>             make test
>             ;;
> 
> Because there we're skipping tests on linux-gcc-4.8, but on travis it's
> the only Ubuntu Trusty image (default is Xenial), so yes we build with
> gcc 4.8, but we're also missing out in seeing if our tests are working
> on a slightly older Ubuntu.

The above comment you propose to remove explains why you should not
remove it...  And, again, running the test suite doesn't seem to worth
the extra runtime.


> Also on GitHub's page the GETTEXT_POISON job finishes in ~10m but all
> the other ones in ~30m, I see some run "make test" twice, as an aside is
> there some limit on jobs but not overall CPU? Otherwise those would
> finish faster if that was split up.
> 
> But "make test" twice doesn't account for a ~3x increase, so it's got to
> be the extra tests we're running, i.e. svn tests, httpd etc.
> 
> It seems to me to provide value in itself to run some shorter version of
> the CI for people using it as a poor man's edit/push/ci/edit loop.
