Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0C91FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965152AbeAJHrE (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 02:47:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:39730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965147AbeAJHrD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 02:47:03 -0500
Received: (qmail 16469 invoked by uid 109); 10 Jan 2018 07:47:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 07:47:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13359 invoked by uid 111); 10 Jan 2018 07:47:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 02:47:36 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 02:47:01 -0500
Date:   Wed, 10 Jan 2018 02:47:01 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
Message-ID: <20180110074701.GB16315@sigill.intra.peff.net>
References: <20180108154822.54829-1-git@jeffhostetler.com>
 <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
 <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
 <20180109072044.GD32257@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 09, 2018 at 09:29:31AM -0500, Derrick Stolee wrote:

> > > But even still, finding small answers quickly and accurately and punting
> > > to "really far, I didn't bother to compute it" on the big ones would be
> > > an improvement over always punting.
> > Indeed. The longer I think about it, the more I like the "100+ commits
> > apart" idea.
> > 
> 
> Again, I strongly suggest we drop this approach because it will be more pain
> than it is worth.

To be clear, which approach are we talking about? I think there are
three options:

  1. The user tells us not to bother computing real ahead/behind values.
     We always say "same" or "not the same".

  2. The user tells us not to bother computing ahead/behind values
     with more effort than N. After traversing N commits without getting
     an answer, we say "same" or "not the same". But we may sometimes
     give a real answer if we found it within N.

  3. The user tells us not to spend more effort than N. After traversing
     N commits we try to make some partial statement based on
     generations (or commit timestamps as a proxy for them).

I agree that (3) is probably not going to be useful enough in the
general case to merit the implementation effort and confusion. But is
there anything wrong with (2)?

-Peff
