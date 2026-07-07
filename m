Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06D42087F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455944; cv=none; b=PqgpBd2tb6TyjC4SkZYL4DwbmTwcCXFDn0NDs7JZuWPpNVB8LInPjK3/yWuUJgz9s/COVsA2vYCFd0gNYLN802TJmEyFXH4oNMms8S+HlSqo9wKRAe5W8MomOwDCBClhdSBzDG7bDaAi/+WrlLroF0WvlDJSHuV5tnEu05ku8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455944; c=relaxed/simple;
	bh=ZrZszbCa3eSqPMxVignth8RGqTQVemdLVjmZqZBAwNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1fcmpRKlnKOJI+ZCIlVdinLeu4lz1VnYPtYTDeo329Lrqcd6vLjAQAO5LtLwWRPId5qBpn3gKZTtjOj0PViI2xdSfhQ0+l/2d3tUrgVTVk6itfhuqSeHC9TN8L32Xv3gKz8nKS0edkbheol9xAVieos2FfAzneLhj4V/8avnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F/GP4TKm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F/GP4TKm"
Received: (qmail 22893 invoked by uid 106); 7 Jul 2026 20:25:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZrZszbCa3eSqPMxVignth8RGqTQVemdLVjmZqZBAwNM=; b=F/GP4TKmv8UadSTZRUHNrnsZc+crIpd20PuigcCGznx73no0uUc4JJyZynhcrB3VIaGlVBxPQLHfgylUSt5gQLn6tOGPNq1bVpa/vZIvm1Rtib3c01hxMfoVTvEv0q5RrqVpPr0apjwrTfOru1hcGBVcBRJRN3rEe/J9GvSGWEv/6VHo7E7notYRO5gOsOROKM/JNye/ayzLYnR7yDfnnrLPfjOwyD3fpF+gKYuAjwVkeqYe7MRAk91pO232NP58X/iSXgOftE4PD94lXJYndZfSCAkrFqC/qxHM/uEYEgBvH7shCro64YZbd1RmHs8S04Wa5W7LkotPCFD3/8tBfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 20:25:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34431 invoked by uid 111); 7 Jul 2026 20:25:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 16:25:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 16:25:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/7] hash: use git_hash_init() consistently
Message-ID: <20260707202541.GE11780@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050141.GA1288294@coredump.intra.peff.net>
 <xmqq5x2q984j.fsf@gitster.g>
 <20260707201315.GC11780@coredump.intra.peff.net>
 <xmqqfr1u1rma.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfr1u1rma.fsf@gitster.g>

On Tue, Jul 07, 2026 at 01:17:49PM -0700, Junio C Hamano wrote:

> > I had actually removed them, but either I missed these two, or more
> > likely I ended up re-applying the semantic patch a final time before
> > committing (I did a lot of "reset --hard; make hash.cocci.patch && git
> > apply hash.cocci.patch" while testing various refactors of the patch
> > itself).
> >
> > I'll drop them in v2. Thanks for reading carefully.
> 
> Thanks.
> 
> If we run cocci twice, the second time it should be idempotent,
> right?  So running it once, fixing these braces and then running it
> again would not make us see the extra braces in the result, I guess.

Yep, exactly.

If my "re-applying" theory above is correct, that is different because I
was calling "reset --hard" in the middle to test that the patch still
did what it claimed. ;)

I assume this is coccinelle having some kind of "add braces to be
careful in some situations" logic, but I didn't dig into it further.

-Peff
