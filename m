Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4550E1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 14:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeHIQzV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 12:55:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:48416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730634AbeHIQzV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 12:55:21 -0400
Received: (qmail 21377 invoked by uid 109); 9 Aug 2018 14:30:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 14:30:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9559 invoked by uid 111); 9 Aug 2018 14:30:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 10:30:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 10:30:10 -0400
Date:   Thu, 9 Aug 2018 10:30:10 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180809143010.GD1439@sigill.intra.peff.net>
References: <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
 <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
 <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
 <20180808230456.GA21882@sigill.intra.peff.net>
 <20180808231226.GA34639@genre.crustytoothpaste.net>
 <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
 <20180809014302.GB34639@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180809014302.GB34639@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 01:43:02AM +0000, brian m. carlson wrote:

> On Wed, Aug 08, 2018 at 05:59:43PM -0700, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > 
> > >> FWIW, I'm on board with returning non-zero in any case where gpg would.
> > >
> > > I think that's probably the best solution overall.
> > 
> > FWIW, I am not married to the current behaviour.  I would not be
> > surprised if it mostly came by accident and not designed.
> 
> Since apparently I was the author of the commit that changed the
> behavior originally, let me simply say that I was not aware that gpg
> signalled the correctness of a signature by its exit status when I wrote
> that patch.  If I had known that, I would have deferred to gpg in my
> change.  My goal was consistency between verify-tag and verify-commit,
> and in retrospect I probably made the wrong decision.

OK, so it seems like we're all in agreement now.

What next?

There was a patch at the start of this thread, but it specifically
checks for "sigc->result == U".  That's probably OK, since I think it
restores the behavior in earlier versions of Git. But I wonder if we
should simply be storing the fact that gpg exited non-zero and relaying
that. That would fix this problem and truly make the rule "if gpg
reported an error, we propagate that".

-Peff
