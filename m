Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533307464
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743818992; cv=none; b=lanSdDw2q8Wy92XEayLEKmaq0FGfMpYTkRnUBP747w7pLISDIM1t3Fz7DvUtxV8eDplgbXaif1D4PBogcp21LPhtUnDllU+0Jh5ytXo0L+WMKWKG62U7wkqCge4hGdo+GVaTugMNAzHNaOw7/alQDNm2QHViooqRYoekRsgpULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743818992; c=relaxed/simple;
	bh=ja2Q9syHz/RFLU8pDgIs8B9LXbiDFNKBj/IOtNq3uSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Ip10uKUCY99Q/tQaSwH9gt5zWqo77SgyqPI5l1cLgl0z8axhQ77nd222G82gYhQsCDgTatXgY2vX7e7PSGmBIGpNt+QW0hKir8sYApIdWnYg8U3zw3otimPsttB0+iRhPQucGPqiPLt7+g0+hOmiTS2XbHQunmUMVx7cRiqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-236.bstnma.fios.verizon.net [173.48.116.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53529Jna020074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Apr 2025 22:09:20 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 001652E0019; Fri, 04 Apr 2025 22:09:18 -0400 (EDT)
Date: Fri, 4 Apr 2025 22:09:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Elijah Newren <newren@gmail.com>,
        Martin von Zweigbergk <martinvonz@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
        "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <20250405020918.GC3051250@mit.edu>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <20250403174847.GB3051250@mit.edu>
 <D8XAETM3PJ4A.1RBPVHJWE9DFT@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8XAETM3PJ4A.1RBPVHJWE9DFT@buenzli.dev>

On Thu, Apr 03, 2025 at 10:31:08PM +0200, Remo Senekowitsch wrote:
> > So as a cauaionary note, as people use Change ID's in Gerrit today,
> > sometimes the Change ID changes between rebases, and I've certainly
> > seen cases where the sematic meaning of the commit has changed
> > significantly without changing the Change ID.  So it's great as a
> > hint, but in practice, at least today, it might not be completely safe
> > to assume the semantics are as advertised....
> 
> That is all true. I would just say that some change-ids not being unique
> doesn't systematically take away from the benefits. If a given change-id
> is unique, you get all the benefits for that patch, independent of
> the uniqueness of the other change-ids. If some patch changes a lot
> semantically while keeping its change-id, that will degrade its review
> history, but without affecting the review history of any other patch.

Oh, agreed.  I've certainly used a Change-ID by pasting it into the
Gerrit Search Box, and when I saw two or three unrelated commits where
the one-line subject were for entirely different kernel subsystem, as
a human I could do the disambiguation myself.  And if I did't find a
particular bug fix for the various release brances, I would cut and
paste the one-line commit summary into the Gerrit Search Box, and find
the right commit, again aided by human intelligence.

So I'm super-glad that it's there, and it *is* useful.  But I just
wanted to inject a note of caution if people were thinking about using
it in some kind of automated tooling --- especilly if there is a
proposal to inject this into git as a first-class object.

Certainly from a git perspective, I will admit that more often than
not, I generally don't do something like "git log --grep
I23e218cd964f16c0b2b26127d4a5ca6529867673", but rather, "git log
--grep 'mediatek: Don't modify spi_transfer'".  If I have to cut and
paste a Change-ID, most of the time I aso have access to the one-line
commit description, and grepping for something human readable is just
easier.

					- Ted
