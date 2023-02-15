Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD6C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 23:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBOX0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOX0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 18:26:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C442E42BE9
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:26:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so4601479pjd.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OhKocSOVjtrJGdQntcyY+fYEBa/tXEl8kaqeTvWUwY=;
        b=DNfKIXrUHFP3u5/scfCgX4EA8shxAG+kr9r/fkvU1T2oH/4GL0AY3m60il927pkUcu
         tlXXbAGL6OGubjTZUqGahYq+elAdC0964XyYE/L0Y1vn6NGNx3jb8ogzNslgUrU+rlCr
         X9Ncpdo6qDXpZKXY1B7q+2B5/e5IQ+DD8zlkD3X1JjqbRmgsqnNp9MbIirQVH4Rkm4mz
         Wn2IMkDKP8pNiTZMHupDU4BCB7seBEb0jk1D+N+RtcT0vBuyRjtPzE0PAnkXVLI6lrJt
         GFcoNh6+OB3gyVfYGQUK/YHJhEgdF4n/t4PJuBiQPW5mSNYCHglaWji2thmbUbDfK/2J
         qkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OhKocSOVjtrJGdQntcyY+fYEBa/tXEl8kaqeTvWUwY=;
        b=pbzTB/HxqHBC7VXQ9nNLxyLS2N0aCXQKy7oYR0hfjyktCt6Hkg+n+96gY03unuH2Kq
         Wb4ubFoVr33jbJ9hSURkGtIOcK2MjGbVf7f6YQUes3eUrqOSa+V7e8lxLd1WEFgVfX3R
         NuBrrLEzxziPDpKLu0rBsR7BlxmWVIDz4IkAJDrfmm5S8ZQnrbmwITRz9b17VQzSQGdY
         n7uTuAE5jKObaxq7EIaUNtqhYi4nif6JOxsvTPjZyIkeCcId+I0ICSf0rD5sGbYbZSJT
         NAPzjiePPo++mYScY1TpHa/DzpJzLiX6iIEr/qQc58dpNyZXvrgOB75Kvli5UhYJfePy
         3UfA==
X-Gm-Message-State: AO0yUKUJs8xp5uM/0/y05wiSHIhhHsWxXxaCUp/zUtKsMQ9Ml3mgaWWm
        hWZSJBPChtdyz7IvM6ECD2o=
X-Google-Smtp-Source: AK7set/QDJv0kIzOiPvVMtvwHKXCSpwwnniSPwwvLV/wS3omdNFNZMqH6G81L0JVXaqgJHz/P9oSjQ==
X-Received: by 2002:a17:903:2309:b0:19a:8118:457b with SMTP id d9-20020a170903230900b0019a8118457bmr5006372plh.26.1676503564041;
        Wed, 15 Feb 2023 15:26:04 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b00192d9b86318sm10016448plk.137.2023.02.15.15.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:26:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v9 2/3] http: read HTTP WWW-Authenticate response headers
References: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
        <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
        <f3f28e508c1792cbc8f8d3bd56099c659743ed3e.1676496846.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 15:26:03 -0800
In-Reply-To: <f3f28e508c1792cbc8f8d3bd56099c659743ed3e.1676496846.git.gitgitgadget@gmail.com>
        (Matthew John Cheetham via GitGitGadget's message of "Wed, 15 Feb 2023
        21:34:05 +0000")
Message-ID: <xmqqy1oyv7ck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> According to RFC2616 Section 4.2 [1], header field names are not
> case-sensitive meaning when collecting multiple values for the same
> field name, we can just use the case of the first observed instance of
> each field name and no normalisation is required.

If the names are not case-sensitive, you can choose to first
downcase the names you see, and use that consistently, and the
result would still be valid.  IOW, "not case-sensitive" does not at
all mean you have to use the first observed instance without
normalization.  You are allowed to choose such an implementation,
but "not case-sensitive" is not a justification to choose such an
implementation among possible implementation that would be allowed
under the rule.

> The collection of all header values matching the WWW-Authenticate
> header is complicated by the fact that it is legal for header fields to
> be continued over multiple lines, but libcurl only gives us one line at
> a time.

Saying "one physical line" at a time may make it clear what you are
pointing out as a weak point in the interface libcURL gives us (I
think you are getting at "if they handled header folding for us and
fed us one logical line at a time, it would have been nicer").

> @@ -22,6 +22,7 @@ void credential_clear(struct credential *c)
>  	free(c->username);
>  	free(c->password);
>  	string_list_clear(&c->helpers, 0);
> +	strvec_clear(&c->wwwauth_headers);
>  
>  	credential_init(c);
>  }
> diff --git a/credential.h b/credential.h
> index f430e77fea4..6f2e5bc610b 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -2,6 +2,7 @@
>  #define CREDENTIAL_H
>  
>  #include "string-list.h"
> +#include "strvec.h"
>  
>  /**
>   * The credentials API provides an abstracted way of gathering username and
> @@ -115,6 +116,19 @@ struct credential {
>  	 */
>  	struct string_list helpers;
>  
> +	/**
> +	 * A `strvec` of WWW-Authenticate header values. Each string
> +	 * is the value of a WWW-Authenticate header in an HTTP response,
> +	 * in the order they were received in the response.
> +	 */
> +	struct strvec wwwauth_headers;
> +
> +	/**
> +	 * Internal use only. Used to keep track of split header fields

The technical term for what you call "split header" here seems to be
"line folding" (RFC 7230, which deprecates it).

> +	 * in order to fold multiple lines into one value.
> +	 */
> +	unsigned header_is_last_match:1;
> +
>  	unsigned approved:1,
>  		 configured:1,
>  		 quit:1,
> @@ -130,6 +144,7 @@ struct credential {
>  
>  #define CREDENTIAL_INIT { \
>  	.helpers = STRING_LIST_INIT_DUP, \
> +	.wwwauth_headers = STRVEC_INIT, \
>  }
>  
>  /* Initialize a credential structure, setting all fields to empty. */
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a76d0526f79..a59230564e8 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1266,6 +1266,29 @@ static inline int skip_iprefix(const char *str, const char *prefix,
>  	return 0;
>  }
>  
> +/*
> + * Like skip_prefix_mem, but compare case-insensitively. Note that the
> + * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
> + * characters or locale-specific conversions).
> + */
> +static inline int skip_iprefix_mem(const char *buf, size_t len,
> +				   const char *prefix,
> +				   const char **out, size_t *outlen)
> +{
> +	size_t prefix_len = strlen(prefix);
> +
> +	if (len < prefix_len)
> +		return 0;
> +
> +	if (!strncasecmp(buf, prefix, prefix_len)) {
> +		*out = buf + prefix_len;
> +		*outlen = len - prefix_len;
> +		return 1;
> +	}
> +
> +	return 0;
> +}

OK.

> diff --git a/http.c b/http.c
> index 8a5ba3f4776..7a56a3db5f7 100644
> --- a/http.c
> +++ b/http.c
> @@ -183,6 +183,124 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  	return nmemb;
>  }
>  
> +/*
> + * A folded header continuation line starts with at least one single whitespace
> + * character. It is not a continuation line if the line is *just* a newline.
> + * The RFC for HTTP states that CRLF is the header field line ending, but some
> + * servers may use LF only; we accept both.
> + */

