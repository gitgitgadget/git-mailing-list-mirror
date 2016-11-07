Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324FA2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 21:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbcKGVP0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 16:15:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:39907 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752070AbcKGVPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 16:15:25 -0500
Received: (qmail 10719 invoked by uid 109); 7 Nov 2016 21:15:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 21:15:25 +0000
Received: (qmail 16088 invoked by uid 111); 7 Nov 2016 21:15:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 16:15:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 16:15:22 -0500
Date:   Mon, 7 Nov 2016 16:15:22 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree
 .gitattributes
Message-ID: <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
 <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 04:10:10PM -0500, Jeff King wrote:

> And I'll admit my main motivation is not that index/filesystem parity,
> but rather just that:
> 
>   git clone git://host.com/malicious-repo.git
>   git log
> 
> might create and read symlinks to arbitrary files on the cloner's box.
> I'm not sure to what degree to be worried about that. It's not like you
> can't make other arbitrary symlinks which are likely to be read if the
> user actually starts looking at checked-out files. It's just that we
> usually try to make a clone+log of a malicious repository safe.

Another approach is to have a config option to disallow symlinks to
destinations outside of the repository tree (I'm not sure if it should
be on or off by default, though).

Again, I don't know that there is a specific security issue, but it
makes things easier for services which might clone untrusted
repositories (e.g., things like CI). They'd obviously have to be careful
with the contents of the repositories anyway, but it's one less thing to
have to worry about.

-Peff
