Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782322F75C
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442198; cv=none; b=vDVtmdz6zQWSf79GE2Ip0DsYMgFItdU3G0FwovNHUAR5FkTU6CINAnx4JvscDKQtMyCY2nRySpP72WrPcPV0KFfZHqn3zj2ZW9eCe4mjYlnLJieJ8klsK4TDZi8jlXZCwGgKVUCwww4VEudCJO4Vct0S7nVsgDoRRQIIJkWs2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442198; c=relaxed/simple;
	bh=voTSz36OilcP2mdRE3hSiFB40FRDmsmIvArQxEx5Fi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neeSK5xrze3qvfZUmaTytq0o5uDS7UaqC5zVNsc5z5qzmseQZ0Vxpf+rX4iqhdFEiYpCFuX/K50npMfXrfVrklfbtDVqpm8t1NsjdAw6D+pLYJdA2FLdmQlGB1Ej90GwARNRQpbAqIyELhWwb7yNeAYbDHsC6dd70KBP3sX3Nxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cZ/OQcZE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cZ/OQcZE"
Received: (qmail 26220 invoked by uid 109); 25 Jul 2025 11:16:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=voTSz36OilcP2mdRE3hSiFB40FRDmsmIvArQxEx5Fi4=; b=cZ/OQcZEd1MxExJ/l6ZGV6YKBsHceFEB1uE4beQ15mlL66R1WTs7D0Uo+Qk1xWu/Ah58t73lZjH/VHr2dKV+8OES9zVBtMA+96UOIYYhmzA+K/ags6LaPvPbialZIr3oD8rszcb9A4jgOUqRCgrCtb7PAaKBwQ2iBZ1iVfD/ErOZuJzRgLen4RyGCmi02yPh1m6HMo0JfsnDsxn0jaII5NSg4eeI60rb1ZLBXtoIovaIpSmHtCbFg58hZhrbZbbFakulLSjl8Q3rwhGewN08fvmp082iBGPtEFvnM/aGl7QTOHEwRCLfkkULpzDSAnwSfgzUNrHmgC+RgF9gqtcL/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 11:16:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21210 invoked by uid 111); 25 Jul 2025 11:16:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 07:16:35 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 07:16:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] test-delta: simplify delta helper with strbuf and
 better cleanup
Message-ID: <20250725111634.GA3015176@coredump.intra.peff.net>
References: <20250724093327.2261615-1-lhywkd22@gmail.com>
 <xmqqjz3xh34c.fsf@gitster.g>
 <20250725111530.GA3015021@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725111530.GA3015021@coredump.intra.peff.net>

On Fri, Jul 25, 2025 at 07:15:31AM -0400, Jeff King wrote:

> On Thu, Jul 24, 2025 at 11:09:55AM -0700, Junio C Hamano wrote:
> 
> > OK.  Except for the whitespace breakage, I didn't spot anything
> > glaringly wrong in the patch.  Looking good.
> 
> Hmm. This looks like just a squash of the 3-patch series I sent earlier?
> 
> (Sorry, it was in another part of the thread and you weren't on the cc).
> 
> If we are going to go in this direction, I'd prefer to leave it split
> into the 3 more obvious patches with explanations.

Probably would have been helpful to actually provide a link:

  https://lore.kernel.org/git/20250723235929.GB592873@coredump.intra.peff.net/

-Peff
