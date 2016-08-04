Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5051020193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbcHDSH4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:07:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:54858 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758843AbcHDSHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:07:55 -0400
Received: (qmail 7458 invoked by uid 102); 4 Aug 2016 18:07:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 14:07:53 -0400
Received: (qmail 14117 invoked by uid 107); 4 Aug 2016 18:08:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 14:08:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 14:07:49 -0400
Date:	Thu, 4 Aug 2016 14:07:49 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160804180749.foowbsmce72s46ww@sigill.intra.peff.net>
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net>
 <xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com>
 <20160803165652.zek5df7tv5reg6w4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608041706040.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608041706040.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 05:29:52PM +0200, Johannes Schindelin wrote:

> So my idea was to introduce a new --reword=<commit> option to `git commit`
> that would commit an empty patch and let the user edit the commit message,
> later replacing the original one with the new one. This is not *quite* as
> nice as I want it, because it makes the changes unobvious. On the other
> hand, I would not find a series of sed commands more obvious, in
> particular because that limits you in the ways of sed. And, you know,
> regexp. I like them, but I know many people cannot really work with them.

I don't have a real opinion on this. I probably wouldn't use it, but I
have no problem with it existing. I think it's somewhat orthogonal to
the idea of _transmitting_ those reword operations to somebody else.

> > That pushes work onto the submitter, but saves work from the reviewers,
> > who can quickly say "something like this..." without having to worry
> > about making a full change, formatting it as a diff, etc.
> > 
> > I do think that's the right time-tradeoff to be making, as we have more
> > submitters than reviewers.
> 
> I agree that it is the right trade-off. TBH I was shocked when I learned
> how much effort Junio puts into applying my patches. I do not want that. I
> want my branch to reflect pretty precisely (modulo sign-off, of course)
> what is going to be integrated into Git's source code.

Like you, I have occasionally been bitten by Junio doing a fixup, and
then I end up re-rolling, and lose that fixup (or have to deal with
porting it forward with awkward tools).

But I think such fixups are a calculated risk. Sometimes they save a lot
of time, both for the maintainer and the contributor, when they manage
to prevent another round-trip of the patch series to the list.

IOW, if the flow is something like:

  1. Contributor sends patches. People review.

  2. Minor fixups noticed by maintainer, fixed while applying.

  3. Only one small fixup needed from review. Contributor sends
     squashable patch. Maintainer squashes.

then I think that is a net win over sending the whole series again, for
the contributor (who does not bother sending), reviewers (who really
only need to look at the interdiff, which is what that squash is in the
first place), and the maintainer (who can squash just as easily as
re-applying the whole series).

It does mean the "final" version of the series is never on the list. It
has to be pieced together from the squash (and sometimes step 2 is not
even mentioned on-list).

So I think it is really a judgement call for step (3) on what is a
"small" fixup, and whether it is easier for everybody to look at the
squash interdiff and say "yep, that's right", versus re-reviewing the
whole series.

> I'd much prefer to resubmit a cleaned-up version, even if it was just the
> commit subjects, and be certain that `pu` and my branch are on the same
> page.
> 
> Instead, Junio puts in a tremendous amount of work, and it does not help
> anybody, because the local branches *still* do not have his fixups, and as
> a consequence subsequent iterations of the patch series will have to be
> fixed up *again*.

And that is the flip side. If the flow above does not happen, then step
2 just becomes a pain.

I don't have a silver bullet or anything. I'm mostly just musing.

-Peff
