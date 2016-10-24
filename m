Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B7B20193
	for <e@80x24.org>; Mon, 24 Oct 2016 12:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936636AbcJXMy4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 08:54:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33401 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934873AbcJXMyz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 08:54:55 -0400
Received: (qmail 4252 invoked by uid 109); 24 Oct 2016 12:54:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Oct 2016 12:54:54 +0000
Received: (qmail 23852 invoked by uid 111); 24 Oct 2016 12:55:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Oct 2016 08:55:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2016 08:54:52 -0400
Date:   Mon, 24 Oct 2016 08:54:52 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron and Ashley Watson <watsona4@gmail.com>
Cc:     git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] Allow stashes to be referenced by index only
Message-ID: <20161024125452.o3xvl3q2lmmwr5qu@sigill.intra.peff.net>
References: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
 <20161023090207.sg52l4mijqtfvip6@sigill.intra.peff.net>
 <CAB0+k9JrX7Ax26HfTEgoSyj02szFyHLayqTyW6KPuxVvXBOEOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB0+k9JrX7Ax26HfTEgoSyj02szFyHLayqTyW6KPuxVvXBOEOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 01:41:25PM -0400, Aaron and Ashley Watson wrote:

> > But what's going on here? Why did we bother running rev-parse earlier if
> > we don't actually use the value of REV?
> >
> > You mentioned tweaking it to fix a broken test, and indeed, just using
> > $REV here breaks a few tests in t3903.
> >
> > Offhand, I do not see anything wrong with pulling the non-option values
> > out in the loop. But in that case I think the assignment of REV can just
> > go away completely.
> >
> 
> The only reason for REV to remain is to preserve the error message seen with
> the previous behavior. Perhaps it would be better to instead move the
> assignment
> of REV to the only place it is still used: the error message when multiple
> arguments were detected.

Ah, thanks, I missed that use. We suppress stderr, so we're literally
just getting the set of revs there. But that should match what we have
in ARGV anyway (after all, $ARGV is where we decided we had too many
revs, and what we'll feed to rev-parse to get the sha1).

So I wonder if:

  Too many revisions specified: $ARGV

would be more appropriate (at which point you can probably just continue
to call it $REV).

> I'm not sure of the next steps in the process of submitting a patch.
> Should I submit a new patch by replying to this email, or is using git
> send-email to create a new mail thread better?

Generally re-rolls of a patch are done as replies to the original. Gmail
is bad about corrupting whitespace, though, so you can't just reply and
paste the patch in there. You can use ask git-send-email to continue the
thread, though:

  mid=1473378397-22453-1-git-send-email-watsona4@gmail.com
  git send-email --in-reply-to=$mid ...other options...

You might also want to cc the people involved in the earlier discussion.
The public-inbox archive gives a customized full send-email command for
each message to make it easy.

  http://public-inbox.org/git/1473378397-22453-1-git-send-email-watsona4@gmail.com/

-Peff
