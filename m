Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9C51F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeHVSs1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:48:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:51652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728207AbeHVSs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:48:27 -0400
Received: (qmail 18641 invoked by uid 109); 22 Aug 2018 15:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 15:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 423 invoked by uid 111); 22 Aug 2018 15:23:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 11:23:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 11:23:06 -0400
Date:   Wed, 22 Aug 2018 11:23:06 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822152306.GC32630@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 08:42:20AM -0400, Paul Smith wrote:

> On Tue, 2018-08-21 at 23:03 -0400, Jeff King wrote:
> >  static inline int hashcmp(const unsigned char *sha1, const unsigned
> > char *sha2)
> >  {
> > +       assert(the_hash_algo->rawsz == 20);
> >         return memcmp(sha1, sha2, the_hash_algo->rawsz);
> >  }
> 
> I'm not familiar with Git code, but for most environments assert() is a
> macro which is compiled out when built for "release mode" (whatever
> that might mean).  If that's the case for Git too, then relying on
> assert() to provide a side-effect (even an optimizer hint side-effect)
> won't work and this will actually get slower when built for "release
> mode".
> 
> Just a thought...

We don't have such a "release mode" in Git, though of course people may
pass -DNDEBUG to the compiler if they want.

However, to me how we spell the assert is mostly orthogonal to the
discussion. We can do "if (...) BUG(...)" to get a guaranteed-present
conditional. The bigger questions are:

  - are we OK with such an assertion; and

  - does the assertion still give us the desired behavior when we add in
    a branch for rawsz==32?

And I think the answers for those are both "probably not".

-Peff
