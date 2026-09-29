Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE25383F8
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706341; cv=none; b=j6XHtsWiMEcSW7H3a1FJ7+sXiCextotEv/BwIgzFmr8Cb+arNhZzSIBv8NesRd09IHoJiULIRAIfIQv/6wBe58pLPbieKp6L1jNlH6C0M8hrafzUPz7CSKtZEYHY1jYrolq9NBMGWKV9kb7wm3Keh9Oogh5cb5jqZkZCdcrKDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706341; c=relaxed/simple;
	bh=fhWjCNlJ0xL9JSVtwgBJbNLPbjUhJT6dEYeu81TV1Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnXoI5OQbfq6jrf0pBm+2JXBeX69RDAQwDDtnghoxqHkPnT+vM3tEkFhq1YV0+QZf0VK/lwbsJk3Lxoo03EcuUB5m4JHfjpAcmQIrPUTkuSOlYsmJB3VM3A8Ss6VwsaSMldQybLFTkqqZ9askykTFEGvFno/93zZUvNGA/q++0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fq2dL/xP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fq2dL/xP"
Received: (qmail 816 invoked by uid 106); 29 Sep 2026 18:25:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fhWjCNlJ0xL9JSVtwgBJbNLPbjUhJT6dEYeu81TV1Zc=; b=fq2dL/xPoMf31uGv05/ofu8yvqibpEpTI97iZcXbK3UBFk2s0pzPbhbZyzLP177jPBj/bb6wOEAGhQ+iHJgsADDIohfM4n5oOYOJpYI5HbK2AHYphGlELHCr3zN3LQ48inDvHlmJIJWtlxtpXMREO5ySquYVS/r5WT3dc7m/6mbiUlNKQ7NAuIDI3uEVgbMyG8jE0tnf1J1dXrErURTF/pXMcu2BY42qy8OskaTCS8i48HHsKucTGpOsprXgx5GzQkv7EJVlDa6GLoul2Noe9IVm+5GJteHOB3vkk6P6xIfgXqpKxiow2vH88PwfWbmZmF/J3yxULAco9fFd1r7Q2Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 18:25:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2189 invoked by uid 111); 29 Sep 2026 18:25:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 14:25:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 14:25:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, git@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>, Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 2/2] merge-ll: use tempfile API for external driver
 files
Message-ID: <20260929182537.GA1710046@coredump.intra.peff.net>
References: <20260929051200.GA1100000@coredump.intra.peff.net>
 <20260929051312.GB1100669@coredump.intra.peff.net>
 <xmqqcxtwhufq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxtwhufq.fsf@gitster.g>

On Tue, Sep 29, 2026 at 09:51:53AM -0700, Junio C Hamano wrote:

> > If we were starting from scratch, I'd say the correct solution here is
> > to shell-quote the filenames we put in the command. But doing so isn't
> > strictly backwards compatible, because users might have their own shell
> > characters. For example, if I configure a driver like this:
> 
> "own shell characters" -> "own shell quoting"?

Hmm, yeah. I was thinking that our quoting could disrupt other shell
metacharacters they used. But I guess if it is only surrounding the
filenames we provide, only their quoting characters could matter. So if
they wrote:

  --option='%A'
  '--option=%A'
  --option="%A"

and so forth.

-Peff
