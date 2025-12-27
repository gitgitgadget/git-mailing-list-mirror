Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1531C5D44
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821828; cv=none; b=Q3Qo3lGWq7LKadNkjr5lZgYKk7nTwFG9i+js/XAR/RgPlR6tCyXF4sxWfR+Q/fHHXks8+x2vSZL0aBzK5YEfXMGvFuX4lmezmL2krsv3TUxvNAvlVMJWd73syNssevri+uHGKAVjoGXY3h3wRU+jiAmkBaKJEYc2J4RbCGP+i4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821828; c=relaxed/simple;
	bh=BLuHJcL0rXgszumO4mWXtu17/bEAxHu/Lam68ru1rZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh/ys6ac8X+rtrIVka+6hqv10yfIqwbc9l9ZwhlSEcjT2am0woFsxgvd3tITqrI1V3ELIBPGtCKkwesuGepKKI73v/fhLJR9jKVEMCHl/dmspKn8Pr805PKGBdDjpyRCfWX650bOI7stSEgdE9VhEuT8bgnbQkaTevP+4rguui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PUv6WeSZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PUv6WeSZ"
Received: (qmail 495714 invoked by uid 109); 27 Dec 2025 07:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BLuHJcL0rXgszumO4mWXtu17/bEAxHu/Lam68ru1rZ0=; b=PUv6WeSZn3ntx97kRfBm1CFvn0FoQl4C8IyXkS57QNnTnyWd1hpFAGD9+24mptqEbMF7jtig9rxUMO1E601wChHwE0EkVDj8OUiojf343C7qH80/Qau1Fs6las7/OmOy039rWOD+zfyIJULDLYX7zJSpppf4Zyy83g9a9PoV2djER7YoDH4jR/igyeikawoSbFAK5sqxO7bLfOHPzy4Pn9EwNH/b8+YoQMR28sGGLLxYsruhi3jomywoHlmvmN+VmismZxbFolIHltIF76kjAIrb63iBS13y2BqrKaTApdBZ/S1eLncKlbfXIARHvmNrEUJkkuOxtP7OY7g5+Kv2UQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Dec 2025 07:50:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 643063 invoked by uid 111); 27 Dec 2025 07:50:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Dec 2025 02:50:30 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 27 Dec 2025 02:50:25 -0500
From: Jeff King <peff@peff.net>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
	Patrick Steinhardt <ps@pks.im>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v3] lockfile: add PID file for debugging stale locks
Message-ID: <20251227075025.GC2071715@coredump.intra.peff.net>
References: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
 <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>

On Wed, Dec 24, 2025 at 12:24:13PM +0000, Paulo Casaretto via GitGitGadget wrote:

> For a lock file "foo.lock", the PID file is named "foo~pid.lock". The
> tilde character is forbidden in refnames and allowed in Windows
> filenames, which guarantees no collision with the refs namespace
> (e.g., refs "foo" and "foo~pid" cannot both exist). The file uses a
> simple key-value format ("pid <value>") following the same pattern as
> Git object headers, making it extensible for future metadata.

FWIW, I like this approach, as the earlier collision possibilities in
earlier iterations made me a bit uncomfortable.

But then I wondered...

> The feature is controlled via core.lockfilePid configuration, which
> accepts per-component values similar to core.fsync:
> 
>   - none: Disable for all components (default)
>   - all: Enable for all components
>   - index, config, refs, commit-graph, midx, shallow, gc, other:
>     Enable for specific components

Do we really need this complexity now? I can see reasons why a user
might want to switch the feature on (because they want the extra pid
debugging info) or off (because they do not want the extra filesystem
operations or potential cleanup hassle of extra stale files).

But if the collision problems in the ref namespace are now solved, does
anybody really care about turning it on just for particular subsystems?
I'd think they would want all or nothing.


Trying to devil's advocate myself: maybe somebody is concerned about
filesystem overhead for frequently-written files like refs but not for
others, like config? That feels unlikely to me, but at least possible.

But if we were to ditch the subsystem-granularity for config, then all
of the extra LOCKFILE_* arguments here could just go away.

-Peff
