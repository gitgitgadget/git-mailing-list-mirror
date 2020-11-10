Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D25C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C9F206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgKJUKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:10:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:53322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731287AbgKJUKm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 15:10:42 -0500
Received: (qmail 9077 invoked by uid 109); 10 Nov 2020 20:10:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 20:10:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4704 invoked by uid 111); 10 Nov 2020 20:10:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 15:10:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 15:10:40 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 13/21] trailer: add option to make canonicalization
 optional
Message-ID: <20201110201040.GF1987088@coredump.intra.peff.net>
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201025212652.3003036-14-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025212652.3003036-14-anders@0x63.nu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:26:44PM +0100, Anders Waldenborg wrote:

> Adds a new `--(no-)canonicalize` option to interpret-trailers. By
> default it is on unless `--parse` option is given.
> 
> When option is on trailer tokens and separators get canonicalized to
> the form they have in config (if there is any config for that
> trailer). This is same behavior as before this patch, which allows
> this behavior to be disabled with `--no-canonicalize`. `--parse` now
> also implies `--no-canonicalize`, if previous behavior with
> canonicalization also in parse mode is wanted it needs to be combined
> with `--parse --canonicalize`

I'm not sure if this should be tied to --parse or not. The idea of
--parse is that you'd normalize syntactic issues to make it easy to
parse the result. But wouldn't normalizing names around spelling or
capitalization be what you'd usually want there?

So it sounds like you'd want it to _always_ be on, but leave
"--no-canonicalize" as an escape hatch for somebody who's researching
spelling variants.

Or maybe I'm misunderstanding what it does, since...

> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -129,13 +129,16 @@ OPTIONS
>  
>  --parse::
>  	A convenience alias for `--only-trailers --only-input
> -	--unfold`.
> +	--unfold --no-canonicalize`.
>  
>  --no-divider::
>  	Do not treat `---` as the end of the commit message. Use this
>  	when you know your input contains just the commit message itself
>  	(and not an email or the output of `git format-patch`).
>  
> +--no-canonicalize::
> +	Disable canonicalization of input trailers.

I think this needs to define "canonicalization" here.

-Peff
