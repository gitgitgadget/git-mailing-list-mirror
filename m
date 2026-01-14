Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED7221DB1
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425252; cv=none; b=S7NdLICgsLLG0Xpzlo3Bd+wquZNJTaVOI+kE4jqi+4DgmB28mSACtLCbCE8LjkC4zan9tB+Rl7zTivO+/URxFlhEglrdByShax0JXU2GKM6NzLGvns2UDRoI6VgPaW5WfUUPNeJMCh3elqujW9SQbaIJb1YaFpWxSIIhrRv1HqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425252; c=relaxed/simple;
	bh=a/XfDRXbxyZmpLJj03Deuxk4iGf4+xeXUuQF3rImv1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX0fJMmeUx2EPTqDXjywL9qRTIG/M89vGgPG3OyQ61Bzm/aGOp03E8cPqJMA1Hk+z/4nWtHm/dpMJSehnl2RwgKIBmlOF7oKHssdi9jwmRnNzxWLTg+nznRjBag4rE4Hvk46+5KpJqW/05OERzIn3pwoT/5BMrd3jByeSN0Pjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hzUYIMfX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hzUYIMfX"
Received: (qmail 41761 invoked by uid 109); 14 Jan 2026 21:14:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=a/XfDRXbxyZmpLJj03Deuxk4iGf4+xeXUuQF3rImv1A=; b=hzUYIMfXgwICYjtEY7iW4ZukZF8MWuHoB2vikVfSwNGTET/v4A/fffZ3WuDDUQ/eGAVL1iHJtgqBSmd0IONkchisQbGa3tnm+61ppxvDAoawZrsMtQtYzDYH8zRsMKoAwbDzNlxZekKIp7MLIeOCdkmLGXkG1HeHffcsxaTpyGLkvPdWWcSrJxptK/3mKeiY3isC6lhW7Ma9BnMU0DZNtHUA87y+/YdBkdD4ayNr36UVN0/Mxw47x4N61Tn0ShMi7QKVFA2mJFnDyg8Oofu/lqAZwQvLtNvDNt6MnGYsyj36eATmHJYuX1+JhfFxs5BTnSZGEimx8buljQ7lSUiWLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 21:14:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 70024 invoked by uid 111); 14 Jan 2026 21:14:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 16:14:12 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 16:14:09 -0500
From: Jeff King <peff@peff.net>
To: Rostislav Krasny <rostiprodev@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 1/1] compat: modernize and simplify byte swapping
 functions
Message-ID: <20260114211409.GA1010080@coredump.intra.peff.net>
References: <20260102002735.31390-1-rostiprodev@gmail.com>
 <20260102002735.31390-2-rostiprodev@gmail.com>
 <20260102061626.GA2581074@coredump.intra.peff.net>
 <CAKU3Xk5=dmdQhTgHB8WrPbbOOo3cyJtCgFgo7juW06F9YaceRQ@mail.gmail.com>
 <CAKU3Xk5kCEDU7JZBhb6a46dZ=gEkP4neCNLMHXVB4RDnYZHG0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKU3Xk5kCEDU7JZBhb6a46dZ=gEkP4neCNLMHXVB4RDnYZHG0w@mail.gmail.com>

On Mon, Jan 12, 2026 at 12:05:22AM +0200, Rostislav Krasny wrote:

> Did you decide something about this pull request? Should I improve it
> and send v2?

I don't have a strong opinion on it. To some degree, it feels a bit like
code churn, because I do not recall anybody complaining particularly
about the current implementation (and as we saw, it ends up as bswap
either way). But maybe others feel differently.

-Peff
