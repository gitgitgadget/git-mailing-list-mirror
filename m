Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC22D9ED0
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589423; cv=none; b=AObm9YJJIGITCWfPdrKM5tocDP3A2kZiXIBzDs4v38rRfYO4rowCGDUh+OgR4HJOjCUW7mULg8CUkDTzS3O2mDwrK5Oa06oqrVm5ZIrfaxR06IObW9ADTdgmZEpZsYJk15Sf8Ap9GAObP6riSEcnWpjpfvZCojsrClxsMAUAsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589423; c=relaxed/simple;
	bh=2VhoQuwtftt4HCoCeOJOOQaVQG+86DOInM05imCgWfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4uKWH/uk1HQlwBhdV3/lZ183OWNadIVuT8aJWArmAsqsHMPr0b6kxCm0OZU16ddBqGT3UI0fXx5Rh7V6HcoU0WfdUxgUqjf7znZGLfnXlqw3vyjOLwxm6YOXHZ997FEyyUTSwaD7y97BGoLdZ3eWgZ3Nj9RSjpKgBLh41lBK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bWxWkJ7P; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bWxWkJ7P"
Received: (qmail 185086 invoked by uid 109); 1 Dec 2025 11:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2VhoQuwtftt4HCoCeOJOOQaVQG+86DOInM05imCgWfs=; b=bWxWkJ7PN0/i2PxN3BnQJlGXXjL+IN7wOn3FOWSS4JGwzvmUO23DrIl2atqnuQt20rEyKvijDbHcLS1m8m15cYt4EqR6QBxzVlbpDNjSfLWQg7YbjaIHFvPsyVQ74AKbWDkrPgNTtZly4JWPthfpguS7atVZu8HUS4I1CThFWQ2zPsk86tfN8vt6Dxi8hHnsagJk3oW3QtPlXZREk62HvVcHprcDeXK0BZGZpiqKEGdk2s6Ue8mJ/GIQm8yIQ3j4HvRQnVeA7qEZyDlc+XzqXEAuwo17YdRbkVhra+yVvhrtN1sE0d5nQSo1XaNvpdQyKWaSek25R8HwW2rzfqU3Qg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Dec 2025 11:43:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 270931 invoked by uid 111); 1 Dec 2025 11:43:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Dec 2025 06:43:42 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Dec 2025 06:43:36 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #10; Sun, 30)
Message-ID: <20251201114336.GA1559453@coredump.intra.peff.net>
References: <xmqq5xaqbxmk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xaqbxmk.fsf@gitster.g>

On Sun, Nov 30, 2025 at 09:05:07PM -0800, Junio C Hamano wrote:

> * ar/submodule-gitdir-tweak (2025-11-19) 7 commits
>  - meson/Makefile: allow setting submodule encoding at build time
>  - submodule: use hashed name for gitdir
>  - submodule: fix case-folding gitdir filesystem colisions
>  - submodule: add extension to encode gitdir paths
>  - submodule: always validate gitdirs inside submodule_name_to_gitdir
>  - builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
>  - submodule--helper: use submodule_name_to_gitdir in add_submodule
> 
>  Avoid local submodule repository directory paths overlapping with
>  each other by encoding submodule names before using them as path
>  components.
> 
>  Will merge to 'next'?
>  source: <20251119211030.2008441-1-adrian.ratiu@collabora.com>

This topic seems to introduce a race in t7450. Running:

  make && (cd t && ./t7450-bad-git-dotfiles.sh --stress-limit=50)

usually fails within 10 or so iterations, whereas without this topic I
can reliably get through 50 iterations (since it's racy, nothing is for
sure, but it seems to trigger pretty easily).

The failing test is the parallel one added by 9cf8547320 (clone: prevent
clashing git dirs when cloning submodule in parallel, 2024-01-28), which
is making sure we catch nested modules during a parallel checkout. The
race seems to be in Git itself, and not an artifact of the test (so this
isn't a race we want to wave away, but probably a real bug, perhaps even
one with security implications, according to that commit).

Bisection points to 099fe37397 (submodule: always validate gitdirs
inside submodule_name_to_gitdir, 2025-11-19). Which seems plausible,
given that it tries to move those same checks from 9cf8547320 around.

It's also possible that the race was always there and this simply makes
it worse, but I wasn't ever able to trigger it on a pre-099fe37397
commit.

-Peff
