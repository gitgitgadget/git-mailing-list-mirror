Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CCC433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B6E20735
	for <git@archiver.kernel.org>; Sat, 23 May 2020 16:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgEWQ3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 12:29:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbgEWQ3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 12:29:16 -0400
Received: (qmail 27754 invoked by uid 109); 23 May 2020 16:29:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 May 2020 16:29:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14038 invoked by uid 111); 23 May 2020 16:29:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 May 2020 12:29:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 May 2020 12:29:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
Message-ID: <20200523162914.GA2178752@coredump.intra.peff.net>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 23, 2020 at 09:07:50AM +0200, René Scharfe wrote:

> > which are both correct. I wonder if there's a more elegant way to do it,
> > though (probably not, as there's definitely some heuristic parsing going
> > on to determine which checkout mode we're in; the new switch/restore
> > alternatives don't suffer as much from this).
> 
> Perhaps:
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e9d111bb83..24336e1017 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1689,7 +1689,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  		 * Try to give more helpful suggestion.
>  		 * new_branch && argc > 1 will be caught later.
>  		 */
> -		if (opts->new_branch && argc == 1)
> +		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
>  			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
>  				argv[0], opts->new_branch);
> 

Oh, indeed, that's way better. Want to wrap it up as a patch?

-Peff
