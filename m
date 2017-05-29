Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1003A1FD09
	for <e@80x24.org>; Mon, 29 May 2017 04:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbdE2EUO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 00:20:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbdE2EUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 00:20:14 -0400
Received: (qmail 27574 invoked by uid 109); 29 May 2017 04:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 04:20:14 +0000
Received: (qmail 12995 invoked by uid 111); 29 May 2017 04:20:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 00:20:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 May 2017 00:20:06 -0400
Date:   Mon, 29 May 2017 00:20:06 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: filter-branch does not require re-export of vars
Message-ID: <20170529042005.xgjx2kuuelak62sl@sigill.intra.peff.net>
References: <20170526173654.4238-1-asheiduk@gmail.com>
 <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net>
 <CAJZjrdVjeeHUN_biza-MA9iqP5Y5CO3DkLaGG-Bq1w5oo5tW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdVjeeHUN_biza-MA9iqP5Y5CO3DkLaGG-Bq1w5oo5tW_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 09:35:30PM -0400, Samuel Lijin wrote:

> > However, I think POSIX mandates the behavior you'd expect. And the only
> > shell I know that misbehaves in this way is Solaris /bin/sh, which we
> > have already declared too broken to support.
> 
> Off-topic, but where is this explicitly documented?

I couldn't find a place that mentioned it explicitly, but POSIX defines
the concept as "the export attribute" of the variables. Which implies to
me that the bit is tied to the variable itself, not its value.

It also says that the flag is cleared when a variable is unset, so:

  foo=one
  export foo
  sh -c 'echo $foo should be one'
  unset foo
  foo=two
  sh -c 'echo $foo is not exported'

That could potentially affect somebody writing a filter-branch snippet,
but presumably if they are using "unset" they know what they're doing.

-Peff
