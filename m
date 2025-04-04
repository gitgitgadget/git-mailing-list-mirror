Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FD634
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800267; cv=none; b=qGosRpjBY9jJWcHD/r0kH9TAmJZfXCEPwl6mKuPLXrfMBR0Y5l+m8wpGbSbq+xDL9hDMcbYZrgyGpIQn5+tHUQLm/YS+hmVOp9nXBUQzGSouu0R2jITUlKa72GajBNHZ8IaI0G+jUZlw4Gj2WpgR1OHlrjcAqZRF2sFxZ04cYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800267; c=relaxed/simple;
	bh=/ramKFUUsy3a5EtywtGChKftMqSynyTnOZFnVvjQ8UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q17BhTnd9V8mwMY13EgD4sT+y57MWaaTdvKUz668+UWVOLqSOPq1C7RsylP49HHNoUlAi66Kv2DL1NedNz4YVqpQSCa+GumOCksZeljUztBGanbKJoRLmoho8VD2R/ibbv4DLmDJXeWgvxH5nGas2knbmiBOjcWA5cOkEWgqNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SLjl3FRx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SLjl3FRx"
Received: (qmail 504 invoked by uid 109); 4 Apr 2025 20:57:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=/ramKFUUsy3a5EtywtGChKftMqSynyTnOZFnVvjQ8UQ=; b=SLjl3FRx+2XDpCLwUuThMpsGHW2FTYfLA/7ai57jT0+k4S60hvEoSC2TPyKhFRXn1fep4iG+HKAu6Dwhwp4K7qmLvg9K/D05+BJ1sZTcYb5HcTHiZCM4ONc2B2+GJwKXnKAUcdLVhmmc5MdMT6d7Prj0EZlWfBXsiYijQS/C95jcXgDN6/rKdoFI9+Ekstmo/GwfxRKnfRR+neM4vUW+oR3MirWsuT45keCqqpQbasSXsYEnIL9XF2E6wVQIGtOo5VBprInwxM2jQOEBfsVZyb4oA/ZqRmucqh2yAfD9mLY8fehUN/SWC7fl6QAhi4BBjv4rocFOnwq67Y6UKQSqHg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Apr 2025 20:57:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10254 invoked by uid 111); 4 Apr 2025 20:57:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Apr 2025 16:57:40 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 4 Apr 2025 16:57:40 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] refs/packed: fix BUG when seeking refs with UTF-8
 characters
Message-ID: <20250404205740.GA780449@coredump.intra.peff.net>
References: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>

On Fri, Apr 04, 2025 at 12:58:38PM +0200, Patrick Steinhardt wrote:

> But in practice the check itself is misbehaving when handling unicode
> characters. The particular issue triggered with a branch that got the
> "shaved ice" unicode character in its name, which is composed of the
> bytes "0xEE 0x90 0xBF". The bug triggers when we compare the refname
> "refs/heads/<shaved-ice>" to something like "refs/heads/z", and it
> specifically hits when comparing the first byte, "0xEE".
> 
> The root cause is that the most-significant bit of 0xEE is set. The
> `refname` and `prefix` pointers that we use to compare bytes with one
> another are both pointers to signed characters. As such, when we
> dereference the 0xEE byte the result is a _negative_ value, and this
> value will of course compare smaller than "z".
> 
> We can see that this issue is avoided in `cmp_packed_refname()`, where
> we explicitly cast each byte to its unsigned form. Fix the bug by doing
> the same in `packed_ref_iterator_advance()`.

Ah, good catch. I think this signed-ness issue has come up before, long
ago, but I don't remember the context. In theory any stable ordering is
OK for sorting, but of course cmp_packed_refname() chose to use unsigned
in order to match strcmp(), and the standard defines it as interpreting
the bytes as unsigned. One of the enjoyable quirks of C.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index b4289a7d9ce..7e31904bd41 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -980,9 +980,9 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  			continue;
>  
>  		while (prefix && *prefix) {
> -			if (*refname < *prefix)
> +			if ((unsigned char)*refname < (unsigned char)*prefix)
>  				BUG("packed-refs backend yielded reference preceding its prefix");
> -			else if (*refname > *prefix)
> +			else if ((unsigned char)*refname > (unsigned char)*prefix)
>  				return ITER_DONE;
>  			prefix++;
>  			refname++;

The patch itself looks good to me.

> +test_expect_success 'list packed refs with unicode characters' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit --no-tag A &&
> +		git update-ref refs/heads/ HEAD &&
> +		git update-ref refs/heads/z HEAD &&

It's possible some filesystems might be unhappy with this character, but
I guess we can see if anybody screams.

> +		git pack-refs --all &&
> +		printf "%s commit\trefs/heads/z\n" $(git rev-parse HEAD) >expect &&
> +		git for-each-ref refs/heads/z >actual &&
> +		test_cmp expect actual

This loses the exit code of rev-parse, but IMHO that is not a big deal.
We'd notice the broken output when we call test_cmp. I don't know if
people who are eagerly hunting down missed exit codes might flag it,
though.

Thanks for the quick turnaround on this (and to Elijah for reporting).

-Peff
