Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE54B1E42
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338490; cv=none; b=ASmqbQaG6JB+qnhOvdAVoK4B9SJM6Z+uBgHFe3/JGvIAspSOGCwJsJ4xSTFWA/GmAIWXvZWi2RurC0xNif82EsPa5jZrtlCFEeTVCZw6Y6AaWeFrQE/BiL9To9YtoQECcSibgzUlUdL5PZOCbw9aqwwq2jDKgHR+GfE3Doualc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338490; c=relaxed/simple;
	bh=ebsjq2Qxn97z2VM3Hk5XU5cVDgwN/zGkuqBdicw72B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIdIEw5HiYBWDH9IkxkD0n7pS5y06ihuMAuVKAZFeAYg+Au9U4puAPhD1IpGBVU873tiSHQEQ1VHiurjtkO5AT6OIFWXxZUYfWJ1OqC+RGz4xcFKUlDon64LycQkS1pnhYd0TT6aWHowQAACP3aCe9v/lUF/hl4nn1uLlqz0PSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U9LhbDwX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U9LhbDwX"
Received: (qmail 541 invoked by uid 109); 15 May 2025 19:48:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ebsjq2Qxn97z2VM3Hk5XU5cVDgwN/zGkuqBdicw72B8=; b=U9LhbDwXzweZOFZhZW6biNCRhma5bgdTyDGDRGQYypZi3TCW5+cH2XrhT6hQQ57jyhCqtbY/2ypRYzKjbGQS0cXghEQT/BePlPwXBAqsSlKSkFXi9tle54f4DWMc6aFHGZyC3gCrHxqWcbaTfaJpgR/uy8y2LtJ38GpcJu6G27zugckzwM7CUJjof921+MoBO/mhLtI/GafRbqn+B5AQ8RzDNG1anYm1NdCV33uRXVw5NSE9D5AqVJvPbLzntwLUhcccafVLa3GtD6pSN6cHSvg0TUag85gyxqsAzknvS+lxptB3NNfl7BiQDFEkkRkycuLVgX2Uz6FU4jCwYbzMCA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 19:48:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30371 invoked by uid 111); 15 May 2025 19:48:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 15:48:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 15:48:06 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] commit: simplify code
Message-ID: <20250515194806.GC3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <767b1e74fc70d78c7e3c84a2dc5eb7b607252f4f.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <767b1e74fc70d78c7e3c84a2dc5eb7b607252f4f.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:39PM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 66bd91fd523d..fba0dded64a7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1022,7 +1022,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			for (i = 0; i < the_repository->index->cache_nr; i++)
>  				if (ce_intent_to_add(the_repository->index->cache[i]))
>  					ita_nr++;
> -			committable = the_repository->index->cache_nr - ita_nr > 0;
> +			committable = the_repository->index->cache_nr > ita_nr;

I guess it is not possible for ita_nr to be greater than cache_nr, since
we are counting up entries in the loop above. If ita_nr were greater,
the original would wrap around and set committable to true, but yours
would not.

So really, I think the original was equivalent to:

  committable = cache_nr != ita_nr;

but I think ">" probably expresses the intent better (we want to know if
there are any non-ita entries). Though in that case I'd think:

  committable = 0;
  for (i = 0; i < cache_nr; i++) {
	if (!ce_intent_to_add(...) {
		committable = 1;
		break;
	}
  }

would be the most clear, since we do not otherwise care about the actual
number of ita entries. And lets us break out of the loop early.

I dunno if it is worth refactoring further, though. Your patch does the
correct thing and fixes the codeql complaint (which I do think is a
false positive, because ita_nr must be less than cache_nr).

-Peff
