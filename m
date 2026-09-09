Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046242903F
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993980; cv=none; b=pFx0Ffb27mMwP9zeAouCFIMQI6aJny7WdA/s3JeZh5d5oAI+q6h453Iymndiy30jzFbdB2jyTh4RgBjNwosKLqbBr+mZ7yjQRAoNi2X5s72xRFiQNlenp5Kje0eNlHoSb/5A2bDSGQlwnkNXb3iWF4JzWeYnWDDuVRErZ8LIG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993980; c=relaxed/simple;
	bh=SxJSX9ZtDiFX+l/hna3jpxUz92mVcoYsiNs1A2lOVUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpEtlyqYNuyFFvkFPkfXCojLJY+xIdKpSdGkC4V9NRtGOWiqju5KNCZR2dNtr/htWvmjmlX68Nk5bTQFiWrqKKcBn5sc5syDUIdYSH0dEhU5XovovFtawNZF461g/N5KfUnfrLP9DccoxRHr1GwLNCU/VzcK0OiaQI1wX8ETdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HO2FfKt0; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HO2FfKt0"
Received: (qmail 29129 invoked by uid 106); 9 Sep 2026 22:46:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SxJSX9ZtDiFX+l/hna3jpxUz92mVcoYsiNs1A2lOVUI=; b=HO2FfKt0AGrTwTSykWS+2CAKg1fkawsxAhiEySWPU96XS5t/6Hey8T+G/5zyJpAOpTOrz8BgcHzlmd9ARfTbfpmkQYqHb9JukWSKaBQi1kFH+goKOtbv6p5ve9QPphm3mZy1FT5LFiK9EFlRIW2f1YobIW3LrlTeBHtejo8U8yVpma9AGWEgkuVx+5zwlRwmKPoOPmpfrVQivJK3Tvw52Wi7eOr4KuihX8GYAJbIC4tb+gVltKLMD3hf3zrnyYwGxAovh289zfXEVEKIj0N76uOjTIGvZFip7MwrFVt1jwGASNPD0lblDLIH49UCdACo/38BnYOz2Y5O9BMC/k9V1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2026 22:46:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 148221 invoked by uid 111); 9 Sep 2026 22:46:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2026 18:46:04 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 9 Sep 2026 18:46:03 -0400
From: Jeff King <peff@peff.net>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: ben.knoble@gmail.org, git@vger.kernel.org, gitster@pobox.me
Subject: Re: [PATCH v3] advice: use global config for default branch name
Message-ID: <20260909224603.GA195381@coredump.intra.peff.net>
References: <20260909202718.GA183838@coredump.intra.peff.net>
 <20260909212214.94151-1-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909212214.94151-1-ub4nal@mail.ru>

On Thu, Sep 10, 2026 at 12:22:13AM +0300, Vsevolod Myalitsin wrote:

> > I had somehow hoped we could reuse the existing CONFIG_SCOPE enum
> > without having to redeclare it ourselves.
> 
> One concern about reusing enum config_scope: since
> CONFIG_SCOPE_UNKNOWN is 0, all existing advice_setting entries without
> an explicitly specified scope_hint would default to
> CONFIG_SCOPE_UNKNOWN rather than CONFIG_SCOPE_LOCAL.
> 
> I believe this is incorrect, since the existing behavior is local
> scope by default. However, if you consider CONFIG_SCOPE_UNKNOWN
> appropriate here and it satisfies the intended requirements, I have no
> objection to using the existing enum.

Any config can work at any scope. These are really just recommendations
on where the user might want to write a value. So I think it would be
fine to treat UNKNOWN as "just suggest the default location for
writing", as we do now.

TBH, I am not really sure what the criteria are for suggesting one
advice option as --global or not. I'd think most of them are about
squelching advice that the user already knows about, and thus they would
go into --global. I didn't really follow the earlier discussion that led
up to this patch, though.

-Peff
