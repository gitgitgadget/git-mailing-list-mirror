Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0AC75809
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788002069; cv=none; b=PfRc6UfIQD+X1GKusghBVMngJWO0wWbiU4FL/3GCoVAa34FeuV6oR+JDooXbnEFyGzZ8kDGI6ndZ01lO3AHqkd5YIS7bfsA7fUimfXohJD6Hd1ge/XIRqz9q1pPHUeRH+5F4lZsXVFEfKzXsso1bplNFD2Fj4UjemQCEW0q1f/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788002069; c=relaxed/simple;
	bh=oIiI/CTKMxlYsYWkHcZNhxBKFcu+ylBJ2PUJAMyQQ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTwQ6fyMuDJjMOrLfnj71Pj8wdRNwi9qH6/SzrbfTr7lWiUV/lzdSLi6l5pthHxF+jQRuwB5R64ErbeEDCg7btsCPDgV1h2wgbaZ5/O8e1vtCE2ra+ewHZQddeDe+ihJ/8Pvv5yd4nI7aLPEgsfe8zFqL6A6nlRsxmr/OWgvCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Grn+s1I7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Grn+s1I7"
Received: (qmail 46538 invoked by uid 106); 29 Aug 2026 11:14:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oIiI/CTKMxlYsYWkHcZNhxBKFcu+ylBJ2PUJAMyQQ5o=; b=Grn+s1I7iTXmzqVP9hwK7YECUrpWTt/y1IUgTcoS+b4v5unjuOaxgROUUsZ4fZg/G54dQr7cUF1NG7H2hcFtYWo4wgwswpkARCtIGJwCd+mj1Nd9PJt8J1FLvCuvjO9+oj7wVvjRdgfw2Aho/n5dNAr4b3vqW0dekeX0NBURupWnD8yYByQLFPK1wZbLckd3/8lF6W2QhoKA9eNZLlFn+577M1UBqIppj/iZmN/iZosRtomq4NtZg1so5zaUDFQVb0jIHs9gKqgzfxFHc0twknj7TMaVQLXE7+QucpmaiblagRkt7sgACnA4awRnhvZCKlIzXKDjvYbk8BxG7p16/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Aug 2026 11:14:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 83549 invoked by uid 111); 29 Aug 2026 11:14:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Aug 2026 07:14:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Aug 2026 07:14:18 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] die_for_incompatible_opts(): accept more than four
 options
Message-ID: <20260829111418.GA40814@coredump.intra.peff.net>
References: <20260826233152.1703497-1-gitster@pobox.com>
 <20260826233152.1703497-3-gitster@pobox.com>
 <20260827045515.GA176544@coredump.intra.peff.net>
 <xmqqv78vbphh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv78vbphh.fsf@gitster.g>

On Thu, Aug 27, 2026 at 07:35:38AM -0700, Junio C Hamano wrote:

> > So that makes sense. Of course the follow-on question is whether any
> > callers actually want to pass more than 4 options. I don't see any
> > patches adding new calls.
> 
> There isn't.  While I was writing [*], I wondered if the two calls
> next to each other for opt3 and opt4 want to be combined to opt7.

OK. I wonder if we're approaching churn here, but I don't have a strong
feeling.

> I think I can do without [1/2], by the way.
> 
>  - die_for_incompatible_optN() (2 <= N <= 4) will keep accepting N
>    pairs of <int, const char *>
> 
>  - die_for_incompatible_opts() will take pairs of <int, const char *>,
>    expects "int" to be 0 (not set), 1 (set), or EOF==-1 (sentinel).
> 
>  - static inline void die_for_incompatible_opt2() emulation layer
>    will call die_for_incompatible_opts(!!opt1, opt1_name, !!opt2,
>    opt2_name, EOF).  Similarly for opt3() and opt4() variants.

Yeah, but then you can't get good compiler support, since I don't think
there is an integer equivalent to LAST_ARG_MUST_BE_NULL. So the varargs
interface feels less safe (and strictly worse since we are not actually
helping any case that has more than 4 items).

If we're not actually exposing the varargs version and expect people to
use the counted wrappers, then it's not as big a risk. But then I wonder
what the value of the patch is.

> We could switch to dynamic allocations immediately after we see
> option[] filled, as we are committed to die() at that point and can
> afford to waste cycles.  That way, for die_for_incompatible_opt10()
> when the end-user uses 7 of them, we can fill option[4], switch to
> dynamic allocation to collect all 7 of them and report.
> 
> The reason I chose not to is primarily because we cannot use the
> existing message templates in that case, hurting i18n/l10n.

Yeah, that makes sense.

-Peff
