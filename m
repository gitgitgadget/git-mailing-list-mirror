Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943EA4A35
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774647962; cv=none; b=B/FUsLUAnjFhyLdphS2MLrbuHdJwQy8TU/pRe1lNfgL0+4MpiaPOyCCwJFGi7yApdT2+zj9oakQXm1I7HlqDMZpGWIXO+K6MiFCtTyajXbpLGZ/qByRVPfMd3tO3w/o1Oyvlsneq5TnSR35jETFOwGjfNa76YIOBBs0qqhxGATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774647962; c=relaxed/simple;
	bh=0TXMIdM6Jf5nIiuPN+oun0aGJJYMhvsLIfGZl/i5v9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozSW7G83mvEWi77NEfJXpXz7sIPDxMVA8IVxinzJpnBYbv6N5ZhRecMbrM5I0CH1Iru2xYq3vr4FhsQVBrReDZdPu1F5QuuSBEvNReuGtbve5/clBJw5jmOmq7GnniDAdPSbzdXo3dtzsFHAkJ5wiwk+hwqPd5raGjeOh1OjNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cIDbOMPz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cIDbOMPz"
Received: (qmail 171151 invoked by uid 106); 27 Mar 2026 21:46:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0TXMIdM6Jf5nIiuPN+oun0aGJJYMhvsLIfGZl/i5v9E=; b=cIDbOMPzOSU7IWBI8xNi+e9McagGp2VS7IKFp/XisM2C7BFZFyx4EcZrF+CQ/BpM/fPlm+s9BVveyY1h46N8n1ClkOt4EHFZI6ntIfOLfBa+9jH0Qz3wpez8iz8KqPOd6KIq597puZp9vUfT3/hRKkG0yOtYAIPtt2twMfWY0cVYS+f3bCCM6MjlTO2VKymTR5UUPoA25Od9OBibbjisbOY85OxqTgURsL3kgif7IFXAj7NxAB72pi8VF+X4iAkV7ZjudOq3/qYhatpii6R/+/OxDEMCzEsd36CjPwrErh2U9vn7RE7nA59zHMbjKhHUulM8eOPuyjdtf7iSxhNlzg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Mar 2026 21:46:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 239876 invoked by uid 111); 27 Mar 2026 21:45:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2026 17:45:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Mar 2026 17:45:59 -0400
From: Jeff King <peff@peff.net>
To: Wesley Schwengle <wesleys@opperschaap.net>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 3/3] connect: Add support for per-remote and
 per-namespace SSH options
Message-ID: <20260327214559.GA599365@coredump.intra.peff.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-4-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326233739.2911354-4-wesleys@opperschaap.net>

On Thu, Mar 26, 2026 at 07:37:38PM -0400, Wesley Schwengle wrote:

> The following configuration is supported, in order of precedence:
> 
>   1. `remote.<name>.sshIdentityFile' and `remote.<name>.sshOpts'
> 
>   2. `core.sshIdentityFile.<owner>' and `core.sshOpts.<owner>'
> 
>      Where <owner> is derived from the repository path. Nested groups
>      aren't supported: git@host:owner/repo.git becomes "owner",
>      git@host:owner/group/repo.git also becomes "owner".

We already have some conditional config mechanisms, and I don't think
it's a good idea to add one that only works for certain keys. If I
understand correctly, this <owner> feature can already be accomplished
with:

  [includeIf "hasconfig:remote.*.url:**/owner/**"]
  path = all-your-options-for-that-owner

It's a little more verbose (and you have to use a separate file), but it
also allows other conditions, like "gitdir:" for selecting based on how
you lay out your repos locally.

-Peff
