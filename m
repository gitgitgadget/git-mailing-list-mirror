Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E84C001B3
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGCRdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCRds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:33:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD0E5D
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:33:46 -0700 (PDT)
Received: (qmail 2132 invoked by uid 109); 3 Jul 2023 17:33:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 17:33:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9575 invoked by uid 111); 3 Jul 2023 17:33:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 13:33:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 13:33:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <20230703173345.GB3544413@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <39e9b0f50d07cc75219325e7c7e72a801ca0cf16.1687270849.git.me@ttaylorr.com>
 <20230703052724.GE3502534@coredump.intra.peff.net>
 <ZKMCzow9EH2BJIfp@nand.local>
 <ZKMD1L6rSph7vb7u@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKMD1L6rSph7vb7u@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 01:22:28PM -0400, Taylor Blau wrote:

> On Mon, Jul 03, 2023 at 01:18:06PM -0400, Taylor Blau wrote:
> > On Mon, Jul 03, 2023 at 01:27:24AM -0400, Jeff King wrote:
> > > On Tue, Jun 20, 2023 at 10:21:21AM -0400, Taylor Blau wrote:
> > >
> > > > Once we start passing either in, `match_pattern()` will have little to
> > > > do with a particular `struct ref_filter *` instance. To clarify this,
> > > > drop it from the argument list, and replace it with the only bit of the
> > > > `ref_filter` that we care about (`filter->ignore_case`).
> > >
> > > Makes sense, but...
> > >
> > > > @@ -2134,9 +2134,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
> > > >   * matches a pattern "refs/heads/" but not "refs/heads/m") or a
> > > >   * wildcard (e.g. the same ref matches "refs/heads/m*", too).
> > > >   */
> > > > -static int match_name_as_path(const struct ref_filter *filter, const char *refname)
> > > > +static int match_name_as_path(const struct ref_filter *filter,
> > > > +			      const char **pattern,
> > > > +			      const char *refname)
> > >
> > > ...wouldn't we then want to do the same for match_name_as_path()?
> >
> > Yes, definitely :-). I'm not sure how I missed this, since the patch
> > message even says that `match_name_as_path()` gets the same treatment as
> > the other function.
> >
> > But in any case, I obviously agree (and the diff below makes sense to
> > me). Applied.
> 
> Ah, this is missing one more spot (that we wouldn't complain about
> during a non-DEVELOPER build). This needs to go on top, but I otherwise
> agree:

Heh, yes. I was applying them in order, and had to make the same fixup
on top of the next patch. I think that was the only other fallout as I
applied the rest, though.

-Peff
