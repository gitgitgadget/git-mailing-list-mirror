Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87681F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 04:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfJOEUI (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 00:20:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:48214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725268AbfJOEUI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 00:20:08 -0400
Received: (qmail 12252 invoked by uid 109); 15 Oct 2019 04:20:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Oct 2019 04:20:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30526 invoked by uid 111); 15 Oct 2019 04:23:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Oct 2019 00:23:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Oct 2019 00:20:07 -0400
From:   Jeff King <peff@peff.net>
To:     Norman Rasmussen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Norman Rasmussen <norman@rasmussen.co.za>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] diff-highlight: fix a whitespace nit
Message-ID: <20191015042006.GC32308@sigill.intra.peff.net>
References: <pull.397.git.1571110286.gitgitgadget@gmail.com>
 <2823d4d360b2f53c1d63ba742808eaee80ede1e4.1571110286.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2823d4d360b2f53c1d63ba742808eaee80ede1e4.1571110286.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 03:31:26AM +0000, Norman Rasmussen via GitGitGadget wrote:

> From: Norman Rasmussen <norman@rasmussen.co.za>
> 
> This changes the indent from
>   "<tab><sp><sp><sp><sp><sp><sp><sp><sp>"
> to
>   "<tab><tab>"
> so that the statement lines up with the rest of the block.

Yep, that makes sense. Looks like I introduced the problem (most of my
perl used to be written in a style that forbids tabs, so it may have
snuck in that way, but the rest of the file definitely follows Git's
usual style of tabs).

> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> index 7440aa1c46..e2589922a6 100644
> --- a/contrib/diff-highlight/DiffHighlight.pm
> +++ b/contrib/diff-highlight/DiffHighlight.pm
> @@ -72,7 +72,7 @@ sub handle_line {
>  	      (?:$COLOR?\|$COLOR?[ ])* # zero or more trailing "|"
>  	                         [ ]*  # trailing whitespace for merges
>  	    /x) {
> -	        my $graph_prefix = $&;
> +		my $graph_prefix = $&;

There are a few lines just above that have 8+ spaces. Arguably those
could be tabs, too, depending on your view of tabs. We usually do "8
spaces is a tab" in the Git project, but the oft-repeated "tabs to
indent, spaces to align" mantra would apply here (and I suspect you're
using a different tabwidth since you noticed this one case). So I'd just
as soon leave them be, and take your patch as-is.

-Peff
