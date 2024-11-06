Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C320966A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921213; cv=none; b=R7D+rxBNuguegNqRzTA1a39fZptcVpswpyr1rS16Qv/FwT5cuAKMRsktKfHeXsu79G3hAgFklHAJnpiP4yXm9H82KPSnRGNKIhpXxy0rpv3i25N9/bFnTVM6AODq9Qm0fa1dA7AoDsUvaC5OIEfej2gcyH61nZ7wpu+dvkVV4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921213; c=relaxed/simple;
	bh=uLutECnws7qqX8dPIXC6C5a+ZfIDOHBHCyFMgOvZzeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAUow6f04U3nW6kGNeHW/LthbN0uEa0lWEwMByw5Kv0qrdcXBFAZNfvkYwDWSwmJudMjcR2mwd9K4V6Cgy2QFj9/odF5vWlmhroIrgjqqCcVacRn3MTsyv/XViihqxTWJaaqpuwZAxFUpbKbia32029lxT2mF3tkFm3LFj2yGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NVCUk7d9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NVCUk7d9"
Received: (qmail 14407 invoked by uid 109); 6 Nov 2024 19:26:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uLutECnws7qqX8dPIXC6C5a+ZfIDOHBHCyFMgOvZzeY=; b=NVCUk7d9FnyPRzpn0JzG7V9GdLycpJ1eb7EeHcIRi6MvGqMLzk5HVwxnnczg8ootf3MuLaqAZOw9vPQbA9eXT54EJsTBMq6j1PzGYxcZqDHB8Q2GpuEIMjWti48SCpxIU9CN9fVSZpqxScZ7Xfpb7XPEYn1LcJGbjiX9h+9CEC8Yq/UsoTJCgmDaghe1f4ffz6z0384mvIegZDx/wIDTGBAdJ90kgSV0MDUeQclXJB4OGwcJTxVNQjI8DblHNfsCdBPEtFlFLBpnpmAHLC3apUN9jlPDMxDUgX5aahx4EpoG83cefsv4xvLiVFfhk3Q/XpFM1tENgwn9GZB5/KPXQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 19:26:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7330 invoked by uid 111); 6 Nov 2024 19:26:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 14:26:50 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 14:26:50 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benno Evers <benno.martin.evers@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 0/4] perf improvements for git-describe with few tags
Message-ID: <20241106192650.GA912471@coredump.intra.peff.net>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
 <20241031114210.GA593548@coredump.intra.peff.net>
 <20241031122456.GB593548@coredump.intra.peff.net>
 <20241031144351.GA1720940@coredump.intra.peff.net>
 <CAEQVFRFWT02QTL7PTf84p6AAferijHx8L_Tu6ON1H7U=iEdb3A@mail.gmail.com>
 <20241106192236.GC880133@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106192236.GC880133@coredump.intra.peff.net>

On Wed, Nov 06, 2024 at 02:22:37PM -0500, Jeff King wrote:

> So here's the series I came up with, which starts by adjusting the tests
> to be resilient to the later changes, but also to show the existing
> failure mode.
> 
> And then the rest of the patches add the performance improvements we've
> been discussing in the thread.

Oops, I just realized there's a silly error in my patch, but I need to
go offline before I can fix it. I'll send patches later today, but I
didn't want to leave anybody confused about the delay. :)

-Peff
