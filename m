Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652AC1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 18:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbeGTSxx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:53:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:54352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733128AbeGTSxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:53:52 -0400
Received: (qmail 30648 invoked by uid 109); 20 Jul 2018 18:04:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 18:04:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30328 invoked by uid 111); 20 Jul 2018 18:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 14:04:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 14:04:27 -0400
Date:   Fri, 20 Jul 2018 14:04:27 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720180427.GE22486@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <CACsJy8BxXyY6h8iN-RExBHASB6FkFLKDkrE_h+gH0A1k2tVd6w@mail.gmail.com>
 <CABPp-BGt2EEW4aFt8TYyy1fATPRW2rnNxpMuGcS0YR_gqs3=ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGt2EEW4aFt8TYyy1fATPRW2rnNxpMuGcS0YR_gqs3=ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 10:48:37AM -0700, Elijah Newren wrote:

> > Is it possible to extend this to ban variables as well? I'm still
> > going to delete the_index from library code. Once that work is done I
> 
> Or perhaps constants, such as PATH_MAX to avoid problems like this one
> from 2.18.0 timeframe:
> https://public-inbox.org/git/7d1237c7-5a83-d766-7d93-5f0d59166067@web.de/

I've been slowly trying to eradicate PATH_MAX from our code base. And I
would be happy with an eventual automated ban there. Unlike the_index,
it comes from the system, so it's in the same boat as strcpy() etc.

That said, I think it's less urgent. The urgent problem fixed by the
patch you linked was the use of strcpy() to overflow the buffer. Without
that, it just becomes a normal bug where we do not handle long paths
well on some operating systems.

-Peff
