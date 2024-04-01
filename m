Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC554FA5
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007968; cv=none; b=BgnwQBJIW8jYQGubPUlLE5WyDwuM2BShZ9d1z6ltT4jVy3IQRf2J4xfxBqsSYZY5ITsY5HnWTNBW0d5g+7T8/Yb9g3H23dQ1nwaMJkW7Z45FYy/KELQcrZw1iBDNRZSJejv/kIQm+fE3lhmR6CtVe+gT8wZuwimxp4tzgJ7cf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007968; c=relaxed/simple;
	bh=l5gVZj23aGaDhOl6UsOLSS/yeX1Ax3PaLSSiKubDmZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRCNh/qY04h1J6l3U4tvpmXViBv6HW39B9fXPYepxbG2p5huzYpYigkAh3V+xEIbVcp4MVwWWT7Pk88UoTH80wKztpheehkpXherUVY1GcH4kw0+AiwanPrW5mCeXyqYQUESashMok96w2qIu2yhrCY1RY3TDGHTugvC8YsNNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RkEXrtUA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RkEXrtUA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E29622EF4;
	Mon,  1 Apr 2024 17:46:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=l5gVZj23aGaDhOl6UsOLSS/yeX1Ax3PaLSSiKu
	bDmZs=; b=RkEXrtUAHlks3DkyBxsMA+uxiKtRvW/C4fHQ7JLgsDNc5aXDKfEREn
	8RgQJ+f5SSpO9XIq5o8FIlhjcCulho0m+GoogKxOjUg+MhnaZLaVll8HO9xhKXMn
	j+3zGW+X8vFrd9RPpZ0Un943DQSjK0uSZp1TRcEcWtKyG5AJ+jipQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 26AF322EF3;
	Mon,  1 Apr 2024 17:46:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90EC122EEE;
	Mon,  1 Apr 2024 17:46:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>
Subject: Re: [PATCH v2 4/4] midx-write.c: use `--stdin-packs` when repacking
In-Reply-To: <b5d6ba5802aef6ddf1542f1b0efffe43c22436ba.1712006190.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 1 Apr 2024 17:16:44 -0400")
References: <cover.1711387439.git.me@ttaylorr.com>
	<cover.1712006190.git.me@ttaylorr.com>
	<b5d6ba5802aef6ddf1542f1b0efffe43c22436ba.1712006190.git.me@ttaylorr.com>
Date: Mon, 01 Apr 2024 14:45:59 -0700
Message-ID: <xmqqbk6s92p4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B8C1D00-F071-11EE-9BA2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> When constructing a new pack `git multi-pack-index repack` provides a
> list of objects which is the union of objects in all MIDX'd packs which
> were "included" in the repack.
>
> Though correct, this typically yields a poorly structured pack, since
> providing the objects list over stdin does not give pack-objects a
> chance to discover the namehash values for each object, leading to
> sub-optimal delta selection.
>
> We can use `--stdin-packs` instead, which has a couple of benefits:
>
>   - it does a supplemental walk over objects in the supplied list of
>     packs to discover their namehash, leading to higher-quality delta
>     selection
>
>   - it requires us to list far less data over stdin; instead of listing
>     each object in the resulting pack, we need only list the
>     constituent packs from which those objects were selected in the MIDX
>
> Of course, this comes at a slight cost: though we save time on listing
> packs versus objects over stdin[^1] (around ~650 milliseconds), we add a
> non-trivial amount of time walking over the given objects in order to
> find better deltas.
>
> In general, this is likely to more closely match the user's expectations
> (i.e. that packs generated via `git multi-pack-index repack` are written
> with high-quality deltas). But if not, we can always introduce a new
> option in pack-objects to disable the supplemental object walk, which
> would yield a pure CPU-time savings, at the cost of the on-disk size of
> the resulting pack.
>
> [^1]: In a patched version of Git that doesn't perform the supplemental
>   object walk in `pack-objects --stdin-packs`, we save around ~650ms
>   (from 5.968 to 5.325 seconds) when running `git multi-pack-index
>   repack --batch-size=0` on git.git with all objects packed, and all
>   packs in a MIDX.

There are some measures in the mind of readers' who have read the
explanation so far.

 - So, this gives us a resulting pack with better delta selection.
   How much better would it get in a sample repository?  10%?  40%?

 - Of course, the better delta selection comes with cost.  How much
   more time do we spend?  20%?  150%?

 - As we do not enumerate all the object names, we save some time.
   Around 0.65 seconds in a sample repository.

I think among the three, the first two are more interesting numbers,
no?

I wonder if we can leverage the trick that reuses existing packdata
when we stream packs to feed the "git fetch" clients---we rely on
the fact that existing packs are tightly packed with good delta
selection, and using bitmap stream contiguous section(s) as much as
possible without disturbing the existing delta chain.  Wouldn't the
"we have many packs, let's repack them into one" workload benefit
the same way?

> -	strvec_push(&cmd.args, "pack-objects");
> +	strvec_pushl(&cmd.args, "pack-objects", "--stdin-packs", "--non-empty",
> +		     NULL);
>  
>  	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
>  
> @@ -1498,16 +1499,15 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
>  	}
>  
>  	cmd_in = xfdopen(cmd.in, "w");
> -
> -	for (i = 0; i < m->num_objects; i++) {
> -		struct object_id oid;
> -		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
> -
> -		if (!include_pack[pack_int_id])
> +	for (i = 0; i < m->num_packs; i++) {
> +		struct packed_git *p = m->packs[i];
> +		if (!p)
>  			continue;
>  
> -		nth_midxed_object_oid(&oid, m, i);
> -		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
> +		if (include_pack[i])
> +			fprintf(cmd_in, "%s\n", pack_basename(p));
> +		else
> +			fprintf(cmd_in, "^%s\n", pack_basename(p));
>  	}
>  	fclose(cmd_in);

Looking very straight-forward.  Will queue.

Thanks.
