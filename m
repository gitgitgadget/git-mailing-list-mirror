Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D16920323
	for <e@80x24.org>; Mon, 20 Mar 2017 03:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbdCTDfj (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 23:35:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:47306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbdCTDfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 23:35:38 -0400
Received: (qmail 22169 invoked by uid 109); 20 Mar 2017 03:35:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 03:35:35 +0000
Received: (qmail 29048 invoked by uid 111); 20 Mar 2017 03:35:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Mar 2017 23:35:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Mar 2017 23:35:31 -0400
Date:   Sun, 19 Mar 2017 23:35:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] receive-pack: simplify run_update_post_hook()
Message-ID: <20170320033530.sl4rbd2lq3qo2kgl@sigill.intra.peff.net>
References: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
 <20170317222320.nsg3yk3nopjadr5t@sigill.intra.peff.net>
 <xmqqshma4ihk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshma4ihk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 10:12:07AM -0700, Junio C Hamano wrote:

> >> -	argv_array_push(&proc.args, hook);
> >>  	for (cmd = commands; cmd; cmd = cmd->next) {
> >>  		if (cmd->error_string || cmd->did_not_exist)
> >>  			continue;
> >> +		if (!proc.args.argc)
> >> +			argv_array_push(&proc.args, hook);
> >>  		argv_array_push(&proc.args, cmd->ref_name);
> >>  	}
> >> +	if (!proc.args.argc)
> >> +		return;
> >
> > It looks at first like the result leaks, because you have to realize
> > that the push will modify proc.args.argc. 
> 
> Hmph, I needed to read the original twice to imagine how a paranoid
> person can fear leaks.  The return condition says "if args array is
> empty, just return" and the thing being empty is an enough indication
> to think nothing is leaking, at least for me.

Yeah, I think I just read it funny the first time. I'm OK with it as-is.

-Peff
