Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CECE1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 00:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfA2Arz (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 19:47:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:52430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726803AbfA2Arz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 19:47:55 -0500
Received: (qmail 25129 invoked by uid 109); 29 Jan 2019 00:47:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 00:47:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31955 invoked by uid 111); 29 Jan 2019 00:48:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 19:48:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 19:47:53 -0500
Date:   Mon, 28 Jan 2019 19:47:53 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] completion: complete refs in multiple steps
Message-ID: <20190129004752.GA4327@sigill.intra.peff.net>
References: <20190128094155.2424-1-pclouds@gmail.com>
 <20190128143828.GJ6702@szeder.dev>
 <20190128172707.GA3050@sigill.intra.peff.net>
 <CACsJy8BXfY+bZKV6Jxa7-3VQyyE6hGrFS7ZAnToFwpGq_o1bpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BXfY+bZKV6Jxa7-3VQyyE6hGrFS7ZAnToFwpGq_o1bpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 07:43:45AM +0700, Duy Nguyen wrote:

> > > In general I think it would be much better to rely more on 'git
> > > for-each-ref' to do the heavy lifting, extending it with new format
> > > specifiers/options as necessary.
> >
> > FWIW, that was my first thought, too.
> 
> I was more concerned whether it's a good idea to begin with. But it
> sounds like you two both think it's good otherwise would have
> objected.

Heh. I do not have any real objection, but I don't think I'd really know
until I used it for a while. It may be a matter of preference, in which
case we might want $GIT_COMPLETION_REF_COMPONENTS to enable/disable it
(I don't have an opinion on what the default should be).

> >   $ git for-each-ref --refname='%(refname)'
> >   refs/heads/foo/bar
> >   refs/heads/foo/baz
> >   refs/heads/another/deep/one
> >
> > we'd ideally complete "fo" to "foo/" and "ano" to "another/deep/one",
> > rather than making the user tab through each level.
> 
> Ah ha, like github sometimes show nested submodule paths. Just one
> small modification, when doing "refs/heads/<tab>" I would just show
> 
> refs/heads/foo/
> refs/heads/another/
> 
> not refs/heads/another/deep/one to save space. But when you do
> "refs/heads/a<tab>" then you get "refs/heads/another/deep/one"
> immediately.

Yeah. It's still only one entry either way (by definition), but it's
going to be much longer than all of the others. Again, I think I'd have
to see it in practice to decide how much I cared either way.

> > Doing that requires actually understanding that the refs are in a list,
> > and not formatting each one independently. So I kind of wonder if it
> > would be easier to simply have a completion mode in for-each-mode.
> 
> That also allows more complicated logic. I think sometimes completion
> code gets it wrong (I think it's often the case with rev/path
> ambiguation, but maybe dwim stuff too). And we already have all this
> logic in C.

Yeah, agreed.

-Peff
