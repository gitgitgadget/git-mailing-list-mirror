Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D412E040D
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154800; cv=none; b=ZMUtaM2N6XRqo5l0794tGTuThoCEyB9sttsJ7JOhlRpsTkHmT1xj1jq4pYfO3BdXC5pqswtr71djfLDkM6fUBzGBKKMDKyAjFPJKY2KMry54UVwZ4vX2sfn1QKcVeyGSOGAN94g2xZDPzP/yYfjoexagSY/tJmaiXxbfLH7UNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154800; c=relaxed/simple;
	bh=duzRmY7wgV8bg4AgOIUzPW1LfXAXcqn6guwEmqC8wCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJiEb5UYXufIEGvpZ7xQxHyJXoOFKb48zKZTRqxtPze8z+L4psRZMB+t12WwgQSGivOmFYl23+e8XUZoUb3aKt0zxmudoT3AAEh0I0PC4nhQvEMfDFF2ZAqk8SYmQcJTKW8h6g6YseUCd8XC8hrVK86IqaSSRslw0s3rh0pDEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CJLuTK2x; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CJLuTK2x"
Received: (qmail 456740 invoked by uid 106); 25 Apr 2026 22:06:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=duzRmY7wgV8bg4AgOIUzPW1LfXAXcqn6guwEmqC8wCQ=; b=CJLuTK2x6vJGUvfqO+8lQIL4YfkcP6vquOvjlabYTKR0p5V6Cyq++P4IcsY6se6sOFh2i2aYTCEPIHINqUrSWfSA+Tm0Ed0DUlC7TVje5gy6NljJqa+0W0Ko/ucgPet5ZTySt3qB6JzvnvOrTAUpx5RQBgtk481UFgRYREMs3ctBWzZ6PsNdUjShypjfWmQLE+HpP0TA1FmEIgxkwe1zAWmF2T8uUSLmLyB8Orun3Q2vR3ICBztUtHmcRRVPR7lIwD310HHf9gYjZD4Je07W7tcfv457EriLxT6i6bKQaqP3CizoxynfPlZEIQRtViLXl1mGNu74/x8LP8hcTz6LQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Apr 2026 22:06:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1036423 invoked by uid 111); 25 Apr 2026 22:06:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Apr 2026 18:06:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Apr 2026 18:06:29 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] remote: add --set-head option to 'git remote add'
Message-ID: <20260425220629.GA28590@coredump.intra.peff.net>
References: <pull.2283.git.git.1777115978088.gitgitgadget@gmail.com>
 <xmqqzf2q8zxc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzf2q8zxc.fsf@gitster.g>

On Sun, Apr 26, 2026 at 06:58:55AM +0900, Junio C Hamano wrote:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Mirror the behavior 'git clone' applies to its first remote: after
> > fetching, set refs/remotes/<name>/HEAD to the remote's default branch.
> >
> > Equivalent to running:
> >
> >     git remote add -f <name> <url>
> >     git remote set-head <name> -a
> >
> > The new option implies --fetch.
> 
> Should this option (and the auto mode of "git remote set-head") even
> be necessary as an extra thing that the end-user should need to be
> aware of these days?
> 
> It feels to me that the "fetch" part of "git remote add --fetch"
> command should behave in line with what "git fetch" from the remote
> does with "remote.<name>.followRemoteHEAD" configuration.

It already does, doesn't it? Doing:

  $ git init
  $ git remote add --fetch origin /path/to/some/repo
  $ git for-each-ref

shows an origin/HEAD link.

Which I think is not too surprising, as it is just calling "git fetch"
under the hood.

-Peff
