Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A5279329
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782450379; cv=none; b=lO3CaEA5Uj9UGQLhO1yL7HTPWcQpGF8721/1/zFaz+Osv9J39jo4VnR+Nyw/1G52X6IgjvgHVuWGZpbK8Crl4Jy01p+n3sJ2d0GXgOedR22Vsjwgr5ufQetytyL7FC/cKPcbTQioep+yMAA7cEUtILOapTRKZpC6xhJ4ULgJDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782450379; c=relaxed/simple;
	bh=p8cS1bftW1DjnQlxbdC6V1MaOjoMKbIUImBGfk5sXAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCovbde91/22kSazYfs40hhmtzNGdKD3E9LqCqw0evKdEjxf3U43/vgFFt1sHXdEm0foGFBoMsI7OVf2jov4TnCbR7QQMVTKsnbuLAsddnkqg8ah4VwyedgHQ4HBDoHl1pA3BzpqcyjOlbIncxtNmAlYEs/ywdvZnNCZZPKZDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DYhx6xU8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DYhx6xU8"
Received: (qmail 37184 invoked by uid 106); 26 Jun 2026 05:06:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=p8cS1bftW1DjnQlxbdC6V1MaOjoMKbIUImBGfk5sXAE=; b=DYhx6xU8v/nnPWoe+Zul2KNmD1hZzrtAgpyURTFaZhBDyzO2DNFbEM21tddEm5gcQ3QA4N0D2xLyhqNi6212iHf82TMLJ8qA0SsbL5uWRTvqp1D82iq4v3j1FQsAE6XWKKscSNnLE6+GoVVVMxjNerRcATmSp+kvlMW0zDGSl7R6HaEuySZg7F3inzbePMPxPOl7JTd1zAQk5Qla/F8KyggccAIoUYtoNfhKtpTr67gTEQKcPwYsqeZXhAzEU3k7dSk5ywDznsIma0AGVAv6RgyUP9IIFi9cSldd6ltE2gOnDLpA6FlNWVX7evFUFcRb9hNxeRG85rXlaWhZO/MW3Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jun 2026 05:06:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 77987 invoked by uid 111); 26 Jun 2026 05:06:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jun 2026 01:06:08 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jun 2026 01:06:08 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v6 00/11] refs: fix "onbranch" conditions
Message-ID: <20260626050608.GA3138423@coredump.intra.peff.net>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>

On Thu, Jun 25, 2026 at 11:19:58AM +0200, Patrick Steinhardt wrote:

>   - Fix the "onbranch" recursion properly: instead of papering over the
>     issue, this series now refactors reference store initialization to
>     not read any configuration at all anymore. Instead, the config is
>     now parsed lazily. This fixes the recursion, but also makes us
>     respect configuration guarded by "onbranch" conditions properly.

Sorry, I was offline and missed reviewing some of the intermediate
stages.

The approach you take in v6 looks good to me, and I'm glad the result
does not look too painful to maintain. If we ever add a config option
that is absolutely required for initializing the reading side of the
backends, we'll be back to our chicken-and-egg problem. But I won't be
surprised if that never happens, and if it does, we can decide on the
user-visible interaction with onbranch includes then (and whatever the
result is, document it).

Thanks for taking the time to re-work all of this.

-Peff
