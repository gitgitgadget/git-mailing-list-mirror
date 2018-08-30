Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852CD1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeH3LlY (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:41:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:33642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727098AbeH3LlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:41:24 -0400
Received: (qmail 12976 invoked by uid 109); 30 Aug 2018 07:40:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:40:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24488 invoked by uid 111); 30 Aug 2018 07:40:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:40:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:40:33 -0400
Date:   Thu, 30 Aug 2018 03:40:33 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 8/9] worktree: teach 'remove' to override lock when
 --force given twice
Message-ID: <20180830074033.GE11944@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-9-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212026.21989-9-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 05:20:25PM -0400, Eric Sunshine wrote:

> For consistency with "add -f -f" and "move -f -f" which override
> the lock on a worktree, allow "remove -f -f" to do so, as well, as a
> convenience.

This one makes more sense to me than the last, since "remove -f" already
does something useful.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 354a6c0eb5..a95fe67da6 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -875,13 +875,13 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  	int force = 0;
>  	struct option options[] = {
>  		OPT__FORCE(&force,
> -			 N_("force removing even if the worktree is dirty"),
> +			 N_("force removal even if worktree is dirty or locked"),

I wonder if somebody might assume from this that a single "-f" would
override a lock. Perhaps not the end of the world, and the manpage does
make it clear. And also I don't really know how to be more specific here
without an overly long line.

I'm guessing all those thoughts went through your head before ending up
here, too. :)

-Peff
