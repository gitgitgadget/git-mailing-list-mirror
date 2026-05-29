Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED6352004
	for <git@vger.kernel.org>; Fri, 29 May 2026 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044208; cv=none; b=Jm1ZOSVIdhsiXtBpo4cjc0KWxaXuzmYu7k/ltD7TTO8Gt5P907VCesh8yx2DbfcWWJDfQF0jGsE1NDsk/y7O0763nvlTjYUhmLkK4qTnQGLUs/OzX2QputIIrjNXEbKEaiOkybIVTJJl2soO9Wf7oDfOvRE0cmcQKz25nyWbUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044208; c=relaxed/simple;
	bh=awKErBWHXfuxTWdEGlcsG1aiUWoeQEBANtJPQLuxRxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMWBLxffmQRFw4nGbfoQgj765yMYJJ44crOhjrXIXMWyS7tUAAxfXFS6L7xppP8cGu8U2zdGjAbN9UDvKS7azFIjvqv2ppuB22/XxriLF4XuVHPBza/d2N7lnu+8vSHAD7Cs7iew5MfzyWzqhI0MNaB/b73EW2iDlS+uL1Iaf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eM1w4E2t; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eM1w4E2t"
Received: (qmail 5860 invoked by uid 106); 29 May 2026 08:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=awKErBWHXfuxTWdEGlcsG1aiUWoeQEBANtJPQLuxRxM=; b=eM1w4E2tsQ8zz2zRQ4nccCByz5/O/Mb1gNr8teKcfJYlfPw1hnJWlaFn41j3/k7wuANQ7mpIOBltdtyD2vyQcJ8sghw6lNH0Xy0kdTj4gTrCtb8N0EYBBBvpt6BVKKcv0TaQcU3E47qCstju/SG4bpyG0orB5rrHQJDekQt2RpjtCprsstEWVmx3YiiFqq6dWFz6xfJs/cjUk2JGr48oGWFmrTcMEKLolgeZbV1wewM3DdgCA55lmcyhcAsyOn+V2iqr6WRQtGz3tv5ReRYDf0du46L5wl3h9avVZf/6IdUBBVAwj7pv5gd7keLvptuvLbo0er+mlkdUaIONn2yLRw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 08:43:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9283 invoked by uid 111); 29 May 2026 08:43:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 04:43:29 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 04:43:25 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] commit-reach: stop sorting in paint_down_to_common()
Message-ID: <20260529084325.GF1106035@coredump.intra.peff.net>
References: <450163b0-82c8-4b57-baab-a269efe430aa@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <450163b0-82c8-4b57-baab-a269efe430aa@web.de>

On Wed, May 27, 2026 at 05:52:17PM +0200, René Scharfe wrote:

> None of the three callers of paint_down_to_common() care about the order
> of its result list: merge_bases_many() sorts it again after removing
> stale items, remove_redundant_no_gen() and repo_in_merge_bases_many()
> throw the list away without even looking at it.  So drop the unnecessary
> commit_list_sort_by_date() call.

Seems like an easy win. If some of the callers do not even look at the
result, could we avoid building it at all in those cases (e.g., by
passing in a NULL result pointer)?

I guess there is not much to be gained, though. The result is a list of
merge bases, so it should usually be rather small. The benefit in your
patch is probably not performance, but just reducing the size of the
code.

-Peff
