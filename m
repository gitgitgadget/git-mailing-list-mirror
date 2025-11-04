Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1BA34D3AE
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294072; cv=none; b=JVrMni9DvvxjLKhsFYeIM/S1Y3CDjsnKrT/hhlqHtl8KZ2zxBg0QODyDZc4GY82Ev+CIBOxiIiBPx+Zun5UucK4HRLqHPdrzTv0C3V3DztoHcyKxLuxEgc1Ja+hgltjxzgYNj5AdVmYWNmCr6OHzKag+Inm+8GaqNvJ3RYlfVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294072; c=relaxed/simple;
	bh=2ETGYMhv3cljX6XDCnt/IEzwaCNhbCmjmizA4JQyCx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIWXDK5esFZOOQzdGGfZBCdxIMkUp7LW8cP/PGhM/wXnbVcnkXNEUONvEpULEMLzSBgRqlyDt8+lC+HTzciRaOgOobp4qxpOOiaBx+GvWCUuyt4YjPA1KQ7Akp5HwB11LPGKjyRBwywuncPNznjTuHhw5RiLmmT3mJ6MIx1SnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L9DUGmmX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L9DUGmmX"
Received: (qmail 431290 invoked by uid 109); 4 Nov 2025 22:07:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2ETGYMhv3cljX6XDCnt/IEzwaCNhbCmjmizA4JQyCx8=; b=L9DUGmmXOQpdrgFwJCr7NLo48YlAIOA/p4m3CpLkvKuT5x1Enzo0IK5MdF79u1In/ReLRMvOu24KiJu3WsHiKZEhu5kpik/1jcH3abvXX2/t4L/9SDci0QpvDIfN1PIdVtjI5GOJVNHG/BKmi0a7p1IAnjV44i7B8fqCWD1s6m9CJU2YpYmZFdEQM/MTIBTM2XeOkJZAHT8OpOtqUMV4LqBrpCjoy0GDMtMAk9w7fFIzAEacsnbxAL3fpm6L6lRJfzHrWKEg/8ar0n8LDwAZ9+eKT9UdzOX9yGGKVnkRAU9w7sCE7ghJWNt+apFEukRQMZZjB16HxBTxoTBu3HLOjQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Nov 2025 22:07:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 678104 invoked by uid 111); 4 Nov 2025 22:07:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Nov 2025 17:07:48 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Nov 2025 17:07:48 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 14/14] ref-filter: parse objects on demand
Message-ID: <20251104220748.GA2638011@coredump.intra.peff.net>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
 <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-14-2be68ce82c9a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-14-2be68ce82c9a@pks.im>

On Thu, Oct 23, 2025 at 09:16:23AM +0200, Patrick Steinhardt wrote:

> -static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
> +static int get_object(struct ref_array_item *ref, int deref,
>  		      struct expand_data *oi, struct strbuf *err)
>  {
> -	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
> -	int eaten = 1;
> +	/* parse_object_buffer() will set eaten to 1 if free() will be needed */
> +	int eaten = 0;

This comment is surely wrong now, isn't it? It will be set to 1 if
free() is _not_ needed:

> +out:
>  	if (!eaten)
>  		free(oi->content);

-Peff
