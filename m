Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34688375ADE
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013456; cv=none; b=a1MT3BJqi/UwSzoNsomSg82f/Dy8BQNN/ZFBsoUYc6FhA2ATCxHXvkf3dAzxUMz+loltTXcNQ9yQgR21qjRqmF02GM1BxLfAvDgOiMVrWVjaX5RLJUL3Xpb2Pqk6s2VrNHLtXD0BCD1YPENj8lc/vspfCe9vKmoayzGBKxh4lTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013456; c=relaxed/simple;
	bh=p1EgP39RLgTvW5ymMvjvHcAs3ZIS/3hiWgOaBr0dBb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uat3hZ6kZhNLb64PDPdgVABtaSN4uxWetcRvbV4/nT7tGwTBIIzm6lQHAGu3H+EW/Q9e6snClv2XCeKXMmsf8qr7C9W4btHAxLKzT3Et0KQ4qZ339naKrtPQfPuQFEyUjmEFowdhTQ/WVw2GnFsOvBIZmReKrFt8sstxFYwW4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XoWjcjrc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XoWjcjrc"
Received: (qmail 21771 invoked by uid 106); 14 Jul 2026 07:17:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=p1EgP39RLgTvW5ymMvjvHcAs3ZIS/3hiWgOaBr0dBb8=; b=XoWjcjrc5wkwK9QuHtz0dP9RJhpuPo9Hgv2RGyn+XD0MI08N89OUb8DbAeCuZqNCwZxPsoh1ja9U18X77ry0C53lm0AAXCIUoME3TSQPDDQpTa3Nw8/OAW0u6aZose4VC/CB3js82kIDQ6aF44tqk3NKxCVDlpAse1kVOVXEitQc/49qmQk135sJj4rsNDl3QFTzrHCUmcV9ePCW5IprdQ1BYtmWk1PEDC1/gk8Z6KX9CW2qyZpJNIzwDlnH9wBENc9fgYlDS6DRWAQyH5lFWdjP6cQAv9am+lMYzomnWRP7eN6PVfXHIiA1ks5lXD+VRi/NLMaVi9MOdWF9nNP1jw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 07:17:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 42830 invoked by uid 111); 14 Jul 2026 07:17:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 03:17:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 03:17:33 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] pack-bitmap: allow aborting iteration of
 bitmapped objects
Message-ID: <20260714071733.GA4058320@coredump.intra.peff.net>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-3-3710a9cc165a@pks.im>
 <alFzja98avOoKjQE@com-79390>
 <20260711080114.GA1470749@coredump.intra.peff.net>
 <alS1rus9thie7NiE@pks.im>
 <alWz_gRs_D0Y0aOy@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alWz_gRs_D0Y0aOy@com-79390>

On Mon, Jul 13, 2026 at 08:58:54PM -0700, Taylor Blau wrote:

> > That's fair. But adapting `traverse_commit_list()` requires tons of
> > changes all over the tree, so I'm inclined to rather leave both
> > `traverse_bitmap_commit_list()` and `traverse_commit_list()` as-is.
> > Does that work for both of you?
> 
> I think that it's fine to leave it as-is for the purpose of this series,
> though I would like to address it.

Me too.

> I don't think we need to adapt `traverse_commit_list()`, though. We can
> go in the other direction Peff suggested, which would be to split the
> callback type used by `for_each_bitmapped_object()` from
> `show_reachable_fn`, keep the former abortable, and make the latter
> return void.
> 
> That keeps `traverse_bitmap_commit_list()` in sync with
> `traverse_commit_list()` without changing the non-bitmap traversal
> machinery. I have a small two-patch follow-up on top of v3 that does
> this, which I'll send separately.

That would be a nice cleanup if it's possible, but I wondered if you
would find that one or more of the callbacks actually rely on this abort
feature. Only one way to find out. :)

-Peff
