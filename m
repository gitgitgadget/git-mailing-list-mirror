Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32AC91F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeKCDEH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 23:04:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:38388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726085AbeKCDEH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 23:04:07 -0400
Received: (qmail 23880 invoked by uid 109); 2 Nov 2018 17:56:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 17:56:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6059 invoked by uid 111); 2 Nov 2018 17:55:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 13:55:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 13:56:05 -0400
Date:   Fri, 2 Nov 2018 13:56:05 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFE] Please add name and email to git credentials
Message-ID: <20181102175605.GA17353@sigill.intra.peff.net>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
 <87zhutjb3t.fsf@evledraar.gmail.com>
 <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
 <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
 <62bf61555a6c2789e959e4f085bfedf28b60f268.camel@laposte.net>
 <CAP8UFD0DHGShwo=DnwbSHz3nvRMF9P4GegEzC27uwHLXQ=A4Zw@mail.gmail.com>
 <1e3901b9a75a043d9c31d66d98410f3288a7c5be.camel@laposte.net>
 <20181102165110.GA11212@sigill.intra.peff.net>
 <841569ad61dd5f4f5424e8c2860a4c01f146c8a1.camel@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <841569ad61dd5f4f5424e8c2860a4c01f146c8a1.camel@laposte.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 06:32:36PM +0100, Nicolas Mailhot wrote:

> > I did create the way git credential matches repo urls. And I do not
> > think your proposal is a good idea. The credential system is about
> > interacting with a remote URL, and creating a commit object is a local
> > operation. That mismatch leaks through when you work with multiple
> > remotes, since it is not clear which URL we would match against when
> > the operation does not involve a remote at all.
> 
> I don't think it's quite that simple. The id part of creating a commit
> object is not a local operation at all. You choose the id written in a
> commit for a specific remote target, it has no use locally, most of us
> do not need it to reach themselves.

I don't think that's true. You do not need to have a remote at all to
use Git.

But more importantly, the commit is not in any way tied to a specific
remote. You might have multiple remotes that are storing many of the
same objects. So even if you wanted to somehow assign a segment of
history to a remote, it is not an unambiguous mapping.

> So yes there is a leak but it’s built in the git commit logic itself.
> Ideally, git would defer resolving <me> in commits to when I push to a
> remote target. I'm sure you’re aware of all the workarounds git users do
> at push time, when they realize the commit <me> is not the good one.

Your second sentence is fundamentally at odds with how Git works and its
decentralized data model.

> And since the leak is built in the commit logic itself, there are no
> perfect solutions that do not involve revisiting how commit works.
> 
> So, unless someone wants to revisit git commit, we’re left with
> imperfect solutions, and git credentials is no worse than another. It
> certainly fixes my use case fine. You did good work in git credentials.

Sorry, I just don't agree with any of the logic here. That's not how
commits work in Git, and all of the solutions are not equally imperfect.

-Peff
