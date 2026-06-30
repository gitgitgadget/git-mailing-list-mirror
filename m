Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537C3016E0
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782797558; cv=none; b=ph9SVzEFmhVg74fs2KSXGzT5WuOWh50DNTlTrVfi06ijijEHEQlsrJuClMHXzIqifWLlNGRJg0igUmDRd324DSpGvE83GYdItMU0VpoXfg2jdSQGPxJJcIxTqk+3tjrSfR8/cmGbr8OQSQ0Gls6nhaHfFbgAqMHHQPtdBKtlZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782797558; c=relaxed/simple;
	bh=fbLMWjUMK1AgAYBYHivVwVGvtjy1e/LKhqm9qjeMmLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBH7erpTRPJHMl7ZPOmNCCz4+87Ys+w0R9cdTkla9hev86i3fDEuerl60xVm2V3/qIGacgvd1QlNZcVbxXE7MIcT7ozd4rUAAMqiw7ZxU4VzinAISCKnllHXfPG8NuRLBhM9vgguqAGS1oOuiZrtbKYH4y8QtD+IY3yP9ROob/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Npjxv0oc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Npjxv0oc"
Received: (qmail 69664 invoked by uid 106); 30 Jun 2026 05:32:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fbLMWjUMK1AgAYBYHivVwVGvtjy1e/LKhqm9qjeMmLQ=; b=Npjxv0ocAX88MjYYaLhGkqc+9CxEcssP9roz7txEZDkQBxfRLqbuHbfcUVwgkI20SvycKno22O29a0OcMDAKW0BCY6ArMcSLbQGzR42EZXplhWpTOJSIAlzcDqhikyTaOaJ6ls6uDW4UTYkOxfKUG/PtUmtEgJsySJVj5+F0/eww5GnWnhhqMBkb+U2o54/09pPj7VUExRQI8b9woiBPH0EcDDpCJr7bnu93oAX1uTn3rRYJVdAPoUNCjpaIs/tFx3N558LWXJ+IVwEUZHR1xPuDUieuoWh4ZcDc/tNx3kapuBnffKUDqRtfzFj4IBI1VGyHP3ckqCBJRPGmXZIzRA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 05:32:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140828 invoked by uid 111); 30 Jun 2026 05:32:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 01:32:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 01:32:35 -0400
From: Jeff King <peff@peff.net>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: Re: [RFC] clone: allow sparse-checkout paths to be specified during
 clone
Message-ID: <20260630053235.GB2495216@coredump.intra.peff.net>
References: <CALE2CrTVVQF4rGhGG-9kmjweFHHYw+xnPU6Jtt=QmHpq7L6P2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALE2CrTVVQF4rGhGG-9kmjweFHHYw+xnPU6Jtt=QmHpq7L6P2w@mail.gmail.com>

On Mon, Jun 22, 2026 at 05:05:06PM +0530, Pushkar Singh wrote:

> Currently, the workflow for this is:
> 
>     git clone --sparse <repo>
>     cd <repo>
>     git sparse-checkout set <paths>
> 
> While this works as intended, it feels somewhat cumbersome, especially
> for someone who is new to Git or not familiar with sparse-checkout
> workflows.
> 
> Personally, I do not think of the problem as:
>     "I need to initialize sparse-checkout and then configure pathspecs."
> 
> Instead, I usually think:
>     "I only want to clone these directories from the repository."
> 
> With that in mind, I was wondering if it would make sense to allow
> sparse-checkout patterns to be specified directly during clone.

I haven't ever really used sparse-checkout, so I don't have much of an
opinion. IIRC the sparseness is contained in a patterns file, so I'd
have expected the first level of fix to be "you can provide that file at
clone time, rather than afterwards". But maybe nobody really touches
that file manually, and they just use the sparse-checkout helper. Like I
said, I don't have any experience. :)

You might try cc-ing folks who worked on sparse checkouts, especially
Stolee.

One final thought from a non-sparse-checkout user: you're coming at it
from the point of view of ergonomics (it is annoying to clone and then
set up sparsity separately) but there is also a performance question. If
the clone knows which paths are of interest, would that make it possible
to request a partial clone of the specific paths?

I think probably not in practice, because most servers have path-based
filters disabled (because they're expensive and work against bitmaps).
So the strategy is usually more like "don't ask for any blobs at all,
and then let checkout lazy-load them as we increase the sparse
checkout". But I'm also not really a partial-clone user, either. ;)

-Peff
