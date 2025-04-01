Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA51514F6
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498970; cv=none; b=dXx43dD5u3UUUx0wpvbn7Kki4O3AMLTSWFeEwWPUMtXspPQ1kf80eJkxqYxHRXeHhV47IzXY7NltizxObbEk+sIhBYz4T/06v2DK03C+lhqN768mkQxn6DoHtWPo30sm4g2TL34yr7NhI2M7R8d0DAIl30GcZ3IBOKx8pJjLLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498970; c=relaxed/simple;
	bh=EI+XXBWvhcqe/MtIfqceQL84M0tWRWVX7g7XOoqJ+sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWypETdB9U9acZk2XLg+0d/5E2WnnD20Roc1CmlA4yPSrQrwIcFyMJG9PgSrWTiwf1M0M9GVUiwwvAclIXzFEzHGDSoNcI97C28wbt4u1Vxmms3dtTBWFu1Sokg7nL8+j5vNI/fSV8rDRvYdfOog+7b+tM8fTjbltSvwV0PqMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dlJxp2/V; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dlJxp2/V"
Received: (qmail 21035 invoked by uid 109); 1 Apr 2025 09:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EI+XXBWvhcqe/MtIfqceQL84M0tWRWVX7g7XOoqJ+sU=; b=dlJxp2/VGDRYp0y0h14fglnSNQff8ezFcitVXHUR4kfUTX6N11+suf/Qy83aPvX8n/3K5Y8PlaiJDTcoIQH28Lm3YtRwOdnVdabxu0Rplt0npKmV09HyELLd3KkFG8mo9WF01IBaSKzgNe/eAX9FGNge1Er8Kglm+1tkldpMYY9gTg4RKOu8Kr1i+g9zVW7co/9Lin4crxVZXcI1/KDfSvrw88JLZMoqPmJK9DrGQ5qadChzUCS8NYl11LRy8v6RcPTJqOmBhHg2Ymls4JHqei3DRxkJhc59g4rtWSWVI1OSfmZDCJfb4E3ZKrn2IZ02hoy009kUC5KUEMWK79hseA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Apr 2025 09:16:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16715 invoked by uid 111); 1 Apr 2025 09:16:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Apr 2025 05:16:07 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Apr 2025 05:16:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/4] http.c: allow custom TCP keepalive behavior via
 config
Message-ID: <20250401091606.GC21089@coredump.intra.peff.net>
References: <cover.1742336481.git.me@ttaylorr.com>
 <cover.1742423021.git.me@ttaylorr.com>
 <3fe62181e563d011d4a6374ed7894cc4ea807316.1742423021.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fe62181e563d011d4a6374ed7894cc4ea807316.1742423021.git.me@ttaylorr.com>

On Wed, Mar 19, 2025 at 06:23:56PM -0400, Taylor Blau wrote:

> For those users and others who wish to more finely tune the OS's
> keepalive behavior, expose configuration and environment variables which
> allow setting curl's KEEPIDLE, KEEPINTVL, and KEEPCNT options.

OK. I have never wanted those myself, but I have no problem with other
people using them. ;)

The implementation mostly looks as I'd expect, but...

> +http.keepAliveIdle::
> +	Specifies how long in seconds to wait on an idle connection
> +	before sending TCP keepalive probes (if supported by the OS). If
> +	unset, curl's default value is used. Can be overridden by the
> +	`GIT_HTTP_KEEPALIVE_IDLE` environment variable.

...while this environment variable (and its siblings) makes sense to
me....

> @@ -1382,6 +1409,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  			ssl_cert_password_required = 1;
>  	}
>  
> +	set_long_from_env(&curl_tcp_keepidle, "GIT_TCP_KEEPIDLE");
> +	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
> +	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");

...we seem to use different names in the code.

I think the ones mentioning HTTP make the most sense, to match the
config (and since this only affects curl).

-Peff
