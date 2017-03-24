Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74331FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 19:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755962AbdCXTyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 15:54:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:51335 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbdCXTyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 15:54:01 -0400
Received: (qmail 28980 invoked by uid 109); 24 Mar 2017 19:54:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 19:54:00 +0000
Received: (qmail 16919 invoked by uid 111); 24 Mar 2017 19:54:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 15:54:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 15:53:58 -0400
Date:   Fri, 24 Mar 2017 15:53:58 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 11/14] completion: let 'for-each-ref' sort remote
 branches for 'checkout' DWIMery
Message-ID: <20170324195357.cv3pjt3stjg6cqjm@sigill.intra.peff.net>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
 <20170323152924.23944-12-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170323152924.23944-12-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 04:29:21PM +0100, SZEDER Gábor wrote:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 394dcece6..d26312899 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -423,8 +423,9 @@ __git_refs ()
>  			# Try to find a remote branch that matches the completion word
>  			# but only output if the branch name is unique
>  			__git for-each-ref --format="%(refname:strip=3)" \
> +				--sort="refname:strip=3" \
>  				"refs/remotes/*/$match*" "refs/remotes/*/$match*/**" | \
> -			sort | uniq -u
> +			uniq -u

I wonder if it would be worth adding a "--unique" option to
for-each-ref. I guess the definition of "unique" may change though (here
you'd want to do it on the sort key, but other cases may want unique
branch names sorted by time, which is less trivial).

-Peff
