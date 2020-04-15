Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFDC2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D42B2072D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fjwAhx4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392355AbgDOARV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392351AbgDOARQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 20:17:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C62C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:17:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so729608pfh.6
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gCoaPNCfA7JyYN0asjYBFSfuIt2jFN81EJJB6HN6jhc=;
        b=fjwAhx4abyEdD5AiKUOxi9F53QffKgrgSDEOb+wuvnZmp2o93RAWsuvpxmPi0fbrlZ
         6vYJEmAj1zWm3e3HEsOdGPiH13xV0CeRIUnUAdfN4ICFcFkdlN+SCfCpzWZbDGz6TnDO
         ACcL9p9XeH0o0JsEcDEv/dEYbRdxnFvRlaQagvha0I21cJab/qb3u9FzNbhGGemK0cOk
         WOJ5nxqcqHJVs919k+CFXxvkN0D9V8C8T9i81l5MIAun/89CyP9A+leAQ64IlWiRAFS6
         1eNPnxaUfdNmLF1AnHmNkymH/prJAzeZRAowbH6dIlY1sQmwE43t50+hvf3HzBLFLYkK
         CSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gCoaPNCfA7JyYN0asjYBFSfuIt2jFN81EJJB6HN6jhc=;
        b=FQobzPJYubvsiZD1EU+BD2CNYvHanlrGVbiVaJZcrAwHaCYSzOZibUhRSHMPqpTvzf
         oD0pVI3Te3fEd9ahgwXDyH5Nx7zbIjQVrsRb8NMeLMhXqGPYzp39oRzQ0XpuLZ3ajGl5
         NssLbP4PVNLnBmWwDA8nPqMiMezdZQ8+ERZnMPe+SK1Xxsdrbk64DRJi/GkAxOVdI55I
         Qf1HpahizYQYSBBsja4uB6LIV92RA/Eoh9ftJQRjE7opmVRr6hOs830K3RRTPrQvAuIa
         o+kag5ZH6ltxZcjwSHpITrZN4/YuqmR+iLa0pivJjYftSdLrPYj3kFFUXP3Y0/153uIl
         ZbcA==
X-Gm-Message-State: AGi0PuYoLrJVe/JejL1h0FMlFlrhmkGpAD69rK46/4hMDtuzzzUgzVny
        S5LvkFoGGxcGf6VTvP6R45uisA==
X-Google-Smtp-Source: APiQypK1L23bglyBiO/ZU830yjgA1PUtFu/UVD6kq5fXnlmQEw9uCf1RNmVgFWFXau01t9Ha7rzpRA==
X-Received: by 2002:a63:8f07:: with SMTP id n7mr24618091pgd.362.1586909835654;
        Tue, 14 Apr 2020 17:17:15 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id mq18sm14503786pjb.6.2020.04.14.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:17:14 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:17:13 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] commit: write commit-graph with Bloom filters
Message-ID: <20200415001713.GB7457@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
 <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
 <20200413161245.GE59601@syl.local>
 <xmqqh7xnauxc.fsf@gitster.c.googlers.com>
 <74e4e8d6-d401-081d-14cc-c4b6087bdeda@gmail.com>
 <xmqqa73e9dws.fsf@gitster.c.googlers.com>
 <36f321b9-e2ff-60c3-637a-38682ee5d9f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36f321b9-e2ff-60c3-637a-38682ee5d9f0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 01:40:53PM -0400, Derrick Stolee wrote:
> On 4/14/2020 1:26 PM, Junio C Hamano wrote:
> > Derrick Stolee <stolee@gmail.com> writes:
> >
> >> On 4/13/2020 6:21 PM, Junio C Hamano wrote:
> >>> Taylor Blau <me@ttaylorr.com> writes:
> >>>
> >>>> Hmm. I'm not crazy about a library function looking at 'GIT_TEST_*'
> >>>> environment variables and potentially ignoring its arguments, but given
> >>>> the discussion we had in v1, I don't feel strongly enough to recommend
> >>>> that you change this.
> >>>>
> >>>> For what it's worth, I think that 'write_commit_graph' could behave more
> >>>> purely if callers checked 'GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS' and set
> >>>> 'flags' appropriately from the outside,...
> >>>
> >>> Yeah, I agree that it would be a lot cleaner if that is easy to
> >>> arrange.  I have a suspicion that Derrick already tried and the
> >>> resulting code looked messier and was discarded?
> >>
> >> Perhaps I could fix both concerns by
> >>
> >> 1. Use a macro instead of a library call.
> >>
> >> 2. Check the _CHANGED_PATHS variable in the macro.
> >
> > I am not sure how use of a macro "fixes" purity, though.  And what
> > is the other concern?
>
> The concern was (1) checking the environment and (2) die()ing in the
> library.

I think that we might as well use a plain old function here instead of a
macro, especially since the macro is just expanding out to what that
function would be if we had written it that way.

For what it's worth, my concern was more that I don't mind dying, but
I'd rather do so in a calling function, and that by the time we're
calling 'write_commit_graph', that we should be using return values
instead of 'die()' or 'error()'.

> > How widely would this "if we are testing, write out the graph file"
> > call be sprinkled over the codebase?  I am hoping that it won't be
> > "everywhere", but only at strategic places (like "just once before
> > we leave a subcommand that creates one or bunch of commits").  And
> > how often would they be called?  I am also hoping that it won't be
> > "inside a tight loop".  In short, I am wondering if we can promise
> > our codebase that
> >
> >  - git_test_write_commit_graph_or_die() calls won't be an eyesore
> >    (and/or distraction) for developers too much.
> >
> >  - git_env_bool() call won't have performance impact.
>
> I could add a comment to the header file to say "this is only for
> improving coverage of optional features in the test suite. Do not
> call this method unless you know what you are doing."

Works for me.

> My intention right now is to only include this in 'git commit'
> and 'git merge'. Earlier discussion included thoughts about
> 'git rebase' and similar, but those are more rarely used when
> constructing an "example repo" in the test scripts.

Ditto. I think that there's benefit in having it in some places but not
all (as Stolee pointed out earlier in the thread), and that trying to
have it everywhere is a fool's errand.

> -Stolee

Thanks,
Taylor
