Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1B405F7
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911693; cv=none; b=CjmPipt+3O1ijrieAggm/0STLvFHPWJY+kfsfKP7g/7h7QiCVD+08qhUIT8oIAsNQ2RG6tybna1yc/wLOCo6N45h4aaNKh7DWnJNuOJsNpvW2QXIiqmBgHdTQFn59lqGqsIaQoc3B366zoNu6AzAvA1tbfj/sq3RZfK2ILCCgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911693; c=relaxed/simple;
	bh=BsoBUWQV8GW0LSoqnhjpGozMeyM/vd6xs0t/NY3lC3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw6Ich9T+LlimqmiNWFY4b7mF86IdG6aEMtIuztEtb5MUxWgAUPjY1GHyOHTpXnX7PSoS6vba0sLm//tbr23zxQt4uoEdaIPBmUzzzrM9M9hZ6yQkc9m53DzQmxk56pGBElpu+s/aW0pM39MYR1gJzuCBsSc3WmkzVlcsz8ISdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FW8cli/9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FW8cli/9"
Received: (qmail 199347 invoked by uid 106); 30 Mar 2026 23:01:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BsoBUWQV8GW0LSoqnhjpGozMeyM/vd6xs0t/NY3lC3Q=; b=FW8cli/9owhK8xxhfxqjeIYz6WKZLdOmzFrfxMTLb/enmJAM0WYNgts/OccGQMynDAxaBpTb8VMzwVkCvVgLXpA5DTglX6LOLD1THq+1KsR7E8AfH20UdhQFFBJH0IQ1F9YgYRYxRqTVSsThNx3ZCX7m5BaWZtwJB9b92Rv45b84nDB3qwhyDDmqD1YwJndf4YJMv4fmOOsL1SS7FmKcNuhcKzbteQ3nGB+hjfSpObPnnA0Wi7XywEBXNDsTYFUmUmUxpHT91yK/heic8NEyw8Dl7Q/uB/mGkzxGsPt4ZNDBAwHAVYYwNIvLV8VgHu2sdTxJRKPt5loHoRlL1WHCbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Mar 2026 23:01:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 306346 invoked by uid 111); 30 Mar 2026 23:01:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2026 19:01:31 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Mar 2026 19:01:30 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <20260330230130.GD41843@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:00PM -0400, Taylor Blau wrote:

> -	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
> +	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
>  
>  	if (ctx.incremental) {
>  		FILE *chainf = fdopen_lock_file(&lk, "w");
> @@ -1760,39 +1760,45 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  			for (i = 0; i < num_layers_before_from; i++) {
>  				uint32_t j = num_layers_before_from - i - 1;
>  
> -				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
> +				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
> +				keep_hashes.nr++;

Gross, we are just manipulating the innards of the strvec ourselves?

Is it really worth doing this (and adding init_alloc()) versus just:

  strvec_init(&keep_hashes);
  for (...)
	strvec_push(midx_get_checksum_hex(m));

? That's amortized linear-time, and it's not like the number of midx
layers is going to be large anyway.

>  				m = m->base_midx;
>  			}
>  
> -			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
> +			keep_hashes.v[i] = xstrdup(hash_to_hex_algop(midx_hash,
>  								   r->hash_algo));
> +			keep_hashes.nr++;

OK, this could be a push, too.

>  
>  			i = 0;
>  			for (m = ctx.m;
>  			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
>  			     m = m->base_midx) {
> -				keep_hashes[keep_hashes_nr - i - 1] =
> +				keep_hashes.v[keep_hashes_nr - i - 1] =
>  					xstrdup(midx_get_checksum_hex(m));
> +				keep_hashes.nr++;

But what is this? We're filling in from the back side of the array? I
mean...yeah, that's something that strvec_push() can't do. But I can't
help but feel like it might be simpler and more obvious to adjust the
iteration to build the array in order.

I dunno. Maybe that is hard to do. But if so, I question whether moving
to a strvec is worth it here, since we are not treating it as an opaque
type anymore. And it is not buying us much to use it (we get to pass one
parameter versus two, though that is easily solved with a struct, and we
get to use _clear() instead of our own free loop).

>  void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
> -				      char **keep_hashes,
> -				      uint32_t hashes_nr)
> +				      const struct strvec *keep_hashes)
>  {
>  	struct clear_midx_data data = {
> -		.keep = STRING_LIST_INIT_NODUP,
> +		.keep = STRING_LIST_INIT_DUP,
>  		.ext = ext,
>  	};
> -	uint32_t i;
>  
> -	for (i = 0; i < hashes_nr; i++)
> -		string_list_append(&data.keep,
> -				   xstrfmt("multi-pack-index-%s.%s",
> -					   keep_hashes[i], ext));
> -	string_list_sort(&data.keep);
> +	if (keep_hashes) {
> +		struct strbuf buf = STRBUF_INIT;
> +		for (size_t i = 0; i < keep_hashes->nr; i++) {
> +			strbuf_reset(&buf);
> +
> +			strbuf_addf(&buf, "multi-pack-index-%s.%s",
> +				    keep_hashes->v[i], ext);
> +			string_list_append(&data.keep, buf.buf);
> +		}
> +
> +		string_list_sort(&data.keep);
> +		strbuf_release(&buf);
> +	}

This hunk was unexpected. We move from xstrfmt() to a strbuf, but does
that have anything to do with the rest of the patch?

Also, I don't think using a strbuf really buys us anything. We are
reusing the strbuf for each format operation, but then we copy into the
string list anyway. So there is one allocation per loop iteration either
way.

Also also, the original was leaking the strings, right? The string_list
was initialized as NODUP, but we assigned allocate xstrfmt() results to
it. But because of the nodup, string_list_clear() won't free them.
It should have been:

  .keep = STRING_LIST_INIT_DUP,
  [...]
  string_list_append_nodup(&data.keep, xstfmrt(...));
  [...]
  string_list_clear(&data.keep);

in patch 2.

-Peff
