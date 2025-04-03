Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1C38382
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702553; cv=none; b=XEBczZJfPl/GGrAaw8BfcNsXExzgQ5tqwxXTk0sFNs6OMwJ/oI4Ry46yacDwXss5X91bztuWa385/Z07xF6Yybe2WWH3UKaPnSAmIvAOtEaEslvvmLFslUyz1tfHVb2Ij+nmL5JFFTHqv/ZxKOhr5pK6jhXubUS61Ei1q5v5Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702553; c=relaxed/simple;
	bh=kJ641ucDrgySJJupHoi0XQ7/KR/hdqWfJoMyTuNNFzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgkog3cMAGS5EHiCWfNOJR53gIE2wZTT8Vfugklb/L4wXGpOLOTMseIPhReJDJ9+YUwsYj2HQMYKiDbvjPpwvFUYw6PKr9LRU9uku6bnvgNIlo+lDnIR/8rn3Z1Z8bcQl8sXV7PbKaMTINvwzPSLMqVe6h35AarG9e0cUyVFMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-246.bstnma.fios.verizon.net [173.48.119.246])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 533HmlLv001491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Apr 2025 13:48:47 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 19D872E0019; Thu, 03 Apr 2025 13:48:47 -0400 (EDT)
Date: Thu, 3 Apr 2025 13:48:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Elijah Newren <newren@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
        remo@buenzli.dev,
        "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <20250403174847.GB3051250@mit.edu>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>

On Thu, Apr 03, 2025 at 08:39:31AM -0700, Elijah Newren wrote:
> 
> But <change ID> isn't unique, right?  The whole point of having the
> change ID is to preserve it despite edits (e.g. rebase, commit
> --amend, cherry-pick), meaning that you end up with multiple commits
> with the same <change ID>.

It's supposed to be unique, but it isn't always.  I've certainly seen
cases where it might not be, but that's arguably a bug.  I suspect in
some cases it's because users are cutting and pasting commit
descriptions, and sometimes when they rebase a patch series, patches
will get collapsed or split apart --- especially when backporting to
an older LTS release.

Perhaps because of this, in some communities, their tooling in front
of Gerrit will always regenerate the Commit-ID when doing a
cherry-pick (For example, when cherry-picking from the development
HEAD branch back to a release branch).

So as a cauaionary note, as people use Change ID's in Gerrit today,
sometimes the Change ID changes between rebases, and I've certainly
seen cases where the sematic meaning of the commit has changed
significantly without changing the Change ID.  So it's great as a
hint, but in practice, at least today, it might not be completely safe
to assume the semantics are as advertised....

				- Ted
