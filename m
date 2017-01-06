Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730611FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 23:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965788AbdAFXUq (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 18:20:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:36241 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964827AbdAFXUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 18:20:45 -0500
Received: (qmail 23093 invoked by uid 109); 6 Jan 2017 23:20:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 23:20:44 +0000
Received: (qmail 21122 invoked by uid 111); 6 Jan 2017 23:21:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 18:21:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 18:20:43 -0500
Date:   Fri, 6 Jan 2017 18:20:43 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Trygve Aaberge <trygveaa@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Regression: Ctrl-c from the pager in an alias exits it
Message-ID: <20170106232042.ptn6grtll5wpxhc4@sigill.intra.peff.net>
References: <20170105142529.GA15009@aaberge.net>
 <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
 <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
 <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
 <20170106073224.5hsrib77tx5tgx7d@sigill.intra.peff.net>
 <3d433abf-71a2-4702-f62b-e254520dc32c@kdbg.org>
 <20170106194115.k5u5esv7t63mryvk@sigill.intra.peff.net>
 <2ed6f78b-7704-c724-c99b-e310c383c4e8@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ed6f78b-7704-c724-c99b-e310c383c4e8@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 11:42:25PM +0100, Johannes Sixt wrote:

> > So I dunno. Maybe this waiting should be restricted only to certain
> > cases like executing git sub-commands.
> 
> If given it some thought.
> 
> In general, I think it is wrong to wait for child processes when a signal
> was received. After all, it is the purpose of a (deadly) signal to have the
> process go away. There may be programs that know it better, like less, but
> git should not attempt to know better in general.
> 
> We do apply some special behavior for certain cases like we do for the
> pager. And now the case with aliases is another special situation. The
> parent git process only delegates to the child, and as such it is reasonable
> that it binds its life time to the first child, which executes the expanded
> alias.

Yeah, I think I agree. That binding is something you want in many cases,
but not necessarily all. The original purpose of clean_on_exit was to
create a binding like that, but of course it can be (and with the
smudge-filter stuff, arguably has been) used for other cases, too.

I'll work up a patch that makes it a separate option, which should be
pretty easy.

-Peff