Nice.

> +static inline int is_hdr_continuation(const char *ptr, const size_t size)
> +{
> +	/* totally empty line or normal header */
> +	if (!size || !isspace(*ptr))
> +		return 0;

obs-fold (RFC7230) begins the next line with SP or HTAB, but
isspace() allows not just SP and HT but also CR and LF.  So
this is a bit pessimistic but rejects what is not a folded
continuation line reliably.

> +	/* empty line with LF line ending */
> +	if (size == 1 && ptr[0] == '\n')
> +		return 0;

And this is a blank line after the headers, with LF (not conforming
but is OK).

> +	/* empty line with CRLF line ending */
> +	if (size == 2 && ptr[0] == '\r' && ptr[1] == '\n')
> +		return 0;

And this is another form of a blank line after the headers, with
CRLF.

> +	return 1;
> +}

After rejecting the above two "blank", it is a folded continuation
line.  OK.

I wonder if

	static inline int ... () {
	  	return (size && (*ptr == ' ' || *ptr == '\t'));
	}

sufficient and easier to grok, though.

> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
> +{
> +	size_t size = eltsize * nmemb;
> +	struct strvec *values = &http_auth.wwwauth_headers;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *val;
> +	size_t val_len;
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
> +	/* Start of a new WWW-Authenticate header */
> +	if (skip_iprefix_mem(ptr, size, "www-authenticate:", &val, &val_len)) {
> +		strbuf_add(&buf, val, val_len);
> +
> +		/*
> +		 * Strip the CRLF that should be present at the end of each
> +		 * field as well as any trailing or leading whitespace from the
> +		 * value.
> +		 */
> +		strbuf_trim(&buf);
> +
> +		strvec_push(values, buf.buf);
> +		http_auth.header_is_last_match = 1;
> +		goto exit;

OK.  We remember that we have seen the beginning of a header we are
interested in (so that we can append if it is a continuation we see
next).  Good.

> +	}
> +
> +	/*
> +	 * This line could be a continuation of the previously matched header
> +	 * field. If this is the case then we should append this value to the
> +	 * end of the previously consumed value.
> +	 */
> +	if (http_auth.header_is_last_match && is_hdr_continuation(ptr, size)) {
> +		/*
> +		 * Trim the CRLF and any leading or trailing from this line.
> +		 */
> +		strbuf_add(&buf, ptr, size);
> +		strbuf_trim(&buf);
> +
> +		/*
> +		 * At this point we should always have at least one existing
> +		 * value, even if it is empty. Do not bother appending the new
> +		 * value if this continuation header is itself empty.
> +		 */
> +		if (!values->nr) {
> +			BUG("should have at least one existing header value");

OK, we should set _is_last_match to true only after we recorded the
header that might see a continuation, so it would be a bug if we
didn't have anything there.  Good.

> +		} else if (buf.len) {
> +			char *prev = xstrdup(values->v[values->nr - 1]);
> +
> +			/* Join two non-empty values with a single space. */
> +			const char *const sp = *prev ? " " : "";
> +
> +			strvec_pop(values);
> +			strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
> +			free(prev);
> +		}
> +
> +		goto exit;

Good that we are prepared to see a logical line split over more than
two lines (i.e. by not toggling _is_last_match off prematurely here).

> +	}
> +
> +	/* This is the start of a new header we don't care about */
> +	http_auth.header_is_last_match = 0;

Or what we just saw and ignored could be a continuation line of a
header we ignored.  The comment is slightly misleading.

Other than that, looking good.

Thanks.
