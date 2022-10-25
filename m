Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F9C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiJYKKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiJYKKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EA10AC0B
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:03:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d3so9653565ljl.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qqsi1BiSgX/uzsS2B+MzrBr/MjMRNzZzx/4J1kRlErk=;
        b=jBhT8Xpks+2Qf9AhEUasfr6hH2dVX1n2ZwiWxsjMZbPB3J0ta10bPqps7ehGmuPX2G
         nCW+s7PZjbtpsnQOj1prCWobd9dN+bRdYGqwwsMeceJxjnft0mDmMyuOmc1lhUy4QS8y
         AfFuzdjjV3JDAwhshUtqF6w7mMbjYnBCcllDwkeQMW0i4TPZ8YQKePL9f8xCNjDp611Q
         486M7UPQ45bgAM1t9zRE/rI1UzROV7PtWhOgTR/oUhRo1gNT+pU9KSOAtNwJIZmCHjVM
         0lIs+Lv4CWDC1UJd3/zLvC1jEydDIR1nDLnLtk/G//xAWQzIbO1lRwFnh7ovnuIh3q8G
         pL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqsi1BiSgX/uzsS2B+MzrBr/MjMRNzZzx/4J1kRlErk=;
        b=KPn/aQau3g/A7M6sDUp3NDBOrYJeT6h+5nkrL/0FbBBBJCUWlZucJT15qhPE5UsF6e
         YZjZP0r/IopMjfYyLKxQGYcaKAl6Z4OX45jYl9uhRGkEZiMv1FnINQDUGMw80V/j6n6F
         hKMJQnX03ylUtizAaWxqzB9yiBIqyJtkJRMpaqnzaYO1VBk3Y6vsZffZH3il3bNPUYqN
         xNoPDuXAiDCERvuGAkDLpdsUh1mkSYkV2TijulGuO+Je+8TsjbCyE9fDIz3zNUjkGfKT
         fyGhXpxLMwazm9QZjSrihSg6SguS6xA3M8S2JvfHJ7HI0vJXIdamrmD31lQMmqIQlZfN
         R/dA==
X-Gm-Message-State: ACrzQf2V08gxljv0QuiW4BtFQrt+dGunFT7Cq02SjDKFRJMVwjU9tID6
        PcP6IqFA1G0CWLFqIaC7QlZVDc+FTZs=
X-Google-Smtp-Source: AMsMyM7V+Cn23OrI0kARBXGmMarfnTPfrrNEsZE0BEltkbHw+KmshJ/P2aO6CCZB8M44eRKf6RaHRQ==
X-Received: by 2002:a17:907:8a24:b0:78d:cd60:1022 with SMTP id sc36-20020a1709078a2400b0078dcd601022mr31272897ejc.384.1666692168729;
        Tue, 25 Oct 2022 03:02:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906960e00b00780ab5a9116sm1123001ejx.211.2022.10.25.03.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 03:02:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onGlh-007uet-35;
        Tue, 25 Oct 2022 12:02:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Parallelism defaults and config options
Date:   Tue, 25 Oct 2022 11:48:51 +0200
References: <CAFySSZAbsPuyPVX0+DQzArny2CEWs+GpQqJ3AOxUB_ffo8B3SQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFySSZAbsPuyPVX0+DQzArny2CEWs+GpQqJ3AOxUB_ffo8B3SQ@mail.gmail.com>
Message-ID: <221025.86sfjccjay.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 24 2022, Calvin Wan wrote:

> While trying to figure out how I was going to set the default
> parallelism in cw/submodule-status-in-parallel, I noticed some
> discrepancies between how all the parallelism config options are set in
> git. I wanted to discuss what we can do now to make them more consistent
> and also what the standard should be for the future. Here is a list of
> parallelism config options in git (let me know if I missed any) and how
> they're set:

Yeah, I've noticed this before & found it odd, thanks for trying to make
it sensible.

