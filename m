Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EB35893
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157693; cv=none; b=lpx17ybFnu6Z0zVswPQ2LppzGyoWPIiYo1snlzrkp4BcLGQfnXHjbUrIeL4qC3YzgWtFc7jMMEmu+tx7VlTSGkI1H5z7/kiIqPmkWgmv9ocuN/+KBSTxdKOTmUbo2/Ng3YhnPlZrUImR+YIuwF/Fds4SMNKqBpg8YAazK4qVOuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157693; c=relaxed/simple;
	bh=GXh1/98YaVEyMcSzmaNPmMVUES4ZHQjlOIjE4YPXcUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sImdfbNEaPcVN0TP0FEA3wCZ+FX386pJKfYrTI8daI9DC+cvXriewO/s389YK+JoNO77lR7tFDIdo+r/dLNaDacHRaf7CF873duYEn5NH2csBhFGpgn00cqQAe9hNn+7DyARVJiXB7iLd9Q9pQE4lriPnnpt1zivIf7djjrgB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XWqAShNy; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XWqAShNy"
Received: (qmail 106073 invoked by uid 106); 11 Jun 2026 06:01:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GXh1/98YaVEyMcSzmaNPmMVUES4ZHQjlOIjE4YPXcUE=; b=XWqAShNyslAndQXnAIsZNJYLuY2q2gnImO5A+uGz9J+XiAT3Nd7iRshYpoLoDH7bqOnOzR33x02k1F0/bfEKNbmmcYm6nN7s+H147klcu27l7vtQyzECgVQGw5MLar6H/zD4f2yCh7ieSheaPzREeqStd+sfosujNzKyGc1+JOmbrUP1UOKJP0LeddKLocfDRMhCo09BGEC+OK2p3GV5S4sD1Db1eKTVhqyiLeRK8bvMqWs8eIXfzDg/ZwWE2g6m6UrdaXgwdNXkDfp+mJeSfsorXDxGPG9f4P+d+51e7OuAhdClqOv0TCIBClF0hmlxsiw1AiQUvWMQVZQFdBrfxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:01:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 313410 invoked by uid 111); 11 Jun 2026 06:01:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:01:28 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:01:23 -0400
From: Jeff King <peff@peff.net>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org, Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: followRemoteHEAD management question
Message-ID: <20260611060123.GA2187173@coredump.intra.peff.net>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260608234946.GB358144@coredump.intra.peff.net>
 <DJ5XE9HC5YNY.33U8AG1GX6ZP0@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DJ5XE9HC5YNY.33U8AG1GX6ZP0@lfurio.us>

On Thu, Jun 11, 2026 at 12:12:54AM -0400, Matt Hunter wrote:

> > Yes, this is a common problem with the remote-config namespace. Defining
> > _any_ key makes the remote "exist", even without a defined url, but that
> > isn't usually the intent.  But we can't distinguish that from the case
> > where you really do want to define a remote without a url (in which case
> > the url is the name of the remote).
> 
> I had no idea a remote like that was supported.  Interesting.

I suspect it is more of an emergent property than something that was
carefully designed, but after so many years I'd hesitate to change it
(at least without a big warning and deprecation period).

> > I think you are on the right track. I can see arguments for or against
> > putting it in fetch.* or remote.*, so you'll have to pick one. ;)
> 
> As stated, I think putting it in fetch.* is more consistent.  I'd be
> curious to hear arguments the other way.

My initial thought is that it might affect clone as well as fetch. But I
guess this feature does not kick in for clone, as it has its own logic
for handling the remote-tracking HEAD. Though arguably it should be
possible to configure it not to create one in the first place.

> As for another design decision: I'm leaning toward omitting support for
> the "warn-if-not-$branch" value in fetch.followRemoteHEAD.
> 
> My take on that option as-documented is that it serves more as an
> acknowledgment from the user that "yes, I understand that origin has
> pointed HEAD at foo, please only warn me if it changes" as opposed to the
> user expressing that the branch "foo" is in some way special to them.
> 
> This interpretation feels very remote-dependent and doesn't make sense in
> the context of a default catch-all value to me.

Agreed. I can't think of a reason you'd want it in the global option.
And if we're wrong, it is easy to add support later (versus adding it
now, finding out that it creates awkward corner cases, and then having
the backwards-incompatible change of ripping it out).

-Peff
