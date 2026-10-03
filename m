Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DBB33998
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790989643; cv=none; b=hWYWezMVeSA+ZBOGUmg3NIhyeEo0aE0UwK/ehNsOPWezRTS677Aeg9q+b19wKXg464CI4M9UO/AaGLkoUUJuaxmQB4UUIGAddab3nDDezU+VcaXi1pqcyjOLvow7gNnpGYzQgzjBJn4ZY2CsvGB4uALRbnBhtyJ6H0vFGjF3JJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790989643; c=relaxed/simple;
	bh=//KSQgCs96oL51UeA+dMdooZXLrmogCN/ByPosSBp30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3nGPewQOx9pOmt1hC7UE0RKG+/d4O8T9rRXOmnJW0mt8WzRp523Ukzzp3Ql2tM821N+2LzaNUYat+WZ6Q/fetjKEmZdHW+sW+1zYv84FsnT84yDAcRqCB36o891ywpisX347HitBwm1ipp/jBtAROyPcnGAIaSo42a5Mf+q9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WsqnyZQZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WsqnyZQZ"
Received: (qmail 17140 invoked by uid 106); 3 Oct 2026 01:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=//KSQgCs96oL51UeA+dMdooZXLrmogCN/ByPosSBp30=; b=WsqnyZQZ6u52PJhhCeQ0TFzL5VTuWMH+1ius9o+bF6/Jtm3gApfXQEiPwMH12caM1ngijCC8DljNWgpvwUYPmQXDW+oPA9ZrtVI+DH2qOg/Y3JpOHRHRM/Y5xPm8QxmzcOMXaXOvbrPrKYm5kdFRrsgeZggQXb06OC4HXnVigNWRc6QKOBmmdC8EZVhEYTIZiB7IPtMn+/2YU7og7vMwGCgfagfhE/h5lq79QpTUMzMjB9r5Rgm2iO2T70HQaJTPPUgk4U4QzHKnnH3jCTeUpI395NqOA3Fc0tfwsfqp6bwp1xT8TlI8pbBkPQes8UjLDJqRhkKBd5fvujfaxsFNaw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Oct 2026 01:07:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 50421 invoked by uid 111); 3 Oct 2026 01:07:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 21:07:24 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 21:07:20 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 6/8] repack: track the preferred pack explicitly in
 MIDX write steps
Message-ID: <20261003010720.GB839051@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <a85dbcd04c7957756848e5f3102744d20b509fc4.1790827875.git.me@ttaylorr.com>
 <20261002232834.GE834759@coredump.intra.peff.net>
 <asBTxLW9j2AIVlxZ@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asBTxLW9j2AIVlxZ@com-79390>

On Fri, Oct 02, 2026 at 08:00:52PM -0500, Taylor Blau wrote:

> On Fri, Oct 02, 2026 at 07:28:34PM -0400, Jeff King wrote:
> > On Wed, Sep 30, 2026 at 11:11:58PM -0500, Taylor Blau wrote:
> >
> > > A MIDX write step marks preferred packs in its string-list entries and
> > > chooses the last marked entry when executing the step. That makes the
> > > choice depend on list order, preventing the list from being sorted for
> > > membership checks.
> > >
> > > Record the last candidate directly in the step, borrowing its name from
> > > the write list. This preserves preferred-pack selection while allowing
> > > the list to be sorted without changing that choice.
> >
> > This is certainly cleaner, though it looks like the existing code works
> > by marking item->util and then doing a linear search for it. So wouldn't
> > that work even after sorting?
> 
> It would if only one entry were marked, but we can mark several.
> 
> For example, when `repack_make_midx_compaction_plan()` folds multiple
> MIDX layers into one via a WRITE step, it marks each layer's preferred pack
> without clearing the earlier marks. The scan doesn't stop at the first
> such mark, and the last marked entry wins.
> 
> So sorting would of course preserve the marks, but may change which one
> comes last.

OK, that does make more sense. Re-reading your commit message again, I
see it even says that, but somehow it didn't quite sink in the first
time for me.

-Peff
