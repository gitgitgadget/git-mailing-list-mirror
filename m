Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317682DF7D
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737275; cv=none; b=gDgaj3N+viEyYxmCnyqJ/HiL+N4vJIT2tF0fkO/7Uq4Kbh7sHzPphG9Vt8GnyVM4FxFljhBSUirUyfGqVfoPVeH36jCIXKtTUTr/UoPBw5UKZ9pVdoRefphf/Wds8XS+Y96oJy6asibywqD4BWxuW4zEZ1a0x4Revc+r4nH77b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737275; c=relaxed/simple;
	bh=+KZq91iwscdEa3a6Sbp5PN1Nvn4iUTVqH3kTvxwuTzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj1YqkNRLlUE9+bdf+pxZKxSF1I3UcUW+3uRM6pNtKDnNaKSGR3XrloJjCwczGw2UaHtKWFrs+Y9H3fM3T2cY2q+N8OO3R4Y5Fr6E1tNeTfpJRhnLZrsOObh0pUKKLPVQMEB+LFklEOCgKwo0LsF9VPrVuXlt43rRHpWaG4a8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25015 invoked by uid 109); 29 Mar 2024 18:34:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Mar 2024 18:34:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21511 invoked by uid 111); 29 Mar 2024 18:34:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Mar 2024 14:34:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 Mar 2024 14:34:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Han Young <hanyang.tony@bytedance.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] t4126: fix "funny directory name" test on Windows
 (again)
Message-ID: <20240329183431.GB31800@coredump.intra.peff.net>
References: <xmqqfrwlltjn.fsf@gitster.g>
 <xmqqsf0bz5oj.fsf@gitster.g>
 <20240328103254.GA898963@coredump.intra.peff.net>
 <20240328114038.GA1394725@coredump.intra.peff.net>
 <CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
 <xmqqa5miuutd.fsf@gitster.g>
 <xmqqh6gqt674.fsf_-_@gitster.g>
 <xmqqil15srub.fsf@gitster.g>
 <xmqqwmplvbsa.fsf_-_@gitster.g>
 <xmqq5xx50x8p.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xx50x8p.fsf_-_@gitster.g>

On Fri, Mar 29, 2024 at 10:21:58AM -0700, Junio C Hamano wrote:

> Even though "git update-index --cacheinfo" ought to be filesystem
> agnostic,
> 
>     $ git update-index --add --cacheinfo "100644,$empty_blob,funny /empty"
> 
> fails only on Windows, and this unfortunately makes the approach of
> the previous step unworkable.
> 
> Resurrect the earlier approach to give up on running the test on
> known-bad platforms.  Instead of computing a custom prerequisite,
> just use !MINGW we have used elsewhere.

Thanks, this looks good to me. You mentioned FUNNYNAMES earlier (which I
forgot even existed). That would probably work in practice, but it is
kind of overloaded already. I think using MINGW here gets to the point,
and as you note, if some other platforms fails we'd want to hear about
it.

-Peff
