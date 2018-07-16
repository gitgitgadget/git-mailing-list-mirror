Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0651F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPS7O (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:59:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:48130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729245AbeGPS7O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:59:14 -0400
Received: (qmail 8497 invoked by uid 109); 16 Jul 2018 18:30:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 18:30:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13732 invoked by uid 111); 16 Jul 2018 18:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 14:30:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 14:30:34 -0400
Date:   Mon, 16 Jul 2018 14:30:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] fsck: downgrade gitmodulesParse default to "info"
Message-ID: <20180716183033.GA22298@sigill.intra.peff.net>
References: <20180713193759.GB10354@sigill.intra.peff.net>
 <20180713193958.GB12162@sigill.intra.peff.net>
 <xmqqwotvt5uz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwotvt5uz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 11:04:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >    site's support). And the broken .gitmodules may be too
> >    far back in history for rewriting to be feasible (again,
> >    this is an issue for cgit).
> 
> "again" but this is the first mention that hints cgit has some
> problem (but not exactly what problem).  Is that the "cgit has a
> file called .gitmodules that predates the submodule support on our
> side?" thing?

I think you missed it. In the paragraph above the one you
quoted, I said:

   The cgit repository, for example, has a file named
   .gitmodules from a pre-submodule attempt at sharing code,
   but does not actually have any gitlinks.

> > So we're being unnecessarily restrictive without actually
> > improving the security in a meaningful way. It would be more
> > convenient to downgrade this check to "info", which means
> > we'd still comment on it, but not reject a push. Site admins
> > can already do this via config, but we should ship sensible
> > defaults.
> > ...
> > Considering both sets of arguments, it makes sense to loosen
> > this check for now.
> >
> > Note that we have to tweak the test in t7415 since fsck will
> > no longer consider this a fatal error. But we still check
> > that it reports the warning, and that we don't get the
> > spurious error from the config code.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Thanks.

So I'm curious if you found the argument in my commit
message compelling. :)

My recollection from the earlier discussion was that you
were more in favor of keeping things tight. E.g.,:

  https://public-inbox.org/git/xmqqh8lgrz5c.fsf@gitster-ct.c.googlers.com/

but reading it again:

 - there we were talking about non-blob objects as
   .gitmodules

 - I think your main concern was that there be a way for the
   user to loosen/tighten, which there is.

-Peff
