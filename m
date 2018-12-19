Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223A81F405
	for <e@80x24.org>; Wed, 19 Dec 2018 22:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeLSWsN (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 17:48:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:46226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727151AbeLSWsM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 17:48:12 -0500
Received: (qmail 18508 invoked by uid 109); 19 Dec 2018 22:48:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 22:48:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25681 invoked by uid 111); 19 Dec 2018 22:47:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 17:47:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 17:48:10 -0500
Date:   Wed, 19 Dec 2018 17:48:10 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
Message-ID: <20181219224810.GA20888@sigill.intra.peff.net>
References: <20181217165957.GA60293@google.com>
 <877eg5fwd5.fsf@evledraar.gmail.com>
 <20181219182216.GA17309@sigill.intra.peff.net>
 <20181219183927.GA228469@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219183927.GA228469@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 10:39:27AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   - web interfaces like GitHub won't linkify this type of reference
> >     (whereas they will for something that looks like a hex object id)
> >
> >   - my terminal makes it easy to select hex strings, but doesn't
> >     understand this git-describe output :)
> >
> > These tools _could_ be taught a regex like /v(\d+.)(-rc\d+)?([~^]+d)*/.
> > But matching hex strings is a lot simpler, and works across many
> > projects.
> 
> Is there some rule about how long the hex string has to be for this to
> work?

In both cases, it has to be 7 characters. In my experience, it doesn't
produce a lot of false positives (in the case of GitHub, I believe it
actually confirms that it's a real commit; in my terminal, it highlights
anything plausible).

> >   In commit 1234abcd (the subject line, 2016-01-01, v2.11.0), we did
> >   blah blah blah
> 
> The issue with this is that it is ambiguous about what the tag name is
> referring to: does that mean that "git describe" and "git version"
> tell me that v2.11.0 is the nearest *previous* release to that commit
> or that "git name-rev" tells me that v2.11.0 is a nearby *subsequent*
> release that contains it?

Sure, it's ambiguous if you've never seen it. But if it becomes a
convention in the project, then I don't think that's an obstacle.

I'm also not sure it really matters all that much either way. If you buy
my argument that this is just about placing the general era of the
commit in the mind of the reader, then "just before v2.11" or "just
after v2.11" are about the same.

> Of course the latter is the only answer that's useful, but in practice
> the former is what people tend to do when they are trying to follow a
> convention like this.  So we'd need some automatic linting to make it
> useful.

I thought we were just talking about an informational message in one
human's writing, that would be read and interpreted by another human
(the commit id is the thing that remains machine-readable). Automatic
linting seems a bit overboard...

> I think a more promising approach is the Fixes trailer Duy mentioned,
> which has been working well for the Linux kernel project.  I'll follow
> up in a reply to his message.

I think that's a good idea if something is in fact being fixed. But
there are many other reasons to refer to another commit in prose (or
even outside of a commit message entirely).

-Peff
