Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946B3AD52F
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482584; cv=none; b=AA+KPDtEcN7CkOovW0ht64n/xmUAsy8Fc4F5tdlm4Cunl+OZyKHtlwd7AxM2EL9zM/8fncYhCYgbAk432Oqr1JPPUZNsG0LDgK/Li7ewYeeLtQkxPvz3jBnnfAcm625aMaqd4RNqyGQ8QrRxV2py+N9yuDt7XK8/uSusizu/Y74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482584; c=relaxed/simple;
	bh=tx0Gtj8/yshmRHPDeRWvG0cL6odidzrHk7NdZrEZEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiFf1MpmeRPfywbaZAWY4CgnA1rojZagZ2v2ePADLj2NveJozcuL0k7Q+a9S/91e1WSTI8wJZ1nNcBjg7AmaODh352GmflXRDSxVMnccXA2uPof/YGCOf0FbsstL9T8StepuNMJTSxrlRHrIqR05ZZ3EKepHC31ZgV8rFQFAJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=GsYPrFCx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="GsYPrFCx"
Date: Wed, 3 Jun 2026 18:29:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780482580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx0Gtj8/yshmRHPDeRWvG0cL6odidzrHk7NdZrEZEgE=;
	b=GsYPrFCxtSwTlco/EajKjWjtJ3MDNiLrd/VxbYfsZz6TjMhJbbasz4dlfdrlvWhTMCnkrU
	lLdixHT6cl+d7obIbXJdGOCP95KeZn9GZcpbigzdJyh956iJ3f50T/WvPnrx4dG/I/yis2
	xUFhXcOVZc/NFUhioCyKL3Nt8VBhiV9XoZZwlstpjwbp6Uz/Qq/u/4VZRFNj1iPzAhNY2a
	dAciPNNzfX09qLkrgwBGweBrNFio3M6xl7Nioije5yiXMWouD/Ih7B8AhJoAhJsIeviIUK
	lXD5fc6wQmUrz28ogZEhWNoFxouGNhFs85IdJmWET4A6inKPsJfssHa7FzJsuA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend
 shallow threading
Message-ID: <aiACDLOtd_0_CCD7@wyuan.org>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
X-Migadu-Flow: FLOW_OUT

I'm afraid there will be some chaos.

As mentioned earlier, GitGitGadget now supports deep nesting of
iterations, if b4 changes while GitGitGadget doesn't, it would be
inconsistent in the archive. So, negotiation is necessary here.

As I know, b4 can generate a cover letter containing "Changes with vn",
e.g. in [PATCH v5 00/10], there would be Changes with v4, v3, v2, v1. In
this case, it is semantically correct that the cover letter of v5 is
replying-to the cover letter of v1.

But in traditional way, it seems that the norm is put a range-diff in
the cover letter. In this case, chain-reply-to makes more sence to me:
e.g. The cover letter contains the range-diff against v2, so cover
letter v3 is pointing to cover letter v2. (I don't know whether
git format-patch accepts several --range-diff or not, but if so, I
guess it might be painful to typing several refs, or copy and paste
from previous cover letter) Therefore, if git format-patch could
generate cover letter containing all the changes with v4/v3/v2/v1 as b4
does, it would be consistent, and semantically correct to pointing to
the first cover letter.

Do we need to consider backward compatibility here? ;-)

Thanks!
