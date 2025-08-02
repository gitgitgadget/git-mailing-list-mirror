Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDE202C58
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754160047; cv=none; b=QyC9LCrPxzh969RFQD9eABU6BjppPNWp8q/D9/O3UWHijcFHePKw//svz3jNtVMfanJCRjRH/dPZGafRiJwaCnYF+ZovXLXi1GakatoPc1vaLwh8uo2dA+Llr56o0JTPTjF2Qpa/1LRficsWBt/B10jm5zBG/n4rV6lgRwTRGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754160047; c=relaxed/simple;
	bh=Z27sfXnXbvQ1AWQ6c0wI4iw8shpPvc9WVGaI1hBjGUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfwNgcREfBWBYusuKPztTaAB+cDlcryEm/w/iTgbCh/XjAHKdh0FhJTKThOc2m1mLS5x9eP7Qm7bY49Qgs4rCXUSa+Hw2XMaZ1BxO9d0UdRGhoIQyNF8jlYBhDdURL151q4Z3PHqUdGCQo1ZaPcsiu6CbCfd5Y1B1kLsfVOAezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hKkuPxSy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hKkuPxSy"
Received: (qmail 13696 invoked by uid 109); 2 Aug 2025 18:40:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Z27sfXnXbvQ1AWQ6c0wI4iw8shpPvc9WVGaI1hBjGUY=; b=hKkuPxSyI+yzXwyLusW42VnbOJ8VdfI3GVPZQhQevUYVQS5WaRpMaFGmajc/LPnwYo3XP7Q5I/TeGMt8hWA6B8Kjycu4+NWyP7gLd+Br0yXjjLoWH8pa/Nscz43u8NvgYKN+/CBwOWupQhnqlUJUG11NXMv5zUCWTykA0qD5l5PXEh5GROiT3AQ8rbhZEyyHE10yKXoLPFXL4cUf/wLN784v5sGVHMcW3z0yGkv6tupEzFiFiflvmvnmRx1lMdCj4v4AjVLC0qsCZ/IQtzBaAY/rSA+qZDnJBQdddPahBtp1FvRUGZXZRcqACOrtKZs1Y/ap4ftL7UZAI1XEkIVhlA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 18:40:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19237 invoked by uid 111); 2 Aug 2025 18:40:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 14:40:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 14:40:44 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 02/11] clean: do not pass strbuf by value
Message-ID: <20250802184044.GC1773585@coredump.intra.peff.net>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
 <20250731225433.4028872-3-gitster@pobox.com>
 <20250802083846.GC3711639@coredump.intra.peff.net>
 <xmqqtt2pisg0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtt2pisg0.fsf@gitster.g>

On Sat, Aug 02, 2025 at 09:44:47AM -0700, Junio C Hamano wrote:

> > I dunno. Maybe it is nitpicking, but I think "don't take a strbuf if you
> > only need a string" is a good general rule. Of course there is only one
> > caller here, so flexibility is probably not that important.
> 
> But I think we engrave both lessons in the history by keeping this
> step as-is, do the string_list_split_in_place_f() thing, and then
> add a new patch to pass just the .buf member to parse_choice().

I would certainly be happy with that.

The other strbuf-by-value in write_worktree_linking_files() could also
just turn into a "const char *".

-Peff
