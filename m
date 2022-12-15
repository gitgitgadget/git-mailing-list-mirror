Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189DAC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLOJbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLOJau (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:30:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2B26D9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:30:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id kw15so50820544ejc.10
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qihA/O0pYPy3b8RLyyIGrP4mZdfl/kVL3fjqQUvsSKg=;
        b=T2kTaRiQwXUabLdKnxWPQD0b9PlaAWH0hLlFw1TyeM9XcuPparhdZA1ZNMl6OA7Hat
         uS/2Ao38wzhWywSwVSBfsBQmdOCjsornch7Rx/9M2ucHlhn2O4MyHCEezWc5YKepyEVL
         4GE8XtRjGQQHDOG+ekjFpQsWo9+I9a8xSzYxMVDog0Jqo/8+zUCLM6++qjidaAerA63D
         n3KM3TcDhhVJO5coB6ddDwnS8v/d80wEpIUhe+VteVa5sJdJYz7H+LC4ARD/67+YCC+E
         K4Xr8BVl7qGn1aR6Bua9Y9Ulg/VqeTQqMOwoF7EeOeW0A2+jDtS0BLGU83gSWzb7sdYs
         VSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qihA/O0pYPy3b8RLyyIGrP4mZdfl/kVL3fjqQUvsSKg=;
        b=FQfEDFl/r79h5QceU3srNetePi22SXzsKzgktkwTfZpjIuDl6z3kZBrbtJsK68Tva4
         w+iftPIWWsWYZPoTK1MivDuHxvk1Fj1J5nfFxPsSMio5p8fuPWAGh1dk5rh9+tT/s0Ic
         pdEj9A2WZZiwa1sJt3NaYENNBOBixlyqqcjrkeC6Iucq5kXCLRZDLR6VKx4uVL9usXEX
         YD+86TKEUgWd1dSqWBdD8ooqLDLTffMnujU+3z+MIWOv1NIVvCRuiCO/qL2eGxrPRnzJ
         ElMLzUCLqpxDnymjhHR08b+8T5NFiI4g4PHLZv7cjoglZiGwIz8qXCDWYzpcaG0/9k/h
         bPvQ==
X-Gm-Message-State: ANoB5pmHbnAr3lV70+dQ6wDE8U2S/c7G+oVzRzFKhD857XYh8PM8A9xM
        T4DF8iXrvSEjZr6F2BUjXkm9fgAYMYlg0g==
X-Google-Smtp-Source: AA0mqf7N/m/Ux344IUcOKO15osAnWHhS1QQln/Wz0ZqDJi3wNRFaJPrdeKmH5oiujD6jn1tryJKBcw==
X-Received: by 2002:a17:907:90d4:b0:7c0:db61:dbd5 with SMTP id gk20-20020a17090790d400b007c0db61dbd5mr20589610ejb.62.1671096643579;
        Thu, 15 Dec 2022 01:30:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id bq19-20020a170906d0d300b007bf5250b515sm6899699ejb.29.2022.12.15.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:30:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5kZe-006AFI-1c;
        Thu, 15 Dec 2022 10:30:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v4 1/8] http: read HTTP WWW-Authenticate response headers
Date:   Thu, 15 Dec 2022 10:27:48 +0100
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <b5b56ccd9419353a4bf5bc9d751a711af07d2197.1670880984.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <b5b56ccd9419353a4bf5bc9d751a711af07d2197.1670880984.git.gitgitgadget@gmail.com>
Message-ID: <221215.861qp13tfh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
> [...]
>  /* Initialize a credential structure, setting all fields to empty. */
> diff --git a/http.c b/http.c
> index 8a5ba3f4776..c4e9cd73e14 100644
> --- a/http.c
> +++ b/http.c
> @@ -183,6 +183,82 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  	return nmemb;
>  }
>  
> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
> +{
> +	size_t size = eltsize * nmemb;

Just out of general paranoia: use st_mult() here, not "*" (checks for
overflows)?

> +	struct strvec *values = &http_auth.wwwauth_headers;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *val;
> +	const char *z = NULL;

Why NULL-init the "z" here, but not the "val"? Both look like they
should be un-init'd. We also tend to call a throw-away char pointer "p",
not "z", but anyway (more below).... 

> +
> +	/*
> +	 * Header lines may not come NULL-terminated from libcurl so we must
> +	 * limit all scans to the maximum length of the header line, or leverage
> +	 * strbufs for all operations.
> +	 *
> +	 * In addition, it is possible that header values can be split over
> +	 * multiple lines as per RFC 2616 (even though this has since been
> +	 * deprecated in RFC 7230). A continuation header field value is
> +	 * identified as starting with a space or horizontal tab.
> +	 *
> +	 * The formal definition of a header field as given in RFC 2616 is:
> +	 *
> +	 *   message-header = field-name ":" [ field-value ]
> +	 *   field-name     = token
> +	 *   field-value    = *( field-content | LWS )
> +	 *   field-content  = <the OCTETs making up the field-value
> +	 *                    and consisting of either *TEXT or combinations
> +	 *                    of token, separators, and quoted-string>
> +	 */
> +
> +	strbuf_add(&buf, ptr, size);
> +
> +	/* Strip the CRLF that should be present at the end of each field */
> +	strbuf_trim_trailing_newline(&buf);
> +
> +	/* Start of a new WWW-Authenticate header */
> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
> +		while (isspace(*val))
> +			val++;

As we already have a "struct strbuf" here, maybe we can instead
consistently use the strbuf functions, e.g. strbuf_ltrim() in this case.

I haven't reviewed this in detail, maybe it's not easy or worth it
here...

> +
> +		strvec_push(values, val);
> +		http_auth.header_is_last_match = 1;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * This line could be a continuation of the previously matched header
> +	 * field. If this is the case then we should append this value to the
> +	 * end of the previously consumed value.
> +	 */
> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
> +		const char **v = values->v + values->nr - 1;

It makes no difference to the compiler, but perhaps using []-indexing
here is more idiomatic, for getting the nth member of this strvec?

> +		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
> +
> +		free((void*)*v);

Is this reaching into the strvec & manually memory-managing it
unavoidable, or can we use strvec_pop() etc?

> +		*v = append;
> +
> +		goto exit;
> +	}
> +
> +	/* This is the start of a new header we don't care about */
> +	http_auth.header_is_last_match = 0;
> +
> +	/*
> +	 * If this is a HTTP status line and not a header field, this signals
> +	 * a different HTTP response. libcurl writes all the output of all
> +	 * response headers of all responses, including redirects.
> +	 * We only care about the last HTTP request response's headers so clear
> +	 * the existing array.
> +	 */
> +	if (skip_iprefix(buf.buf, "http/", &z))

...Don't you want to just skip this "z" variable altogether and use
istarts_with() instead? All you seem to care about is whether it starts
with it, not what the offset is.

