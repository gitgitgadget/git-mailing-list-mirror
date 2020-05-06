Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DBBC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D182145D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgEFQ0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:26:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:39070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729477AbgEFQ0t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:26:49 -0400
Received: (qmail 22904 invoked by uid 109); 6 May 2020 16:26:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 May 2020 16:26:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8768 invoked by uid 111); 6 May 2020 16:26:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 May 2020 12:26:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 May 2020 12:26:48 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 4/4] credential: document protocol updates
Message-ID: <20200506162648.GA1275237@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
 <20200505013908.4596-5-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505013908.4596-5-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 06:39:08PM -0700, Carlo Marcelo Arenas Belón wrote:

> Document protocol changes after CVE-2020-11008, while at it do some
> minor improvements for clarity and consitency.

s/consitency/consistency/s

I think the overall direction is good. A few small comments below.

>  `host`::
>  
> -	The remote hostname for a network credential.
> +	The remote hostname for a network credential.  This includes
> +	the port number if one was specified.

It might be worth giving an example of the syntax, like:

  the port number if one was specified (e.g., "example.com:8088").

> @@ -146,8 +147,11 @@ Git understands the following attributes:
>  	value is parsed as a URL and treated as if its constituent parts
>  	were read (e.g., `url=https://example.com` would behave as if
>  	`protocol=https` and `host=example.com` had been provided). This
> -	can help callers avoid parsing URLs themselves.  Note that any
> -	components which are missing from the URL (e.g., there is no
> -	username in the example above) will be set to empty; if you want
> -	to provide a URL and override some attributes, provide the URL
> -	attribute first, followed by any overrides.
> +	can help callers avoid parsing URLs themselves.
> +
> +	Note that specifying a protocol is mandatory and if the URL
> +	type doesn't require a hostname (like for cert://) then an
> +	empty ("")  hostname will be generated.

So we are losing the bit about overriding. I think that is OK, as we'd
like to avoid suggesting that is a good idea, and we may even remove the
feature in the future.

The word "generated" confused me a bit. Maybe something like:

  ...and if the URL doesn't specify a hostname (e.g.,
  "cert:///path/to/file"), the credential will contain a hostname
  attribute whose value is an empty string.

> +	Components which are missing from the URL (e.g., there is no
> +	username in the example above) will be left unset.

Makes sense.

-Peff
