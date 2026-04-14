Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185C2701B6
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147368; cv=none; b=s5dpnBz/KTOq0TOSKI4jHPJn/EqtIE4Yjtw3IOlXtGBsIQYUKYy9Fz+wKIDofu4GnmT7LQbYodNCWPQF+dDYB0Ks99Fb8U65TpuHyAxjzf6kK7BWhWdy+ptGoJzUCmCoGmDfRAiJBOnajEZZZYhCiqupjTeGmV5hYLWjj6/Wg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147368; c=relaxed/simple;
	bh=sCCiXa2jQzyfA1fqcxBQ2czT9tAU9HcGRdv667hlHl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq8FNmxpiCrKERMS3hFtguJus3gvaqRnDvcEomX3WOAgM8lOar8X5MWShfpnXH0Aae5jW2vEN/ZxFnAgzNQ+Jr/ZlKAap8uI+ug5jo8IdMdZ9xbThOFHrT7TxgI8a8A6DgZIZidGAJSJ6M8Lzf/viSmqZG0+MQcoQ1KtSfvDQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dJNqQ++9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dJNqQ++9"
Received: (qmail 342813 invoked by uid 106); 14 Apr 2026 06:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sCCiXa2jQzyfA1fqcxBQ2czT9tAU9HcGRdv667hlHl0=; b=dJNqQ++9kmwAtiiRKM6SdciDC+UA3A4q3E1RE+uSXNfA4IvKnBv2j6eoB8+MREwZhE/TToFa+qIl4ZLzjAvacvv/UeSjv85YXgghCRimdl4aKf2HuJlVb0pja1NHpesu9RyCVFEEDy+HqE0byTBv0D5W2Ius7QdwUvMqdsp0FT33AESz6YqjUwO/UHelaSUl+7nPWxbG3qfj0G3OhuxVJ1TO38pFlHg84JjOfHNhIsgTqMERXArmEg7SLjrUSCWLXaTIK0nn+TjJ9aEnKV3zk9CYsYWwXOEn56MkohkYDKwOaBNwCnBao8Lqvv/YXAV2rcBXrpz93hPMHmBjzLLXCA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 06:15:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 573286 invoked by uid 111); 14 Apr 2026 06:15:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 02:15:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 02:15:58 -0400
From: Jeff King <peff@peff.net>
To: Shibo Xia <sbxia25@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: How should submodules use different sshCommand during initial
 update?
Message-ID: <20260414061558.GA2902306@coredump.intra.peff.net>
References: <CAAC4ekqE0rGTeZA3fPKYePr3=J8pHe-KORgn5W026J8AAhRRHw@mail.gmail.com>
 <xmqq1pgilufr.fsf@gitster.g>
 <CAAC4ekquR+eCxTWifOR-X5hgd+rSen8eAUy8cxukouUE57xaoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAC4ekquR+eCxTWifOR-X5hgd+rSen8eAUy8cxukouUE57xaoA@mail.gmail.com>

On Tue, Apr 14, 2026 at 09:28:20AM +0800, Shibo Xia wrote:

> My concern is that this still solves the problem indirectly through URL
> rewriting / SSH host aliasing, rather than allowing the submodule's SSH
> behavior itself to be configured more directly.
> 
> So I think this answers the practical "how can this be done today?" part,
> but I am still wondering whether there is a reason Git should not support a
> more direct per-submodule sshCommand-style configuration.

For arbitrary per-submodule config, I can think of two approaches:

One is conditional includeIf directives in your ~/.gitconfig, matching
based on the submodule names. Like:

  # replace PARENT and SUBMODULE with your filesystem names
  [includeIf "gitdir:**/PARENT/.git/modules/SUBMODULE"]
  path = .gitconfig-submodule

and then in ~/.gitconfig-submodule, you'd have:

  [core]
  sshCommand = whatever

This works, but it's kind of gross, as it depends on the module naming
scheme (and isn't there a proposal to make these more opaque? I didn't
follow it). And of course you're not actually putting the config in the
submodule, but rather polluting your user-level config with it (which
might or might not be preferable, depending on what you're trying to
configure).

The second thought is that we faced the same problem with "git clone"
itself: you might want to tweak some config after the repo is
initialized but before we fetch anything. We added the "clone -c" option
for that. It would seem reasonable to me to have a similar option that
is passed along to git-clone under the hood. We already have ways to
pass through options like --single-branch for the same reason.

And then presumably you could do:

  git submodule update --init -c core.sshCommand=whatever

In the meantime, as a workaround I suspect you could do it in two steps,
like:

  # set it for the initial clone; this is using the one-shot "git -c",
  # not "clone -c" that will actually save the result in the
  # new repo
  git -c core.sshCommand=whatever submodule update --init

  # and then save it for subsequent fetches
  git submodule foreach 'git config core.sshCommand whatever'

It's rather unwieldy. And I think gets weird if you want to cover only a
subset of paths, as it doesn't look like "submodule foreach" allows
that. So you might be stuck with:

  git -c core.sshCommand=whatever submodule update --init some-path
  git -C .git/modules/some-path config core.sshCommand whatever

which is back to being overly intimate with the filesystem layout. There
might be a better way to do a per-module command. I don't really use
submodules myself.

-Peff
