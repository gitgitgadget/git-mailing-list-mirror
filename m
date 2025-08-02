Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1D25F7B5
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127149; cv=none; b=jLugfIYoDl04pApoH4Zs7uttcw7Q0/lPHBcNKygdA2trtQWcDhzB6oSHvHP4A3qBBBmwBkCvb71dNuHn3SjXzw/ioanJ5JDKvJobXEOdXv57NOjLYr3/uRC6ZuoEBBcZ4pE3uWbw9WZTqcrx2CyXcwDTGfzARMeh3xHmywLWgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127149; c=relaxed/simple;
	bh=e21DkvsP+TOSa1+5yeRfTriSy/X8i9qIg++MnWMvSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhMTGrPeimgntpsbt7mZ6c1qzhNBkJ9VYvjx5VmRfkjTQ4m7qEqGxvkGCKgCFvHXLeWcKM/OPO0snoRjz2XhORiNAQpnrdJ8M6MDIyar/dazqTxL017M4jFBmky48I5KIzUZPj/x0OAhQBNt3A4xBcf1XfBbjhag4XceVDRGj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h30pVbTZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h30pVbTZ"
Received: (qmail 8969 invoked by uid 109); 2 Aug 2025 09:32:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=e21DkvsP+TOSa1+5yeRfTriSy/X8i9qIg++MnWMvSwg=; b=h30pVbTZ3mNqeHA3tZc0qE4gFTodYerXyhy4Apt9Go0w1XdAorSRNVVInxFzmR/I0AtknWGLMj1cjPlK+QUm/ZqtVk8XZIkoxIgJ3tcy6WmdyklFvR+0bhY2OzPKkELPOSL4LCiA3xsHuF13iDu9wjVkD+nzmpXj0pUpAL9grTI/H4gdKMkKwez366EYCCsvkmcASZrkCr4/SmnOfKW8iLOgfpoCWFt+HzlUumCCn14fatqcpqF5hAoF/RIvsqWmgaTFKiqjzLMRkh8EuVGOhWzTnxox/NqP/HEOFzPjUVXgCvSA7BUVBoFBAYltIEB2AYFegD2MXuPO/0tozw9eIA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 09:32:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11529 invoked by uid 111); 2 Aug 2025 09:32:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 05:32:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 05:32:26 -0400
From: Jeff King <peff@peff.net>
To: Justin Su <injustsu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Fetching upstream remote fails if repo was a blobless clone
Message-ID: <20250802093226.GF3711639@coredump.intra.peff.net>
References: <CAB=S_8+LMsSpnRWQZwK2Dj63WdcPy1vp+aJ=erDbf_aaPoU3cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=S_8+LMsSpnRWQZwK2Dj63WdcPy1vp+aJ=erDbf_aaPoU3cA@mail.gmail.com>

On Fri, Aug 01, 2025 at 05:30:56AM -0400, Justin Su wrote:

> git clone --filter=blob:none git@github.com:injust/delta
> cd delta/
> git remote add upstream git@github.com:dandavison/delta
> git fetch upstream
> [...]

> ```
> remote: Enumerating objects: 1578, done.
> remote: Counting objects: 100% (776/776), done.
> remote: Compressing objects: 100% (15/15), done.
> remote: Total 1578 (delta 772), reused 761 (delta 761), pack-reused 802 (from 2)
> Receiving objects: 100% (1578/1578), 2.67 MiB | 5.34 MiB/s, done.
> Resolving deltas: 100% (1156/1156), completed with 356 local objects.
> fatal: did not receive expected object 0020d54b979cc8cf59a13406f98bfe515b190559
> fatal: fetch-pack: invalid index-pack output
> ```

Hmm. I can't reproduce here, but I wonder if it is dependent on the
server-side repo state. E.g., if it depends on the fetch from the
upstream remote receiving a delta against a blob from origin. And that
might change if the server repacks, or even if there is another push.

Is it still happening for you?

-Peff
