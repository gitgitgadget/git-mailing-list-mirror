Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F719AD8B
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801144; cv=none; b=o9BXQJGhAuvBJs8TXobhRg375CEBu/r8Lhim6/5aPNVW545LkfxWlW1zz/HvD5PLPvqKWSwbTKHUnBa6yPCwboL6GJOIVVv88tMUXc7od5QJ8YpDzjyu4Vj6Uag9sn9+rsAA+XUtAQxoHpf+Ks4zrNVkwsTQL7XbP3UP2VIipt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801144; c=relaxed/simple;
	bh=CC9BaJvy05XQ0pbtt8R2oYXufKuEh+a7gVc8OeCsfAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in62yXR8btZGxI9JEfsrE9Z6mJBYZ0cIFB56G3YmJHEWENcC0SFuB0IV0OtQ+oiKLt65eADttPhl4QoV8fvRnRbxEpA/345TVfZ/2uTAhdFmiga2r4No7pONniP3bBCy8Cg5kvcEd47jUBUp/0m12mckS+M7WEi4w+izBCBtqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XE1H7t6x; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XE1H7t6x"
Received: (qmail 244343 invoked by uid 109); 3 Dec 2025 22:32:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CC9BaJvy05XQ0pbtt8R2oYXufKuEh+a7gVc8OeCsfAk=; b=XE1H7t6xC+IZjGd8Khxh1f6Oe8Bd4Bm5qu4mVNh/qIdZAb/Hlk73hTF0iqGFGwRp9aBHAUGUd8YPQw56BrXGx4OHqYFT1WLONLsql3AWJTYgSlKEwkNAKkPFCpFtKyByjUppyV6kC9XXZzlFFQOH0bTA3VQSb3oKikZ/svC25NF/aZttwzO8In/gstGGnRKJJ+l6evgM3KE9yyD1eEkVVKRr0Z/dMPPLvT0yNf2Cl7Lrmpqfb7L48Z7cutm5i+xBgdxhMrfeavrIY4ZP3l5F0El4p+Cj353BVmPYTiR2yiGMxXX9QiOJTt88bklnVO5hv5O+sZthelmrkesyN6lacg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Dec 2025 22:32:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 311737 invoked by uid 111); 3 Dec 2025 22:32:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Dec 2025 17:32:23 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Dec 2025 17:32:20 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
Message-ID: <20251203223220.GA66584@coredump.intra.peff.net>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
 <20251203211610.GA64204@coredump.intra.peff.net>
 <xmqqsedr5hrc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsedr5hrc.fsf@gitster.g>

On Wed, Dec 03, 2025 at 02:21:11PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I dunno what that means for your patch. I notice that the user has to
> > enable the feature manually. But it feels more like it should be
> > selective based on which subsystem is using the lockfile (so refs would
> > never want it, but other lockfiles/tempfiles might).
> 
> Or perhaps the way to opt into the feature is to create an empty
> file $GIT_DIR/lockfile-audit, and the lockfile subsystem will append
> to it every time a lock is taken?  We need to ensure that a PID and
> pathname formatted into a single record is small enough and O_APPEND
> would relieve us from worrying about multi writer races, which may
> introduce different kind of complications, though.

I like a single log much better from a management perspective. I agree
that atomicity is a potential issue, though. I think that even if we
kept it small, network filesystems like NFS do not provide great
guarantees for atomic appends. Something like flock() can work there,
but that's not something we've relied on before.

It also raises questions about reading (do we find pid files in the log
in order to provide more directed advice?) and maintenance (do we ever
clean it up, or just let it grow without bound?).

-Peff
