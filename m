Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCDDDD2
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909940; cv=none; b=VgS2NJH5sAidOEv40dIUbARkxmWpmizfWhBlIXLRPw9ziFfEV6rwDavL0TXq2Ul0GUagbc/y3yQhmV5qtl7wWRUQIgi/6mmntmY3+Y90ukMfwtcajaiPIJYWuAtLjU/Wd+b8zSyVgHwE2mHpElgBg/O69NmdaB4h6ONBchMI6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909940; c=relaxed/simple;
	bh=Mu+3QvaJqaXxtbVq9jF0ox8SiclPHM0NGPfUDZ7u/4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttF+GdteS+Dg6yf6lNwpybrCyEmDkDrqzp1K8Sm5zfI3aCHCxeTIgbe6j6qV4YrU5zD8o48BmaJM1ETcB6sbnH21ZcOmoJXuhF8Y0cf9jBiIwkZuAzjcBOZjpDdjVpZsNYRyhecr6ytHowqWNeWdJYyDzGIJZ2+VxWVffTul0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=wNH6868q; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="wNH6868q"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14F61F5CB;
	Wed,  2 Oct 2024 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1727909458;
	bh=Mu+3QvaJqaXxtbVq9jF0ox8SiclPHM0NGPfUDZ7u/4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wNH6868qym4w3sG+l1MaC1aK6VRclDNB0zVz6eDjoJU2QUTgr2+4y2P3GVSU3AsCb
	 IpA2wo6a4aYTf99HHP+L+EGYRv1dSi2Ah0ApxzF9lIJt9G9hbKcKRfZhDS/mw6U0Vm
	 qFtbNUFtNYH9smnk6myWucHSvgJtsTTv1l3GyJhE=
Date: Wed, 2 Oct 2024 22:50:57 +0000
From: Eric Wong <e@80x24.org>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: Linking topic merges to mailing list threads
Message-ID: <20241002225057.M796260@dcvr>
References: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>

Emily Shaffer <nasamuffin@google.com> wrote:
> Hi all,
> 
> We've been wanting to gather metrics on Git's code review process -
> how long it takes from first contact on list to merge, how many
> iterations are needed, time between iterations, etc. One missing link
> is the actual merge time in `next` and `master` - a human can infer
> the link between the patch and the mailing list thread, but it's more
> challenging for a script to do it.

Searching by commit titles as a phrase against email subject (`s:')
can probably make it easy w/o having to look up amlog or explicitly
keep track of human-unmemorizable metadata such as Message-IDs.

Example:
https://80x24.org/lore/pub/scm/git/git.git/365529e1ea19b44a7a253b780f3ae3a1cb2f081f/s/#merged

...In the "find merged patch emails" textarea.  Yeah it's part of a
100% JS-free alternative to cgit, gitweb, etc...

(https://public-inbox.org/meta/20241002223902.4139389-4-e@80x24.org/
 implements the query generation)
