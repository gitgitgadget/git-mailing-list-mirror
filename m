Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A729B8E1
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984586; cv=none; b=asmDYZKstGcEAakgF8MA2UeFJKkeE4xHTaWnoc/HjdR/0gnW4Rbtq/BoXtdJg67Wf9TgnU3g+chsjDzJi4vubM7hUwCX0kuiSz0YIuGYPMnVx2wRGCo76jUl66ja8Qdp13epFJ7qncm7Tb2Ob84NGZ6fXIMLsnQNtBiwYuHuPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984586; c=relaxed/simple;
	bh=EaY5CELYuqPQM3zMzs/6bUsOmutTCKtEBJWyolTDi10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI5gD0SWPpkLQSwdHBF7fUp2J3azya+vpidvC+pCVi3vQlWKrmV7WnQAnwxw1VA7hmgAgvzMUusxwJcvLT+Ll9nDDpklz2n86VDPKxH+N+nNQA0mxB2I37nVXvdSH1OSTO/+7Tw3ydV09LBRF6mcbhHe273bjLNc1349bZ8+nTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KJWq3upR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KJWq3upR"
Received: (qmail 202443 invoked by uid 109); 4 Sep 2025 11:16:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=EaY5CELYuqPQM3zMzs/6bUsOmutTCKtEBJWyolTDi10=; b=KJWq3upRxR2UQbXYU5WkJt96Wzv3qENtvajtBzWU0Rr5MjcOkslXvqBT1PQbxu6AOV4KX7I6CjtEX/O0xMMwTmauvJAb6QuaJyoAOsIqxkFcwhvuCYEwzmouthfSTRMRkUnrfhT/gBRa9dIbEd0jSEFAa9GDmo2c25aLd20e6QrNxNuZZ3sXC5xjfnVk1lxn2MHJPJmXQvcgSAskiYa0mfYuqJNJvXqhYAWpDnRD7bec2r8O0JPuDvw9/Q3ofmaZHEKClz/pU8bfe98oLKSJC0gZDVfpre3cLDMp+Gx5RO8kd0nsr0I8njwBKUfRtNOAp9wPvMjwqoRgPmKavnjO+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Sep 2025 11:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 356114 invoked by uid 111); 4 Sep 2025 11:16:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Sep 2025 07:16:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Sep 2025 07:16:19 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250904111619.GA2474144@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <cb192b28-d85a-4866-a312-df4408cae93e@web.de>
 <20250902123834.GA711442@coredump.intra.peff.net>
 <05b8e161-9087-4eb8-b049-6e99ff288af7@web.de>
 <20250903143134.GA1884731@coredump.intra.peff.net>
 <f6b4c1fb-9f59-4072-a796-e2971524ffa5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6b4c1fb-9f59-4072-a796-e2971524ffa5@web.de>

On Wed, Sep 03, 2025 at 05:41:49PM +0200, René Scharfe wrote:

> How does an attacker control object hashes?  Hash it, check if it fits
> the criteria, if it doesn't then make some inconsequential changes like
> adding whitespace to a commit message and repeat.  That criteria can be
> "bits 1-16 are all zero", but it can just as well be "bits 1-8 XORed
> with bits 9-16 are all zero".  For the former they'd have to roll the
> dice in the order of 2^16 times, for the latter just 2^8 times.

Hmm, yeah, you're right. I was counting the wrong thing. It is not one
expensive action to generate a byte (or word) of sha1 hash. It is one
action to generate the whole hash. And then cheap to XOR it and find out
what the result would be in our XOR-bucket scheme. So if you are just
brute-forcing anyway, it is the same number of hash attempts, which is
what the attacker cares about minimizing. My proposal adds nothing
there.

> The attacker in our scenario doesn't have to care about the individual
> bits of object hashes, just the resulting hash table hashes, which
> reduces their search space a lot.  Making the deterministic function
> more complicated or using more attacker-supplied input bits doesn't
> change that.

Yep. Thanks for a dose of sanity.

-Peff
