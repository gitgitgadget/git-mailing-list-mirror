Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451D335081
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474947; cv=none; b=bicotOU+UjT8C+ljBeXOfDceLylDSHmYiSvl1kH+2aBGZ/6waCdZapwrAjnJ8IT33dRfzmb1GSsRw8Lk3kriHqSD5UXjoFF2AK8232YvLnxCBOCPb2D+I8fA7MdgsPi8PQeXkzxb3xRDpjOmAAY0AvrJyUq/i19/ypRlVzveTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474947; c=relaxed/simple;
	bh=mFV+v5tloArRsNhu1DTE/YyP0uatDTzc16nNJjLJ3WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+vzH356TPBu0lEqcHsaKO78JnG6r+jc58HfRIw7TEx5DCJ+hFL6Zgl9hSEPKVFiwBZ1kxf8Fn1GFyL58Z2/9VjEwUrowNjRy5H38uTPMwS0vOmqSP68fkkUvEJP9s2YXwy6bl5hRfphn5x/tBpXvFrCzT/oGwhQbV61q7NpgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QSZv81/Y; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QSZv81/Y"
Received: (qmail 29308 invoked by uid 106); 2 Mar 2026 18:09:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mFV+v5tloArRsNhu1DTE/YyP0uatDTzc16nNJjLJ3WY=; b=QSZv81/YSbWMyCkI1Kbbi4Jv1PxqdkI5NlFKiOZUKL/I2Zz2gkTrjc4/XR25F4adhp/ctHgISf48zAnepcy9fiySK/PMeUzEDu359+7VjvbgetWpoXEGVb5fbRjh5zw6NdER2pAyghsZr4VMJwIioi1Z3d9lVn7foLq1+V2txHt0OUwBx6r+8Bj42WXSI6v78KYmjIXi3SozO9YcKdugwvS72diGrw9O2Df3hCH+Mi6KdWt4mpBcjlKjcSyMKU7RV+WItV6YHzKzabNW9Bbybii+TvorNW7E221lDItiFSlNs5Zjk0OtOPBmT7DGKPFCCSH4km0BvIATDhEhC9wVdw==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 18:09:05 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 333974 invoked by uid 111); 2 Mar 2026 18:09:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 13:09:05 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 13:09:04 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
Message-ID: <20260302180904.GF28275@coredump.intra.peff.net>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g>
 <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
 <20260225131344.GA2139176@coredump.intra.peff.net>
 <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>
 <20260227224238.GA2956443@coredump.intra.peff.net>
 <cd9adbd9-b996-46da-b6a8-d2395be79a0f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd9adbd9-b996-46da-b6a8-d2395be79a0f@gmail.com>

On Mon, Mar 02, 2026 at 10:31:48AM -0500, Derrick Stolee wrote:

> > I think you could make arguments either way about what should happen
> > when spawning a command in another repo. But I'd really prefer for us to
> > have a single spot to specify that policy, and not subtly-different
> > behavior from different commands. So I'd really like to see this using
> > that other function (or the logic from it factored out into a helper).
> 
> I agree that it would be best to have a single place.
> 
> I was looking at prepare_other_repo_env() and saw that it requires a
> computed gitdir, which is not easy to compute. We want the child process
> to perform that discovery based on the -C parameter.
> 
> However, we can extract the existing environment clearing logic and use
> that here. I'll give that a try and confirm that it passes the tests
> that I prepared to fix the bugs in this version.

Yeah, that was exactly the refactoring I had in mind. What you have in
v3 looks good.

> > Dropping GIT_CONFIG_* from the environment does make sense in general,
> > but it doesn't actually happen with the patch above (because only
> > GIT_CONFIG_COUNT is in the local_repo_env list; to find the others we'd
> > have to actually enumerate the current environment).
> 
> It has GIT_CONFIG (the local Git config file), GIT_CONFIG_COUNT, and
> GIT_CONFIG_PARAMETERS. My patch was wrong because of the string, showing
> the value in having tests to confirm the right behavior.

Ah, I forgot about GIT_CONFIG (though it obviously would not match
CONFIG_, even if we correctly said GIT_CONFIG_). It's mostly a
historical oddity for git-config itself and can be ignored (other
commands do not even look at it, and we'd never set it ourselves).

-Peff
