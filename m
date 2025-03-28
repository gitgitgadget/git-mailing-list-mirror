Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E30E573
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140998; cv=none; b=QPyYsmAu6Ozy+8g2iAMruf8wsZMFgTwKGPcNe640qUOWeKP4tzLbXsPS205EwMVT4pz9sHH1GTzAT35+HhnoEg+q/uUULSucyJ4ILXmY9yiYh4GzDEAPKFj2nXBvHA6p9nscfsm9PJl/J8j/nMPYUTh8Ot3HiQju1Vv77Mxuhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140998; c=relaxed/simple;
	bh=f8b8Kk9A7pP7vwXtO8/qhlG//MD+KJqYpD/Qd+DWghE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv6Z5/NDx/NQ6jjl+DPIXPbuDF6GItYx2XMdU0zMZb0CnBGPwLDFDu3UbOcQBDzPa83J9paLF8zZHq6TY/qjC9sErrCNfN9IcgmSKeV1x5Pogb9T3diGemj30HO9Y3+dX0XcOTKuP9hOn+622JbnAE5YezBUcyAmPJ/pRaBpN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TSsKTFHB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TSsKTFHB"
Received: (qmail 30692 invoked by uid 109); 28 Mar 2025 05:49:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f8b8Kk9A7pP7vwXtO8/qhlG//MD+KJqYpD/Qd+DWghE=; b=TSsKTFHBj4+iZW+AEv37XYyVf4RGEl92ue+aFUP3EdZdbw2UVU5B5kU9qDXmv8NVwnrN9g5hlI2sEms8rhcFLvj+ZrQu8bLyRx1VPY/UGiB5FyjCqvBlxbuFU2v0nQMpCmSEuPYUvFU86q9Z+XXPtApVMLwB08/zF3pesplVeKf5CDfEdnr+u8/AiL2ouMetfjPXyf7XMQqqr4ggO9zNzrt+m1DdUYvWZBPXPmXYjIIV4ppxO9tQPhS6RTJAsthrCnUTZ/RTvQ1OreIcdfzdfmdjiYSy6X16txHs9JpHpJl80LSY1IEjaYDCJE7616XeQhWYSOjN+eqv+3RjO/g0Sw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Mar 2025 05:49:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12439 invoked by uid 111); 28 Mar 2025 05:49:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Mar 2025 01:49:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 28 Mar 2025 01:49:53 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] read-cache: check range before dereferencing an
 array element
Message-ID: <20250328054953.GA3590654@coredump.intra.peff.net>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
 <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
 <73cae30129338cf219a810c3a2a78ef48d5637d0.1743073557.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73cae30129338cf219a810c3a2a78ef48d5637d0.1743073557.git.gitgitgadget@gmail.com>

On Thu, Mar 27, 2025 at 11:05:57AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Before accessing an array element at a given index, we should make sure
> that the index is within the desired bounds, otherwise it makes little
> sense to access the array element in the first place.
> 
> In this instance, testing whether `ce->name[common]` is the trailing NUL
> byte is technically different from testing whether `common` is within
> the bounds of `previous_name`. It is also redundant, as the range-check
> guarantees that `previous_name->buf[common]` cannot be NUL and therefore
> the condition `ce->name[common] == previous_name->buf[common]` would not
> be met if `ce->name[common]` evaluated to NUL.
> 
> However, in the interest of reducing the cognitive load to reason about
> the correctness of this loop (so that I can focus on interesting
> projects again), I'll simply move the range-check to the beginning of
> the loop condition and keep the redundant NUL check.

Thanks, I think this explanation works, and the patch looks fine. (I
didn't dig deeply into patch 1, but I agree with Junio's analysis that
it is also a false positive).

-Peff
