Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21781C84BB
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079249; cv=none; b=k+6oarjB57WZUEQjh1PGojkwW+b/hKssCa8o1/pqlHc7cnJbxegzz+7AOa65eEx2mysFXK2fSQ8riUGpZHX+NOQPRMPVdjc8ZL0oGNJnkWhKZbweOVvJQEg++n/wYs7q/7mDz2BTrNEXAQQTGKQDUzZhMI7FYie2WIjo+KbZIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079249; c=relaxed/simple;
	bh=iQO831RzoKsuPiOgDWot1/irDFwYmW45N5LwbQVtdoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT+x1nyxVJFSBVWfGi9qTTh6pFW4n5HlS14IRkxx40W/EuExC/O08I+ICFffVdcPywfff0CVHGajSADWX/+SauPn9vE/juUdppOz4TuxfQUFipR5cK46DXeMaY0p3YtIbkSGnAHZ6AbsR8aZC/FONPC6cF3UgJZ7FAuI6Y7I4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XiKSmtj1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XiKSmtj1"
Received: (qmail 208764 invoked by uid 106); 21 Jun 2026 22:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iQO831RzoKsuPiOgDWot1/irDFwYmW45N5LwbQVtdoA=; b=XiKSmtj1e2lImGJOeI08Y1lm9Eu0y2EWGM1qd2dN+a4+9v9BThbrpfP9IhnB3mP0d/Pxyc0yo0/hYgpsXm41pQU0Ztlyv7p/z4FV+2s872iK7hMHMOQXhvLhLbX93OUbYYqxbB+jOlYsgkv/ReSWt72PucH8kOactjnLq5Z4DvD/bJ5RkdmHPuIfaoRDICz4Bbxmpj+dXqL17QYl00ONPwPBDtQJRVwDAD7c7wCS6p/Fv4+qlwLd1rW9jY4DNahAoTuVXgSt4aw7kark08M27eNswxH1s47jaQDTaPAqHDk2TU7HwBI5FTv6jepDLVgXOt9dH/CJ0Bw7IV9CfvJGiA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 22:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 526959 invoked by uid 111); 21 Jun 2026 22:00:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 18:00:48 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 18:00:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <20260621220046.GE2297179@coredump.intra.peff.net>
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net>
 <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net>
 <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
 <xmqqa4sog1e9.fsf@gitster.g>
 <20260621172432.GA2206349@coredump.intra.peff.net>
 <20260621174518.GB2206349@coredump.intra.peff.net>
 <xmqqechz60ah.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqechz60ah.fsf@gitster.g>

On Sun, Jun 21, 2026 at 02:39:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > BTW, I don't think diffcore actually has the information it would need
> > to do so. The racy stuff is handled under the hood in ie_match_stat(),
> > which returns only a set of "changed" flags. So the caller cannot tell
> > the difference between the two cases:
> >
> >   1. We checked ce_match_stat_basic() which said "no change", and then
> >      is_racy_timestamp() was false, so that was good enough.
> >
> >   2. is_racy_timestamp() is true, so we further did a content check,
> >      found nothing, and returned the same "no change"
> >
> > Obviously we could pass back another flag, but that would disrupt the
> > other callers. Hmm. It looks like we could pass in a flag to say "assume
> > racy entries are modified". And then they come back to the diff code,
> > diffcore_skip_stat_unmatch() sees they're not real diffs and suppresses
> > them, but we _do_ count them as stat-dirty.
> 
> Yeah.  Because ie_match_stat() does have access to istate, we could
> add a new member to istate, next to "updated_workdir" and friends,
> and smudge the bit when the is_racy_timestamp() goes to the
> compare-data codepath and finds that we are better off auto
> refreshing.  Then "were we told to do skip-stat-unmatch and actually
> found some that is worth refreshing?" code can be taught to pay
> attention to that bit as well.

Yeah, that sounds fairly clean. Though if using nanoseconds works out
and makes racy entries extremely unlikely, that is better still. :)

> This is a tangent, but why do we call refresh_index_quietly() in the
> central code path in cmd_diff() in the first place, I have to
> wonder?  It should not matter when we are comparing two tree objects
> (or two commits), at least.  It of course is not hurting, though.

It seems like it could probably just go into builtin_diff_files(), but
are there other paths that might hit stat-unmatch entries? Maybe the
builtin_diff_b_f() path?

It probably should also support --no-optional-locks, which is currently
only respected by git-status. I don't think it matters that much in
practice because the point is reducing conflict with commands running
frequently in the background, and people don't tend to do that with
git-diff.

Back when we added --no-optional-locks, the idea was that people could
apply it in more spots if they ran into them in practice. So I guess
nobody has with git-diff.

-Peff
