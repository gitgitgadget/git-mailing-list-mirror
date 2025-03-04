Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930301D7E35
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070020; cv=none; b=uMSjPm+92gHUDrfNeotR+Gzv8fjdG/Ir64nyd/kJwjw4p48H/690JB7r16/QB/DWwrUe0++INZeCgF1Q45QI7/qU6RIwHXGjJ7xi1nWQ1iGpflN/eVmyrZkkT7oe1/lLrYoKr9VaSeYL+uYdbcHPXlRyr/1+mg4bSLR4YH5J/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070020; c=relaxed/simple;
	bh=m5YvEnMRJuc2hzlMf54Q4p5JqhhGryJYeRbwaXUGJ40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgPzn9PtV+hN50wX4saf+z3EoiFesnnxdmxF9oO2uTYMd8ZdUBOHdZ1lDB9JWMvMItVSdZ7hJB7NzuHPqvV91jHfDgQ+cGuT8dRNAp/j49Jx5bw7JT4kxLM8/q8ngP8F+ortEAfrckByLCZ6bh0+3QzzFNcP6He4mdhSfDFIW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YKNHG7hX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YKNHG7hX"
Received: (qmail 9074 invoked by uid 109); 4 Mar 2025 06:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=m5YvEnMRJuc2hzlMf54Q4p5JqhhGryJYeRbwaXUGJ40=; b=YKNHG7hXwufy82ObTx1+pmKk130PCj54my1JDw9xa2LaM6w2BGfGTsR8k7eBSs+anHoVX1IGHtk1jCUbuxj90hoba+BoiGLmAKQSkhwfjLBc/RbcVX0yxxzRntYgDx20fknOYug1v5qspmMtsjJX+LGmLi1LG3cZ0tivAkNcA3/HWQbQXs3ehK8NVisJ2OhhpUhRv6/p3NvIDHLt3nPiUXqGr1VUCWHBoYJUZnXJAyjZucb0OSczTNVxprWI0El1Yqq9rI9Eze45OGCu+ms8GBRVKilR9QlVL2ZL5826rM7sz83eYjt8kHWztxbLWPL4Gkc6W49WMhrK56TguRc0bg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 06:33:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22072 invoked by uid 111); 4 Mar 2025 06:33:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 01:33:29 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 01:33:29 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, H Z <shiyuyuranzh@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: Subject: Memory Leak vulnerability in reftable/readwrite_test.c
Message-ID: <20250304063329.GA1283445@coredump.intra.peff.net>
References: <CAAJd+fZSUiiUm05D_eO3HS7p=WoxAWSZo51dUNjyGjUNJBvyGg@mail.gmail.com>
 <bca5c0ec-0995-421e-9745-330f729357d6@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bca5c0ec-0995-421e-9745-330f729357d6@web.de>

On Sat, Mar 01, 2025 at 12:31:33PM +0100, René Scharfe wrote:

> --- >8 ---
> Subject: [PATCH] reftable: release name on reftable_reader_new() error
> 
> If block_source_read_block() or parse_footer() fail, we leak the "name"
> member of struct reftable_reader in reftable_reader_new().  Release it.
> 
> Reported by: H Z <shiyuyuranzh@gmail.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  reftable/reader.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 3f2e4b2800..f38c83f140 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -666,6 +666,7 @@ int reftable_reader_new(struct reftable_reader **out,
>  	reftable_block_done(&footer);
>  	reftable_block_done(&header);
>  	if (err) {
> +		reftable_free(r->name);
>  		reftable_free(r);
>  		block_source_close(source);
>  	}

Coverity complains that "r" might be NULL here. At the top of the
function we do:

  REFTABLE_CALLOC_ARRAY(r, 1);
  if (!r) {
	err = REFTABLE_OUT_OF_MEMORY_ERROR;
	goto done;
  }

and then the done label hits your new line (the "done:" is right above
the context in your patch). And err of course is non-zero.

So this probably needs an "if (r)", or multiple layered out-labels.  Or
alternatively we could return directly when the first allocation fails,
since there is nothing to clean up at that point.

-Peff
