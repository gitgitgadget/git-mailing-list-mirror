Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444216EB42
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771036914; cv=none; b=dUEHNMbU7YX07CbW9ceWkbrl4YX2wWbS+7neiNjxWhFaAXu0uYHtspEDYB4f4ovTmP3LkYQj4Bo6KcP6xKPEFNJUupWVBQYVJ/RIFl56LXbErLdgYuxhazYbyZMX6Lv1GJLtSAreUHjhYudo141g6R41RNkjk3qggoBVcVjZImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771036914; c=relaxed/simple;
	bh=XblAqZ7AMaKS3A0XpSTScay4irc9KwYouLWMk4FmRmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPJ8dEtR6cd8R2gmp3dXOEFaVUKqumg/KRJsHJ5LvLXIIsOUxeumMbXpJJUV+pOjs7eSZcxf0Gff91/1VZZ/0ZBO60vsRxMM4zJCYRvj5jlIJJr9e/G6uIt4MfIQ3eztf7owf9fHGtQ36PD4Fh0vdPcxf76DEtDxaxnpkqzef5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aCtZ7ALS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aCtZ7ALS"
Received: (qmail 38561 invoked by uid 109); 14 Feb 2026 02:35:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XblAqZ7AMaKS3A0XpSTScay4irc9KwYouLWMk4FmRmY=; b=aCtZ7ALSb1/Bq8ljl1SIGm0bipS3ADGiy9POI1bbktMNAsV+X5yOOynK4k40EAI9pMbHKvmRbXIlrDLLrmUPpXzIwpy/7nJ/3opc+qQnEH7CilEn8CnlaBi10+fAp8XCuhb0qLUc4DZ5DcXRdVC+/o6SQpbCm0cKMniPE/jRdlA2gTiSqU/YHsyq9vA4todCBoAUBhlxVBZ1kLER2dgyyIyLZHmk4Hw7G7Ya81yszPGfdOTk29mjiIfUchfj8XzRJa0LtLr9cBjYHqTzmQlKJXz7gJ5IkWSL4NH6htwN5ySCuj2Cs6l6ZPHTQkHSIiyW0PHuxUJz7AatacR3tgZaBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Feb 2026 02:35:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 85641 invoked by uid 111); 14 Feb 2026 02:35:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Feb 2026 21:35:13 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Feb 2026 21:35:09 -0500
From: Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 6/9] list-objects-filter-options: support 'auto' mode
 for --filter
Message-ID: <20260214023509.GA3684377@coredump.intra.peff.net>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
 <20260212100843.883623-7-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212100843.883623-7-christian.couder@gmail.com>

On Thu, Feb 12, 2026 at 11:08:37AM +0100, Christian Couder wrote:

> @@ -317,6 +346,7 @@ void list_objects_filter_release(
>  	struct list_objects_filter_options *filter_options)
>  {
>  	size_t sub;
> +	unsigned int allow_auto_filter = filter_options->allow_auto_filter;
>  
>  	if (!filter_options)
>  		return;

This will segfault if anybody passes in a NULL filter_options, before we
get to the NULL check in the context.

I don't think anybody does this in practice, but probably we should
either remove the NULL check, or you should push the assignment of your
local variable down below it.

(Noticed by Coverity).

-Peff
