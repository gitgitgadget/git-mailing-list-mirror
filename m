Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F53214812
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170955; cv=none; b=Kypc61d7dNq5sDJAlbwN0kx+AfYovxp18ucj7q71CK5XbDZVG0ItwACpfCdJyeS4zshijnR4+rthXupsEBCczj3H7ZT1gsGw4s90YbuHfhvyQmE1hCuouG9ptZkrzxuq4KvXOwxwOwaVHnRnu0rOr47scpKi8L40TuwG8mEd+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170955; c=relaxed/simple;
	bh=LpWWp0jfofE1vmLZAy0LMrasZPPZRPouLyV78ZmPZZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbJzBmEKOyz5QcMzKT8F42OPtpGuyFoBrU92TCUDljUONlik5LLC/T5LM7hRa9IDX0gw44ldNBqeiIUsWhrKCe6pvZX5TrKw8XMnX2dgPi3KeJCqHgEbCRw4HeEmoBhVjI2ssG/plAuDo94Y428/spysY0FJJK2FYOAijA7f0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cTVobcZ7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cTVobcZ7"
Received: (qmail 273036 invoked by uid 109); 4 Feb 2026 02:09:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LpWWp0jfofE1vmLZAy0LMrasZPPZRPouLyV78ZmPZZc=; b=cTVobcZ7gd6bNoiyDxV0M29i+PxNHY7fvOYopB6SnwsHc9vcIt2OZRHe7GeJ4Ez4hGB0gJxAH5Fx30siCaqt0yF0hhcTpgZL3h3Kz1Rp9qgGeX/qyVg+w1NHPIhJY0lt29w6e9+ldLdbNHyiNJghW9tvItYWziY1azYH8mnwEiLJ1RHt2RY/Cw+kOz55m7dajOkCA86F/K/XMZaYmW2RcAbFfAzDvwKh2+he1M3fEquuE5TqBw0QcauXyAGDofl502nyRFgykJKGfxZuqTucV6dTmQs3IrK/+3f2u35aiBea3y26yDAaTLLblKfm3GA2bMae1qM9hl3LZqBW7i9fsw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Feb 2026 02:09:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 540595 invoked by uid 111); 4 Feb 2026 02:09:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Feb 2026 21:09:16 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Feb 2026 21:09:12 -0500
From: Jeff King <peff@peff.net>
To: Chris Packham <judge.packham@gmail.com>
Cc: GIT <git@vger.kernel.org>
Subject: Re: git format-patch --no-renames
Message-ID: <20260204020912.GA350923@coredump.intra.peff.net>
References: <CAFOYHZDn-e5P9Rs3=2oS857QvYnHbpYq23x3RCkDWTTVGg5gNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFOYHZDn-e5P9Rs3=2oS857QvYnHbpYq23x3RCkDWTTVGg5gNA@mail.gmail.com>

On Wed, Feb 04, 2026 at 08:58:29AM +1300, Chris Packham wrote:

> The man page section for the --no-renames options says "Turn off
> rename detection, even when the configuration file gives the default
> to do so."
> 
> But I can't actually see what option that might be.Does git
> format-patch use the same config as git -diff?

Yes, it's just diff.renames, which controls rename detection for most
commands, including git-diff and git-log. The notable exception is for
plumbing commands like diff-files.

> Selfishly I'd like `git diff` to show renames but `git format-patch`
> to output things that can be applied by `patch` (specifically a
> version that doesn't understand renames).

There's no way to do that right now via config. You'll have to use
"--no-renames" or "-c diff.renames=false", either manually or using a
command alias.

If you want to change that, the usual approach is to have a
command-specific option that defaults to the more generic one. So add
format.renames, and if it's not set, fall back to diff.renames as we do
now. There's some prior art in the merge.renames and status.renames
options.

-Peff
