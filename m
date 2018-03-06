Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0431F576
	for <e@80x24.org>; Tue,  6 Mar 2018 06:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbeCFGxz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 01:53:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750783AbeCFGxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 01:53:54 -0500
Received: (qmail 15509 invoked by uid 109); 6 Mar 2018 06:53:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Mar 2018 06:53:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1396 invoked by uid 111); 6 Mar 2018 06:54:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Mar 2018 01:54:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2018 07:53:50 +0100
Date:   Tue, 6 Mar 2018 07:53:50 +0100
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 3/4] config.c: introduce 'git_config_color' to parse ANSI
 colors
Message-ID: <20180306065349.GD3522@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180306021729.45813-4-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306021729.45813-4-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 06:17:28PM -0800, Taylor Blau wrote:

> In preparation for adding `--color` to the `git-config(1)` builtin,
> let's introduce a color parsing utility, `git_config_color` in a similar
> fashion to `git_config_<type>`.

Sounds good...

> @@ -1000,6 +1001,15 @@ int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *
>  	return 0;
>  }
>  
> +int git_config_color(char **dest, const char *var, const char *value)
> +{
> +	if (!value)
> +		return config_error_nonbool(var);
> +	if (color_parse(value, *dest) < 0)
> +		return -1;
> +	return 0;
> +}

Why do we take a pointer-to-pointer here? We don't allocate like
git_config_string() does, but instead fill in the existing buffer.

-Peff
