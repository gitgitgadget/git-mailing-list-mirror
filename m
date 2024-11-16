Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB528FF
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731727436; cv=none; b=uVvEBmtlzlqGxP2Wm1vbKYBbEyJB4n3mFJlUylhCkMqCnGbD7rgzXK6kp1Bp/bv4WkaNVYdimQ7KYZOqcGQieoKFQmTzVEbiLrOnghkHjnh4G+1i1NdoXWMC2jwvrux2TNTusj8e2LD/1r+4FDj5vYj3PJfzSHmxiEhuK4jSxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731727436; c=relaxed/simple;
	bh=xosnw0HgbapQv+Z4vV9+MnSGDM3Srr25KVvaAeKgCJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us20dO0ACdC9lwURLmZ1Fm4vVy+Hd6CYYVeMtBBO5U44QjEHw+pUSwMBAigOsQxPWBRDTXInFDSQAKiz/BfrjoDAc09oJnb0ONRl+Zz5VljoPkfTu4zSkkpUgYOlHCdE5pr9u9xHFCDSc3vS0OUplwvlj5iJ8DhejEtvt2QcS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S9QtAgNL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S9QtAgNL"
Received: (qmail 24896 invoked by uid 109); 16 Nov 2024 03:23:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xosnw0HgbapQv+Z4vV9+MnSGDM3Srr25KVvaAeKgCJI=; b=S9QtAgNLm3o3EYiUiozzmnprmiNwNvJlwOaVsuz30alZVbSr2v39MoBUjPj15HOUusJgcrkG1tB7KevKnvpFsEuLE1JNonGjbstpCM8jd09SidhrznSpDMletQH144k8WScvpTcbO/DP4Jc/z+4APIGqJ8Ag9kDwBFYXXpmU3rvgz/DzRN5VXdJldal/eB/NZMoSRr+FZDHkyHD+Piaye2k0S0ev2QWvURYnVomVQ+rBcWWymVBvfFWlM9//vrwvhr18BSYcW6wM4B/nKDWZrqRtJK9qT70s8HqLNP3txewucBKkdUYtQTxNRJNc4rI1z9FnOppAE1eZBl6d2/QCQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Nov 2024 03:23:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16297 invoked by uid 111); 16 Nov 2024 03:23:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2024 22:23:56 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Nov 2024 22:23:52 -0500
From: Jeff King <peff@peff.net>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, steadmon@google.com, hanyang.tony@bytedance.com,
	me@ttaylorr.com
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
Message-ID: <20241116032352.GA1782794@coredump.intra.peff.net>
References: <20241114005652.GC1140565@coredump.intra.peff.net>
 <20241115195503.3395744-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115195503.3395744-1-jonathantanmy@google.com>

On Fri, Nov 15, 2024 at 11:55:03AM -0800, Jonathan Tan wrote:

> > So this may become more real in the future. I wonder if there is a way
> > to add a test to future-proof against changes to how the quarantine
> > system works. The theoretical problem case is if we did quarantine
> > fetches, but accidentally wrote the new promisor pack into the main
> > repo instead of the quarantine, and then a fetch rejected the incoming
> > pack (because of a hook, failed connectivity check, etc). Then we'd end
> > up with the new promisor pack when we shouldn't, which I guess could
> > move objects from that incoming pack that we rejected into the main
> > repo, despite the quarantine?
> > 
> > I can't think of a way to test that now, without the quarantine-on-fetch
> > feature existing.
> 
> Quarantine on fetch does seem like a good idea. I also can't think of
> a way to test that now. Although, for the fetch case, my patch set is
> not the first time that an extra packfile (that is, a packfile not in
> the "packfile" section of the fetch response) could be written during
> a fetch: packfile-uris and bundle-uris already exist. So I would hope
> that the implementor of the fetch quarantine feature would be aware of
> at least one of these extra features, and design the test to check that
> absolutely no packfiles are written if the fetch is rejected. (So I
> don't think the future needs to be "proofed" so much.)

Good point. I think we have to just leave it until that hypothetical
future and hope that person is careful. :)

-Peff
