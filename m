Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA29D1F859
	for <e@80x24.org>; Mon,  8 Aug 2016 11:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbcHHLVv (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 07:21:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:51081 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752228AbcHHLVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 07:21:51 -0400
Received: (qmail 28939 invoked by uid 109); 8 Aug 2016 11:21:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 11:21:49 +0000
Received: (qmail 2627 invoked by uid 111); 8 Aug 2016 11:21:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 07:21:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 07:21:47 -0400
Date:	Mon, 8 Aug 2016 07:21:47 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t5533: make it pass on case-sensitive filesystems
Message-ID: <20160808112147.b4ypgazlorlyy752@sigill.intra.peff.net>
References: <93e1fb21d1d24c5b751e2d9d25d9220704bae5aa.1470322425.git.johannes.schindelin@gmx.de>
 <xmqqwpjw4fmj.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608051613570.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608051613570.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 04:19:08PM +0200, Johannes Schindelin wrote:

> > The fix is meant for jk/push-force-with-lease-creation topic, but I
> > had to find it out by the old fashioned way, i.e. running blame for
> > these lines in 'pu' to find eee98e74f9 is the culprit and then
> > running "git branch --with eee98e74f9".  The only thing the line
> > made easier is I _could_ start the blame at the named commit (which
> > is on 'next') instead of 'pu'.  When I took that "base-commit"
> > series, I was hoping that it would give us a lot more useful
> > information.
> 
> Sorry for that. The way my mail-patch-series.sh script works is that it
> tries to determine which branch between `master`, `next` or `pu` is the
> base (and it then submits *all* commits that are on top of that branch).
> 
> So my branch was indeed based on `next` for that reason, not on
> top of `jk/push-force-with-lease-creation`. Otherwise, I would have
> resubmitted John's patches because the script would have determined that
> my patch is on top of `master`, not on top of `next`.

Do you fetch from the main git.git repository, or Junio's gitster/git
workspace on GitHub?

I usually fetch the latter, and then you have all the information you
need. So to work on somebody else's existing topic, you can do[1]:

  git checkout jk/push-force-with-lease-creation

which will check out the branch, tracking Junio's version of the topic
as your "upstream". Then things like "git rebase -i" just work, and you
can extract the patches as @{u}..HEAD.

It does get weird when he picks up your patch but you want to do further
work, because you would probably not want to "rebase -i" on top of it
(your version of the patch would become obsolete!).

-Peff

[1] I'm assuming you know the topic name. If not, then I usually find
    the commit through the usual archaeology, and then run "git branch
    a --contains" on it (or "for-each-ref" works for that these days,
    and you can restrict it to a pattern matching topic branches).
