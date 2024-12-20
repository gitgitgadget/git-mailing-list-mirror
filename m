Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F376218AB7
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709947; cv=none; b=XzkaYXs/ZeVf3vvXN/Kkh8SiAZ1cuZ12EgqdBlROG6VCxLUXKxLGmEFjjSv/eFJgbnpOX2SDXrA4XOm72fkxNKGlAheIT8WNecb0lPe9CgTG6Gw8bciq0/WDNvgMTSTinkar7vJdmxiqdupA2kSkqyfeArZS1+H6i2I70cz/MdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709947; c=relaxed/simple;
	bh=qSdiztFTMHNYnyXm1KcZQm8B+GqPdmoUvORVjlZWQNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffbKpBcLRIreTZr40froMNM7qwjniNEZOjs2VHf20cW1JRFmNcQqVz8fSxPHpGqqUkXJS/f7Qazx4brjA4pj7/DqtBj+G/VSDVBAzrvbowzM7+rarYZZzcM7Y2E8ZxZX6P2VXu4Awb3w33pgyNBa12RXH/pg58u7GOpug1H42CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FzIs9tO4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FzIs9tO4"
Received: (qmail 13797 invoked by uid 109); 20 Dec 2024 15:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qSdiztFTMHNYnyXm1KcZQm8B+GqPdmoUvORVjlZWQNs=; b=FzIs9tO49ukrFdg8LmaamPKFjsplZ37RKEQ67ZZcMSdF6BePr9kRbnirhTeIQRGpAZrZRqKiOR440c+I00d6osvz89Vx0sFGhUe2d+phJ25dUOgEOT6LURRyr96l0NOdyW0MuLjGK7L621xYZ8WgKPuqCktcemTZg8FHeqH3WKNwl9wlMSZooHL42AcdI4iD9PANfb3OGgpzFSoI0U81dKWslKDl3zEjBiWXNmisccRTDEaDGtUphq+qx5c4DblRGU8Dqvxv3DlBMICSVHOPVG2jCvFPjFk2mxp83tWSMpL450wlmCBxvZwiWxHR7gx0jCjENtPquls+MDr0wLd8OA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 15:52:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18500 invoked by uid 111); 20 Dec 2024 15:52:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 10:52:23 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 10:52:23 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 1/5] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <20241220155223.GA152570@coredump.intra.peff.net>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-1-f1457a5e8c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-1-f1457a5e8c38@pks.im>

On Fri, Dec 20, 2024 at 01:22:45PM +0100, Patrick Steinhardt wrote:

> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index de0e63bdfbac263884e2ea328cc2ef11ace7a238..27f9d6a81f77248c652649ae21d0ec51b8f2d247 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -29,7 +29,10 @@ export GIT_CEILING_DIRECTORIES
>  
>  # First see if there is a version file (included in release tarballs),
>  # then try git-describe, then default.
> -if test -f "$SOURCE_DIR"/version
> +if test -n "$GIT_VERSION"
> +then
> +    VN="$GIT_VERSION"
> +elif test -f "$SOURCE_DIR"/version

Hmm. If $GIT_VERSION is set, then we set $VN here...

> -GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
> +# Only strip leading `v` in case we have derived VN manually. Otherwise we
> +# retain whatever the user has set in their environment.
> +if test -z "$GIT_VERSION"
> +then
> +    GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
> +fi

...but later we ignore $VN completely.

So it would work equally well with the first hunk dropped completely.
However, having an entry in the cascading if/else does mean that we
short-circuit the effort to run git-describe, etc.

I don't think the old code ever did that (we'd generate the Makefile
snippet in GIT-VERSION-FILE, read it back, and then make would still
override the value from the snippet).

So I dunno. I like keeping things simple, but I also like skipping
unnecessary code, too. Maybe if the top hunk were:

  if test -n "$GIT_VERSION"
  then
    : do nothing, we will use this value verbatim
  elif ...

that would make the intended flow more obvious.

There are probably other ways to structure it, too. The whole $VN thing
could be inside the:

  if test -z "$GIT_VERSION"

block. Or alternatively, if each block of the if/else just ran expr and
set $GIT_VERSION itself (perhaps with a one-liner helper function) then
we wouldn't need $VN at all.

I don't know how much trouble it's worth to refactor all this. Mostly I
was just surprised to see the first hunk at all in this version.

-Peff
