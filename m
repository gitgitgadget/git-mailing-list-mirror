Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA2420986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbcJGQGQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:06:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:54007 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751959AbcJGQGP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:06:15 -0400
Received: (qmail 2721 invoked by uid 109); 7 Oct 2016 16:06:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 16:06:14 +0000
Received: (qmail 7129 invoked by uid 111); 7 Oct 2016 16:06:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 12:06:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2016 12:06:11 -0400
Date:   Fri, 7 Oct 2016 12:06:11 -0400
From:   Jeff King <peff@peff.net>
To:     Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
Cc:     git@vger.kernel.org
Subject: Re: Systems with old regex system headers/libraries don't pick up
 git's compat/regex header file
Message-ID: <20161007160611.wu2ehzqg6cxhkwgr@sigill.intra.peff.net>
References: <9f43a2f1-5d7e-3a2e-5a83-40e92ab0d7b5@connectinternetsolutions.com>
 <20161006191127.2vjtmxl7ygjeqcbk@sigill.intra.peff.net>
 <4ac0ce84-ca6c-3650-ef5e-e13c54c60504@connectinternetsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ac0ce84-ca6c-3650-ef5e-e13c54c60504@connectinternetsolutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 04:45:08PM +0100, Richard Lloyd wrote:

> On 06/10/16 20:11, Jeff King wrote:
> > Junio mentioned the NO_REGEX knob in the Makefile. If that works for
> > you, the next step is probably to add a line to the HP-UX section of
> > config.mak.uname, so that it just works out of the box.
> 
> This doesn't work because the check in git-compat-util.h only looks
> for REG_STARTEND being defined (if it isn't, it #error's out).
> 
> That define is not mentioned anywhere else other than in the
> compat/regex tree, which is why I used -Icompat/regex to pick up
> <regex.h> from there - this was the "easiest" solution for me on
> HP-UX 11.

I'm confused. Setting NO_REGEX in the Makefile will add -Icompat/regex
to your compiler invocation. So git-compat-util.h should pick up our
compat regex routines, which _do_ have REG_STARTEND.

How are you building? Doing:

  make NO_REGEX=1

is supposed to work, and if it doesn't, there's a bug.

-Peff
