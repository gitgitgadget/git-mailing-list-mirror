Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40728DF1F
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762490; cv=none; b=slx/67C+z5I6NlOuPs8gzu/57JkcRjbsm7BbDpsyDBc03SFWsXWj6HRa5cHXAI+iyJKwzmoKv6sps/E+YSVB/wPoaOEB1c8tSUJBKnlmg5/a9oFtAArGqpn1peB9/76RpvxnllRl4+HvXCkcgI83/8MM6FrYdDpyPtVnR/5Dc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762490; c=relaxed/simple;
	bh=HgwkbHsybO+hpeHiNYc3YCqciPKwWG6BxnleYht1b7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2AJhNR8wO5oqiFDEeSMOpNT35gJ66z3RbqI72XEGV6StF+hC62UPWApbix/yE/EjFX880n7mwMTg3PjbVSSqs7OKDvOWROodMxGhQj4gdQNxWGTFEibzcuAtoWc+tQlpJM2WLXhTFNaoyYq14WQIo1q8/R614qhokFcpFyUm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G9x8LXVV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G9x8LXVV"
Received: (qmail 17883 invoked by uid 109); 24 Jun 2025 10:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HgwkbHsybO+hpeHiNYc3YCqciPKwWG6BxnleYht1b7w=; b=G9x8LXVVGxxAupUEjYXT8LHJWRM+L6epzhC0sO3qPBTbPDT/K1wLEgEH2fIlHXLjeQfc5OBLsJ/htiXmYzg1DZTVyOcECwLebCLHykxI9Qb+y9iBISl3rku5rE7Ol/hH2kejDUEOocTBJ5T3/RNUKidqqpP+6O6oHH2dYS2EidZdc6xQDIDYBqAeY08pjQldFXKF68m1E5loL9M9xn48EoVNaU1hC81ANmxuJySrr5gh5JwFhxMSZ6AsflxNDwnHDngihvXxY+0HgP4ctEXXx6qdjfOTfyTDE/EELrBoh5fs8WTXSCNx+YRDACqSvsQXCIv+lJxkQh361yGHg7Y1CA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Jun 2025 10:54:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29827 invoked by uid 111); 24 Jun 2025 10:54:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Jun 2025 06:54:47 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Jun 2025 06:54:47 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 9/9] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <20250624105447.GA716990@coredump.intra.peff.net>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
 <6487001f64653d1434890df39b4c4937ea4d0b2c.1750375803.git.me@ttaylorr.com>
 <20250621043551.GA3002138@coredump.intra.peff.net>
 <aFmhQZZnYyvxDelO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFmhQZZnYyvxDelO@nand.local>

On Mon, Jun 23, 2025 at 02:47:29PM -0400, Taylor Blau wrote:

> > This test (but none of the others) fails when run with:
> >
> >   GIT_TEST_MULTI_PACK_INDEX=1 \
> >   GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1 \
> >   ./t7704-repack-cruft.sh
> >
> > The culprit is the incremental flag, but you need the first one for the
> > second to do anything. The issue is that the cruft pack unexpectedly
> > appears in the midx:
> >
> > [...]
> >
> > I'm not sure if it's just a funky interaction with the hacky GIT_TEST_*
> > variables, or if it's a real bug.
> 
> Thanks for spotting. This is definitely a real bug. The root cause here
> is that our loop to gather the set of packs we know are in the MIDX does
> not account for multi-layered / incremental MIDXs.
> 
> In our example, if there's a cruft pack in any other layer of a MIDX
> besides the tip, the proposed implementation here won't realize it, and
> thus (incorrectly) conclude that the cruft pack is not in the MIDX
> already, so can thusly be omitted.

Ah, right, that makes perfect sense.

> If we do this on top:
> 
> --- 8< ---
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 346d44fbcd..8d1540a0fd 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1614,13 +1614,16 @@ int cmd_repack(int argc,
>  	string_list_sort(&names);
> 
>  	if (get_local_multi_pack_index(the_repository)) {
> -		uint32_t i;
>  		struct multi_pack_index *m =
>  			get_local_multi_pack_index(the_repository);
> 
> -		ALLOC_ARRAY(midx_pack_names, m->num_packs);
> -		for (i = 0; i < m->num_packs; i++)
> -			midx_pack_names[midx_pack_names_nr++] = xstrdup(m->pack_names[i]);
> +		ALLOC_ARRAY(midx_pack_names,
> +			    m->num_packs + m->num_packs_in_base);
> +
> +		for (; m; m = m->base_midx)
> +			for (uint32_t i = 0; i < m->num_packs; i++)
> +				midx_pack_names[midx_pack_names_nr++] =
> +					xstrdup(m->pack_names[i]);
>  	}
> 
>  	close_object_store(the_repository->objects);
> --- >8 ---

And this fix looks reasonable to me. It is a bit unfortunate that the
incremental midx concept bleeds all the way out to callers like this,
because it means we might have the same problem in other spots. But that
is nothing new, and I'm not sure of a good solution. If the
public-facing API pretended as if "struct multi_pack_midx" contained the
packs for all of the sub-midx entries of the chain, that would solve it.
But then all of the internal parts of the code that look at the
incremental entries would need a separate representation. And I suspect
there's a lot more code in that latter group than the former (most
callers won't be this intimate with the midx, and just want to convert
an oid to a pack/offset pair).

Would we want a test to cover this case? We do catch it in the
linux-TEST-vars build, but it might be nice to have coverage in normal
test runs. I'm not sure how much of a pain that would be.

-Peff
