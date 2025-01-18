Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191B1922C4
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203314; cv=none; b=VABQedlR2hp5+QMVPDvtsGDkZKwbZGvI7Rs2d1mWRgJ8rrK+cYYT7EOVdh3lkyEYjzQoyVkJ4Qgqy6iOT1z+c1azkjTufPN6bpiQbqSeI1ogn62ETZ3MvOpSbr7vL/thPujzPBd1aOORjXVIJ1RXAcRU0+SDxTTkZav8vMFn5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203314; c=relaxed/simple;
	bh=Yy4VFEOA6xkMDpGwi0y8sxX53g7L3zehMCX//jGKDCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVlOso0/u4XxWZqKO6QHb7utvI2OFMIuWqZLb80JwzxUkPbfLXXBJUIX/K29oElNZPX67rcbaIdqaDbFv0qI+MsRIHcB/lwZ0b2t/wte906oHT3GeDEsK56QIR4NiweIb4iXiyxErc/k/XxlrFedqrISa86XYesrC9yPDglQ+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ik30nvPM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ik30nvPM"
Received: (qmail 31356 invoked by uid 109); 18 Jan 2025 12:28:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Yy4VFEOA6xkMDpGwi0y8sxX53g7L3zehMCX//jGKDCQ=; b=Ik30nvPMn0TmFsjvACPsljSgOSRis7M/gqgnXesfti525VWCjKPFz516hId1rW3tPsAOflKPXViB2t+R6LyKC5/Y3DrfMX7EkpJKzmCH9FsNp7TBeiYctKnQIIuJOmk1/hnU/5Fmr3B6zzod2nnsUcd0ZvTytTMmHz0swKp6zlu73gYXVzrY1LGYtiblUPn5FsL/f6AEUFk/SMZYM8UqjxdgUE+8HxCYxLXD1LjC7nj4Dbb38HrgW26FtMz/4XekHkZDHfkWhD6bAXiGHPWe+ZgK4m6ik6lnCIQmnm7aKnG7f5R48tZP1Y6PEKeQaN/vXdDC1rO6MLSRZwNePUJtOw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 12:28:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20304 invoked by uid 111); 18 Jan 2025 12:28:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 07:28:31 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 07:28:31 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <20250118122831.GC3510721@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737151386.git.me@ttaylorr.com>

On Fri, Jan 17, 2025 at 05:03:07PM -0500, Taylor Blau wrote:

>     +    Note that hash_algo_by_ptr() needs an adjustment to allow passing in the
>     +    unsafe variant of a hash function. All other query functions on the
>     +    hash_algos array will continue to return the safe variants of any
>     +    function.
>     +
>          Suggested-by: Jeff King <peff@peff.net>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>      
>     @@ hash.h: struct git_hash_algo {
>       };
>       extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
>       
>     -@@ hash.h: static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>     - 	return p - hash_algos;
>     +@@ hash.h: int hash_algo_by_length(int len);
>     + /* Identical, except for a pointer to struct git_hash_algo. */
>     + static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>     + {
>     +-	return p - hash_algos;
>     ++	size_t i;
>     ++	for (i = 0; i < GIT_HASH_NALGOS; i++) {
>     ++		const struct git_hash_algo *algop = &hash_algos[i];
>     ++		if (p == algop || (algop->unsafe && p == algop->unsafe))
>     ++			return i;
>     ++	}
>     ++	return GIT_HASH_UNKNOWN;
>       }

OK, so this version introduces the loop we discussed earlier. I think we
can probably dismiss any performance loss as theoretical unless somebody
can think of a good way to measure. It seems like worrying about it is
probably a premature micro-optimization.

It is a little quirky that it loses the transitive nature of
hash_algo_by_ptr() and hash_algo_by_id(). So this is unsafe:

  /* start with unsafe variant */
  algo = unsafe_hash_algo(the_hash_algo);
  algo->init_fn(...);

  /* returns GIT_HASH_SHA1, even for the unsafe variant */
  id = hash_algo_by_ptr(algo);

  /* returns the safe variant */
  algo = hash_algo_by_id(id);

  /* oops, this is mix-and-matching */
  alog->update_fn(...);

Now obviously that sort of round-trip is a silly thing to do in a single
function. Could it happen across a larger call-chain, where the id is
stored in a struct and passed somewhere far away? I guess so, but it
also seems kind of unlikely.

It does make me wonder if hash_algo_by_ptr() should just return UNKNOWN
for the unsafe variant. Then we'd at least get a loud error from the
caller (as opposed to the code before your patch, which is undefined
behavior). I dunno.

-Peff
