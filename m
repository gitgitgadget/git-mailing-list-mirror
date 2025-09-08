Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4630CD80
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347592; cv=none; b=ohzfV5Mi4tW1JSnhjGhPhuh9YDYgA3lzjtlxzA1uQ+TGbhYd8XhuNg8E88vkd/4ftCXvA4l71SVk5G8rDxYtKI+ZoHC+bPhuDUE2d/ryouxva3vQ0gAh1C/wRAELUsMetkAXViLvJOhLd3aFwcyukfsP8uqXjGIfxmibPg6Xx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347592; c=relaxed/simple;
	bh=aCXhyIYA+tgdzgeUeYcYPh8HsFqSdgYBHaXcuKbYZIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7MBSVQZjmzc627I8MLxG0aqMVdBG+2345MhqEQ+RKuy/KqskYAeoKQkgZfArlvIzAl+zlGBUlPtsZeyjHjuWJ7JhWMAPyaRfTXvcz0sp2z+lh4TIjFs0VDhRUEak4O8GQFuLoONC5SQ6GX7mzUDZ/tWLt/pmfZxpI/L+G9vX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZQ+VQ5t3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZQ+VQ5t3"
Received: (qmail 21314 invoked by uid 109); 8 Sep 2025 16:06:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aCXhyIYA+tgdzgeUeYcYPh8HsFqSdgYBHaXcuKbYZIo=; b=ZQ+VQ5t3hbhtmCicCnzPeoVlCJu58VDukZpBblmbyu5//JdFILAc4McZm+/pv7RFRsrqNq2f3anOjOLb8B2FnUso12yXe7u+ranGIaeUmEp5G/1AwmuLeOtv0UmeS+mTDUpEbUPItDjIcICLG/gp7YlgpFoRsdv8367UKN5/K/u4Hwnj9ImAcT1hVWOOdpM635GD876iEAeDcO9Hfe7V468So55DEhe5IlMqxK0QufwBQtZeJj8wttV6whhxPSaxvKREj7zPzc/p2yMI44AFlD2cDk0i0E0G3nEFCu/iK9DAv8VTbW7ZROxus4sIo2xjxCLOyDggr8wMwraN4X7pWw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 16:06:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34623 invoked by uid 111); 8 Sep 2025 16:06:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 12:06:29 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 12:06:28 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] stash: pass --no-color to diff-tree child processes
Message-ID: <20250908160628.GB1308482@coredump.intra.peff.net>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250821071517.GA1839835@coredump.intra.peff.net>
 <aLfs5EDk-krJHnmQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLfs5EDk-krJHnmQ@pks.im>

On Wed, Sep 03, 2025 at 09:23:16AM +0200, Patrick Steinhardt wrote:

> > @@ -1345,6 +1346,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
> >  
> >  	cp_diff_tree.git_cmd = 1;
> >  	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
> > +		     "--no-color",
> >  		     oid_to_hex(&info->w_tree), "--", NULL);
> >  	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
> >  		ret = -1;
> 
> All of these make sense. It feels a bit like whack-a-mole, and fixing
> the root cause would address that. But I also understand that you shy
> away from addressing it due to the high chance for regressions.
> 
> There's also a call to "diff-index" in the same file. Do we also need to
> adjust that instance?

I was focused on the "-p" code path, but yes, I think it fails when
we stash an index change with GIT_PAGER_IN_USE=1. I've fixed it and
added a new test in my re-roll.

-Peff
