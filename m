Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669AC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D9D2073B
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5CKy2jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgE0WjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 18:39:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10FC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:39:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so2188874pjd.0
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNwZEMtdISZVddsSk+3fWl+VObNBnupUCo/xO0lPq98=;
        b=J5CKy2jRxWOeXZ/1qD6PSXyUMr1LSPnrYG55Jzgqp0AsW1wQZoBB4luFu/K1u3JsE4
         /QWKMRI2wq8WolkcTFsi9SC8760t2ILMyepzX8gACvkWYJLw2pyM3E/G6SkFw3HbAFIK
         P+aZEanEtOuTK+3iIK30pTgEyhItOZ1pcCF95Yey9QzTQgWOVUdfHqdrZAjXO3JfB6qq
         YSS2/XLfhxV/0NDfvg0/7MfZ2rG1/KUHO8+aWY68guo6SfjE64pCqLQhVx2exPb6NSYO
         AYcl42a4UtHQfaG0Y9SjNIoncgnKWDrHDVMisUPlhgghtuMSgvkV+iZFWnuCIJwMpiVx
         wvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=jNwZEMtdISZVddsSk+3fWl+VObNBnupUCo/xO0lPq98=;
        b=drVvDPpmrzMVVBGPeXyUfdNNCGZK4lXmIZ2f3bB1owyiK7ycxwomkSXFU9bFKqYnRB
         ++4Ld03kMgH5lpjlAG+NKBCcSUqjnfoGosfDZBN3k3jPxcMjhkvj1O4qt+sTUS7wOtep
         XwTzkTfSU2IQK5/y6mGIztLn72n8ZDj+T+yjYznCPx9KESUKSAIi+RQzhjwEgtxb8Asu
         HnEYW3IaMeG/ne0Kl2o9Xbxyf85VCMvrjRSGThbOHKHc1wdKwsniun/w1QqtUuk9n7EA
         SYk//nnbhZ+GdehKNlkPwlyUgPuoTRI7+GhCyNcdO9dz/6hpu6Z+998wSsjFuLj+Ci1H
         ilsA==
X-Gm-Message-State: AOAM5329WBl2bGyTlpsGuKj+SbmHPn2HvUgg7wRnk7artTIegp10FsUw
        jXOrL8+mnWt77gy1s7z1gfBA/w==
X-Google-Smtp-Source: ABdhPJxnZYpeXey5SC/SAJtYExipDYmKiMQK23Wic9w2ARnNne48d3BNjyhRu2MWUx+u23Pfkju8pA==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr542504ply.139.1590619155078;
        Wed, 27 May 2020 15:39:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id gp18sm3006236pjb.38.2020.05.27.15.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:39:14 -0700 (PDT)
Date:   Wed, 27 May 2020 15:39:07 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Message-ID: <20200527223907.GB65111@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
 <20200407014829.GL6369@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
 <20200408000149.GN6369@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408000149.GN6369@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm late to the discussion, but I'd like to chime in here too.


On 2020.04.08 00:01, brian m. carlson wrote:
> Hey,
> 
> On 2020-04-07 at 22:23:43, Johannes Schindelin wrote:
> > > If there are periodic tasks that should be done, even if only on large
> > > repos, then let's have a git gc --periodic that does them.  I'm not sure
> > > that fetch should be in that set, but nothing prevents users from doing
> > > "git fetch origin && git gc --periodic".
> > 
> > Hmm. Who says that maintenance tasks are essentially only `gc`? With
> > _maaaaaybe_ a `fetch` thrown in?
> 
> What I'm saying is that we have a tool to run maintenance tasks on the
> repository.  If we need to perform additional maintenance tasks, let's
> put them in the same place as the ones we have now.  I realize "gc" may
> become a less accurate name, but oh, well.
> 
> > > Let's make it as simple and straightforward as possible.
> > 
> > I get the impression, however, that many reviewers here seem to favor the
> > goal of making the _patches_ as simple and straightforward as possible,
> > however, at the expense of the original goal. Like, totally sacrificing
> > the ease of use in return for "just use a shell script" advice.
> 
> I think we can have both.  They are not mutually exclusive, and I've
> proposed a suggestion for both.
> 
> > > As for handling multiple repositories, the tool to do that could be as
> > > simple as a shell script which reads from ~/.config/git/repo-maintenance
> > > (or whatever) and runs the same command on all of the repos it finds
> > > there, possibly with a subcommand to add and remove repos.
> > 
> > Sure, that is flexible.
> > 
> > And it requires a ton of Git expertise to know what to put into those
> > scripts. And Git updates cannot deliver more value to those scripts.
> 
> Perhaps I was unclear what I thought could be the design of this.  My
> proposal is something like the following:
> 
>   git schedule-gc add [--period=TIME] [--fetch=REMOTE | --fetch-all] REPO
>   git schedule-gc remove REPO
> 
> The actual command invoked by the system scheduler would be something
> like the following:
> 
>   git schedule-gc run
> 
> It would work as I proposed under the hood, but it would be relatively
> straightforward to use.

