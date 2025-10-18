Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C19354ADC
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780845; cv=none; b=FD+jAmZG/rD2cpxwpPn3P0NNfVF6otTHpXMZkjR3ml6IY2S5YI/5w5sBUo9iXUo67xFaX1HtZxwtDZzzqGUz5irH2L70pOl3x3ZUjNyI1DnxiizFH4DqHVMps+RvDX09g1vbRxb+sXFgeXaCMAb82qs9iyxDVlncA8z8m5fXbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780845; c=relaxed/simple;
	bh=dgPF/3nXfhJr5rV/KNupmBNdjKMEtm/HDzvNj8s2aVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZO4Kl3wpcDjAMRRBGJL7/Z3iqdoLJJyK5Jcqtj9/Ws3CgRwyA2cFe9w2hDWpvTwQehhezSLZXCjqn3s4FtSA+Gnk0obyyCogGfUayIfWHvcVK8GKJaWZe+q5mtJbj0NOO8LJz+oBm0c5Wr/ZjKhLZGix4T/PMQmaG+HHaNLGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KcZtzuvT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KcZtzuvT"
Received: (qmail 261221 invoked by uid 109); 18 Oct 2025 09:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=dgPF/3nXfhJr5rV/KNupmBNdjKMEtm/HDzvNj8s2aVs=; b=KcZtzuvTOxwJA4BRzMnu8v9ODHtSozzduf9olkABoc5WFJsQXZrlvNIJUTIcsFXbFgWhVhErlDb+tr3BpVOSX57DRIB2t1CQdr5XU6Bs6aZ9XWY+JJsSQgWRv2eGB5Y/n5H0eUJplYmMtGHfS1fploJinVBOwPHifNax3MXv6Lnj14PDU7RLzd3VbuNJk9n+fTl5ZyV6oh8/sb3bT2tDS0K/7UbHtW/91KwAbdzTBQ47lWPFle29w6jNCovQqn3bFseaGWMzQATPx65h8sewtrpKh/SPZ92BegKzG70/ldQo+hSZQlTpNQhwc1fBgnwPWphSFM03ccfnnmdObxu67A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 09:47:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 409696 invoked by uid 111); 18 Oct 2025 09:47:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 05:47:23 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 05:47:22 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
Message-ID: <20251018094722.GC1060824@coredump.intra.peff.net>
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
 <xmqqh5vx1p0q.fsf@gitster.g>
 <6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>

On Sat, Oct 18, 2025 at 09:11:34AM +0800, Lidong Yan wrote:

> > Test that exercises "git diff -I<regex>" is in line with what the
> > original b55e6d36eb wanted to address, but given that we saw a
> > recent regression report like [*], I would have liked to see "git
> > diff --quiet" in the test as well.
> 
> I will read Peff’s test and see if I should also add some similar tests

What I was hoping was that we'd apply my patch, as a matter of release
engineering (backing out the regression-causing bit of b55e6d36eb). And
then you could make more-specific fixes on top (since -I would still
have potential problems). And then you don't need to add a test for the
regression case, since it's already there.

-Peff
