Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AA2CAB
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260582; cv=none; b=tB+PrpQdGREdmS9yKG+UsyXy84Dy1b8X+pKBYDOdWJkvNkdsTBPws5knvr0HHPJk1ZvdtOeACZa4rXKry5ndEEdIZgw4yWkEFpoF5w4Hd+eDqHvSYZ1yDUxv9eNiYLNmyMuffEx3RWDa01ZGpG1s027juhmy8DGk1K3zkANOcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260582; c=relaxed/simple;
	bh=STwpaxy69EzM9HulW0NFJ1rPTHygzIav4cWUopGYjvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl6hy48gVohL+h49BSr8WWnRSwzf7OroZsCvP2eT6BjyGV61zgz6cIzZDyVnOZ/XQ+pNPRUxTAp9kJEbuM1z1RJ/j+PGNAknPcohRGugsiLiN2yhfIExeSMVDsV4JJr299/CpR8lEmcztIxdCFjbJA/OoLybsPkBQlnmmZMijVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OyBCgyXP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OyBCgyXP"
Received: (qmail 26290 invoked by uid 109); 18 Mar 2025 01:16:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=STwpaxy69EzM9HulW0NFJ1rPTHygzIav4cWUopGYjvc=; b=OyBCgyXPJrO7WwKFcBwBl74tuyUDXVSc8EC9pJd8KZCe6wWTy6V/90Bq41n1gxtQis3L+0B7pfj1gA1Q4+NmD/DApVwr3Brpv/CuLl/FvRVPtq661XINsAbxaY1JWxy/pH2m78VBwbcYR1aS20AK/QqF0QQrEHh1fS9eUh6kpjlE1tTjCdVyNzpM4jR4iklmfbP1ahV80dZNJToAcZbadz2hr399PgAoBJafR9V3UMN3oZZrDZgd6JbKFxE5W0JcPKFgwgq3dQfLqDG6NgHUDf/m6mLftwHIQOmdAFjCBDn0c0KBywb0sHkFB9p9sw9jvzCMRWmKWiVjWb8l29hpAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 01:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2902 invoked by uid 111); 18 Mar 2025 01:16:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 21:16:19 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 21:16:18 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <20250318011618.GA1471939@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f565f2fff166bdf4bb2505f4a8853215a5365b17.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f565f2fff166bdf4bb2505f4a8853215a5365b17.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:20PM -0400, Taylor Blau wrote:

> +In the incremental MIDX design, we extend this definition to include
> +objects from multiple layers of the MIDX chain. The pseudo-pack order
> +for incremental MIDXs is determined by concatenating the pseudo-pack
> +ordering for each layer of the MIDX chain in order. Formally two objects
> +`o1` and `o2` are compared as follows:
> +
> +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
> +  `o1` is considered less than `o2`.
> +
> +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
> +   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
> +   preferred and the other is not, then the preferred one sorts first. If
> +   there is a base layer (i.e. the MIDX layer is not the first layer in
> +   the chain), then if `pack(o1)` appears earlier in that MIDX layer's
> +   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
> +   appears earlier, than the opposite is true.
> +
> +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
> +   same MIDX layer. Sort `o1` and `o2` by their offset within their
> +   containing packfile.

OK, I think this ordering makes sense. I had to read this description
over several times to make sure I wasn't missing something. The earlier
part that says "it's just concatenating the pack order of the layers" is
a much more intuitive way of looking at it (modulo that you might need
to remove duplicates found in earlier layers).

But I think an even more basic way of thinking about it is that it's the
same as the pseudo-pack order you would get if you had a single midx of
all of the packs in all of the layers (in their layer order). We already
have to deal with (and have documented) duplicates in that case.

Not really suggesting any wording change here, just making sure I
grokked it all.

> +Note that the preferred pack is a property of the MIDX chain, not the
> +individual layers themselves. Fundamentally we could introduce a
> +per-layer preferred pack, but this is less relevant now that we can
> +perform multi-pack reuse across the set of packs in a MIDX.

Calling this out explicitly is good, since it's an obvious question
for somebody to have.

> +=== Reachability bitmaps and incremental MIDXs
> +
> +Each layer of an incremental MIDX chain may have its objects (and the
> +objects from any previous layer in the same MIDX chain) represented in
> +its own `*.bitmap` file.
> +
> +The structure of a `*.bitmap` file belonging to an incremental MIDX
> +chain is identical to that of a non-incremental MIDX bitmap, or a
> +classic single-pack bitmap. Since objects are added to the end of the
> +incremental MIDX's pseudo-pack order (see: above), it is possible to
> +extend a bitmap when appending to the end of a MIDX chain.
> +
> +(Note: it is possible likewise to compress a contiguous sequence of MIDX
> +incremental layers, and their `*.bitmap`(s) into a single layer and
> +`*.bitmap`, but this is not yet implemented.)
> +
> +The object positions used are global within the pseudo-pack order, so
> +subsequent layers will have, for example, `m->num_objects_in_base`
> +number of `0` bits in each of their four type bitmaps. This follows from
> +the fact that we only write type bitmap entries for objects present in
> +the layer immediately corresponding to the bitmap).

OK, so each layer's bitmap does depend on the layers above/before it.
That obviously needs to happen because each incremental midx is not
likely to be a complete reachability set anyway.

But I also wondered what would happen with a situation like this:

  A -- B
   \
    -- C

stored like this:

  base midx:
    - pack 1:
      - object A
      - object B, which can reach A
  incremental midx:
    - pack 2:
      - object A
      - object C, which can reach A

That is, two objects B and C both depend on A, which is duplicated in
two midx layers. Even if the incremental midx is complete in the sense
that C only depends on A, its bitmap cannot just be "11". Because the
bit position for object A in the incremental midx does not exist in the
pseudo-pack order at all! It must refer to the copy of "A" in the base
midx, so it's correct bitmap is "101" (A and C, but not B).

Again, just talking through it here.

> +Note also that only the bitmap pertaining to the most recent layer in an
> +incremental MIDX chain is used to store reachability information about
> +the interesting and uninteresting objects in a reachability query.
> +Earlier bitmap layers are only used to look up commit and pseudo-merge
> +bitmaps from that layer, as well as the type-level bitmaps for objects
> +in that layer.

I'm not quite sure what this means, but I guess you're saying that
internally as we produce a bitmap, we'll always use the complete bitmap
over all of the layers?

> +To simplify the implementation, type-level bitmaps are iterated
> +simultaneously, and their results are OR'd together to avoid recursively
> +calling internal bitmap functions.

OK, I guess we'll see what this means in the patches. ;)

The general rules for the data structure make sense to me, though.

-Peff
