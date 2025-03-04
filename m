Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196677102
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072102; cv=none; b=Dc0XlEf3QjVlfoV8hVlDzm+d9RMfydZdAulJuUXKxvSbB1aLBoSGdhBpIjT9wVIXD0MRttjFTB6nvHrKP2D6KM1pFpzIpLG5ucOmnj55KlbVH54caBMlbeHkozAUtXBR+ml8JmZFaFp+LfqSjd/AoDHjAum1/wHreqsB+jW04qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072102; c=relaxed/simple;
	bh=YTmBsgimZ+4/N1WFOEC8VtYPwUEekAXu+DNMbnZsLow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkFooWRLEITwI7xburjXUcrQO9ArohXf6fIrEWBzXjzcZGzODJyoHYtCj2y44OA8JcrTrcwTPah8zeMtN+an2jrHHvDj0Z9gc0/r3DiBX6nNXOBJ6L/sQbrNc+C52a7bNr6KtkscBL03w1lyItvvdGO9FW/2Lr3c7BjfQN7PV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e+2zO3Jy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e+2zO3Jy"
Received: (qmail 9249 invoked by uid 109); 4 Mar 2025 07:08:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YTmBsgimZ+4/N1WFOEC8VtYPwUEekAXu+DNMbnZsLow=; b=e+2zO3JyYAGrIBWSqOZOL5ps53EBT+QR++0wgwrJnOFvFfrwLoKWdxRqUf1hJkMSlvhm24TyX24YHOrRWmekOQEW3AucGzmqmAWxTIo/5vFkaHGxyZYRwMtP+P9fpix3ulg9Wy6HR1en424/+U16CXWWJI7702FUmEz4z7zYBzvyb/vYYJK1f9r3Day/7qSjRTOAbDWD72tx7qU4B2wB2MNFCQopu1zo1ptDoB4yWgbRHj79UIAn4LwkRcyrS1qxqCJ3Gi2Lk9Q8qGisan8oxyFlszZXPK7jSSDMeApHn0RMc6seMUczbhwk/ARL4SMU/D/K3wJoIgSDHDfpoklQyA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 07:08:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22435 invoked by uid 111); 4 Mar 2025 07:08:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 02:08:19 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 02:08:18 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 05/10] git_inflate(): skip zlib_post_call() sanity check
 on Z_NEED_DICT
Message-ID: <20250304070818.GA1283943@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063026.GE1293961@coredump.intra.peff.net>
 <xmqqr03kg7mb.fsf@gitster.g>
 <Z8EDxd3f/U+EdoLO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8EDxd3f/U+EdoLO@nand.local>

On Thu, Feb 27, 2025 at 07:31:01PM -0500, Taylor Blau wrote:

> It's been a few weeks since I last looked at this patch, but I have a
> vague recollection that we chose the second approach while discussing
> this together.
> 
> And indeed, looking at the copy I have from that session, it looks like
> we did
> 
> --- 8< ---
> diff --git a/git-zlib.c b/git-zlib.c
> index 651dd9e07c..265d3074e1 100644
> --- a/git-zlib.c
> +++ b/git-zlib.c
> @@ -122,6 +122,8 @@ int git_inflate(git_zstream *strm, int flush)
>                                  ? 0 : flush);
>                 if (status == Z_MEM_ERROR)
>                         die("inflate: out of memory");
> +               if (status == Z_NEED_DICT)
> +                       break;
>                 zlib_post_call(strm);
> 
>                 /*
> --- >8 ---
> 
> I actually have a vague preference towards that approach, since I too do
> not anticipate that we'd ever need/want to support Z_NEED_DICT (and if
> we did, we could always change from option (2) to (3) later on).
> Likewise, the resulting diff is considerably smaller by line count,
> though on the other hand this diff is not all that more complicated
> overall.

Yes, that was definitely the patch we initially wrote. And I do agree
that it's pretty unlikely that we'd use Z_NEED_DICT ever. But what I
really disliked is that it leaves the git_zstream in a totally broken
state, unsynced with the underlying z_stream.

If the caller takes it as a hard error and immediately throws away the
stream that's not too bad. Although even then it gets a little weird: we
have to call git_inflated_end(), which itself does the usual zlib
pre/post calls. The "pre" call overwrites the zstream with old values,
which zlib's inflateEnd() then operates on.

It seems to be OK in practice, but we are making assumptions about which
parts of the struct zlib cares about. I guess it's unlikely that
unexpectedly rewinding total_in would cause zlib to misbehave, but it's
probably better not to be too intimate with it.

And of course if somebody ever does want to play with Z_NEED_DICT, it's
a bit of a booby trap we've left for them. We know today that they will
need to change from option (2) to (3), but in that hypothetical future
they will have to first figure out why their z_stream is corrupted. ;)

-Peff
