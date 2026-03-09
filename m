Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D13ED11D
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084607; cv=none; b=IRwV6LV0LPoBMO3gaUzmtUg0RRy2F+BXXSKKVD10xpjbxsEtnwf4JxkbNjCX49uxLaBcsEKFNOQaBAPNRGvqnLMJwdFIb3Rr3fRHp3ZLii15ObiwnEM5HYwIZb0TSDIGcsYj107PhqmC6mgn3ycIQ3o5WSOu8GpnqRXxSWjINPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084607; c=relaxed/simple;
	bh=fMh1vuH73gfKNnVRWcoauPsiWGJlQ03T+Ykim5xM8ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvx00hRcbNWfkDouIAS0eDkHeBxTeyw8auSPLZrPB4hXlAOUiSTn8HItFWGHRX7f5FYewapekofUfCV3WCsC7+TfREhC96Wswk8FD/Zz5GzmpMo+dq48qza7hGqDW52NlnEdtbu6cCpEtxtcH64SsjpyP1rFIL5BVtZcOrVbdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YN8XVN2i; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YN8XVN2i"
Received: (qmail 49843 invoked by uid 106); 9 Mar 2026 19:30:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fMh1vuH73gfKNnVRWcoauPsiWGJlQ03T+Ykim5xM8ng=; b=YN8XVN2iYVL+5noyxyeGqenN2OUdr/xUrs0tcIyZ/ty9OTGiosMpFFkD6wWoxlLWc4deuwS2js/EAA8vG+O5BB9vVWm5xySzu5dSasdw4NlMwHYrkm8+eAB2cE+QepenqkwdsCqulY54Hv7iN//eD+e7EQ25uZUCAKQ78z8t6z7hh0eKJ4cDydZomYfrQWkfziw/K21lX3yPAAHhvfWorpeXQZhlz3/E2i7oeYMizDswG+RUlwYBXQatsAkuvWXvJIPXp/xpyGcW6MRED5suTMHTjBRgcws+P0RjoFdMxU99E7t8uw8U33QabqTSgxG6teQ4C0SoL6fzMjG9Q3RG6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Mar 2026 19:30:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 458347 invoked by uid 111); 9 Mar 2026 19:30:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Mar 2026 15:30:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Mar 2026 15:30:01 -0400
From: Jeff King <peff@peff.net>
To: Florian Schmidt <flosch@nutanix.com>
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: Option for "git submodule foreach" to also run on the parent git?
Message-ID: <20260309193001.GD309867@coredump.intra.peff.net>
References: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com>
 <xmqqsea9591f.fsf@gitster.g>
 <66419a04-67b0-4b60-bf23-078cf92b2c04@nutanix.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66419a04-67b0-4b60-bf23-078cf92b2c04@nutanix.com>

On Mon, Mar 09, 2026 at 05:43:14PM +0000, Florian Schmidt wrote:

> > but at that
> > point, wouldn't it be simpler to explain what you are doing as
> > 
> >      do-this . ;# do it here
> >      git submodule foreach do-this ;# do it there all over
> 
> That's basically what's I'm doing. I figured instead of doing "foo && git
> submodule foreach foo", a "git submodule foreach --also-parent foo" would be
> marginally neater. But I don't feel strongly about it.

These days we also have git-for-each-repo. It is primarily about running
a command in a set of otherwise unrelated repos. But I wonder if:

  git for-each-repo --submodules do-this

would be a natural fit as an alternative to "git submodule foreach"? And
then you can imagine a "--current" option to discover the current repo
and include it in the list. And then:

  git for-each-repo --submodules --current do-this

would do what you want.

I dunno. I do not have any need for this myself, but just thinking out
loud.

-Peff
