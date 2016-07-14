Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AA8203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 21:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbcGNVfj (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 17:35:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:45014 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbcGNVfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 17:35:38 -0400
Received: (qmail 17151 invoked by uid 102); 14 Jul 2016 21:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 17:35:38 -0400
Received: (qmail 9808 invoked by uid 107); 14 Jul 2016 21:35:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 17:35:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 17:35:35 -0400
Date:	Thu, 14 Jul 2016 17:35:35 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	gitster@pobox.com, git@vger.kernel.org, dwwang@google.com,
	jrnieder@gmail.com, e@80x24.org, dennis@kaarsemaker.net
Subject: Re: [PATCHv6 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160714213534.GB20645@sigill.intra.peff.net>
References: <20160714212454.16643-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160714212454.16643-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 02:24:54PM -0700, Stefan Beller wrote:

> # interdiff to v5:
> [...giant deletion...]

Much nicer. :)

> +static struct string_list *read_push_options(void)
> +{
> +	struct string_list *ret = xmalloc(sizeof(*ret));

This struck me as a little non-idiomatic for our code base. The usual
technique is to take a pointer to a stack-allocated struct, and write
into that.

I guess that here:

> @@ -1774,6 +1806,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		const char *unpack_status = NULL;
>  		struct string_list *push_options = NULL;
>  
> +		if (use_push_options)
> +			push_options = read_push_options();
> +

You will want to later check whether push_options is NULL. But you can
also just check push_options.nr.

-Peff
