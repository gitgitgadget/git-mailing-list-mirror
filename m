Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C3C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D627C22BF5
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kam8ZI36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgHUR06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgHUR0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:26:48 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A7C061574
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:26:47 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k18so748974uao.11
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y++f/kx5/VZos4a9u/d3NlnJy2RL+SBoFL726yrmmhc=;
        b=Kam8ZI3635Tcrnggbg0ifXgbzcaS3StjWb59nyOqOx79A5f+Y6xhMNqszYqCG7CgzH
         rkJIiQmvLccByymqEANfWW0/wiexp575z9GqLha0t2om3UAvzXNAq45CyQAsS3Wf9nKh
         vGKuOgMbBl240AUpAMBygcXvo1k9wEw4ISuZ+dcnQcZl2SoWz/GGigCXxbim2Wi8+U35
         kECr4jjHXWa4IDQtc8T+CKhQ3qU7pm4qCN0fOtxkrDOD4U9/2f6ZODCVBjtgjXcWd535
         74OKjgp3alKLG+4Y9TgZ6PHvnzAZVzNy+S42EThCVH78zvWrdR43SCmqrQW02yA9gdaF
         auDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y++f/kx5/VZos4a9u/d3NlnJy2RL+SBoFL726yrmmhc=;
        b=fxApNVuzcBZHzM0UiIeLXwWcRip0ZyjYhiGxXraGxE6+tVghA14GPumXR7/8ApYtew
         d6t+9XLoOT0tuxDilyS8CPWWg8KbYw/BPf9gT5eNw3iO0YrQOsU3gUhGEROIDhbhG1oP
         qbEjFqR7HNKfjHfbQxJ8TstaK4UT6mHkYxwWIHex6XHaP7RNJNBLBxockba+lPveK0Uh
         lozxD6SSgqU5Fdyvu5XDkvecI45yOcgkVpXtO51Psgpw2mnmy3EEvvEhXGHQ/TeCiuj6
         qelUg3nzsOQZf0wVgW6SSnqvUYiwdyn4DrQ9ZwQZZ3gicohtomiPG2Bv5t7XVue+5Jzh
         FBZQ==
X-Gm-Message-State: AOAM531XVkVimSK06E9eF573/1OxwwSCnYeXcvADhTDEioE9hGt8/MOG
        XzdyefHHrgWrHZuT8pmI6nb+/Q9KOb+AmWnavLkxFwbtWCA=
X-Google-Smtp-Source: ABdhPJxmN3hB1x7Dcgzx0lFykYfqSIwg/5RSuSNK8Yx4uxJyXriV4q+xAov41iG9Rdwbr9vu25OEWqBTW5alFCwPksE=
X-Received: by 2002:a9f:2f18:: with SMTP id x24mr2190385uaj.21.1598030806621;
 Fri, 21 Aug 2020 10:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com> <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
 <20200818174116.GA2473110@coredump.intra.peff.net> <CA+P7+xrPep7caJm2uN+hAqOqZU3b2njpW95JQCzYJdKgbakp8A@mail.gmail.com>
In-Reply-To: <CA+P7+xrPep7caJm2uN+hAqOqZU3b2njpW95JQCzYJdKgbakp8A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Aug 2020 10:26:35 -0700
Message-ID: <CA+P7+xq4+RJF5f8v6ZG6mfXKg29Sh4CcFB72tKDPTx5vQLsS1A@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 10:16 AM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Tue, Aug 18, 2020 at 10:41 AM Jeff King <peff@peff.net> wrote:
> > Hmm. I think the behavior we'd want is something like:
> >
> >   # make sure the other side has three refs
> >   git branch prune/one HEAD
> >   git branch prune/two HEAD
> >   git branch prune/three HEAD
> >   git push dst.git refs/heads/prune/*
> >
> >   # now drop two of ours, which are eligible for pruning
> >   git branch -d prune/one
> >   git branch -d prune/two
> >
> >   # push with pruning, omitting "two"
> >   git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
> >
> >   # we should leave "two" but still deleted "one"
> >   test_write_lines one three >expect
> >   git -C dst.git for-each-ref --format='%(refname:lstrip=3)' refs/heads/prune/ >actual
> >   test_cmp expect actual
> >
> > I.e., the negative refspec shrinks the space we're considering pruning.
> > And we'd probably want a similar test for "fetch --prune".
> >
> > I just tried that, though, and got an interesting result. The push
> > actually complains:
> >
> >   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
> >   error: src refspec refs/heads/prune/two does not match any
> >   error: failed to push some refs to 'dst.git'
> >
> > For negative refspecs, would we want to loosen the "must-exist" check?
> > Or really, is this getting into the "are we negative on the src or dst"
> > thing you brought up earlier? Especially with --prune, what I really
> > want to say is "do not touch the remote refs/heads/two".
> >
> > We can get work around it by using a wildcard:
> >
> >   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two*
> >   To dst.git
> >    - [deleted]         prune/one
> >
> > So it works as I'd expect already with your patch. But I do wonder if
> > there are corner cases around the src/dst thing that might not behave
> > sensibly.
> >
>
> Hmm. So this raises a good point. I added a variation of this test
> where I used separate names for the source and destination. It looks
> like with the current implementation, negative refspecs always apply
> to the destination.

I also tried adding a test for fetch --prune, but that ultimately
calls query_refspecs_multiple and query_refspecs. I need to figure out
how negative refspecs need to interact with that function still.
