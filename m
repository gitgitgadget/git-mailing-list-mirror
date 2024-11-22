Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A35D477
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290281; cv=none; b=NgivL24FLBfa8cyEqyTbHVtFMrGABMxKEK+IfSMAe40RfRat+LPswsWHHo3hzVYWFjptbpMeJIXYorRDcufgI1gOzeTpyQPFYUGd3Z9cMnlmLjwG3mNnoGB9dKtYjGeGH2v3zHLBT2hd+gKeTExa1ni9Hgixyxa+L7NsMcscH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290281; c=relaxed/simple;
	bh=IjByqb4Rj7Doi6k3b/nEHpxdG4rHA8PscCormCIOyQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWJGOhDFrThAdIyI48fcud7500LgaQYfOuLxWvUMp1UR3a5jHrwuZIF3QDzukzpyWh6uB1qp4fPjL9g57UE9wVkpCjICrBJOySdlgu9syaqkkziya0cJDUZ8jUqzcU3lxxfUFPQAm6Sw1W4GtPSHyCmTf6GJigjbahg2e/NTrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BQBnDMwZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BQBnDMwZ"
Received: (qmail 13704 invoked by uid 109); 22 Nov 2024 15:44:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IjByqb4Rj7Doi6k3b/nEHpxdG4rHA8PscCormCIOyQk=; b=BQBnDMwZdLRz/bN1IOXdERICf0ISh5Grvoq0UMy8gd2ezUS3pszRkN5wrJuYFfmtNHzuH3vr05MoISsnCnnfU0Tws4oqB3oZP79Zuk7f0mQnp11CeU91TOGoDYxzWXaup1+6P0G0YDYd0kXBqYQ2X2m7Dk8WpTS5qB07lPMu48XLsw9ix3/AFTV2En2apGO3j5zTPPKbtgM3XnyishNEq/gGbJRBWzaZUWTsr0Ku/b9ZMUhy6sBkwzRoBJZ5NfKB0FVQPDc/P1YplSEkINnmvsnNadog9HO5GwHqUy84OW/7OTB/vrah1XUhFlU947LUMCsWu0hTOPQn5JNC9MVKVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Nov 2024 15:44:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5895 invoked by uid 111); 22 Nov 2024 15:44:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2024 10:44:38 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Nov 2024 10:44:37 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap.c: typofix in `find_boundary_objects()`
Message-ID: <20241122154437.GB1738455@coredump.intra.peff.net>
References: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>
 <xmqqiksgdrv8.fsf@gitster.g>
 <20241122154116.GA1738455@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122154116.GA1738455@coredump.intra.peff.net>

On Fri, Nov 22, 2024 at 10:41:16AM -0500, Jeff King wrote:

> > A possible alternative "fix" for this typo could be to unify these
> > {type}_objects members into a single .non_commit_objects member in
> > the rev_info structure; given that we (as far as I remember) never
> > utilized the "feature" that, say, we can ask only for trees but not
> > blobs for the past ~20 years, nobody knows if the apparent "support"
> > for that feature is subtly broken in multiple ways (and one of them
> > you just fixed with this patch) and the "feature" may not be worth
> > keeping.
> 
> I have been tempted to do that, too. But FWIW, I do remember
> implementing something that set some but not all of the fields in a
> series. Digging in my old branches, I think it may have been for a
> reachability check for remote git-archive, where we want to dig only as
> deep as the object we are looking for (so if we are finding out if a
> tree is reachable, we do not need to ask about blobs, and looking for a
> tag needs neither trees nor blobs).
> 
> If no such code made it into the project in those 20 years, it may not
> worth worrying about too much. But I wanted to point it out as a
> plausible use case.

There are also two curious cases added by f18b512bbb (bundle: create
filtered bundles, 2022-03-09) that set tree/blob, but not "tag". Not
sure if that is a bug or not.

-Peff
