Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F6C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B572C20735
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDneaY1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHUSVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHUSVd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:21:33 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC53AC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:21:32 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e14so1287376vsa.9
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vz68qFrVS93PJnog7YsNfEx69lP9qGxS3V2gj8ZnoDc=;
        b=fDneaY1umzQZrcqVqEUJVVMon6xtdGD6kobbKKOz7WSK5/eU99IlW3h1IE612Ecfda
         mXhIhjhyf4fYHAoEIdN2wOQosRkJecb84z0uVUj9guPYOu5npsSJCAaRyZpi+wC9I5st
         GCr0FjyfUTl40x5Eyke2HRSu2WJiA4+n0j3gRtj9BaLVvBsghS8Z5fyRIrygvLgMKyZA
         JPB+g9uiiYgQ9mIh5MJkqkAO8Dguqw097dMDlcH8XKQrsUtEDJxjCzQge07uF23wCrOd
         qPGUYcqunHdUcrg8QmSG8XEyyLaJ3NMCkYThF0AHL00+AuEsuBW5xUGwVG59H1Kmyg1I
         LJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vz68qFrVS93PJnog7YsNfEx69lP9qGxS3V2gj8ZnoDc=;
        b=lH2lbwcHEeuFUbQH57l2/hIK11e06bV4t405GApS3GYKj80lvYDkZJVB45pH8yk/Of
         NgL53P6urdvumD2cEho2j714tpzFbRpP6CdwVVehlpVNmTLa/1VOZh3kh3VcGv2wHSCv
         p491TjM2XW5EgYnw2XT+0aO83ewUpwx7B8MpRs/fufsufqVsYjN1wqajpy5hKTMfkBcZ
         Bx+mNMqrhokx18QBiy8xwFO1YpAoziFMQkmXwQhqIPtkSeD1q46Jtg3rHSy8SDwREWR7
         DtM4xUZxDBEe58SVu8BJUscwYvnkiyxWmXkjZAHtNfGlrUr3uTXHcmkxZ/L2PFsQhFeF
         IXgw==
X-Gm-Message-State: AOAM530drZrmpnUxOk7XFCmIkKQgaaaJcf1y6ZpmFLLhSltOtkFRzeqS
        te+zCSQoo/VTv41sjJEGL7742gQhs5xuhNoRZZE=
X-Google-Smtp-Source: ABdhPJyRjZxH9ng8B+FmAotf2HJK9yKKS1EBfF1grEx1WxRW3aNHduXpi9h+3UhteXYL3h2mZMZjyDHycnX+SEDLokQ=
X-Received: by 2002:a67:33d7:: with SMTP id z206mr1093577vsz.15.1598034091867;
 Fri, 21 Aug 2020 11:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com> <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
 <20200818174116.GA2473110@coredump.intra.peff.net> <CA+P7+xrPep7caJm2uN+hAqOqZU3b2njpW95JQCzYJdKgbakp8A@mail.gmail.com>
 <CA+P7+xq4+RJF5f8v6ZG6mfXKg29Sh4CcFB72tKDPTx5vQLsS1A@mail.gmail.com>
In-Reply-To: <CA+P7+xq4+RJF5f8v6ZG6mfXKg29Sh4CcFB72tKDPTx5vQLsS1A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Aug 2020 11:21:19 -0700
Message-ID: <CA+P7+xo8KqGnKRmF7dGhWYV9tQ7dwzjoyezGMEbh4mxKHQJUbg@mail.gmail.com>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 10:26 AM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 10:16 AM Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 10:41 AM Jeff King <peff@peff.net> wrote:
> > > Hmm. I think the behavior we'd want is something like:
> > >
> > >   # make sure the other side has three refs
> > >   git branch prune/one HEAD
> > >   git branch prune/two HEAD
> > >   git branch prune/three HEAD
> > >   git push dst.git refs/heads/prune/*
> > >
> > >   # now drop two of ours, which are eligible for pruning
> > >   git branch -d prune/one
> > >   git branch -d prune/two
> > >
> > >   # push with pruning, omitting "two"
> > >   git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
> > >
> > >   # we should leave "two" but still deleted "one"
> > >   test_write_lines one three >expect
> > >   git -C dst.git for-each-ref --format='%(refname:lstrip=3)' refs/heads/prune/ >actual
> > >   test_cmp expect actual
> > >
> > > I.e., the negative refspec shrinks the space we're considering pruning.
> > > And we'd probably want a similar test for "fetch --prune".
> > >
> > > I just tried that, though, and got an interesting result. The push
> > > actually complains:
> > >
> > >   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
> > >   error: src refspec refs/heads/prune/two does not match any
> > >   error: failed to push some refs to 'dst.git'
> > >
> > > For negative refspecs, would we want to loosen the "must-exist" check?
> > > Or really, is this getting into the "are we negative on the src or dst"
> > > thing you brought up earlier? Especially with --prune, what I really
> > > want to say is "do not touch the remote refs/heads/two".
> > >
> > > We can get work around it by using a wildcard:
> > >
> > >   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two*
> > >   To dst.git
> > >    - [deleted]         prune/one
> > >
> > > So it works as I'd expect already with your patch. But I do wonder if
> > > there are corner cases around the src/dst thing that might not behave
> > > sensibly.
> > >
> >
> > Hmm. So this raises a good point. I added a variation of this test
> > where I used separate names for the source and destination. It looks
> > like with the current implementation, negative refspecs always apply
> > to the destination.
>
> I also tried adding a test for fetch --prune, but that ultimately
> calls query_refspecs_multiple and query_refspecs. I need to figure out
> how negative refspecs need to interact with that function still.

So there's an interesting problem here... query_refspecs_multiple
takes only the destination name, which makes the "get_stale_heads" not
work properly, since for fetch we want to apply the refspec to the
remote sides "source".
