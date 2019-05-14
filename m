Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024981F461
	for <e@80x24.org>; Tue, 14 May 2019 09:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfENJ3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:29:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:56572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726148AbfENJ3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:29:02 -0400
Received: (qmail 2871 invoked by uid 109); 14 May 2019 09:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 09:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10944 invoked by uid 111); 14 May 2019 09:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 05:29:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 05:29:01 -0400
Date:   Tue, 14 May 2019 05:29:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alyssa Ross <hi@alyssa.is>, git@vger.kernel.org
Subject: Re: [PATCH] doc: explain why file: URLs and bundles don't mix
Message-ID: <20190514092900.GA11679@sigill.intra.peff.net>
References: <20190513002355.25031-1-hi@alyssa.is>
 <xmqqv9yebwzp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9yebwzp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 05:05:14PM +0900, Junio C Hamano wrote:

> I think what is closer to the reaility is that we check if the
> source is a bundle when the local filesystem path is used and try to
> clone from the bundle, before using the local filesystem path as a
> directory we can "clone --local" from.  On the other hand, when the
> <scheme>://<path> syntax is used, we do not even bother seeing if
> the named resource is a bundle, or if --local optimization is
> possible (because we do not bother seeing if the named resource is a
> local filesystem entity, either).

Yeah. My concern on reading Alyssa's patch is that it goes into too much
detail about "why", when this is basically just "it's a bug that nobody
has yet fixed". I think it makes sense to warn people about the
behavior, but we should probably be vague about the reasons and up-front
that there is really no good reason that it doesn't work (and it might
in the future).

Of course fixing the issue is better still. ;)

> A possibly interesting tangent to think about is what would happen
> if we slightly tweak the above design.  What it would require for
> the code to take "git clone https://site/repo.bndl", realize that
> the named resource is a bundle file, curl/wget it and clone from
> that downloaded bundle?  And if it is feasible to implement, would
> it even be a good idea to begin with?  I do not have a ready answer
> to either of these questions myself.

I've been meaning to come back to this for, oh, going on 8 years now:

  https://public-inbox.org/git/20111110074330.GA27925@sigill.intra.peff.net/

(though it was meant to work with a CDN "try this first then top-off"
strategy; with Jonathan Tan's more flexible CDN work which uses raw
packfiles, I doubt I'd come back to this).

-Peff
