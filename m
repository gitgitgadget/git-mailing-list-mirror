Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0551F453
	for <e@80x24.org>; Sat, 29 Sep 2018 08:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeI2Osm (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:48:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:36210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727628AbeI2Osm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:48:42 -0400
Received: (qmail 11596 invoked by uid 109); 29 Sep 2018 08:21:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 08:21:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4778 invoked by uid 111); 29 Sep 2018 08:20:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 04:20:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 04:21:08 -0400
Date:   Sat, 29 Sep 2018 04:21:08 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
Message-ID: <20180929082108.GJ2174@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
 <20180926184914.GC30680@sigill.intra.peff.net>
 <3677a12b-5b9b-ad2a-1e3a-7de251baa40d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3677a12b-5b9b-ad2a-1e3a-7de251baa40d@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 10:18:05AM +0200, Rasmus Villemoes wrote:

> >     it, and then it is up to the alias to handle "-h" sensibly.
> 
> I'd be nervous about doing this, though, especially if we introduce this
> without a new opt-in config option (which seems to be the direction the
> discussion is taking). There are lots of commands that don't respond
> with a help message to -h, or that only recognize -h as the first word,
> or... There are really too many ways this could cause headaches.
> 
> But, now that I test it, it seems that we already let the alias handle
> -h (and any other following words, with --help as the first word
> special-cased). So what you're suggesting is (correct me if I'm wrong)
> to _also_ intercept -h as the first word, and then print the alias info,
> in addition to spawning the alias with the entire argv as usual. The
> alias info would probably need to go to stderr in this case.

Right, I'm proposing only to add the extra message and then continue as
usual.

It is a little funny, I guess, if you have a script which doesn't
respond to "-h", because you'd get our "foo is aliased to git-bar"
message to stderr, followed by who-knows-what. But as long as it's to
stderr (and not stdout), I think it's not likely to _break_ anything.

> >   - "git cp --help" opens the manpage for cherry-pick. We don't bother
> >     with the alias definition, as it's available through other means
> >     (and thus we skip the obliteration/timing thing totally).
> 
> It sounds like you suggest doing this unconditionally, and without any
> opt-in via config option or a short wait? That would certainly work for
> me. It is, in fact, how I expect 'git cp --help' to work, until I get
> reminded that it does not... Also, as Junio noted, is consistent with
> --help generally providing more information than -h - except that one
> loses the 'is an alias for' part for --help.

Yes, I'd suggest doing it always. No config, no wait.

-Peff
