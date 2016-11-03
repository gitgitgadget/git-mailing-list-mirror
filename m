Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5562021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbcKCPe6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:34:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:38045 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756858AbcKCPe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:34:57 -0400
Received: (qmail 28685 invoked by uid 109); 3 Nov 2016 15:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 15:34:55 +0000
Received: (qmail 13334 invoked by uid 111); 3 Nov 2016 15:35:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 11:35:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 11:34:54 -0400
Date:   Thu, 3 Nov 2016 11:34:53 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Help with vger's rules, was Re: [ANNOUNCE] Git for Windows 2.10.2
Message-ID: <20161103153453.4aipi5lxkmkt3kco@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1611022158140.3108@virtualbox>
 <alpine.DEB.2.20.1611031554100.3108@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611031554100.3108@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 04:15:05PM +0100, Johannes Schindelin wrote:

> When it finally sent out the mail, and I thought everything was alright,
> thinking that I could turn out for the night with a well-deserved drink, I
> got this from vger.kernel.org:
> 
> -- snip --
> SMTP error from remote server for TEXT command, host: vger.kernel.org (209.132.180.67) reason: 550 5.7.1 Content-Policy reject msg: Wrong MIME labeling on 8-bit character texts.
> -- snap --
> 
> Is there *anybody* who could give me a clue what this means?

That's a new one for me. One guess, though...

> For the record, I tried to use `git send-email` to send out the
> announcement for the very first time, and the headers of the mbox file I
> fed to that command read thusly:
> 
> -- snip --
> From 2.10.2.windows.1 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 02 Nov 2016 21:43:54 +0100
> To: git-for-windows@googlegroups.com, git@vger.kernel.org
> Subject: [ANNOUNCE] Git for Windows 2.10.2
> Content-Type: text/plain; charset=UTF-8
> Fcc: Sent
> -- snap --

This is missing a Content-Transfer-Encoding. I think the default is the
traditional 7-bit ascii encoding, but your body has characters with the
high-bit set (your UTF-8 bullet).

Try adding:

  Content-Transfer-Encoding: 8bit

I haven't seen this before, but I do recall that vger's MTA is very
picky about this and wants to rewrite transfer-encodings, so it seems
plausible.

-Peff
