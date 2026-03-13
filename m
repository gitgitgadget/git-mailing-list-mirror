Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675E2D8DDB
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361475; cv=none; b=lrA9A2lBLgtRRQQa9EL2pNt2JiLEd246COeg1893to3AsFfLvnPUeRS/aOnoz39fGHXLk7VwMsxxNaY+6YR24krdC2Y4rukZ6uqY+rlbPzzWC/0RW+cmKl4Yho1t2qDkhg6PyADdOoipb8i3Q1VeUctS11ZM7feedY6gyXsBzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361475; c=relaxed/simple;
	bh=ipC7DkHNY7Euc/yg3kl2OVit5xUQkMVlw7ZNZFJnvyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwzrMUx5eNZvtskPrYOvjVmwH2K7QkkmTGlnMyxxdlSAFyZVuhvq49IAUNdizeUkhMjRscKN/qXLmFvfymv2C9iT1E+kCUdbqjIL/zVhs/DV1usSK2APBwrsg/7GpHxgFbzsa+ortsWdD1F8vTGqbl7wx6za1EzRkUfR77YmZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fz/IpmJ6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fz/IpmJ6"
Received: (qmail 94473 invoked by uid 106); 13 Mar 2026 00:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ipC7DkHNY7Euc/yg3kl2OVit5xUQkMVlw7ZNZFJnvyA=; b=fz/IpmJ6EG0qTo660MOPdmmxhboqmCAzcvDW6Q6DV6xdjvoYV1OBEo8ovOp4Q8xyXnBYdF9bkFjZAJJvfite9/VQI10GPWbmjHuWk8HChy2do6rWY7b3dzKyfiuioEP/yXdA8C2e5gHX5buhKzyh1nQ1UsEqJ2pfUIyiG+yGDmdViNoGqGOcI/rdEJ90JQv0QzyEXSIdmUG/Mq9eyrIj1smkh9zvbOnl2NAWU0Erjp1w7lv4I7D13XT6Ac9CviWZ9HC7hc02PZ+3jspfGsf6/TgpEuiUxCCCKpf+DY7Q1y0jYKSoD0nG1YboXuvpTbwToT9qnrIZYPTvW4lqPSe22A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Mar 2026 00:24:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 517506 invoked by uid 111); 13 Mar 2026 00:24:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 20:24:34 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 20:24:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #05)
Message-ID: <20260313002431.GA3200726@coredump.intra.peff.net>
References: <xmqqh5qka8so.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5qka8so.fsf@gitster.g>

On Thu, Mar 12, 2026 at 05:10:31PM -0700, Junio C Hamano wrote:

> * mf/apply-p-no-atoi (2026-03-09) 1 commit
>  - apply.c: fix -p argument parsing
> 
>  "git apply -p<n>" parses <n> more carefully now.
> 
>  Will merge to 'next'.
>  source: <20260310050621.3849719-1-mroik@delayed.space>

I think this is responsible for test failures on Windows in jch/seen,
but I'm stumped as to why. You might want to hold off until we figure
it out.

From the output I doubt the code change is responsible, but failing
tests in 'next' is annoying.

-Peff
