Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9108207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbcI2TTC (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:19:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:50117 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbcI2TTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:19:00 -0400
Received: (qmail 14721 invoked by uid 109); 29 Sep 2016 19:19:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 19:19:00 +0000
Received: (qmail 4162 invoked by uid 111); 29 Sep 2016 19:19:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 15:19:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 15:18:57 -0400
Date:   Thu, 29 Sep 2016 15:18:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
Message-ID: <20160929191857.lxcgzf2cg5zfjkrq@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-3-gitster@pobox.com>
 <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
 <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
 <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
 <xmqqa8eqfsap.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8eqfsap.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 11:57:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> "either" meaning "we do not need to add --local and we do not need
> >> GIT_CONFIG_NOSYSTEM"?
> >
> > Yes. I didn't test it with your core.abbrev patch 4/4, but I _didn't_
> > have to touch their expected output after pointing them at a non-empty
> > etc-gitconfig file in the trash directory. Which implies to me they
> > don't care either way (which makes sense; they are asking for a specific
> > key which is supposed to be found in one of the other files).
> 
> There is a bit of problem here, though.
> 
>  * If we make t1300 point at its own system-wide config, it will be
>    in control of its contents, so "find this key" will find only it
>    wants to find (or we found a regression).
> 
>  * But then if it ever does something that depends on the default
>    value of core.abbrev (or whatever we'd tweak in response to the
>    next suggestion by Linus ;-), we cannot really allow it to do
>    so.  We'd want t/gitconfig-for-test to be the single place that
>    we can tweak these things, but we'll have to know t1300 uses its
>    own and need to make the same change there, too.

Right, but I think that's fine. Tests that care deeply about the
contents of etc-gitconfig are unlikely to care about core.abbrev. And in
the off chance that they do, then the worst case is...they get updated
to handle core.abbrev (either passing a command line option, or just
putting core.abbrev in their test file).

I just don't see it being a problem. Adding core.abbrev for the whole
test suite is just about not having a big flag day where we change all
the tests. Changing one or two tests (and again, I'd be surprised if we
even have to do that) doesn't seem like a big deal.

-Peff
