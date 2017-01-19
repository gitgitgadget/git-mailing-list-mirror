Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED14420A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdASVu7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:50:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41826 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752176AbdASVu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:50:58 -0500
Received: (qmail 16704 invoked by uid 109); 19 Jan 2017 21:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 21:50:19 +0000
Received: (qmail 9718 invoked by uid 111); 19 Jan 2017 21:51:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 16:51:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 16:50:17 -0500
Date:   Thu, 19 Jan 2017 16:50:17 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH v2 2/2] Be more careful when determining whether a remote
 was configured
Message-ID: <20170119215016.j675tzhmhcku2y43@sigill.intra.peff.net>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
 <cover.1484860744.git.johannes.schindelin@gmx.de>
 <1605031b76025f4bd0e485705c34a25557bb75a1.1484860744.git.johannes.schindelin@gmx.de>
 <20170119213100.g72ml7r2khu7bvey@sigill.intra.peff.net>
 <xmqqy3y6yb9i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3y6yb9i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 01:45:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm trying to figure out why "fetch --multiple" wouldn't just take a url
> > in the first place. I guess it is because multiple fetch is useless
> > without refspecs (since otherwise you're just writing to FETCH_HEAD,
> > which gets immediately overwritten).
> 
> This is probably a tangent, if FETCH_HEAD is overwritten, wouldn't
> that be a bug in the implementation of --multiple?  I somehow
> thought we had an option to tell second and subsequent "fetch" to
> append to FETCH_HEAD instead of overwriting it.

Maybe. I was just speculating on the reason.

I just disabled that check and tried it with two local repos:

  git init
  git fetch --multiple /path/to/one /path/to/two
  cat .git/FETCH_HEAD

and indeed it does seem to append.

The logic comes from 9c4a036b3 (Teach the --all option to 'git fetch',
2009-11-09), but it does not seem to give any reasoning. Nor could I
find anything on the mailing list. <shrug>

-Peff
