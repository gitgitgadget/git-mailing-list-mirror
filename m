Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403591F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 20:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeKQGlf (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 01:41:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39910 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQGle (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 01:41:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so7230441pfc.6
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 12:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjLHrGJ7wFRMy1iKMTQQsyiLQhEBo0BIZUOsLDhNG8g=;
        b=GOQ1hK5De3Of6bw9CwjlaeC70/MwhFv1VQMWEn8U1gOvddeLINkE9GlbIBtsfW+dOF
         XIcmX8D0EAClk+Z551a3Td8l38P8Xy3Mp9bx5iyo8iWW6MtuHUX3Y7EKM+kD7OTC5gL0
         V3iTJhDibak1siZ5QHQ2Cit3Dc14DEf6WIT/LZ+Gxz9VsIC7ilqU+edwVBZp1BzJk2Dc
         Fo+KrZQ5t1JkjQdn2lKXjkKs+kV1OIfw9n7OsVo7KfChebOq+5ViUq6RLz+HNm5AoQIh
         VqDyL1nx9FpO37T8BisvBPm58zZ78Kc0z71Oh1OlC/UCjTEXD5bztdc7o+lSw4/FVAC3
         cCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WjLHrGJ7wFRMy1iKMTQQsyiLQhEBo0BIZUOsLDhNG8g=;
        b=Deys2RfPifNVVlLGrdTuGX8HQfZGQ0PXh4qwz7eDohrMhl+QJnu1FfI8GVOt3Setgp
         C2OnqJc6EzTwxxq+XjeWheQd82KxO+rwZr+TMa5mujWjMQi4Ku2fB3gEU3/XHIorvZIO
         20aHwPwKvbXPifGWZqJ9URkxWvJUbuo4Qbnv25VBOnu5PyutSN1Aa84A5BN/TRPzqcnJ
         o2qWUhpiRGsDb5T57d5ByixVYfVdP22DkBw0d2yv70Tan1p572IZY8emyXuE7dsClb+I
         iso3ruv0pncUkc1UEY9omWZ0pjgY8PjbruW9FgsnXjW4QTGiVoRtrGSCp9aKNFpL1WOv
         lBwA==
X-Gm-Message-State: AGRZ1gKqtUAGjZMlq0mTm0mKyNKvPopE9oi9Z4FvAnh5DBNC5pQPSn5I
        izZxh52Vf/v+q2EI6sV0g7b2cvye7kzVjg==
X-Google-Smtp-Source: AJdET5f/redxHPl+AtcxvHoZdpNJhg5Xksc+GRO9CfS6VQn58w4HCrUiYC6h6AdqYdsl29gsrAfBEg==
X-Received: by 2002:a62:2ad6:: with SMTP id q205-v6mr12507922pfq.152.1542400060715;
        Fri, 16 Nov 2018 12:27:40 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id n13-v6sm44712872pfk.19.2018.11.16.12.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 12:27:39 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:27:34 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] remote-curl: refactor smart-http discovery
Message-ID: <20181116202734.GC9703@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <20181116084725.GA31603@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116084725.GA31603@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.16 03:47, Jeff King wrote:
> After making initial contact with an http server, we have to decide if
> the server supports smart-http, and if so, which version. Our rules are
> a bit inconsistent:
> 
>   1. For v0, we require that the content-type indicates a smart-http
>      response. We also require the response to look vaguely like a
>      pkt-line starting with "#". If one of those does not match, we fall
>      back to dumb-http.
> 
>      But according to our http protocol spec[1]:
> 
>        Dumb servers MUST NOT return a return type starting with
>        `application/x-git-`.
> 
>      If we see the expected content-type, we should consider it
>      smart-http. At that point we can parse the pkt-line for real, and
>      complain if it is not syntactically valid.
> 
>   2. For v2, we do not actually check the content-type. Our v2 protocol
>      spec says[2]:
> 
>        When using the http:// or https:// transport a client makes a
>        "smart" info/refs request as described in `http-protocol.txt`[...]
> 
>      and the http spec is clear that for a smart-http[3]:
> 
>        The Content-Type MUST be `application/x-$servicename-advertisement`.
> 
>      So it is required according to the spec.
> 
> These inconsistencies were easy to miss because of the way the original
> code was written as an inline conditional. Let's pull it out into its
> own function for readability, and improve a few things:
> 
>  - we now predicate the smart/dumb decision entirely on the presence of
>    the correct content-type
> 
>  - we do a real pkt-line parse before deciding how to proceed (and die
>    if it isn't valid)
> 
>  - use skip_prefix() for comparing service strings, instead of
>    constructing expected output in a strbuf; this avoids dealing with
>    memory cleanup
> 
> Note that this _is_ tightening what the client will allow. It's all
> according to the spec, but it's possible that other implementations
> might violate these. However, violating these particular rules seems
> like an odd choice for a server to make.
> 
> [1] Documentation/technical/http-protocol.txt, l. 166-167
> [2] Documentation/technical/protocol-v2.txt, l. 63-64
> [3] Documentation/technical/http-protocol.txt, l. 247
> 
> Helped-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote-curl.c | 93 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 34 deletions(-)
> 
> diff --git a/remote-curl.c b/remote-curl.c
> index 762a55a75f..dd9bc41aa1 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -330,9 +330,65 @@ static int get_protocol_http_header(enum protocol_version version,
>  	return 0;
>  }
>  
> +static void check_smart_http(struct discovery *d, const char *service,
> +			     struct strbuf *type)
> +{
> +	char *src_buf;
> +	size_t src_len;
> +	char *line;
> +	const char *p;
> +
> +	/*
> +	 * If we don't see x-$service-advertisement, then it's not smart-http.
> +	 * But once we do, we commit to it and assume any other protocol
> +	 * violations are hard errors.
> +	 */
> +	if (!skip_prefix(type->buf, "application/x-", &p) ||
> +	    !skip_prefix(p, service, &p) ||
> +	    strcmp(p, "-advertisement"))
> +		return;
> +
> +	/*
> +	 * "Peek" at the first packet by using a separate buf/len pair; some
> +	 * cases below require us leaving the originals intact.
> +	 */
> +	src_buf = d->buf;
> +	src_len = d->len;
> +	line = packet_read_line_buf(&src_buf, &src_len, NULL);
> +	if (!line)
> +		die("invalid server response; expected service, got flush packet");
> +
> +	if (skip_prefix(line, "# service=", &p) && !strcmp(p, service)) {
> +		/*
> +		 * The header can include additional metadata lines, up
> +		 * until a packet flush marker.  Ignore these now, but
> +		 * in the future we might start to scan them.
> +		 */
> +		while (packet_read_line_buf(&src_buf, &src_len, NULL))
> +			;
> +
> +		/*
> +		 * v0 smart http; callers expect us to soak up the
> +		 * service and header packets
> +		 */
> +		d->buf = src_buf;
> +		d->len = src_len;
> +		d->proto_git = 1;
> +
> +	} else if (starts_with(line, "version 2")) {
> +		/*
> +		 * v2 smart http; do not consume version packet, which will
> +		 * be handled elsewhere.
> +		 */
> +		d->proto_git = 1;
> +
> +	} else {
> +		die("invalid server response; got '%s'", line);
> +	}
> +}
> +
>  static struct discovery *discover_refs(const char *service, int for_push)
>  {
> -	struct strbuf exp = STRBUF_INIT;
>  	struct strbuf type = STRBUF_INIT;
>  	struct strbuf charset = STRBUF_INIT;
>  	struct strbuf buffer = STRBUF_INIT;
> @@ -405,38 +461,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	last->buf_alloc = strbuf_detach(&buffer, &last->len);
>  	last->buf = last->buf_alloc;
>  
> -	strbuf_addf(&exp, "application/x-%s-advertisement", service);
> -	if (maybe_smart &&
> -	    (5 <= last->len && last->buf[4] == '#') &&
> -	    !strbuf_cmp(&exp, &type)) {
> -		char *line;
> -
> -		/*
> -		 * smart HTTP response; validate that the service
> -		 * pkt-line matches our request.
> -		 */
> -		line = packet_read_line_buf(&last->buf, &last->len, NULL);
> -		if (!line)
> -			die("invalid server response; expected service, got flush packet");
> -
> -		strbuf_reset(&exp);
> -		strbuf_addf(&exp, "# service=%s", service);
> -		if (strcmp(line, exp.buf))
> -			die("invalid server response; got '%s'", line);
> -		strbuf_release(&exp);
> -
> -		/* The header can include additional metadata lines, up
> -		 * until a packet flush marker.  Ignore these now, but
> -		 * in the future we might start to scan them.
> -		 */
> -		while (packet_read_line_buf(&last->buf, &last->len, NULL))
> -			;
> -
> -		last->proto_git = 1;
> -	} else if (maybe_smart &&
> -		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
> -		last->proto_git = 1;
> -	}
> +	if (maybe_smart)
> +		check_smart_http(last, service, &type);
>  
>  	if (last->proto_git)
>  		last->refs = parse_git_refs(last, for_push);
> @@ -444,7 +470,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  		last->refs = parse_info_refs(last);
>  
>  	strbuf_release(&refs_url);
> -	strbuf_release(&exp);
>  	strbuf_release(&type);
>  	strbuf_release(&charset);
>  	strbuf_release(&effective_url);
> -- 
> 2.19.1.1636.gc7a073d580
> 

Looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
