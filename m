Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E83FCDB465
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 00:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjJLAEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 20:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJLAEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 20:04:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C442990
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 17:04:17 -0700 (PDT)
Received: (qmail 20833 invoked by uid 109); 12 Oct 2023 00:04:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Oct 2023 00:04:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11720 invoked by uid 111); 12 Oct 2023 00:04:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 20:04:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 20:04:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
Message-ID: <20231012000416.GA520855@coredump.intra.peff.net>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa5sokdd3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 03:23:20PM -0700, Junio C Hamano wrote:

> Christoph Anton Mitterer <calestyo@scientia.org> writes:
> 
> > But I still don't get from that why X would be needed?
> >
> > My less manpage documents it as:
> >> -X or --no‐init
> >>     Disables sending the termcap initialization and deinitialization
> >>     strings to the terminal.  This is sometimes desirable if the
> >>     deinitialization string does something unnecessary, like clearing
> >>     the screen.
> >
> > Is it to avoid clearing the screen?
> 
> I think that was the reason we added it back in 2005.  In any case,
> asking "why" is not a useful use of anybody's time, because it is
> very unlikely to change in the official version we ship, and because
> it is so easy for any individual who does not like it to drop by
> exporting the $LESS environment variable.

I agree it is probably not worth changing now, but I think the history
here is a little interesting.

Yes, I think "X" was added because less would clear the screen after
exiting, and with "F" this meant you'd see nothing. Here's a thread from
the same time period discussing it:

  https://lore.kernel.org/git/cc723f590610210623sbee2075i5f2fd441cceb84ae@mail.gmail.com/

But I also think this was a pretty well-known annoyance with "less" back
then.

However, I can't seem to reproduce it now! Digging into the history and
the changelog, this note is in "changes between less versions 487 and
530":

  Don't output terminal init sequence if using -F and file fits on one
  screen.

So it seems like the problem has been fixed inside less for recent
versions. And in theory we _could_ drop "-X" if it is causing problems.
That version of less is ~5 years old. It does seem a little premature to
assume everybody has it. And as you say, if there are people who really
care about their LESS options, it is easy for them to override it.

-Peff
