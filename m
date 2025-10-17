Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50F21B185
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690422; cv=none; b=YxhffNdic2QppEXkLe3ZFazzIkjZouUAgeumqIx8Mx3pghI6St7PDna7kMD05Hr6+md2Kh8K91ZNXAEK0/hLRA1Dwvr8Xdvz35nuqX9VowDAjtpHWBkc1TvYL5VKE4M30svnRHHQzMo/rPA9MutVpw8PZHiyHlFGncRhS9ZyakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690422; c=relaxed/simple;
	bh=1DidZ5zog3PY9mL6hyIUVksidqaRv6FEMctQBk1N/xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inSeT3cLzaLWrFlWOupx+CSemn5MIaib+vPf1fcvNKqzYKwGcDCT2o9a1elnlSLTyBL/uf9GEdiE1aKV2OJrO+jyHkg08bS41Fpe8YrVnyXJzIijFlhNCr5vo631ZSd8NPq9Geeqr7Qr4yjqBdopvVJbZ/Qx826Pg2RTGOEuMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=adBPfnh6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="adBPfnh6"
Received: (qmail 252240 invoked by uid 109); 17 Oct 2025 08:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1DidZ5zog3PY9mL6hyIUVksidqaRv6FEMctQBk1N/xI=; b=adBPfnh64vJHlrzfS2YIUZVk5qTe/ywWtFB6RHRUIG/M8h/6haX2NqNwwfLoLptagXL2zsPLJDJzdm+bTSlDs5WvLmOlnXqIvUCdo8bViOdlsOsWPWVVDC8I0LG64uwgYS6gp0envfUZScM+4qITE+IV6jQ5l2qEY1axruSSt24LVZjJw/pLV+QgabXv1q77JtL4r8RtA3An2gl8w8K0IouYeaPj/SN4sARVb0hoTWUFZMZAHTYrLhQnj88n3OrNcrJQGBCctxbEFDd2li353ZakJShzznT68fYnOKKuopfG0JZKGYQPEMK0USN4vNfOjDoTuwCoxfGSHaQH+qAofA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 08:40:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393750 invoked by uid 111); 17 Oct 2025 08:40:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 04:40:19 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 04:40:18 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/49] repack: prepare for incremental MIDX-based
 repacking
Message-ID: <20251017084018.GA4096665@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
 <aPDJj5e9GKLSeVfS@pks.im>
 <xmqqtszy4vrc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtszy4vrc.fsf@gitster.g>

On Thu, Oct 16, 2025 at 10:11:19AM -0700, Junio C Hamano wrote:

> > I didn't quite feel like reviewing all of these patches again, so I only
> > had a look at the range-diff. The changes in there all look good to me
> > and address my feedback.
> >
> > So I feel like all of this is in a reasonably good shape and a
> > definitive improvement for our code base. Thanks!
> 
> ;-)
> 
> Thanks for a vote of confidence.  With what I saw in v1 round, I
> agree these are in good shape.

I likewise looked over the range-diff, and it covered all of my
actionable comments from the v1 review.

-Peff
