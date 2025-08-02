Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14213AA2F
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131699; cv=none; b=HSVWiaiYeBkXqhc/EO2ufu4JxniC5RhWK5J923DF5XMD0Vw4xFZEQvha851Wf1YeoM+jViA/bRu1tZG+AhueUFZp0Im9iex+YBLo6A/7v4Uo7+CzmXyp5Vv3V1xMiMGxgYQHyuYiC99KWC3O0X0Opj0djchaosya1fYBAVQ+CYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131699; c=relaxed/simple;
	bh=zu2irBrtIOicnxXCneVXSbm9oLqmScMxTdexHtLuMZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1VKdg3MEiMI53bjw3yFE/ENxMzkFXUO7qUgW47ZgLBo8bSeKxi9aJJlF3la3jF3aMbmhImIcUwTyj9thpII/tkp9f1aK3JWGwRpPMV5yu5nw0SelwCU5c/M/SXDNQIJ5E95gefAweSsPAkshADL612/wQPefKPC+gcrUQjsxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bONtM2QV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bONtM2QV"
Received: (qmail 9152 invoked by uid 109); 2 Aug 2025 10:48:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zu2irBrtIOicnxXCneVXSbm9oLqmScMxTdexHtLuMZw=; b=bONtM2QVmiIcWAG7ZIqdJhdWhRoDHsAMYXNje2BGGkaoQlzObzdYvX2n/VSG/ghCKo2bGcmAznoc2cyi+CZurRJcxh2cSqFIA+NykOaozSRbDqiJmXpGXqxr2X9p6BunV4hrkfxlPFOXZF4rjHG7+NV0w0KO08uAGAhqa7HrItHvphr4qPA4zd3QcIQwRbTHZTnQ2KfKnOjQ8pvlQOZdUOIin/8+di3bxN3RWVon83+8dOpLSUcPAp5ghDgbootC6vhN0og66NLdcC3VuSObBI6pUT46rGju+jNe1SRxUqqYNmaTgX9NPUGWzPAMPrdf+nHVtD9MFJCVSQGtZfmmsg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 10:48:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12757 invoked by uid 111); 2 Aug 2025 10:48:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 06:48:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 06:48:16 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
Message-ID: <20250802104816.GB1180347@coredump.intra.peff.net>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
 <20250729081658.GA1842689@coredump.intra.peff.net>
 <aIi9mAoAb1v9igQ6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIi9mAoAb1v9igQ6@pks.im>

On Tue, Jul 29, 2025 at 02:24:56PM +0200, Patrick Steinhardt wrote:

> > It's hard to bring myself to care, though. This is a stupidly
> > pathological reflog, and the absolute time change is peanuts compared to
> > the per-ref cost you're fixing here.
> 
> For the "files" backend performance is worse, for the "reftable" backend
> I'd expect that this might even be faster. Mostly because there is no
> way to trivially rename a reflog -- we basically do the same on a rename
> as we are doing with this patch series now.
> 
> Overall I don't care too much about this edge case. By default we never
> write reflogs for remote references anyway, and I doubt that you'll ever
> end up with a remote reflog that has thousands of entries. So I'd rather
> make the general case fast even if the esoteric case becomes slower.
> 
> But ideally we're able to lift such limitations in the future if we were
> to do the above rework.

OK. It looks like you did end up with a single transaction in your
re-roll. So in theory _if_ we had a "rename" transaction entry the
backends could be smarter here. But I agree with you that touching the
core of the ref transaction code is tricky and liable to cause
regressions. Given the numbers I produced earlier, I'm fine with leaving
it for later (or maybe never) and just copying the reflog entries as you
do in your series.

-Peff
