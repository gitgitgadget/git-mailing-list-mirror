Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9026126C05
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181854; cv=none; b=NQepu464/pGezh/Xxr68Vq8ywUvVyWaFQqdOdv5LQtj3kAk/kH17WDMZgG9qt/5WuIS+qe31Lj3DOECDkkEGREbmxMrOnWp7o4FHGQMJUJgL6U3yOQQNbJjSRBoL8h8rg/XJponm2uxp2L4YAM966HFpmC7xjmx51C6lj/3a4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181854; c=relaxed/simple;
	bh=FcgikA9M7Kzjw1ZygDbA++BBhKoMmd1OpSjF1J8OfGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSYNMde7viWoR4cESxl/ARuJEbBqNaFrBlRCV2aS0Xse1JSqExFQ0X7P92p4d0uPAeB67MD++Cifi61vFJlWeqUd8tC233OjkZBRVC7onMOc61jU5usu+Iy409XJ4FupZ/0m904COHQWoFRT+zKp+bVcPMebtsdMrrTSHX9Zf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HC2qX40F; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HC2qX40F"
Received: (qmail 30467 invoked by uid 109); 21 Nov 2024 09:37:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FcgikA9M7Kzjw1ZygDbA++BBhKoMmd1OpSjF1J8OfGY=; b=HC2qX40FybnYKqKUEUSM7lhTWCBGxDBwLvhcRf1x2Lgh1pegmU9jy3567mrthOK1vX4CyJB/oMvkF3BEwx+ATFAiLVftnxGDsBymn+4m3Og36aj7PGMKWo5NpZUDMtGeGoKIjAcWErXIWtzVKFT0luw66bIEM9za6A2+gzasySpExO9Q6l7Zz4kOaAjNcr+JDZOevkDOyOfTrMSzc4Pn17Bg2esQkKZ/nK3lMD7Th9z8GV7TVDlkQKFEyFSDffdV0xR8PgnicSMW8GvjgUjzs/vAgVUbPpv7J/2rOaXnZQ3RtNO7cXfOCTc6Dz7qzSLsRtuGa8qS/5WTTCf9cVp5Pg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 09:37:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22706 invoked by uid 111); 21 Nov 2024 09:37:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 04:37:36 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 04:37:31 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/6] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <20241121093731.GD602681@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>

On Wed, Nov 20, 2024 at 02:13:50PM -0500, Taylor Blau wrote:

> +static const struct git_hash_algo sha1_unsafe_algo = {
> +	.name = "sha1",
> +	.format_id = GIT_SHA1_FORMAT_ID,
> +	.rawsz = GIT_SHA1_RAWSZ,
> +	.hexsz = GIT_SHA1_HEXSZ,
> +	.blksz = GIT_SHA1_BLKSZ,
> +	.init_fn = git_hash_sha1_init_unsafe,
> +	.clone_fn = git_hash_sha1_clone_unsafe,
> +	.update_fn = git_hash_sha1_update_unsafe,
> +	.final_fn = git_hash_sha1_final_unsafe,
> +	.final_oid_fn = git_hash_sha1_final_oid_unsafe,
> +	.empty_tree = &empty_tree_oid,
> +	.empty_blob = &empty_blob_oid,
> +	.null_oid = &null_oid_sha1,
> +};

All of the non-function fields here naturally must match the ones in the
parent algo struct, or chaos ensues. That's a little fragile, but it's
not like we're adding new algorithm variants a lot. The biggest risk, I
guess, would be adding a new field to git_hash_algo which defaults to
zero-initialization here. But again, there are only three total and they
are defined near each other here, so I don't think it's a big risk
overall.

I think this struct is a potential landmine for hash_algo_by_ptr():

  static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
  {
          return p - hash_algos;
  }

It's undefined behavior to pass in sha1_unsafe_algo to this function
(but the compiler would not complain since the types are the same). I
don't find it incredibly likely that somebody would want to do that on
an unsafe variant, but I'm not thrilled about leaving that wart for
somebody to find.

If we don't care about the speed of this function, then an
implementation like:

  for (i = 0; i < GIT_HASH_NALGOS; i++) {
	if (p == &hash_algos[i] || p == hash_algos[i]->unsafe)
		return i;
  }
  return GIT_HASH_UNKNOWN;

would work. I'm not sure if that would be measurable. I was surprised at
the number of places that hash_algo_by_ptr() is called. Many low-level
oid functions need it because we store the integer id there rather than
a direct pointer (so oidread(), oidclr(), oid_object_info_extended(),
and so on). But I'd also expect the loop above to be pretty fast. So I
dunno.

>  const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
>  	{
>  		.name = NULL,
> @@ -241,6 +257,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
>  		.unsafe_update_fn = git_hash_sha1_update_unsafe,
>  		.unsafe_final_fn = git_hash_sha1_final_unsafe,
>  		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
> +		.unsafe = &sha1_unsafe_algo,
>  		.empty_tree = &empty_tree_oid,
>  		.empty_blob = &empty_blob_oid,
>  		.null_oid = &null_oid_sha1,

OK, and we can leave the sha256 pointer zero-initialized, since the
function handles that at runtime. Good.

-Peff
