Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9461A83FE
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685851; cv=none; b=TT3tlYO9xIaAwDHjeXc5NPLD+hYfVxnhR/KpDaKVzha4xQcGR4u+kphMYPElI8iyvgeXLS0ylfVzrCt+bfT0779rqOZx78GHvJdTSLk0W52lV0owoePokCIWrU0in30VDIdhuZcTYFTNMQ1AmmzNEJmJ9vpwPeqDsdZNsgwGzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685851; c=relaxed/simple;
	bh=XiPY/s1P0oPfN56QoClJomFYfksc7fVGom41nNQA01E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3fYQJzrnKQzWBsVp0CeRwvv/gu5LC2vbnLKqZM2Y5VdGEygD74h452dizIM9wQPkar1Zj2+6KV1eahWgOc8G/DtEP0c7cYJvQwkFJmIyuhn6ggqerM3CFkiY/6whFMN1FoM3DNS3FaHouHRvYfRbFSPbu2EhBRMj7H/r5qdjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EOBZJ3vV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EOBZJ3vV"
Received: (qmail 8854 invoked by uid 109); 20 Dec 2024 09:10:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XiPY/s1P0oPfN56QoClJomFYfksc7fVGom41nNQA01E=; b=EOBZJ3vVRwep1250JqSyjEzeHTKmP3Vhqd9jJoeeC9zriMzuHxjinY2gDqbszzkGqfTyxRdoOxba1zPEp8aIbpdjr7ioby9Y/VS1zF5Wi6398mPh6NQ6J0fu3udAIJyKDZDdyUcrUIjSD0z2scK/A06TL34y8rq++K3azbfpGhR4yqto0FbXShujeeP9JhR/LuLLKh5DaOHBuqUTq9BHt6N8BpGo3STsGeBDSsE7Sm4IF58XZDCNWs0FaxdIV3OV/6+XAKf2MwC5PR+9mC8KGQnGdSfhAV9sV6vTmTPEpwFOtquHJb7UTWopyqUwTT4DlvTKl19L8p77l4MOt2tB5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 09:10:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14504 invoked by uid 111); 20 Dec 2024 09:10:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 04:10:48 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 04:10:48 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241220091048.GE133148@coredump.intra.peff.net>
References: <20241213081211.GA1443203@coredump.intra.peff.net>
 <xmqqv7vnevjc.fsf@gitster.g>
 <20241213103850.GA1456983@coredump.intra.peff.net>
 <xmqqcyhtaecy.fsf@gitster.g>
 <xmqq5xnladwi.fsf@gitster.g>
 <20241216111112.GA2201417@coredump.intra.peff.net>
 <xmqq5xnj7fre.fsf@gitster.g>
 <20241218113927.GB594795@coredump.intra.peff.net>
 <xmqqv7vhujo4.fsf@gitster.g>
 <20241220090908.GD133148@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220090908.GD133148@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 04:09:08AM -0500, Jeff King wrote:

> > Ah, OK.  So your "caution" was about the underlying mechanism to
> > allow attributes corrected from the specified tree, and not
> > specifically about using "attr.tree" to specify that tree?  That was
> > what got me confused.
> > 
> > If that is the case, I do not think the documentation patch that
> > started this exchange that adds attr.tree to where GIT_ATTR_SOURCE
> > and --attr-source are already mentioned makes anything worse.
> 
> Yeah, I agree it's somewhat orthogonal. Your patch made me think about
> it because it is advertising the config variant more widely. Somebody
> doing:
> 
>   git --attr-source=foo diff ...
> 
> is probably OK, but:
> 
>   git --attr-source=foo pack-objects ...
> 
> is less so. Using attr.tree instead means you're going to do the latter
> whether you intended to or not.

Re-reading my message, I guess I didn't really give any conclusion. ;)

I should add: I'm OK with leaving the performance implications
undocumented for now. Hopefully in the long run somebody is interested
in addressing them.

-Peff
