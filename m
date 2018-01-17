Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637B81F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeAQVpS (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:45:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:47060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750931AbeAQVpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:45:17 -0500
Received: (qmail 19708 invoked by uid 109); 17 Jan 2018 21:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 21:45:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5893 invoked by uid 111); 17 Jan 2018 21:45:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 16:45:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 16:45:16 -0500
Date:   Wed, 17 Jan 2018 16:45:16 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v2 04/18] cat-file: move struct expand_data into
 ref-filter
Message-ID: <20180117214515.GB13128@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc532-75f3ef78-26cb-4751-9ded-eb0e8d23833b-000000@eu-west-1.amazonses.com>
 <20180115214419.GE4778@sigill.intra.peff.net>
 <CAL21Bmm0u4NgnPZMOh8PZqQ0is3inANKmCAr7MTaQHVyEOO7XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21Bmm0u4NgnPZMOh8PZqQ0is3inANKmCAr7MTaQHVyEOO7XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 10:00:42AM +0300, Оля Тележная wrote:

> > I think some of these will want to remain in cat-file.c. For instance,
> > split_on_whitespace is not something that ref-filter.c itself would care
> > about. I'd expect in the endgame for cat-file to keep its own
> > split_on_whitespace flag, and to set it based on the presence of the
> > %(rest) flag, which it can check by seeing if the "rest" atom is in the
> > "used_atom" list after parsing the format.
> 
> Yes, maybe we will need to leave some part of expand_data variables.
> But, if it would be only "split_on_whitespace", it's better to make
> just one flag without any other stuff. Actually, I thought about
> moving related logic to ref-filter also. Anyway, it's hard to say
> exact things before we code everything. Do I need to fix commit
> message and make it more soft?

Yeah, I think it might just be split_on_whitespace, and that could live
on as a single variable in cat-file.c.

I don't think it makes sense to move that part to ref-filter, since it's
not about formatting at all. It's about how cat-file parses its input,
which is going to be unlike other ref-filter users (which don't
generally parse input at all).

-Peff
