Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20516202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 21:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbdGEVaa (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 17:30:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:60440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753037AbdGEVaR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 17:30:17 -0400
Received: (qmail 22614 invoked by uid 109); 5 Jul 2017 21:30:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 21:30:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10595 invoked by uid 111); 5 Jul 2017 21:30:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 17:30:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 17:30:10 -0400
Date:   Wed, 5 Jul 2017 17:30:10 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
Message-ID: <20170705213010.asbegr77pgvectuz@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
 <c4a4df1c-bf38-fbad-e7c2-9236fde87417@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4a4df1c-bf38-fbad-e7c2-9236fde87417@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05, 2017 at 09:05:14PM +0100, Ramsay Jones wrote:

> On 05/07/17 09:00, Jeff King wrote:
> > Since its inception, the general strategy of the reflog-walk
> > code has been to start with the tip commit for the ref, and
> > as we traverse replace each commit's parent pointers with
> > fake parents pointing to the previous reflog entry.
> > 
> > This lets us traverse the reflog as if it were a real
> > history, but it has some user-visible oddities. Namely:
> > 
> >   1. The fake parents are used for commit selection and
> >      display. So for example, "--merges" or "--no-merges"
> >      are useful, because the history appears as a linear
> >      string. Likewise, pathspec limiting is based on the
> >      diff between adjacent entries, not the changes actually
> >      introduced by a commit.
> > 
> >      These are often the same (e.g., because the entry was
> >      just running "git commit" and the adjacent entry _is_
> >      the true parent), but it may not be in several common
> >      cases. For instance, using "git reset" to jump around
> >      history, or "git checkout" to move HEAD.
> > 
> >   2. We reverse-map each commit back to its reflog. So when
> >      it comes time to show commit X, we say "a-ha, we added
> >      X because it was at the tip of the 'foo' reflog, so
> >      let's show the foo reflog". But this leads to nonsense
> >      results when you ask to traverse multiple reflogs: if
> >      two reflogs have the same tip commit, we only map back
> >      to one of them.
> > 
> >      Instead, we should show each reflog individually, in
> >      the order the user gave us on the command line.
> > 
> >   2. If the tip of the reflog and the ref tip disagree on
>     ^^
> It seems hard to get off the second point! ;-)

Heh. You know, I even remember checking that I didn't screw that up
(because I originally wrote the first and third, and later went back to
add in the second point). But somehow I botched the proofreading, too.

I'll plan to re-roll this to update the little bits you and Junio have
pointed out. Junio, I'll probably just do the whole thing on "maint" and
then the merge-up to "master" should be straight-forward, I'd think.

-Peff
