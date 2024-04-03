Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8B12E4E
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107842; cv=none; b=k/uCvdhLui6YcP0ID/HNRyQQQRpOvICBnZ8ReMo8FyVD2jptpQjCDF5lcs6kqFt2sp8e2aqCqPP1v5a2qX8edvoJXW8EuYdGmogEsKJEtTji4nGMGqxVH1lxIbmtyVBtWk8x7iXKMGBUcirOuvaWFb1ulp/+83YXGrH7kleDreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107842; c=relaxed/simple;
	bh=x5v0jOppY8l6M9n+un1H/J87ammi1MddVZywD2fSeXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTb9BPvD90wOXpMwUr+rghjPh8h1+fgGvsoed7aYNrSh1EbNOMweq33FKNiFykD4dMlJsSciOtSrzOkUNt/XKk2aStkSWgrNeaMNRBulIVf1z0uV2+jYsMPsBqE0DElup3zhHw/ywmT4DfzwyyKNF7ekJtt7tEtf37yqYsk+akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14597 invoked by uid 109); 3 Apr 2024 01:30:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 01:30:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3555 invoked by uid 111); 3 Apr 2024 01:30:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 21:30:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 21:30:39 -0400
From: Jeff King <peff@peff.net>
To: Tobias Boesch <tobias.boesch@googlemail.com>
Cc: git@vger.kernel.org
Subject: Re: Git Gui Clone: Error Failed to create repository (with hints)
Message-ID: <20240403013039.GD892394@coredump.intra.peff.net>
References: <6aadf39561e13681c069d4da7b1a4581f143dc92.camel@googlemail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aadf39561e13681c069d4da7b1a4581f143dc92.camel@googlemail.com>

On Fri, Mar 29, 2024 at 10:12:17PM +0100, Tobias Boesch wrote:

> when I clone a git repo (from github or COdeberg) through Git Gui I get
> the following GUI error (nothing in the terminal and nothing in
> journalctl):
> 
> "Failed to create repository <repo-path>: Hint Using 'master' as the
> name for the initial branch. This default branch..." and so on.
> 
> Screenshot
> https://i.postimg.cc/66df98MZ/Screenshot-from-2024-03-29-22-06-49.png
> 
> I have no idea what is going on here. Has someone an idea what the
> reason could be?

I don't work on or use git-gui, but it is written in Tcl/Tk. And IIRC
Tcl is very anxious to consider programs that print anything to stderr
as "failed". And in this case we are just printing warning/hint
diagnostics to stderr.

I suspect there are solutions within git-gui's code base to check the
actual exit code, and it's just a bug that we're not using them in this
instance. But the obvious workaround in the meantime is to set the
config that the hint mentions, which should silence it.

> Cloning the same source into the same path from command line works.
> The cloned git repo opens fine in git gui.

Right, the clone is happening fine. It's just that git-gui is
incorrectly thinking that it failed.

-Peff
