Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F633451B0
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193506; cv=none; b=i1bzg53UcOw90UNOSf8W+yol4hFDpUNKfiNUlU+Qxm0gavcnpdP/qswFAIEVmDAbPw+YvosvtdzmMuz2cPt9ihIcgKe9c/XCzS6o1sBY/iDWq0je3udUs8CU3FicQZMegy4bjNa5hMpOl/fPHrGH5lr3jOjw9t7fdxOE2VMDgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193506; c=relaxed/simple;
	bh=RzwcvFm/qOwC5XiRTIYqeswVBFDPAP7Vkno0cyxsga0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Racfj3UslyQc/HfnUp7H8Tn1DLjDgPYnV26eW/3c+iEUbyzxRhsBjSE1ReRC/HFLxQuKBB0APC10gd16Px/hBRwz4di32DMN6cdB6uRGSBJruTatITXArPzGl+l6Rxf6XcTwn10kbLzFQgJxOtk7apE2OZTx+bki3UBJOu/ET3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ENt53w0t; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ENt53w0t"
Received: (qmail 42810 invoked by uid 106); 16 Jul 2026 09:18:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RzwcvFm/qOwC5XiRTIYqeswVBFDPAP7Vkno0cyxsga0=; b=ENt53w0txVnMv2CEExDPb8viGs7YKoebP2sIpHuFr86SYcIfKtvFn2XRMP2MM6or3Np1JKjt/CUpbyQwEHu91CQKlU2Rxti3adXOZiBXkG0S3kDq4UT1+n91JNJbv9+r7JZibYuyZSEzE296E7PWrqkQ9DYWHGVOfcrJtwEKw30k+S+YlSqLWwLC80jvUFkAO32WvetSpYFyVirES7IFicZnH5gqp4XtaXKeWb3wHWo6AK3TFRO0xy3S9QCikQZQHuesk4N4pks+DBbXslW3FME5yGtWyRTtvzEm7WfSVJ+wsD8mGSP3m/3lVV33kFhPVNWW5/2iTsJ0vshGWCH14Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2026 09:18:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 77700 invoked by uid 111); 16 Jul 2026 09:18:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2026 05:18:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jul 2026 05:18:22 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v4 3/3] commit-reach: die on contains walk errors
Message-ID: <20260716091822.GA1212956@coredump.intra.peff.net>
References: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
 <20260612-ref-filter-memoized-contains-v4-3-5ed39fd001dd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-ref-filter-memoized-contains-v4-3-5ed39fd001dd@gmail.com>

On Fri, Jun 12, 2026 at 05:49:14PM -0400, Tamir Duberstein wrote:

>  int commit_contains(struct ref_filter *filter, struct commit *commit,
>  		    struct commit_list *list, struct contains_cache *cache)
>  {
> +	int result;
> +
>  	if (filter->with_commit_tag_algo ||
>  	    generation_numbers_enabled(the_repository))
>  		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
> -	return repo_is_descendant_of(the_repository, commit, list);
> +
> +	result = repo_is_descendant_of(the_repository, commit, list);
> +	if (result < 0)
> +		die(_("failed to check reachability"));
> +	return result;

Makes sense. And we can see from the test that repo_is_descendant_of()
will already have printed the real reason for the error.

-Peff
