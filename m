Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E9493646
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787546913; cv=none; b=HUk8KucCHtiSaPQp9hFK531drKmPfEH7VQqBSD4Uyu7fLuKd+fx66The9jrNY0MlEavMVVmqBO4ZxIXf6ZyQw4lnvO4ZDF86vD4fiqwxI+0Lks9Gr1BsIy7Uw0NIm6IYgRpj/fyReZHrgqG2TbiOZYw2bBbPdxM6hQeWvrxxSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787546913; c=relaxed/simple;
	bh=ZONOsNC3PXvmeJQU+QDaFyIeL92m81evcAQc4SsjpUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyKSqDGs36FIUo38CJtFYyyVcETEFhdyxG9/iStVteoUHVmKu7EfwBX6EULENeXLBmsXVsTybB4dg7kberSzvp2yvb77XcFNseN5JEhb+hA7Op6GhpC0Qr8xIRCvL3JWm5uqOfC3XbRrYUiX+l+iS9UjYssTVfEq7wS4AiJcj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FuPZq05J; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FuPZq05J"
Received: (qmail 104031 invoked by uid 106); 24 Aug 2026 04:48:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZONOsNC3PXvmeJQU+QDaFyIeL92m81evcAQc4SsjpUs=; b=FuPZq05J2k/e5Uj6XC/C5PVzDMZZ3mD+YJ50nOQ56bWmzrFWycLRkfE6ysrv7LL7JEWf7sMYljGTmgKKi1v3Ik4tLKlOoxsZgpC8+8PGaQRSIj44RuydbMZCGwpboxUQCyxnYCtVovZ2H//m9erwNeMdk68UGazlQJt23rIRUfMugiB4jHKy01KkStEEFn60CPIM+XRtFH6BmQmth+eNE4Wd12wFTEPVTQpoqZa0dnP/8v/bX7tof4SNjx+LlQD/hRSpV/deOEXl0dUQ75TOhCP72EWpYRbYGdBnok3sSk5dl+AYpHczfYzeJUfDJjA/9skz5cupqzPnQis5//L9bA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 04:48:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 127275 invoked by uid 111); 24 Aug 2026 04:48:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 00:48:27 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 00:48:22 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260824044822.GA142844@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <aoayppoxHAkcFTBN@pks.im>
 <CABPp-BEBbdmE9q+98gWq-wLzDdhJOyazcHF=pP95o5AcmgCv1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEBbdmE9q+98gWq-wLzDdhJOyazcHF=pP95o5AcmgCv1Q@mail.gmail.com>

On Thu, Aug 20, 2026 at 06:36:09PM -0700, Elijah Newren wrote:

> > > The false negative is not limited to one caller.  Any reader
> > > (cat-file, rev-list, pack-objects, ...) can spuriously fail with
> > > "unable to read object", and callers that only ask whether an object
> > > exists get a wrong answer too, since the OBJECT_INFO_QUICK path never
> > > retries.  Writers that merge in-core, such as "git replay", are hit
> > > hardest: merge-ort treats the unreadable tree as a premature abort, sets
> > > result.clean < 0, and returns without a result tree.
> >
> > Hm. Isn't there a slight variant of the race though for any caller that
> > does not use OBJECT_INFO_QUICK?
> >
> > Namely, the packfile containing our object disappears and is being
> > written to a new packfile, and that file is the only one containing it.
> > Without OBJECT_INFO_QUICK we would be fine: we notice the object could
> > not be found, and then we perform a second read that makes the "packed"
> > backend reload its packfiles. It would find the new packfile, and
> > because it's not covered by its MIDX it would use it to surface the
> > object. But without OBJECT_INFO_QUICK that's not the case, as we would
> > skip reloading packfiles altogether, and hence we would not be able to
> > find that object at all.
> >
> > As far as I can see though, we don't seem to pass OBJECT_INFO_QUICK in
> > any of the mentioned readers. I could very well be missing something
> > here, but I would have thought that those readers are fine in this
> > scenario?
> 
> Nicely caught -- and you're right that the readers named above are
> fine: they're all non-QUICK, so the second read reloads the packfiles
> and finds the object in its new, non-MIDX-covered home, exactly as you
> describe.

OK, so do I understand correctly that you _can't_ get the "unable to
read object" result that the commit message claims? I.e., the reprepare
/ packfile reload is helps us (just like it does for the non-midx case
when an idx has been mapped but the pack disappears before we open it).

So there is no bug there for non-QUICK callers. But then...

> But the variant you describe is a real bug for QUICK callers that
> don't get that second read -- e.g. upload-pack's object-existence
> checks and mktree --batch.  I have three more race-condition patches
> to clean up and submit, and this is one of them: it forces the reload
> even under OBJECT_INFO_QUICK once we notice a pack has vanished out
> from under us.

This seems wrong. The whole point of the QUICK flag is that the caller
is OK producing a false negative for an object lookup, and it would
prefer that outcome to spending the time to reload. If there are callers
passing QUICK that aren't OK with false negatives, they are broken and
the fix should be there. But repreparing the packs for a QUICK miss is
going to reintroduce the performance problems that QUICK was introduced
to help.

So between the two cases, it sounds like things (or at least the
low-level lookups) are working as designed, and there is no bug. Or am I
misunderstanding something?

> Your wording also makes me realize that my fix in this unsubmitted
> patch still has a hole: it triggers when opening the pack .idx fails,
> but if the timing is such that the .idx is already mmapped and only
> the .pack has gone missing, it won't fire.  I'll look into that before
> submitting...and then clean up/submit my two other race fixes as well.

I think it would be fine, for the same reason that regular idx lookups
are fine. In packfile_fill_entry() we call is_pack_valid(), checking
that the pack is still there (and relying on its side effect of leaving
the fd/mmap open so that it remains accessible even if the file is
deleted).

-Peff
