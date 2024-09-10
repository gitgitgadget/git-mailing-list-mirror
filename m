Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8F1779B1
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949616; cv=none; b=UeHKpyJE6F/ACg2ZerV3Q8Lwq6jYB4397xWkmegEaAGzIEYUK5i1dd/La2Hmd6cYWK7lwXbFh8kEvrkHzJjqEqymiirGi16SxcSQajM+Uf44iPJe81aywxao25Cq0c8K03mB7EUwE3E0xPX1j72/20jHcaf7GYgHz0nUdTkWy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949616; c=relaxed/simple;
	bh=+8wGhjUCJ6qYqSkPOsBngJyYkgBFIrHgWGkE3DTyFmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnY0zIhBvMbpt63LKhP7yaIevLet56YkYMw9NPf1ma6Tu82sHlGwIf9MJhJRB+maR/j6kcv4SU7/m6vbVV6ZZ5hf9bWR0w32oWjL02pJ1Ws6FSUSblCMxka0a5DDi5TadH6aSeH9uD3vOiYF+XzZNxGStzYYIvnlMOC2EwY0zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3196 invoked by uid 109); 10 Sep 2024 06:26:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Sep 2024 06:26:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29010 invoked by uid 111); 10 Sep 2024 06:26:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2024 02:26:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Sep 2024 02:26:42 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 2/9] ref-filter: avoid extra copies of payload/signature
Message-ID: <20240910062642.GA1459778@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231228.GB921834@coredump.intra.peff.net>
 <Zt_ikkhuMrqVcFOx@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zt_ikkhuMrqVcFOx@pks.im>

On Tue, Sep 10, 2024 at 08:09:22AM +0200, Patrick Steinhardt wrote:

> > But parse_signature() would never find such a buffer! It only looks for
> > signature lines (like "-----BEGIN PGP") at the start of each line,
> > without any header keyword. So this code will never find anything except
> > the usual in-body signature.
> 
> Okay. So in other words the intent was to parse in-header signatures,
> but the code failed to do so correctly and thus this never worked in the
> first place?
> 
> In any case, `parse_signature()` is only a glorified wrapper around
> `parse_signed_buffer()` in the first place, so in the end they would
> both parse the buffer in the same way.
> 
> Nice cleanup, even though it leaves one wondering why the in-header
> signatures have only been wired up partially.

I, too, was confused. See this exchange with brian:

  https://lore.kernel.org/git/20240908233636.GA4026999@coredump.intra.peff.net/

-Peff
