Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176C5201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbdBURrq (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 12:47:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:59349 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754251AbdBURrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 12:47:41 -0500
Received: (qmail 20480 invoked by uid 109); 21 Feb 2017 17:47:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 17:47:40 +0000
Received: (qmail 13944 invoked by uid 111); 21 Feb 2017 17:47:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 12:47:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 12:47:38 -0500
Date:   Tue, 21 Feb 2017 12:47:38 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC] Subtle differences in passing configs to git clone
Message-ID: <20170221174737.qpg6dawdvhntuikm@sigill.intra.peff.net>
References: <EC270E42-9431-446C-96F9-E1A0C3E45333@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EC270E42-9431-446C-96F9-E1A0C3E45333@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 12:36:25PM +0100, Lars Schneider wrote:

> I stumbled across the following today:
> 
> (1) git -c foo.bar="foobar" clone <URL>
> 
> --> uses the config temporarily
> 
> 
> (2) git clone -c foo.bar="foobar" <URL>
> 
> --> uses the config and writes it to .git/config
> 
> This was introduced in 84054f7 ("clone: accept config options on the 
> command line") and it makes total sense.

Yep, they were designed to match.

> However, I think this subtitle difference can easily confuse users.
> 
> I think we should tell the users that we've written to .git/config.
> Maybe something like this:
> 
> git clone -c foo.bar="foobar" <URL>
> Cloning into 'test'...
> Writing foo.bar="foobar" to local config...
> remote: Counting objects: 2152, done.
> remote: Compressing objects: 100% (33/33), done.
> remote: Total 2152 (delta 19), reused 0 (delta 0), pack-reused 2119
> Receiving objects: 100% (2152/2152), 328.66 KiB | 217.00 KiB/s, done.
> Resolving deltas: 100% (1289/1289), done.
> 
> What do you think?

<shrug> I don't find it confusing, but I can see how one might. Since
"clone" is already pretty chatty, I don't mind adding the extra message.

-Peff
