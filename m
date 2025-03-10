Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329C21E0BF
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622921; cv=none; b=HRtG/xpcaJlEJjRou00SYDCIpBS7gnrw/bmdclLwxkQPopz2bTX4X1Nqhj4aSDiNJLV/IYFz0f76X49o7LDauxU4rN//LIPmRer/ib9lryYp4NobcVmpbbjigzE/9RrCB7cLePx+1DOrgpmgyR7efIfmNgQ8dM9KUF5j6qefeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622921; c=relaxed/simple;
	bh=ELRXxKun5NwpTjoJsOKBmxGyx1nxpp6JomqQLOQpAHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJpMV/X3U//Z0LINH4ky01IRj33vkdDJLvOOuhJyEV3CR8FM3k7GpId0yfT8pqMRpnC8QHDEjLUWOAOL+mfXgqwJSfOxuOVydU3Jkikn2qikjMjeQClLDYjATToVujNyTTA9zx69VBj7CNT0ve/bowkf1n/tNJQLsERGYrKKAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KxRpjB9N; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KxRpjB9N"
Received: (qmail 24097 invoked by uid 109); 10 Mar 2025 16:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ELRXxKun5NwpTjoJsOKBmxGyx1nxpp6JomqQLOQpAHc=; b=KxRpjB9No7vgkct34jkbW5y6b6NqzHpFmjxQ3/+Xmai017p3E/pwMU13aZq9hfMAEoii6E1WB7GkZI+zND2u5IgcJDw8nbN1yWKHHIIgCuN2mgEu9vt35Fd9hu0xn+L1wm559ycRgSWlKboYfWi7s9b3kYE2T0EhYpu1t8igeVYVnZInlIPzdDqPNhIAiUjx7qJI4WcRpy0DPehMDqGu8lKBb6ikQqeQY4QWjIiRyWLOIa3mkb/G5MT/4p/QQRG+If/8nqi1nXBv1gjqhifUhTTXVRo13zElCoZAUSJTyGHf66NQAWNVBnBOOxwvzdAtbWNwZqd8xAu9Ud8B+8du6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Mar 2025 16:08:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29520 invoked by uid 111); 10 Mar 2025 16:08:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Mar 2025 12:08:38 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 10 Mar 2025 12:08:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Benjamin Woodruff via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Benjamin Woodruff <github@benjam.info>
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
Message-ID: <20250310160837.GA26308@coredump.intra.peff.net>
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
 <xmqqo6yejg0y.fsf@gitster.g>
 <20250309033908.GA2361799@coredump.intra.peff.net>
 <xmqqwmcx9io3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmcx9io3.fsf@gitster.g>

On Mon, Mar 10, 2025 at 05:25:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > .... What
> > git-status does with --no-optional-locks is to update the index
> > internally for its _own_ use (giving it the correct results), but not to
> > lock nor write out the resulting index (to avoid conflicting with other
> > running programs). So it's pessimal (losing the opportunity to share
> > what it learned) but prevents lock contention.
> 
> Yup, that sounds somewhat sensible.  I also have to wonder, other
> than commands that are clearly about changing the repository state
> like "add", the inspection commands like diff and status should
> always opportunistically write the index back, without even being
> asked?

Yeah, certainly it is a potential source of confusion to have a
conceptually read-only operation take locks or modify the repo state.

But I'm not sure we have a sense of how valuable that optimization is in
practice. After touching some files, every git-status, git-diff, etc
would end up re-hashing those files instead of using the stat cache.
But maybe that is lost in the noise of reading the files to actually do
diffs, etc? I dunno. I expect it is more important for status, which
probably does not need to read the whole file contents in most cases
(and which may be run a lot from the user's prompt, etc).

It seems like a big and possibly risky departure from what we've done
for so many years. I'm inclined not to rock the boat too much. ;)

-Peff
