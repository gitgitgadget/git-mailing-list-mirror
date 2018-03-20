Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5101F404
	for <e@80x24.org>; Tue, 20 Mar 2018 06:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCTGJe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 02:09:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:35562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751334AbeCTGJd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 02:09:33 -0400
Received: (qmail 2362 invoked by uid 109); 20 Mar 2018 06:09:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 06:09:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29475 invoked by uid 111); 20 Mar 2018 06:10:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 02:10:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 02:09:31 -0400
Date:   Tue, 20 Mar 2018 02:09:31 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] log --graph corrupts patch
Message-ID: <20180320060931.GE15813@sigill.intra.peff.net>
References: <897b7471-037a-78d9-fc11-0624ef657b4d@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <897b7471-037a-78d9-fc11-0624ef657b4d@talktalk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 10:21:56AM +0000, Phillip Wood wrote:

> I've just been reviewing some patches with 'git log --graph --patch' and
> came across what looked like a bug:
> 
> | @@ -272,6 +272,9 @@ do
> |       --keep-empty)
> |               keep_empty=yes
> |               ;;
> |       --allow-empty-message)
> | +     --no-keep-empty)
> | +             keep_empty=
> | +             ;;
> |               allow_empty_message=--allow-empty-message
> |               ;;
> 
> However when I looked at the file it was fine, "--allow-empty-message)"
> was actually below the insertions. 'git log --patch' gives the correct
> patch:
> [...]
> git fetch https://github.com/phillipwood/git.git log-graph-breaks-patch

That's really strange. I can't seem to replicate it here, though; it
looks correct with our without --graph. Knowing how the graph code is
implemented, it seems like an unlikely bug for us to output lines out of
order (but of course anything's possible).

Are you using any exotic filters for your pager? If you use "git
--no-pager" does the problem persist?

-Peff
