Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195981119A
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257480; cv=none; b=sMj9Ei2u8bEubtTB96jqcezi4xYUXvRKXVCYbB/q+FQhyNYDXZTmcVbAdNeKM5L6blu4CCD3QNcmFQ5RW2LS5HAGcAfTHT9dDUT6SJuKnDScVDMaWO2HyqFjkhoy2KuIlEOG9jJGzgTSGv/S4+Qbcip8H8REyYVjcxxj73FpWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257480; c=relaxed/simple;
	bh=Cdl4OAq6i4+2h+zkCgLBPBrXhRn0jRjD8nrrWOEC2pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UopxH4nhbzTZ6xJZPbUESkP6FhOGySHwICUUtLmPwsqI9wsRBEWE1/9bbKWgZ54+F10lkObkGWcbe9FSH4JyBfgXDA9fTbWn3zG7eCWouYbc9LzH75WI4gcTqa/okWQsjIIi8BJsFiFJoc2teBBbwg8DMOV67eHW0UDz6JJmMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a5UUxlir; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a5UUxlir"
Received: (qmail 25829 invoked by uid 109); 18 Mar 2025 00:24:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Cdl4OAq6i4+2h+zkCgLBPBrXhRn0jRjD8nrrWOEC2pY=; b=a5UUxlirvT73wBZoQaF5Ivtn+gspVGI1Ij68SNNnjfQr724z0zMUAj9aQZiePATZ5+dHAZMrbxjnIex+iH39AmsMTAYWlBwDrrKWVl5gqdFQaoDUvND5xAj82AEzwprfzZMZWwiJypKUBmDweWkRqYsgHYMKE0kkC2Q5KSyBhsDyZOXdcue9oofaqKwMTdnYwzA22e8mep3amI/8hwT7U3xgRQcwos4w24Cqvc52ao8GKLwfcRAykeePIA46kBjWuRxr8oOhBIPjzCF23fsQ3vigJ20Wx1MoD9QcpyWvgeDZYx+vJTAqr7M7FcHufegVjN4W9vWhzZXI1UYd3ouqMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 00:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2171 invoked by uid 111); 18 Mar 2025 00:24:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 20:24:36 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 20:24:36 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 1/4] refspec: treat 'fetch' as a Boolean value
Message-ID: <20250318002436.GC1470172@coredump.intra.peff.net>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742250259.git.me@ttaylorr.com>
 <7e662acb5ac50b778917cbf2f9f791d35e95e31d.1742250259.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e662acb5ac50b778917cbf2f9f791d35e95e31d.1742250259.git.me@ttaylorr.com>

On Mon, Mar 17, 2025 at 06:24:24PM -0400, Taylor Blau wrote:

> Since 6d4c057859 (refspec: introduce struct refspec, 2018-05-16), we
> have constants called REFSPEC_FETCH and REFSPEC_PUSH. This misleadingly
> suggests that we might introduce other modes in the future.

I don't know that I'd call it misleading. We _could_ introduce new modes
if we had new operations. But I do agree it's unlikely (even if we had
other operations like git-archive, cat-file, etc, they would probably
not have refspecs).

So it seems like a reasonable direction to me.

The one thing I don't like is:

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 9c4a00620a..8bbfcce729 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -738,7 +738,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
>  	const char *spec_src;
>  	const char *merge_branch;
>  
> -	refspec_item_init_or_die(&spec, refspec, REFSPEC_FETCH);
> +	refspec_item_init_or_die(&spec, refspec, 1);

The third argument here (and elsewhere) becomes much more mysterious to
the reader.  Maybe not a big deal, though.

> diff --git a/git-diff-pairs b/git-diff-pairs

Hmm.... :)

-Peff
