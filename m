Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460631B21B9
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931405; cv=none; b=lLcRXa0fhtzKJBev3v8i2jdPJR/6s2NuDz8sJMYLZOAOJZh3w/8RvR8FF2MxUSyt8zkI/nRSg9ACyStS1+5+O0m8EFwsYc9ZRuQxKrNRRLuYe14F5lBRQNWUykuUqFwXUpOfJzAcXv9zisH/hXRKgz81DtxrsVI+lWJpT17G0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931405; c=relaxed/simple;
	bh=IFQzT5slubw+ADJd4mzlAaG9Asx6zIYpsZ/9dayWRIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9UuEMbiAHsbkpUskFbDslnBiNTkBaktyDkzAMlcsOEN4yI9/Pjcl/mQE4WVURbxlzDQlxBcI5dl7ipp0hIG5fTojT7LsBfn9Crpr7UyGGwIpHvaNVBK/x4BtleS9lfig/jEIv6Cv6z2YdU0pFdX2xoU1ejViE3CQsq89P+YIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Kvb5S9/8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Kvb5S9/8"
Received: (qmail 18533 invoked by uid 109); 3 Jan 2025 19:10:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IFQzT5slubw+ADJd4mzlAaG9Asx6zIYpsZ/9dayWRIk=; b=Kvb5S9/8ZNeQjU9BOT+w4RhNaXNuKOLVSydYYj7n2ZC0Jrxr78Ybrp7MdmpPM8XH5Ga3lHz05hYbpXs8//5HQbsfRuW9i56KIaBdcs1pa4+a4iZbab1IalpRW8pVsVJPiwN2rIT7aOV50OCT3c+kiHHYY2OruNUlpvbtaNz8ZjHb3bhMVkovm/3HGMdRo6TFSfFRLE8xcK7/k7fTzP+SsFIfbxAv9EMipaeGNmJfU3NsjKAE24VKbCiAfu7NjhUth4z2cyL1Sv91dCsf3XWbTf/ky8SCYzW+rL8fNHd3KS+/kvOCbBt+G8k2osClYM2cvuOMCVA57uKw1OOUdC4Wpw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 19:10:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4140 invoked by uid 111); 3 Jan 2025 19:10:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 14:10:01 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 14:10:01 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] object-file: rename variables in `check_collision()`
Message-ID: <20250103191001.GD3208749@coredump.intra.peff.net>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
 <20250103-b4-pks-object-file-racy-collision-check-v1-1-6ef9e2da1f87@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-b4-pks-object-file-racy-collision-check-v1-1-6ef9e2da1f87@pks.im>

On Fri, Jan 03, 2025 at 09:19:54AM +0100, Patrick Steinhardt wrote:

> Rename variables used in `check_collision()` to clearly identify which
> file is the source and which is the destination. This will make the next
> step easier to reason about when we start to treat those files different
> from one another.

Seems obviously good, and definitely worth doing as a separate step from
the actual code change.

-Peff
