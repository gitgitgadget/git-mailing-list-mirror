Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C41DA0E1
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152637; cv=none; b=EQIXHoAW6cOMbZm0Hz7HNSxwikkAy8FfTclHEivBgmxBA53N0hPsGpZzJatfPhmE271dGrgdnrky7MkZTDG4bJv6lZgNm7NtOpcOHD1mdAidoh1kyx7LzLffI4bjtEcD+SBYRgoWNv9NOw8yq7mN/rY43v6QYd0n6GsylTcBgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152637; c=relaxed/simple;
	bh=anGBgcnwPrWdzHIaY6M4rknKhoRpvc6kQab9evIcCPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv9W48ANQrzXjYn0rASpC7PFy8DGtbkqHYb4CekY+5oFJl2uKA3eO/dM7dDm1Kgs2cUl0WUOP3wzJkBgxlNQb5fIUxqRFBqeEJgZhG65p4j0kxaVbbD9yl4LBihan7uzn/7QcnCkLCf/hlkvYNOUJKuGSM9/yVUfyvwGMoj5oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TYh/u9hI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TYh/u9hI"
Received: (qmail 15753 invoked by uid 106); 19 May 2026 01:03:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=anGBgcnwPrWdzHIaY6M4rknKhoRpvc6kQab9evIcCPk=; b=TYh/u9hIm69wrSZgLRJhuxVYXfug0GW3fePQEKxFR2Q02luRWjv5/k8t1cMsYmtcg0ECGTgXvRgDalSmkX14G21GKaqCNgcc66Q3oILrRlZMylXVoEQcPzBJ6XwN+y/Dq7SEdmw6tfJk+Bj8+h37JFvU2o5sYxANPx5m7SgTrCRD7O4lHP5/5ThIawg4ojtDqh/6Q2af/9XmrDsfGjnnj2vpQEMbfuxiy4lF2Z6uNHaHKfShu417Hk1ElWmw/onvEAPBX7L/7WgudVfZfxETE21zwX8D5i8KifHhFCjeVYe9uBVB2gcLvhZrqhiUVsORWmmpDsOCutGjFowQgDbRBQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 01:03:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38481 invoked by uid 111); 19 May 2026 01:03:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 21:03:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 21:03:54 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/2] commit-reach: use object flags for
 tips_reachable_from_bases()
Message-ID: <20260519010354.GE1612961@coredump.intra.peff.net>
References: <pull.2116.v2.git.1778922993480.gitgitgadget@gmail.com>
 <pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>

On Sat, May 16, 2026 at 03:59:39PM +0000, Kristofer Karlsson via GitGitGadget wrote:

> v2 of this patch, addressing Jeff King's feedback:
> 
>  * Replaced the decoration hash with the RESULT object flag (simpler, no
>    extra data structure, handles duplicate tips naturally)
>  * Fixed early-termination bug when multiple refs point to the same commit
>    (the decoration API overwrites on duplicate keys)
>  * Removed the now-unused index field from struct commit_and_index
>  * Diff is +11/-12 lines

Using the object flag here is so much nicer. I see you're reusing the
RESULT flag. I'm not sure offhand if there might be any conflict with
other uses of that flag bit. I think probably not, since it looks like
it is cleared by the other users after they leave their respective
functions?

Using a direct set-inclusion check with the flag is nice, but we still
look at min_generation_index. If I'm understanding the code right, this
is mostly about counting the tips we've seen. Which at first glance
means we could probably replace that code with some kind of counter. But
I think maybe there is some notion of "crossing off" commits which we
don't actually visit, but which we know become un-visitable because we
traverse past their generation numbers.

I think. This is really the first time I'm looking at this code. So
AFAICT your patch as-is is correct, but it would be nice to go an ACK
from Stolee.

-Peff
