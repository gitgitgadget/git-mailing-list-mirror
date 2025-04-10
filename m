Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AAE2857F3
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292705; cv=none; b=p2xxXfh1Kh7EBZXnQcCjErUNgLlFBaB651JGhh8a8Ha51CXnO4WUD6PCB/yv6BVQCLxN6ClkldKfl+Y/Dk8KLSh9JX5I5MUdh7umS+kV9Z0PICujxfr6o7tInI9g+PtcFBRimsHEbBqABlqSpVlu7vSBj+nHGTKBla8RPFmBXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292705; c=relaxed/simple;
	bh=KtFOVEDulxSUFzpRVJmuk+6Hg7wNWeXbF7JdjqcjHfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC16BdkR3D6VJggJGYzw/C9dHNQOqnS9pBwK3Dj6vQnxW0tr0N2NLHh9iNVgpuEysOyzg+R0sem0OUHnIZKIT3Rk9QYRIONPdUp7ZCiQFKxz4SjAfl0j1RdWUZd+/U7qDQCzCPDI6JBGqqumoYDC0eaIOx1Y5VKOgWh5vwCrBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53ADiQTl031341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 09:44:27 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 227552E00E9; Thu, 10 Apr 2025 09:44:26 -0400 (EDT)
Date: Thu, 10 Apr 2025 09:44:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>,
        Martin von Zweigbergk <martinvonz@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
        remo@buenzli.dev,
        "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <20250410134426.GB13132@mit.edu>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g>
 <Z/a+AVopz+HLa1eL@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/a+AVopz+HLa1eL@ubby>

On Wed, Apr 09, 2025 at 01:35:45PM -0500, Nico Williams wrote:
> I was using file rename heuristics to explain that I wouldn't like more
> of the same for other things; I was not trying to litigate renames.
> 
> I'm trying to litigate the _addition_ of more similarity-based
> heuristics for _other_ things.
> 
> If similarity heuristics were enough for CR tools then none would have
> introduced anything like change IDs.  Or perhaps CR tools authors have
> been flat out wrong to not try or use similarity heuristics exclusively
> over change IDs.  That's a topic worth discussing.  I've stated my
> preference for not relying solely on similarity heuristics.

There is quite a lot of similarity between trying to record file names
(and having the concept of "inode numbers" for files tracked by git),
and the discussion we've had about how to track user intent when a
commit gets split or merged, and having a "Change-ID" which exactly
functions like an "inode number", except for an individual commit
intead of a file.

The arguments about why we don't have an "inode number" for files,
because it *is* complicated and hard to getr right, are *precisely*
the same argument for why I remmain unconvinced that having an "inode
number" of the semantic idea of a commit (read: Change-Id).

If you are someone who very much believes in the importance of doing
per-commit Code Review using something like Gerrit, then you might
think that a Change-ID is more *important* than an "inode number", and
so it is therefore worth the greater amount of complexity and/or
ambiguity when the Change-Id gets subject to the same levels of
incorrectness that having the IDE track the user intent behind a file
copy or rename might have.  That's a value judgement, and there's no
real right answer here.

After all, there are still people, for example as seen on a thread on
the The Unix Heritage Sociey mailing list, who have argued that git
is a hot mess because we don't track file renames and copies the way
"real" source code management systems like BitKeeper and Perforce does
things.  I happen to disagree, but that's a value judgement about
what's important in a SCM design.

Regardless how we come out on whethe having an "inode number" for the
high-level semantic value of a commit is worth it, I do think having a
"patch set ID" which ties related commits together does make sense,
though.  That would solve some interesting problems both for the
web/forge review workflow as wel as the mailing list review workflow.
I'd be curious what people might think about that.

Cheers,

						- Ted
