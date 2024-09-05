Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D419D895
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550881; cv=none; b=r2pkvDhj3ECd0czn461gzp1xIi4v4ctUTidGqejK8GAErSAf3Lwjx4WlDZFsP0+l4CZkDT8qAoA9EzFR7lNR/FYnl4foDN5yaRdVsrRi+1DBmTgXm5GL0KvGT3ec3zJj/so+T8EMyKxwObYYVK3HRtxelYd4Y+eThKb7Y/hhQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550881; c=relaxed/simple;
	bh=e5zZsMzVK0B2oS9o+Xgk75sa4VzMfWPqiUsO5jXwTyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsDQNS1sIcbkWyaHaq62Ejs1Cj5Hq5oayXwfh4FbRLArNme9DFbM72dnugXDwA42Y7RCcjDFedENud2oOYqIO6UWCET3O5+SVreGiT0Wyy+qYLf670vMxNdKIAErQLoLwayT85xiXdH0wmyo3zDigoK3OaCwQtLluV8WcWPGgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TBJp2lZt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBJp2lZt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EE2A2BDDD;
	Thu,  5 Sep 2024 11:41:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e5zZsMzVK0B2oS9o+Xgk75sa4VzMfWPqiUsO5j
	XwTyo=; b=TBJp2lZtliZkqCM8Llvw7YX9OnEnUUHpwnpabyBvO3ydnxm3NWb8/v
	6YonH1Pvldd2VMQBacNsY054uYs+pwpwjwXIDotf0+PlvM7CsMx4U8XFn9H7l5Pq
	+uI2Pl33JSP87SNFCqstcEQVKga3aMteYPLpTK0scOJzvpQ+lZDxI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36C872BDDC;
	Thu,  5 Sep 2024 11:41:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99F3F2BDDB;
	Thu,  5 Sep 2024 11:41:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <20240905103736.GC2556395@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Sep 2024 06:37:36 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
	<Ztdn25zfi8WHO+GS@nand.local>
	<20240905103736.GC2556395@coredump.intra.peff.net>
Date: Thu, 05 Sep 2024 08:41:16 -0700
Message-ID: <xmqq34me5crn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A8B7F60-6B9D-11EF-9B44-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Probably the solution is:
>
>   - renaming packfiles into place should use finalize_object_file() to
>     avoid collisions.  That happens for tmp-objdir migration already,
>     but we should do it more directly in index-pack (and maybe even
>     pack-objects). And possibly we should implement an actual
>     byte-for-byte comparison if we think we saw a collision, rather than
>     just assuming that the write was effectively a noopi (see the FIXME
>     in that function). That becomes more important if the checksum gets
>     more likely to collide accidentally (we essentially ignore the
>     possibility that sha1 would ever do so).

Yes.  I somehow mistakenly thought that Taylor analized the code
path when brian raised the "we rename over, overwriting existing
files" and I included fixing it as one of the steps necessary to
safely switch the tail sum to weaker and faster hash, but after
reading the thread again, it seems that I was hallucinating X-<.
This needs to be corrected.

>   - possibly object_creation_mode should have a more strict setting that
>     refuses to fall back to renames. Or alternatively, we should do our
>     own check for existence when falling back to a rename() in
>     finalize_object_file().

True, too.

>   - at some moment we will have moved pack-XYZ.pack into place, but not
>     yet the matching idx. So we'll have the old idx and the new pack. An
>     object lookup at that moment could cause us to find the object using
>     the old idx, but then get the data out of the new pack file,
>     replacing real data with the attacker's data. It's a pretty small
>     window, but probably possible with enough simultaneous reading
>     processes. Not something you'd probably want to spend $40k
>     generating a collision for, but if we used a weak enough checksum,
>     then attempts become cheap.

This reminds me why we changed the hash we use to name packfiles; we
used to use "hash of sorted object names contained in the pack", but
that would mean a (forced) repack of a sole pack of a fully packed
repository can create a packfile with contents and object layout
different from the original but with the same name, creating this
exact race to yourself without involving any evil attacker.  We of
course use the hash of the actual pack data stream these days, and
that would avoid this problem. 

It is funny to compare this with the reason why we switched how we
name individual objects in a very early part in the history.  We
used to name an object after the hash value of _compressed_ object
header plus payload, but that obviously means different compression
level (or improvement of the compressor implementation) would give
different names to the same contents, and that is why we swapped the
order to use the hash value of the object header plus payload before
compression.  Of course, that _requires_ us to avoid overwriting an
existing file to foil collision attack.  That brings us back to the
topic here ;-).

> So I think we really do need to address this to prefer local data. At
> which point it should be safe to use a much weaker checksum. But IMHO it
> is still worth having a "fast" SHA1. Even if the future is SHA256 repos
> or xxHash pack trailers, older clients will still use SHA1.

Yup. 100% agreed.

Thanks.
