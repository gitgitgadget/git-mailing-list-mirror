Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639CC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKJCwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiKJCwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:52:06 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4CA20F78
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:52:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p141so332228iod.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJHGDsl4qNg/9WHG4YgyedhJOEwStrsvV3W5+3lrM+o=;
        b=sHmaP+oP1/tnHM1LukUqiZ3VRW0FIDMaERCdFc+H5kmLI0yPXCN6Hp4ZOooPLJWoNe
         DPOmzakC5FlWLhKKG6+hrO3bX2qDdUjbUwacRj7btrTU/TBI44SUiRr7hmUZLEz3apqf
         xjINDVL/nRdAzuJPmw9ag41WJNpQKxQzgfnwMjdAmyCDcfBtv/kvNTaavdejiE1gu4TE
         805j/alihyVGcm4eeFn3clnDBDzgLbtomR/ZISr3d+AydcZbGHoaCj5WsFYIIOKVOOAB
         TKISrOJyGLXf9xOoIpmyvn8BPZMUymtLR+hjJAqH6P100cCgI6T1w5zPGsFEdF6iXSEz
         4xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJHGDsl4qNg/9WHG4YgyedhJOEwStrsvV3W5+3lrM+o=;
        b=zAoUGVWzC7BvRYryWpm9VkDgG0O/o27nZxzWSsEXgyZU404rAf5Pxuu3BbW5I2kk5D
         f29lKvpk8FX5/5E5mm4qUhaNga+klTp7hzdVfNdgpZM6INByNGPYADZiewv/WNrN3jb8
         OUNR5uRUK+FOZZW05VhuPdA51ByT5P1Tme6y9+dT23Fn7iEe56b9mxC5obzuq52QlKM+
         4+Hj4Wme0y5dl912CJnMDD2BEvF1S5MmsgnEbCD8uelHto8NEiFvDM4Wwe5jBWsXNq9i
         yVp5pb/4vjEK/OSWtWuNMXRAsardUiZzL6R3Zh5RM6LXZEuz9zxE1JQAQ31orz/cZ3M5
         2EUg==
X-Gm-Message-State: ACrzQf2hfNFuguVeQ2VSZmKvjNAuAhDU/Zi7LDM7C7lJVtofzqSkeqkC
        przqvDKA4BSxO1vjHHnp20sgV8zGgXJZig==
X-Google-Smtp-Source: AMsMyM6AbVXbjb8lO9cKqZ/t7A5+2Y3IxXeiEc/Wkgn6kcZFn/BP6Crz9WuhJjcuEjIx9veF5jgxwQ==
X-Received: by 2002:a02:c942:0:b0:375:b479:dd5c with SMTP id u2-20020a02c942000000b00375b479dd5cmr12592199jao.41.1668048725342;
        Wed, 09 Nov 2022 18:52:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r5-20020a0566022b8500b006d8b7bcaa6esm6074213iov.4.2022.11.09.18.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:52:04 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:52:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
Message-ID: <Y2xnUyEoCFmbPtUI@nand.local>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 12:52:31AM +0000, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
>
> With GIT_TRACE_CURL=1 or GIT_CURL_VERBOSE=1, sensitive headers like
> "Authorization" and "Cookie" get redacted. However, since [1], curl's
> h2h3 module also prints headers in its "info", which don't get redacted.
> For example,
>
>   echo 'github.com	TRUE	/	FALSE	1698960413304	o	foo=bar' >cookiefile &&
>   GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 git \
>     -c 'http.cookiefile=cookiefile' \
>     -c 'http.version=' \
>     ls-remote https://github.com/git/git refs/heads/main 2>output &&
>   grep 'cookie' output
>
> produces output like:
>
>   23:04:16.920495 http.c:678              == Info: h2h3 [cookie: o=foo=bar]
>   23:04:16.920562 http.c:637              => Send header: cookie: o=<redacted>

Oops. Thanks for sharing this patch, I agree that the general approach
makes sense.

>     I initially sent this to the security list, but the general impression
>     is that this isn't sensitive enough for an embargoed fix, so this is
>     better discussed in the open instead.

Indeed, this only really matters if the would-be victim is convinced to
somehow share the contents of their GIT_CURL_VEROBSE or GIT_TRACE_CURL
output. So I don't think there are any security implications here,
though I appreciate your caution in double checking with the
git-security list first.

>      * How could we set up end-to-end tests to ensure that we're testing
>        this against affected versions of curl? To avoid regressions, I'd
>        also prefer to test against future versions of curl too.

Does that necessarily matter? We want to make sure that we don't see
sensitive headers from the h2h3 module with any version of cURL, no?
>
> +/* Redact headers in info */
> +static void redact_sensitive_info_header(struct strbuf *header)
> +{
> +	const char *sensitive_header;
> +
> +	if (trace_curl_redact &&
> +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> +		struct strbuf inner = STRBUF_INIT;
> +
> +		/* Drop the trailing "]" */
> +		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);

Makes sense. If the incoming header contains the "h2h3 [...]" marker,
and we are redacting sensitive headers, and there are header to redact,
redact them.

> +		if (!redact_sensitive_header(&inner)) {
> +			strbuf_setlen(header, strlen("h2h3 ["));
> +			strbuf_addbuf(header, &inner);

This leaks inner.buf, no?

> +			strbuf_addch(header, ']');
> +		}
>  	}
>  }

The rest looks good.

Thanks,
Taylor
