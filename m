Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB810F2
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685336; cv=none; b=guao8vRkTa6yN5Xpdg6mMuM7pn34v+UWlAx8qamENfwzlt7ZLCV3PI4ft2mffW/gLvqtNztKbOM0n3Ed9+gqupU08VBFwzWuNQRXzrvW8gQUBhCAL7KAOrZwKp40IrnN4u67xQv+teskq7BkUN6rXiily/Ln+dh1QMxMGoLMIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685336; c=relaxed/simple;
	bh=YkDEQ4coWdSLC74m5Szz7/aG4En4YhELpX+jgqyoitg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYd5lI8mwy9907pOY2B8zQyeMeYfLTRqHK0vP93Pkn5GEcLkMgFpDAM0zPtazakxsIsg4uwe/nPrXSRimPjKHNDCHNM3gK14zo4sMBS4j9bh+h4DnvyDPzfoHLVhhS1XFIAIJFCcz50/jnYvCrL4tRk9KShGd22qY5QadFDMz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fiHYILjJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fiHYILjJ"
Received: (qmail 251949 invoked by uid 109); 17 Oct 2025 07:15:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YkDEQ4coWdSLC74m5Szz7/aG4En4YhELpX+jgqyoitg=; b=fiHYILjJnumPoe2Dw2G1UpVywjQKkabO5kEUok3MA1uPsmYlKao/ddLsZNafIRB6+A+FwTcB4E24M4Oa3eSPKPwdK2rXz74hkd95hopgLvOYC/n7NpRQKWP5ZGnV8fUx/4GZBFB33KPInodgeQoPJ5ZmyntJbcf3IBvEaJJaVZrBSDQPmUxe0Cdd55Ai+OoXT5hiEva9KDkK8fbIh6CIc2F5vGomU4tN84HznYs+c4k6ysKBq4Z3fuZgEWp7VwblA4Q6pgULJB2IhPanMFnFpsMrhkggJWaensstzYUc7CRf9nLGbCJKIffmMSrU8fWgwZMuhFeVmBS3kBlj7JgLEA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 07:15:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 392796 invoked by uid 111); 17 Oct 2025 07:15:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 03:15:33 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 03:15:32 -0400
From: Jeff King <peff@peff.net>
To: fence.borrowing375@passmail.net
Cc: git@vger.kernel.org
Subject: Re: [BUG] protocol.file.allow=always not honored when --local
Message-ID: <20251017071532.GA4073661@coredump.intra.peff.net>
References: <176066758616.6.12811000416591629223.957743298@passmail.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176066758616.6.12811000416591629223.957743298@passmail.net>

On Fri, Oct 17, 2025 at 02:19:38AM +0000, fence.borrowing375@passmail.net wrote:

> Created an empty directory, then initialized git:
> `mkdir ~/test && cd ~/test && git init`
> 
> Ensured file:// transport protocol is default/unset value (file:// is
> disabled by default):
> `git config --list | grep protocol`
> # no output
> 
> Enabled file:// transport for local repository:
> `git config --local protocol.file.allow always`
> 
> Then, attempted to add a git submodule:
> `git submodule add /path/to/module/.git`

I don't think this will work as you expect, because of the use of "git
config --local". When we run git-clone under the hood to clone the new
submodule, it is a new repository, and does not look at the config of
the containing repository at all[1].

As you noted, setting it in the user-level "--global" config file would
work. You can also override the config via the environment like:

  git -c protocol.file.allow=always submodule add ...

though note that anybody cloning will need to do the same thing (and of
course have the submodule available at the exact same local path!).

-Peff

[1] There have been discussions in the past on whether submodules should
    receive some config from the superproject repository. But there are
    a lot of complications, as it is the right thing for some config
    keys but not for some others. I doubt we will change the behavior
    anytime soon.
