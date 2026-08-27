Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9852DE70D
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810786; cv=none; b=gPR5R7ZHsDpIoI5jZMRj2CWzrNfD4UtY5Vkk/FqNsi5yynrFO6W8njdI5lzivc6qLViBbhaKDciQLwAf9DzIrwO2RoIG66XCbzbFYLlIiy6Jc82zfL0VPics4yl351qFb1nop0NUjzjtQFSnhXuAiSxGM8x2KQTrwNawvqwW7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810786; c=relaxed/simple;
	bh=MHjEEZ4OKbz6Ima3BNb+19bpdLi3lljWNhuCO3qIPPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZA9OUMjYV/P17d9W4ty8NZHvzXAx0Qrfrjw0egz76o87IubwTtK0sHo13bEVl2BmisPt5f9ufTMAShbaI6u3XELF9V0k173fyexoluXVg/9adSCuUpMtJ1PXn8ngTFb6vdOHNyfwNMB0lw7AvyXx5ah+3eDjBk6+qBEbmHUVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Vmj8Zpg+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Vmj8Zpg+"
Received: (qmail 7721 invoked by uid 106); 27 Aug 2026 06:06:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MHjEEZ4OKbz6Ima3BNb+19bpdLi3lljWNhuCO3qIPPU=; b=Vmj8Zpg+1Lf4J6lvu6DF7qNQM3wG039zgpALsXg9Tpf9P49fsellY14htR7zCQrV0zNOV4YDNWyEN/flpVlatmD1XVGrPSXL2hzzGBSgwl6OEiwyboDfhXwH+mZ0x0kB+AaLCh2U+u/iRqpJcQkpkP64+vO6hsJ13TJGlZPSOy6O39PIEhgxjwPI+0G/r0lhufrtC9AwC3fBLpj5/4OSS55G+mggRrXkkANMe17NEQDaIXOk4LGfJ+H/Eoe05/bznAY1yAF7o7v9PCnpwfUixn2yujeEyZwIO4OyhrRMuJEuC93hOyUDt8f1gP66PyON7HMRuH4vSRKwwYvZ++HOXA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2026 06:06:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38672 invoked by uid 111); 27 Aug 2026 06:06:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2026 02:06:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Aug 2026 02:06:22 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/4] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260827060622.GC189659@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
 <eacf6ba4b11e366466da18b7b668e65793c532a9.1787684429.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eacf6ba4b11e366466da18b7b668e65793c532a9.1787684429.git.gitgitgadget@gmail.com>

On Tue, Aug 25, 2026 at 07:00:29PM +0000, Elijah Newren via GitGitGadget wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 399acd0f22..30ad7d822c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1786,7 +1786,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
>  		struct multi_pack_index *m = get_multi_pack_index(files->packed);
>  		struct pack_entry e;
>  
> -		if (m && fill_midx_entry(m, oid, &e, NULL)) {
> +		if (m && fill_midx_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
>  			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
>  			if (want != -1)
>  				return want;

We've changed the return value semantics without changing the signature
(or name). So we need to make sure we adjust all callers, as here.
That's _probably_ OK in practice for such a specialized function. But we
could also rename it if we wanted to be paranoid (especially about
new callers added on parallel branches).

> +enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
> +				      const struct object_id *oid,
> +				      struct pack_entry *e,
> +				      struct packed_git **bad_pack)

OK, so this is our tri-state fix. Mostly looks as expected, though:

>  	if (prepare_midx_pack(m, pack_int_id))
> -		return 0;
> +		goto owner_unavailable;

I'd have expected just "return MIDX_FILL_OWNER_UNAVAILABLE" here. But
then, I'm not sure I buy the need for this stale_packs_detected stuff
from patch 3.

>  	p = m->packs[pack_int_id - m->num_packs_in_base];
>  
> -	/*
> -	* We are about to tell the caller where they can locate the
> -	* requested object.  We better make sure the packfile is
> -	* still here and can be accessed before supplying that
> -	* answer, as it may have been deleted since the MIDX was
> -	* loaded!
> -	*/
> +	/* Make sure the pack is still present before pointing at it. */
>  	if (!is_pack_valid(p))
> -		return 0;
> +		goto owner_unavailable;

This comment rewrite seems superfluous at best. Can we try to keep such
patch fluff to a minimum?

> +	/*
> +	 * Recovery for a concurrent-repack race: a stale MIDX may still name a
> +	 * vanished owning pack even though the object survives in another pack
> +	 * the same MIDX covers.  The regular fallback above skips MIDX-covered
> +	 * packs, and repreparing the on-disk pack set does not reload the
> +	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
> +	 *
> +	 * Do this only on the second read, by which point repreparing packs has
> +	 * already had a chance to find an object merely relocated into a new,
> +	 * uncovered pack; only a genuine hidden duplicate reaches here.
> +	 */
> +	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
> +	    (flags & OBJECT_INFO_SECOND_READ)) {
> +		struct multi_pack_index *m = store->midx;
> +		uint32_t i;
> +
> +		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
> +			struct packed_git *p;
> +
> +			if (prepare_midx_pack(m, i))
> +				continue;
> +			p = nth_midxed_pack(m, i);
> +			if (p && packfile_fill_entry(p, oid, e, bad_pack))
> +				return 1;
> +		}
> +	}

OK, and this is as-before but now gated on the SECOND_READ flag. As
expected in this revision.

-Peff
