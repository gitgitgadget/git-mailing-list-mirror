Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613DC2BB55
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D236C20771
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDIOOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:14:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:38032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727184AbgDIOOx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 10:14:53 -0400
Received: (qmail 19189 invoked by uid 109); 9 Apr 2020 14:14:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 14:14:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18486 invoked by uid 111); 9 Apr 2020 14:25:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 10:25:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 10:14:52 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.txt: move closing "----" to cover entire listing
Message-ID: <20200409141452.GC3494212@coredump.intra.peff.net>
References: <20200409103541.23743-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409103541.23743-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 12:35:41PM +0200, Martin Ågren wrote:

> Commit 1925fe0c8a ("Documentation: wrap config listings in "----"",
> 2019-09-07) wrapped this fairly large block of example config directives
> in "----". The closing "----" ended up a few lines too early though.
> Make sure to include the trailing "IncludeIf.onbranch:..." example, too.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Not sure how I managed to botch this in 1925fe0c8a.

I managed to botch the review, as well. :)

This looks good to me. Some observations below.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2450589a0e..74009d5402 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -220,12 +220,12 @@ Example
>  ; affected by the condition
>  [includeIf "gitdir:/path/to/group/"]
>  	path = foo.inc
> -----
>  
> -	; include only if we are in a worktree where foo-branch is
> -	; currently checked out
> -	[includeIf "onbranch:foo-branch"]
> -		path = foo.inc
> +; include only if we are in a worktree where foo-branch is
> +; currently checked out
> +[includeIf "onbranch:foo-branch"]
> +	path = foo.inc
> +----

I had to stare at this for a moment before realizing that the "-----" is
not 5 dashes in context, but the removal of the old, misplaced 4-dash
line.

I checked it with doc-diff, but was surprised to find no change. That's
because the manpage shows it the same either way (the indented chunk is
just a different example, but two examples back to back render the same
as a single one). But you can see the difference in the HTML version,
where the final example isn't in the grey box.

That explains why I didn't see the issue when running doc-diff on the
original bug. I wonder if we could teach doc-diff to look at the HTML,
too. I'm not sure how, though. Certainly html2text or similar would get
us something diff-able, but without the visual elements (like the grey
box), I don't know that it's much more valuable than the manpages.

-Peff
