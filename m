Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB2FC433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8A3613DB
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhEOJjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 05:39:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:55456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhEOJjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 05:39:02 -0400
Received: (qmail 23420 invoked by uid 109); 15 May 2021 09:37:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 May 2021 09:37:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8336 invoked by uid 111); 15 May 2021 09:37:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 May 2021 05:37:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 May 2021 05:37:48 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 02/11] doc: doc-diff: allow more than one flag
Message-ID: <YJ+WbMx+HTjbV2ZP@coredump.intra.peff.net>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-3-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210514121435.504423-3-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 14, 2021 at 07:14:26AM -0500, Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/doc-diff | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> index 1694300e50..ecd88b0524 100755
> --- a/Documentation/doc-diff
> +++ b/Documentation/doc-diff
> @@ -146,7 +146,7 @@ render_tree () {
>  	# through.
>  	oid=$1 &&
>  	dname=$2 &&
> -	makemanflags=$3 &&
> +	makemanflags="$3" &&

This line does nothing; the shell won't split whitespace here either
way.

> @@ -181,6 +181,6 @@ render_tree () {
>  	fi
>  }
>  
> -render_tree $from_oid $from_dir $from_makemanflags &&
> -render_tree $to_oid $to_dir $to_makemanflags &&
> +render_tree $from_oid $from_dir "$from_makemanflags" &&
> +render_tree $to_oid $to_dir "$to_makemanflags" &&

This part is necessary (and sufficient).

It would be nice to mention in the commit message why the use of
$makemanflags in render_tree must remain unquoted (as I did in mine when
I made the same change).

-Peff
