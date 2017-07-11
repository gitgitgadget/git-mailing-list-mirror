Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541252035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbdGKTTQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:19:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:37426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933570AbdGKTTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:19:16 -0400
Received: (qmail 28878 invoked by uid 109); 11 Jul 2017 19:19:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 19:19:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19499 invoked by uid 111); 11 Jul 2017 19:19:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 15:19:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 15:19:13 -0400
Date:   Tue, 11 Jul 2017 15:19:13 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git config --help not functional on bad config
Message-ID: <20170711191913.jjvw6kqtywyeyf7a@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1707111541150.18163@ds9.cixit.se>
 <20170711175342.mllx7efdsqlzv5lo@sigill.intra.peff.net>
 <CAGZ79kbQsRQaHjRccs-0jkYkfhBwU-gX-M3A9sP4hqTtqqpFYw@mail.gmail.com>
 <20170711190846.jr53xhwa42uz4ky2@sigill.intra.peff.net>
 <CAGZ79kbL=Ry_6L9iJw1GQA39gdPsS=twoJFpKPc3ZP+M2saoWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbL=Ry_6L9iJw1GQA39gdPsS=twoJFpKPc3ZP+M2saoWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 12:13:59PM -0700, Stefan Beller wrote:

> > There are other die calls hidden deeper. For instance:
> >
> >   $ git -c core.ignorecase=foo help config
> >   fatal: bad numeric config value 'foo' for 'core.ignorecase': invalid unit
> >
> > Those ones are hard to fix without changing the call signature of
> > git_config_bool().
> 
> Good point. While looking at it, parse_help_format can also die,
> so building a safe git help config is hard:
> 
>     git config --global help.format foo
>     # everything is broken, how do I fix it?
>     git help config # breaks, too, for the same reason as you outlined :/

Yeah, I think that should be switched to return an error, and probably
all errors from git_help_config() should issue a warning and still
return 0.

-Peff
