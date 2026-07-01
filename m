Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E203B6C11
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892818; cv=none; b=khMJqPTfe+nfBof2sXFHjKSdEMRQKlht9TFqSbKkihKmwEAlnYs+UQAfLR63q49MEcamtCBQc/6uBLJwsQCzLKv7FpdiToxW3CwBR3xRniGTIG9nsYFb+7+GHsAf4kbGKDAx+4GFmzQfeZAI/fHBgcZkPOZCWQ53dUqFghP7Sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892818; c=relaxed/simple;
	bh=0RhAMKlg/UBl6iS+m3u958+Vz2fDTsaEdnCM/PKfMGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em58Klai8D4n3LuPId8MIVi49AA2t9jBneCVyL1+UYjNehnorl0dBBWC45TzJf+XXlE3jiWkoQGxcTAA153tFgIR2AhCmFxlCk4F+3H7zWOpbiufNp+0EBm4IkTNmsZbuX7ksvbGSbrxbWysIhPq5NX325lYLL8wWp00KZ5qwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SzHw15bS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SzHw15bS"
Received: (qmail 77491 invoked by uid 106); 1 Jul 2026 08:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0RhAMKlg/UBl6iS+m3u958+Vz2fDTsaEdnCM/PKfMGw=; b=SzHw15bSkVGt6WrheBUFBO8bOYAR+iU7hSEmFuIXNCTAMqo3jnmq3j9ASakFMRh6BV5C61uhXKAEGuaBOUKzg1M1cUSDBK2ZdVLmj2BBcyxmnaBaCVZp6Qje2QwkZIxuFCQOixcE5MVMcdxpjTtzkZkpzGbpr1tAjEi1kppv4AK/B9IFCmrHeLB2DkJFxFw2DxRyKFkSUKbc0bOttoZKZI95XIqR+YC2EebBgYHrT2dK/vTIkAxJGcfCho1n/3MCfMe4HCXYqAcnLDDgJZVoPovs4tkguPH79puDMQXFpnVjOJQ+a+HypySqhnxsKJQx8qtuMzhBaIuBSxfnYYDFmg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 08:00:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 158635 invoked by uid 111); 1 Jul 2026 08:00:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 04:00:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 04:00:14 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551:
 pack refs after creating many tags
Message-ID: <20260701080014.GA3748390@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
 <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net>
 <akOG0oMu2KTqqyW7@pks.im>
 <20260630234702.GA3759976@coredump.intra.peff.net>
 <20260630235850.GB3759976@coredump.intra.peff.net>
 <akSxCUfm2P7ocLJX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akSxCUfm2P7ocLJX@pks.im>

On Wed, Jul 01, 2026 at 08:17:45AM +0200, Patrick Steinhardt wrote:

> This is a known issue, I think [1].
> 
> The problem here is the tombstoning: when you delete all references,
> chances are that they are not truly gone but that every reference is
> just tombstoned. The problem with this is that reading refs may now take
> signifciantly more time as we cannot just say "this stack is empty".
> Instead, we need to figure out that it is empty by processing all the
> tombstones, and that takes a lot of time.
> 
> I remember that I did some digging back then and improved the status quo
> quite significantly by optimizing `refs_verify_refname_available()`. I'm
> sure there are more opportunities for optimization here though -- I have
> a feeling that we for example exhaust the merged iterator until its end
> when searching for a specific refname, where we could easily abort once
> the observed tombstone name sorts lexicographically after the needle.

Yeah, it is (mostly) the same problem. About half the time is spent in
refs_verify_refnames_available().

The other half is in reftable_be_transaction_prepare(). Looks like it
makes individual calls to prepare_single_update(), which reads each ref.
And those reads are expensive because of all of the tombstones. It might
be possible to do an iterator merge or similar between the sorted list
of transaction refs and the reftable contents.

> But eventually I decided to not care too much about this edge case, as
> it seems very specific to this artificial benchmark scenario. Which of
> course doesn't mean that it's not worth doing, I just had bigger fish to
> fry and didn't get around to it yet.

Yeah, that's fair. I dug a bit further in case there was anything useful
to write up, but I don't have much to add beyond what's here and in the
thread you linked. We can let it live on in the archive for now.

-Peff
