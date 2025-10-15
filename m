Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4A31C561
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524197; cv=none; b=tw8KDWtz1d46aM4HMU0rkVg3a9v7QBsZ/jzPV06I78hyS7Xd1ihKp+btn+Aoi7RCG49cgUAZVWMTELT1a1bXEg5MZ9un6/5VWoJKI3/flQRjB5hdk6mEJ91i5oFMSMlbEvv3tOxBmXran/Yt3twP1xZLcoMy2uxhd6xi9idvzpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524197; c=relaxed/simple;
	bh=Q2DYDNfaBP6VCQO37XdAaYse5bvrcxCcGWvkEfs0rc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCopojASAeJ0cLQ4b5GvfDQrLudMuewvbncGlEXCheRUQC7+EyTIMb7iSkkyvQVfIBEvjw7FJSkRUBDiZsLVMJ8cGJFb+v/XGKDNlr0WsAeznMWaOHkLkQ2FBOpp3qxhBCuthf6dn/Yb1Ba6mwrPT9aCzb2WC9L74mhvvwzSvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V2250Wd3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V2250Wd3"
Received: (qmail 226750 invoked by uid 109); 15 Oct 2025 10:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Q2DYDNfaBP6VCQO37XdAaYse5bvrcxCcGWvkEfs0rc4=; b=V2250Wd3dlAtuJK9jHLRjsr79fpjQE5X/DLJvzXgL3wWzViXOG8CpzCptxpvSCIONKiVYXadq7rg75qxg2VFtWxYlQR8vTi4isCaQp/HBC0ABzyIXBW8e7bgROYvsmTFvlqgZfqUjUswRWNFfd1xGy30Ov60IMpBic+mmWIE6Z95muOogNkp7UkhgLIo+QK6DijCDt6CU8sHifYN2oPlnKfEWwUQQuKAnheCs5BdgR/aT7nLn1kWbCFoQKHQ8X0sa1xGYJw0xLEc5TXAr8BJ/tN0NrotPlhCTv59VvbyxBkafR6WkDbsosZJcq26qFwvz7XVjXKixHc1KIyvYdvrLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Oct 2025 10:29:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 362969 invoked by uid 111); 15 Oct 2025 10:29:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Oct 2025 06:29:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Oct 2025 06:29:53 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 41/49] builtin/repack.c: use `write_pack_opts` within
 `write_cruft_pack()`
Message-ID: <20251015102953.GC2250228@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <7826afc17376f0d4a7f3169d9aafce21b3273ff5.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7826afc17376f0d4a7f3169d9aafce21b3273ff5.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:09:57PM -0400, Taylor Blau wrote:

> -static int write_cruft_pack(const struct pack_objects_args *args,
> -			    const char *destination,
> -			    const char *pack_prefix,
> +static int write_cruft_pack(struct write_pack_opts *opts,
>  			    const char *cruft_expiration,
>  			    unsigned long combine_cruft_below_size,
>  			    struct string_list *names,

Following on the comment from the previous commit, I guess with my
proposal we'd have to call find_pack_prefix() ourselves here in
write_cruft_pack().

OTOH, this call...

> @@ -599,6 +597,13 @@ int cmd_repack(int argc,
>  
>  	if (pack_everything & PACK_CRUFT) {
>  		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
> +		struct write_pack_opts opts = {
> +			.po_args = &cruft_po_args,
> +			.destination = packtmp,
> +			.pack_prefix = pack_prefix,
> +			.packtmp = packtmp,
> +			.packdir = packdir,
> +		};

...would go away, so I think it is net the same number of lines.

-Peff