Regardless of what happens with the job-runner, I would like to see a
top-level command that performs a single iteration of all the
recommended maintenance steps, with zero configuration required, on a
single repo. This gives an entry point for users who want to manage
their own maintenance schedule without running a background process.


> > > I'm not opposed to seeing a tool that can schedule periodic maintenance
> > > jobs, perhaps in contrib, depending on whether other people think it
> > > should go.  However, I think running periodic jobs is best handled on
> > > Unix with cron or anacron and not a custom tool or a command in Git.
> > 
> > Okay, here is a challenge for you: design this such that the Windows
> > experience does _not_ feel like a 3rd-class citizen. Go ahead. Yes, there
> > is a scheduler. Yep, it does not do cron-like things. Precisely: you have
> > to feed it an XML to make use of the "advanced" features. Yeah, I also
> > cannot remember what the semantics are regarding missed jobs due to
> > shutdown cycles. Nope, you cannot rely on the XML being an option, that
> > would require Windows 10. The list goes on.
> 
> I will freely admit that I know next to nothing about Windows.  I have
> used it only incidentally, if at all, for at least two decades.  It is
> not a platform I generally have an interest in developing for, although
> I try to make it work as well as possible when I am working on a project
> which supports it.
> 
> It is, in general, my assumption, based on its wide usage, that it is a
> powerful and robust operating system with many features, but I have
> little actual knowledge about how it functions or the exact features it
> provides.
> 
> I want a solution that builds on the existing Unix tools for Unix,
> because that is least surprising to users and it is how Unix tools are
> supposed to work.  I think we can agree that Git was designed with the
> Unix philosophy in mind.
> 
> I also want a solution that works on Windows.  Ideally that solution
> would build on existing components that are part of Windows, because it
> reduces the maintenance burden on all of us.  But unfortunately, I know
> next to nothing about how to build such a solution.
> 
> > > I've dealt with systems that implemented periodic tasks without using
> > > the existing tools for doing that, and I've found that usually that's a
> > > mistake.  Despite seeming straightforward, there are a lot of tricky
> > > edge cases to deal with and it's easy to get wrong.
> > 
> > But maybe you found one of those issues in Stolee's patches? If so, please
> > do contribute your experience there to point out those issues, so that
> > they can be addressed.
> 
> One of the benefits of using anacron on Unix is that it can skip running
> tasks when the user is on battery.  This is not anything we can portably
> do across systems, nor is it something that Git should need to know
> about.
> 
> > > We also don't have to reimplement all the features in the system
> > > scheduler and can let expert users use a different tool of their choice
> > > instead if cron (or the Windows equivalent) is not to their liking.
> > 
> > Do we really want to start relying on `cron`, when the major platform used
> > by the target audience (enterprise software engineers who deal with rather
> > larger repositories than git.git or linux.git) quite obviously _lacks_
> > support for that?
> 
> Unix users will be unhappy with us if we use our own scheduling system
> when cron is available.  They will expect us to reimplement those
> features and they will complain if we do not.  While I cannot name
> names, there are a nontrivial number of large, enterprise monorepos that
> run only on macOS and Linux.

Speaking purely as a user, I agree with this point. This is why I want a
single-iteration top-level maintenance command.

Once we have that, we can provide recommended configs for existing
scheduling solutions (cron, launchd, systemd, etc.) in contrib/. If the
Windows scheduler is cumbersome enough that users don't want to use it,
then I think it's perfectly reasonable to provide our own limited
job-runner in contrib/ as well, so long as we don't require people to
use it.

> That doesn't prevent us from building tooling that does the scheduling
> on Windows if we can't use the system scheduler, but it would be nice to
> try to present a relatively unified interface across the two platforms.
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


