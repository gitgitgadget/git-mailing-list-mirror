Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E61B4123
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733440902; cv=none; b=eHgHljBl3sR8C4HvnYDgi6M1Uizx9xacWplufDD8VhIMG+heuDV1FPM9ZVggnX4Kwn1ASGw/67BR+DSggvFhy7zO4AkIW9Z//kkz8WJkoWjPq5IrHdTRqWhbZzIadzjm2lpHcfHNkuODkNjbLJaPETlNHCmQEAL1uKEYSoWn38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733440902; c=relaxed/simple;
	bh=y3Xj8566zCFPMyUbMb7PuT0vUrzzBi01s0rNFbzeCBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnqeIf5dG8cAtYDA/vOOwzy3146p3DDgXf8+AJ8Jqht9PEjcZ6/f2mrtgyKUIsNG5LYGiLKmtBf9B/blbGN2X+ni8Wk5XeHPTFE4z/+EtaQd6qNvKqYpgBzCut0IqSoweU4RoBgrCgaRwZAydWGKtUl+qJ8G0l/p8JPZqbkGcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aZ/iDS0M; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aZ/iDS0M"
Received: (qmail 1743 invoked by uid 109); 5 Dec 2024 23:21:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y3Xj8566zCFPMyUbMb7PuT0vUrzzBi01s0rNFbzeCBU=; b=aZ/iDS0MAnfRwGkZivKnm4BVdn6LCVhkibYxh9EdAjfQwvKv+Koor+05HPf6Ldx45McBbzvYlO4kexpHuv+OYtXv8jfAm+QoHyvHMYmYwjsmFcJVZPi/LgKrKYCiupCgeKDK1JmMxAJo8dMlQi7xosaa3cItgD0IGFhmUWAXSl2Qf0JTq42M2bcLst7SwA+4Mulb9Wn+/Kl6l/mHIjgSXRGiLbpRgRYG63Kk26xRDQC6L5C0kCjVpgCKoC/P73IBKjYgCJDuFl1ZAfIIyvzzAUtKNbraT1oGFIl6W/LLyet86P8CXaqZAtrwYIa0P+M3ZWbk5rmiutDOKCVaa2dCFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 23:21:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11330 invoked by uid 111); 5 Dec 2024 23:21:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 18:21:32 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 18:21:32 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, benno.martin.evers@gmail.com,
	benno@bmevers.de, ravi@prevas.dk, jpoimboe@kernel.org,
	masahiroy@kernel.org
Subject: Re: [PATCH] describe: drop early return for max_candidates == 0
Message-ID: <20241205232132.GA3171999@coredump.intra.peff.net>
References: <20241106211717.GD956383@coredump.intra.peff.net>
 <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
 <20241204232750.GA1460551@coredump.intra.peff.net>
 <20241205201449.GA2635755@coredump.intra.peff.net>
 <plncccgcchrmspkelepacifqpfua7nzsb4y5xzjv4vzc3p36yr@r63i2xo6avba>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <plncccgcchrmspkelepacifqpfua7nzsb4y5xzjv4vzc3p36yr@r63i2xo6avba>

On Thu, Dec 05, 2024 at 02:28:45PM -0800, Josh Steadmon wrote:

> > Actually, after thinking on this a bit more, I think the solution below
> > is a bit more elegant. This can go on top of jk/describe-perf.
> > 
> 
> Thanks, and sorry for not replying earlier, I got distracted by a
> different $DAYJOB breakage:

No problem. Thanks for finding it!

-Peff
