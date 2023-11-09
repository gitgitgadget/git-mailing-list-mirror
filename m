Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF0374E3
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0925D3C07
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:27:27 -0800 (PST)
Received: (qmail 456 invoked by uid 109); 9 Nov 2023 21:27:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 21:27:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14249 invoked by uid 111); 9 Nov 2023 21:27:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 16:27:27 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 16:27:21 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] commit-graph: handle overflow in chunk_size checks
Message-ID: <20231109212721.GA2728242@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <20231109070948.GA2698043@coredump.intra.peff.net>
 <ZU1LbV0/ciDdO1aD@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU1LbV0/ciDdO1aD@nand.local>

On Thu, Nov 09, 2023 at 04:13:17PM -0500, Taylor Blau wrote:

> So everything in this patch makes sense and looks good to me. It does
> make me think about the pair_chunk_expect() function that I proposed
> elsewhere. I haven't yet read the rest of the series, so it may be a
> totally useless direction by the end of this series ;-).

Nope, it's not useless. But I do think it affects what we'd want the
interface to look like, and...

> But I wonder if the interface we want is something like:
> 
>     int pair_chunk_expect(struct chunkfile *cf, uint32_t chunk_id,
>                           const unsigned char **p,
>                           size_t record_size, size_t record_nr);
> 
> So we can then grab the size of the chunk, divide it by "record_size"
> and ensure that end up with "record_nr" as a result.

...this is exactly the direction I was thinking it would go. So if you
got to the same place after reading my explanation, then hopefully
something went right. ;)

-Peff
