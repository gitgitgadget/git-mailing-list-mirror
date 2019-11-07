Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E931F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfKGF4q (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:56:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:41654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725875AbfKGF4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:56:45 -0500
Received: (qmail 28888 invoked by uid 109); 7 Nov 2019 05:56:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 05:56:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32034 invoked by uid 111); 7 Nov 2019 06:00:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:00:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 00:56:44 -0500
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191107055644.GA6431@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
 <20191101165921.GD26219@sigill.intra.peff.net>
 <20191102010215.GB17624@danh.dev>
 <20191105080010.GA7415@sigill.intra.peff.net>
 <xmqqftj1yeo5.fsf@gitster-ct.c.googlers.com>
 <20191106040314.GA4307@sigill.intra.peff.net>
 <20191106100322.GC6351@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106100322.GC6351@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 05:03:22PM +0700, Danh Doan wrote:

> On 2019-11-05 23:03:14 -0500, Jeff King wrote:
> > >     3. You are dealing with a project originated on and migrated
> > >        from a foreign SCM, and older parts of the history is stored
> > >        in a non-utf-8, even though recent history is in utf-8
> > > 
> > > to the mix?
> > 
> > I would think you'd want to convert to utf-8 as you do the migration in
> > that case, since you're writing new hashes anyway.
> 
> Sorry but I'm confused.
> If we're migrating from foreign SCM, we could make our commit in
> utf-8 (convert their commit message to utf8).
> Even if we need to synchronise history between the foreign SCM in
> question with git, we could use i18n.logoutputencoding for the output
> comestic.

Right, that's the same thing I'm suggesting.

> > But I think a similar
> > case would just be an old Git repository, where for some reason you
> > thought i18n.commitEncoding was a good idea back then (perhaps because
> > you were in situation (1) then, but now you aren't).
> > 
> > In either case, though, I don't think it's a compelling motivation for
> > optimization, if only because those old commits will be shown less and
> > less (and even without modern optimizations like commit-graph, we'd
> > generally avoid reencoding those old commits unless we're actually going
> > to _show_ them).
> 
> I'm not sure if we're misunderstood each other.
> I've only suggested to encode _new_ commit from now on in utf-8.
> Reencoding old history in utf-8 is definitely not in that suggestion.

Yes. My point was that's _already_ the default behavior, unless you
explicitly set some config asking for non-utf8 commit objects. And I
don't think there's any good reason to set that these days.

-Peff
