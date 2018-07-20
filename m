Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080B41F597
	for <e@80x24.org>; Fri, 20 Jul 2018 18:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeGTSuD (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:50:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:54342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387950AbeGTSuD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:50:03 -0400
Received: (qmail 30456 invoked by uid 109); 20 Jul 2018 18:00:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 18:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30304 invoked by uid 111); 20 Jul 2018 18:00:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 14:00:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 14:00:39 -0400
Date:   Fri, 20 Jul 2018 14:00:39 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720180039.GD22486@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <CACsJy8BxXyY6h8iN-RExBHASB6FkFLKDkrE_h+gH0A1k2tVd6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BxXyY6h8iN-RExBHASB6FkFLKDkrE_h+gH0A1k2tVd6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 04:41:34PM +0200, Duy Nguyen wrote:

> > Let's start by banning strcpy() and sprintf(). It's not
> > impossible to use these correctly, but it's easy to do so
> > incorrectly, and there's always a better option.
> 
> Is it possible to extend this to ban variables as well? I'm still
> going to delete the_index from library code. Once that work is done I
> will ban it from entering again (it's only allowed in builtin/ for
> example). The next target after that would be the_repository.
> 
> Right now I will do this by not declaring the variable [2], which ends
> up with a much less friendly compile warning. I did something similar
> [1] in an earlier iteration but did not do extensive research on this
> topic like you did.

IMHO just not declaring the variable is the right move (and is what I
would do with these functions if libc wasn't already declaring them).

The compile error may be less friendly, but these things are temporary
as topics-in-flight catch up. Whereas strcpy() will be with us forever.

I also think that removing variables is a special case of a larger
technique: when we change function semantics, we try to change the
signatures, too. So there you'll get a type error, or not enough
arguments, or whatever. And the next step is usually "git log" or "git
blame" to see what happened, and what the conversion should look like.

-Peff
