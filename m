Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AC136658
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969708; cv=none; b=l/2lWBJXV9AKlTuAiIT/ShtFnqD0NV+bBBWnOrTnNX2AMzdE7uvFYg0486fzYBAkrnYdXJpRSHKXnWm9DAkuQNY9KE6lncZV2cNC8CQNw/h0yKNQpiTAT3SagkNzz0qz+clJ/5Ye41NgIGHMowifcgbnt+LLSOPKGBc1ZixO3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969708; c=relaxed/simple;
	bh=KcqxA2rME3ddzqqI+3rEizcykn2zUAze1V4NIJhfCe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7c9ywYfOI0Q4CW1u6H2/GxRLDAPkSs9OvsjoZ521IN+40VP9GPTzmDmae1ptyotj5NgafnPrtz6XpLXEUEJNPq3W7pumTl5mnCesLsjC2AxSVLGcu7wbbj1KmQG1WeAJshYakHg3pKjRyGp8pgyTuPnNEvSIieIbBNeq2Pahsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12567 invoked by uid 109); 23 Jan 2024 00:28:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jan 2024 00:28:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10852 invoked by uid 111); 23 Jan 2024 00:28:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 19:28:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 19:28:24 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Bug?] "git diff --no-rename A B"
Message-ID: <20240123002824.GA827890@coredump.intra.peff.net>
References: <xmqq34uvtpob.fsf@gitster.g>
 <20240120011800.GF117170@coredump.intra.peff.net>
 <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de>
 <20240122230051.GB814674@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122230051.GB814674@coredump.intra.peff.net>

On Mon, Jan 22, 2024 at 06:00:51PM -0500, Jeff King wrote:

> then running:
> 
>   t/helper/test-tool parse-options --do
> 
> correctly complains about the ambiguity (though amusingly it mentions
> "--no-no-doubt" in the error message). And if I add KEEP_UNKNOWN_OPT,
> then it gives the wrong behavior. But curiously it does so even with
> your patch applied. So I think there may be further fixes needed.

Oh sorry, I'm stupid. Of course it does not complain with
KEEP_UNKNOWN_OPT. It treats it as unknown and keeps it!

So with the patch I showed (and adding in KEEP_UNKNOWN_OPT), even
without your patch "--do" is handled correctly (it is unknown and left
in argv[0]). It is only "--no-do" which is broken, and your patch fixes
that.

Sorry for the noise. :)

-Peff
