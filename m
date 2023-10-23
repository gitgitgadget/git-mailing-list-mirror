Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB532110F
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQyz0yWP"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B5B4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:05:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f61a639b9so51202787b3.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698084357; x=1698689157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jzaBHGFqJmTdp8jD7OsZGeeBodYUWKuK6wm0Zfbafxs=;
        b=XQyz0yWPpAE3CM/HbZUF/u7A3egZ4ZSmA6StcXWKpsOH46riZjeGXuxd1CIuqF+qvi
         G6/WbEjh55eHHeBr5eMGf+k095k+WMy0qRTYKRIULehAkzXU8NxBZRtNYmhes5wrFH65
         ldOmVyQdUIe179AmASLvRiYY8VizlIVBcHDwoXXz3hmkhS6y+K3rbbpdJZQc48NVCkfu
         OmznqQrOliWMEIYvmUYmtsbTmMN/p/YINGFwBfeGas0jeZ3gUQ6G4cvJqrZaQkl44tZl
         DF2Z0gEYqs96qdSSLFbInZ9viwaODK12Mp88RxBvgZ2qAoG5WwOhaVuIo/kGELQSkH+Z
         Kx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084357; x=1698689157;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzaBHGFqJmTdp8jD7OsZGeeBodYUWKuK6wm0Zfbafxs=;
        b=Z+3p8kQT8H+gBjIpdiKBQKs5fzkS2eDmtyukEOgA+5w21iZt0sTewoNkoojyAZAgXo
         sctGJD4aAtESxXYhF8x7MSxzIwJUGwwYfwwoIeU5Ld/XcynXqSylQbqI8TVX3OpnBpFS
         hr8tcXpBavZC2z+17waSSn2Ba+yDnnkc4uUoi735oK+m7yJh/ZsgYd9lUxdr0gFq9MYY
         d/dbXGt+zjJxcY6bimeYoUzfiGkp2EPuzUAXXGdVYo6MT0YkChIGibgYy7gqnUWsEyvF
         p9sdyGrXN7rDNyihpYuTelCNSAomTUUQR0zTaFmJHZuWvq5MbC005GPjh6d9lkDcQgm0
         mg9g==
X-Gm-Message-State: AOJu0YxGNKqALuBxFkwUK20eP5HplbCIonkU9HPcJMxpNB2L09jygRfS
	qA/UgNuoBVsRTOYWxSP01X3I8NKLJz1hEcJPuQ0Y
X-Google-Smtp-Source: AGHT+IGty9F5BF5q5Gfi5IL468R/hjYzaoIiWryq6sDmJdjWw0PKEvhDVThOCbB8Ao6Uc8dvjDNWry0TNHdpqZoUC5Zx
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:29f6:5cb7:f652:5c5e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:6c11:0:b0:5a7:ba3f:3407 with
 SMTP id h17-20020a816c11000000b005a7ba3f3407mr196999ywc.9.1698084357562; Mon,
 23 Oct 2023 11:05:57 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:05:55 -0700
In-Reply-To: <8a1463c223497fca2fd3f11a54db5d7e52d1d08a.1695330852.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180555.986240-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/5] config: split do_event() into start and flush operations
From: Jonathan Tan <jonathantanmy@google.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	glencbz@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:
> +static void start_event(struct config_source *cs, enum config_event_t type,
> +		       struct parse_event_data *data)
> +{
> +	data->previous_type = type;
> +	data->previous_offset = get_corrected_offset(cs, type);
> +}

It's a pity that get_corrected_offset() has to be called twice (once
here and once below) but I think that's the best we can do given how the
code is laid out (and I can't think of a better code layout either).

> +static int flush_event(struct config_source *cs, enum config_event_t type,
> +		       struct parse_event_data *data)

One thing confusing here is that the "type" is not what's being flushed,
but used to change details about how we flush. Technically all we need
is is_whitespace_type and is_eof_type, but that's clumsier to code. I
think the best we can do is add some documentation to this function,
maybe 'Flush the event started by a prior start_event(), if one exists.
The type of the event being flushed is not "type" but the type that was
passed to the prior start_event(); "type" here may merely change how the
flush is performed' or something like that.

> +{
> +	if (!data->opts || !data->opts->event_fn)
> +		return 0;
> +
> +	if (type == CONFIG_EVENT_WHITESPACE &&
> +	    data->previous_type == type)
> +		return 0;
>  
>  	if (data->previous_type != CONFIG_EVENT_EOF &&
>  	    data->opts->event_fn(data->previous_type, data->previous_offset,
> -				 offset, cs, data->opts->event_fn_data) < 0)
> +				 get_corrected_offset(cs, type), cs,
> +				 data->opts->event_fn_data) < 0)
>  		return -1;

Another confusing point here is how EOF is used both to mean
"start_event() was never called" and a true EOF. I think for now it's
best to just document this where we define CONFIG_EVENT_EOF.