> grep.threads: if unset or set to 0, git uses number of logical cores.
> index.threads: if unset or set to 0/true, git uses number of logical
>   cores. If set to 1/false, multithreading is disabled
> pack.threads: if unset or set to 0, git uses number of logical cores.
>   (documentation doesn't mention what default is)
> checkout.workers: if unset, defaults to 1. If set to < 1, git uses
>   number of logical cores
> fetch.parallel: if unset, defaults to 1. If set to 0, git uses number of
>   logical cores (documentation says reasonable default)
> http.maxRequests: if unset, defaults to 5. If set to < 1, git uses the
>   default 5.
> submodule.fetchJobs: if unset, defaults to 1. If set to 0, git uses
>   number of logical cores (documentation says reasonable default)

Aside from anything we come up with, I think it's fine to change the
defaults, i.e. to make some of these parallel by default where they
aren't now.

> The first inconsistency is the difference in language used to describe
> when each option is set to "online_cpus()". Some are explicit while
> others omit it or use language such as "reasonable default". Being
> explicit for all of the options is probably the easiest documentation
> fix.

Ideally I think a documentation fix would be to just have these point at
the same text, e.g. a "parent" option could explain all the details, and
they could each point to that.

> The next inconsistency is for values < 1. Most options use online_cpus()
> when set to 0 except index.threads which is a special case of its own.
> Some options error out when set to a negative number while
> checkout.workers falls back to online_cpus() and http.maxRequests falls
> back to 5. I don't think we can fix this retroactively unless we decide
> that all config options will be set to online_cpus() if the value is
> negative. Should that be the case going forward or should 0 be the only
> special cased value for now? I can see an argument for allowing other
> negative values to be configured in the future for different defaulting
> options.

We also have other options, like warning() on negative values if we
think it's worth making these consistent while slightly annoying
existing users.

I think it's safe to say that by far the majority of git users aren't
tweaking these at all, so we have a lot of leeway for sensible changes.

> The final inconsistency is how values are defaulted if unset. Some
> default to online_cpus() while others default to 1 (http.maxRequests is
> 5). I want to call out grep.threads specifically here -- on my machine
> with 48 cores, the default is actually SLOWER than using 1 thread. This
> is because the grep operation is heavily IO bound, so creating too many
> threads adds overhead every time the read head changes. Interestingly,
> this option runs optimally at 4 since that's how many PCIe lanes my SSD
> uses. While it makes sense to default processor heavy operations to
> online_cpus(), does it make sense to do the same for IO heavy
> operations? (I wasn't able to find an equivalent of online_cpus() for
> drive reading capabilities.) And what about operations that have a fair
> mix of each?

First, http.maxRequests is different from any of the rest, it'll impact
3rd party servers. So we should treat it differently. I'd think unless
we have solid evidence for something else we should just leave that one
be, and certainly not have it be some function of online_cpus().

> The safe option is to default to 1 process for many of these config
> options, but we trade off in improving the experience for the average
> user that is unaware of these options. If we're already defaulting to
> online_cpus() for grep.threads and selecting 5 for http.maxRequests,
> then why not do the same for other options? My suggestion would be
> defaulting IO dominant operations to min(4, online_cpus()) since that
> seems like the standard number of lanes for people using SSDs. I would
> also default operations that have a mix of both to
> min(8, online_cpus()).

I haven't thought/tested what the defaults *should* be, but I think it's
a fair assumption that the current defaults were probably picked on the
basis of a few ad-hoc tests on some person's laptop :)

I.e. the 48 core case you mention etc. is likely to be untested & wasn't
thought of at the time.

I think *structurally* the best approach is something like having a
family of config variables like:
	
	core.jobs: [(false | 1)|(0 | true) | [2..Inf] ]
	core.jobs.IOBound: [(false | 1)|(0 | true) | [2..Inf]]
	core.jobs.CPUBound: [(false | 1)|(0 | true) | [2..Inf]]

Note that it's "0 or true" and "1 or false", not a mistake, i.e. that
matches our current defaults. You'd set it to "true" to get the "yes, I
want it parallel" setting.

We'd have these take priority from each other, so "grep.threads" would
override "core.jobs.IOBound", which in turn would override "core.jobs".

The common case would be that you wouldn't set either "core.jobs" or
"grep.threads", so we'd default to "core.jobs.IOBound", which we'd set
to some sensible default.

All of that's off-the-cuff, but hopefully has some worthwhile
feedback. In particular I think leaving our docs in a state where we
don't have to repeat ourselves (sometimes inaccurately) would be nice,
whether it's via includes or because we point to a "parent" variable.


	


