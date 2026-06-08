Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1D22423A
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962737; cv=none; b=Ob+m1fJHXd+f/+RSfgAIZpMHHRD1moB38zup+Ze3WFfFOf5n4Tt9dSIZsqMxmN/8io5DGD7CDbaGkHasAlDo1cwbA9mz5SpIclJGZDgII9N30aic4pByn8hVIhwEkxtAOAB+kUnSoIG4DW8tUxQSYdpbpd53MuA+tsoebYeymiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962737; c=relaxed/simple;
	bh=VscX5df4kyaPxodKjZzUKZl1c5DDWOv/0aLJtk/XkYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkJWbXmLfML2/tNAPKODSs9KMEZOtv1edsKq1sxH83/j0yPsLTwBLA5TSzMb2/wiGYIBAnE62KYvSAz9CUBBDY3rhEplwBtqunRDVgiJotb5UOR0A0RFmssAbhKbYlkw9289x8EpDtMW1Q16z5Qa6LAe8sa09/V6fL8QPvstGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OVRwkRdW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OVRwkRdW"
Received: (qmail 83919 invoked by uid 106); 8 Jun 2026 23:52:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VscX5df4kyaPxodKjZzUKZl1c5DDWOv/0aLJtk/XkYQ=; b=OVRwkRdWkYwAwTEe9gbEV5ho7bbaNwqE1XK8bNWcurQ8gPPYU6DfEfhX6sUCP/mggfmYlFx5uoEmM4vDeb6uSSZt06V97F8P3rRqeOe+NLVJDCdN8m/GnWT5TfSUAB//og4TE1WJhrGMCHiXlLGpgONU1uBAow0BuKP+OiecQ2F9soIA1y7FnX9ZPv2xJgTd3+SzfoD6iH0L7NFM6qdZnEbCRIUYBpg4Wyq3m7ryWyRWI21boX7idrj05vHmtuoXV1AvUV+6hNo9EuOH+6q+FWfoAo7hNxm8PPerevhy1tPQAf31HXk7Zu8T8YsF3c1MW+obAT6jO9M61VsgcIQmag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 23:52:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 245633 invoked by uid 111); 8 Jun 2026 23:52:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 19:52:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 19:52:14 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] ref-filter: reuse --contains traversal results
Message-ID: <20260608235214.GC358144@coredump.intra.peff.net>
References: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
 <20260608223430.GA340696@coredump.intra.peff.net>
 <CAJ-ks9ng3Obv8jydYiBD4kxmTSZCJX8xNb0YihNeSW8_8WL5Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-ks9ng3Obv8jydYiBD4kxmTSZCJX8xNb0YihNeSW8_8WL5Ew@mail.gmail.com>

On Mon, Jun 08, 2026 at 07:35:57PM -0400, Tamir Duberstein wrote:

> > So I think a better rule here is to tweak the selection in
> > commit_contains() to select the depth-first algorithm when we have
> > generation numbers enabled. There's a patch in an old thread, which was
> > revived a week or two ago by Kristofer (cc'd):
> >
> >   https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify.com/
> 
> Very good catch, thank you. I reproduced the regression with a
> 100,000-commit history and generation numbers disabled. The parent
> took 13.0 ms, the unconditional depth-first version took 238.4 ms, and
> the generation-aware version took 9.1 ms.
> 
> I didn't find a patch in that thread, so I will reroll using the
> memoized walk for tags or when generation numbers are enabled, while
> retaining the breadth-first walk otherwise. If someone else would
> prefer to send that patch, that is fine by me as well.

It's just this:

diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..cdea0030b8 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -799,7 +799,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache)
 {
-	if (filter->with_commit_tag_algo)
+	if (filter->with_commit_tag_algo ||
+	    generation_numbers_enabled(the_repository))
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
 	return repo_is_descendant_of(the_repository, commit, list);
 }

from:

  https://lore.kernel.org/git/20230324191009.GA536967@coredump.intra.peff.net/

But I won't be surprised if you recreated the identical patch yourself. ;)

-Peff
