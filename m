Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFF496D3B
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071075; cv=none; b=kGoT6BwgzY8fui69mDG2Zuts+oy9jebmV1L9kmugQqWDXW3hSfbXLvXq0IyZxE4FI+ucF9CNF1YF9ENgCYXrBT/SXNQf0xo2oVS1Y1T7HLJRuf8xkzn+x9ZQApHpiXMdvbqta5EDhBFH+9JWyppo4qjUDhTNj1vxXBDFyo9IHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071075; c=relaxed/simple;
	bh=5rInuPLyETE2tRBnxHWLf5Z4nMH2WukZ1SR1FcsRJ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjQE1dWkA/wUAfhkjxQZP07dnCrHpyV4MYkeBf4ThqyiYNbizr9V8NIcIBAlvsyCWIgAlUQpaMzV6+ybMuZK5vi1+/Ddo7tJkd5Q6uKIf/zdB8STi0/v4jTzTF9VZp/z8CNBg/gktUJhjOwZmU44KDpgceSV/brtKwosF+vQ0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QLWNvOn3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QLWNvOn3"
Received: (qmail 32763 invoked by uid 106); 10 Sep 2026 20:11:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5rInuPLyETE2tRBnxHWLf5Z4nMH2WukZ1SR1FcsRJ/M=; b=QLWNvOn3lXwcb7GELV3nLkx4NqF7R7NCZ0tkhU/dXwX0PCNCt2l+e43s63Fbm/cobUIIW9c2swIQFLkMlCKsIbVBW4KIiWOf0hAzR7fgCn9nKe39Edx1lsn3A2adV5dSRsVF0DPLKCMNZqk6fBsqBrKXBqjLcR9IMdSBdKS5mMMFHw9yaazOE/s2qwknVjKbQ9tvKLo4V0dhPEa8XUhvT1sbB1X7sJmdiMxPJuYYrzRMQaxAVSVu9stqmP5LiLJKH4aiAIF9TDIaTRaslSsTvyTeLf6uhi8b1TrZzGhc6O19vdgMulu75h2ktAXFXY3B+t9qrOYAfTdrl73hlxvQfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 20:11:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 161164 invoked by uid 111); 10 Sep 2026 20:11:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 16:11:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 16:11:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, git@vger.kernel.org,
	ben.knoble@gmail.com, gitster@pobox.me
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Message-ID: <20260910201111.GA919731@coredump.intra.peff.net>
References: <20270829004959.90983-1-ub4nal@mail.ru>
 <20260910085353.109373-1-ub4nal@mail.ru>
 <20260910085353.109373-3-ub4nal@mail.ru>
 <xmqqzexpf78k.fsf@gitster.g>
 <20260910155247.GA251185@coredump.intra.peff.net>
 <xmqqpkyldke1.fsf@gitster.g>
 <20260910190345.GA903701@coredump.intra.peff.net>
 <xmqqh5jwevbm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5jwevbm.fsf@gitster.g>

On Thu, Sep 10, 2026 at 12:54:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I kind of wonder if _all_ advice should just say "--global". I cannot
> > think of an advice flag that is really repo specific. They are about
> > silencing extra help because the _user_ understands the situation and
> > wants Git to be less chatty.
> 
> I think there are two things in play.
> 
>  * If applicability of a piece of advice depends on the workflow
>    employed, and a user who works on multiple projects that use
>    different workflows, set of advice messages may want to be
>    squelched per project, hence "--global" may not be appropriate.
> 
>  * "I, a physical single person, understand this piece of advice" is
>    inherently per user, so squelching a piece of advice that the
>    physical single person understands globally may make sense very
>    well.
> 
> In hindsight, the latter argument should have been given more
> weight, but I think the primary thinking back when we designed the
> customizable advice messages was instead the former.

Yeah, my contention is that the first thing doesn't really exist. But I
admit I didn't carefully go through the list of advice looking for
counter-examples.

I'd be surprised if anybody really thought carefully about it, though.
When I introduced advice.* in 2009 (geez, has it really been that long?)
I had assumed people would just set it in their user config. The actual
"git config" command advice came much later, but I don't see any
discussion of global vs local in that thread:

  https://lore.kernel.org/git/pull.548.git.1581311049547.gitgitgadget@gmail.com/

Amusingly that thread also touches on some of the "could we just convert
everything to advise_if_enabled()" issues we've discussed here. I had
zero recollection of it, despite participating.

-Peff
