Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8427C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A378C61222
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347325AbhDNFaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:30:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhDNFaB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 01:30:01 -0400
Received: (qmail 3298 invoked by uid 109); 14 Apr 2021 05:29:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Apr 2021 05:29:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4242 invoked by uid 111); 14 Apr 2021 05:29:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Apr 2021 01:29:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Apr 2021 01:29:39 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sam Bostock <sam.bostock@shopify.com>,
        Git List <git@vger.kernel.org>
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
Message-ID: <YHZ9w6MVMMHMxGeA@coredump.intra.peff.net>
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
 <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 05:26:02PM -0700, Chris Torek wrote:

> On Tue, Apr 13, 2021 at 5:18 PM Sam Bostock <sam.bostock@shopify.com> wrote:
> > Long story short, it seems to me that `git fetch` should update
> > "refs/remotes/origin/HEAD" when the upstream HEAD changes, but it
> > doesn't.
> 
> It's never been the *intent* to have `git fetch` update
> the corresponding remote-tracking `HEAD` ref.  To make
> that happen, you must run `git remote`:
> 
>     git remote set-head origin -a
> 
> for instance.
> 
> I have, however, often thought that this is the wrong
> *default* way for things to work, and that at least by default,
> `git fetch origin` should update `origin/HEAD` if the
> fetch result indicates that it should.  See also Junio's
> reply.  I think a configuration knob (similar to `fetch.prune`)
> would be reasonable here.  Users could then be encouraged
> to set `fetch.prune` to `true`, and `fetch.update-remote-HEAD`
> (or whatever) to `true` as well.

I think so, too. The previous discussion Junio referred to it is here:

  https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@gmail.com/

If you do read it, note that the parts of the conversation about unborn
heads are out of date. We do pick this up via clone these days, courtesy
of the commits in 69571dfe21 (Merge branch 'jt/clone-unborn-head',
2021-02-17).

-Peff
