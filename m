Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A32120248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbfB1VEr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:04:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:33406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726414AbfB1VEr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:04:47 -0500
Received: (qmail 30825 invoked by uid 109); 28 Feb 2019 21:04:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:04:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23653 invoked by uid 111); 28 Feb 2019 21:05:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:05:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:04:45 -0500
Date:   Thu, 28 Feb 2019 16:04:45 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 01/20] cat-file: reuse struct ref_format
Message-ID: <20190228210444.GA12723@sigill.intra.peff.net>
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
 <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:

> Start using ref_format struct instead of simple char*.
> Need that for further reusing of formatting logic from ref-filter.

Makes sense.

>  struct batch_options {
> +	struct ref_format format;
>  	int enabled;
>  	int follow_symlinks;
>  	int print_contents;
> @@ -24,7 +26,6 @@ struct batch_options {
>  	int all_objects;
>  	int unordered;
>  	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> -	const char *format;
>  };

Not a huge deal, but unless there's a compelling reason to move the
field around in the struct, the diff is easier to read if the deleted
and added lines stay in the same place.

> @@ -491,9 +492,6 @@ static int batch_objects(struct batch_options *opt)
>  	int save_warning;
>  	int retval = 0;
>  
> -	if (!opt->format)
> -		opt->format = "%(objectname) %(objecttype) %(objectsize)";
> -

This assignment moves down to cmd_cat_file(). I don't see any reason
that shouldn't work, but it makes reviewing easier if there aren't
unexpected changes (so if it doesn't need moved in the grand scheme of
things, leave it as it was; if it does, it should either come in its own
patch, or get a note in the commit message as to why it needed to move).

-Peff
