Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD333E355
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973229; cv=none; b=Z5pyPmNrtrX2xxD6im45r3Zz/NNiiukZ/SY5p0yKbG7eObmNqUJS7hhE7qNcYK1wqZgmXUZV1PizTbs9gtScSXrlEVRzd9QLD301HqU2vSj2C0wHfWx2QKMU0VLwtk2EgzV8lKJAG2JfYFJ+39iR3qVCPUyoIIh55g4nB6gdy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973229; c=relaxed/simple;
	bh=eYpu8CgRUiwKZ6ZyU0/MqlWEQor0WqW6RhQZTWHDE/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTrh/yN/865hM2RbrvqPaVPXWIJAWez35dY69CTA3+yf35PPkKxo5rWdVuyNyGLccwSc5NOMxgz/A0XTI6UCAk/ikuXLkKam7wnjXzLwSm1FSpP2EzlnwzBSr5XYvg6zxhfjXURrK4JLa/C8BhABDHgyTdA3x/mehZ0glA+xGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UwFK3RD2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UwFK3RD2"
Received: (qmail 119293 invoked by uid 109); 21 Jan 2026 05:27:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eYpu8CgRUiwKZ6ZyU0/MqlWEQor0WqW6RhQZTWHDE/o=; b=UwFK3RD2j8d5zUEpmm2kk5PyZwDQAPZrSsq7XROgRU9cY8GsGNda3bZkXKSyO1rb8d8AvAM0/HDWQe3ZRXPvc1+smKjwg20riK/PVW6dlrLYkhHjGto0yuS8RAl4vhM0Ml1mNUgcGYJkJHDdGoDM2NekYwCt5Q+kmK9BjOL5Va/vlIP8scJ+UZnKyF777zS3dnXLm3kmHYn4D6eQZaSBAhQSohpuGgpQ+4/10k5aTKvZKtDc3cJuq71zcMHP2LjRIBP1FpQ6b9DRphSrmBgvmcHh3PlswovwOSbqdTFovRaxycksFj8WsLgzjQKm1zXVGnxXfvrLKb2BEeoegKL26Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 05:27:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 193312 invoked by uid 111); 21 Jan 2026 05:27:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 00:27:09 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 00:27:05 -0500
From: Jeff King <peff@peff.net>
To: Chris Packham <judge.packham@gmail.com>
Cc: GIT <git@vger.kernel.org>
Subject: Re: Detecting source of a push in a pre-receive hook
Message-ID: <20260121052705.GA567009@coredump.intra.peff.net>
References: <CAFOYHZDnXQOcDmzwf1WRpZpNRAs-R2YOBh3ru0mr0ffrMLB=9Q@mail.gmail.com>
 <CAFOYHZDcFJBiZwmposZVGmymmRz1XOaXP8iCRgTDVcsWPTH=6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFOYHZDcFJBiZwmposZVGmymmRz1XOaXP8iCRgTDVcsWPTH=6g@mail.gmail.com>

On Wed, Jan 21, 2026 at 09:45:51AM +1300, Chris Packham wrote:

> For various reasons we also have a CI system that pushes some things
> (mostly tags but some automated merge commits as well) that runs as
> the same user. We'd really like to be able to have the pre-receive
> hook reject pushes from the CI system but allow them from the Gerrit
> server. Does the pre-receive hook have any way of knowing the source
> of a push operation?

Git doesn't do any authentication or know about the push sources itself;
it just sees that stdin/stdout have somehow been hooked up to a client.

But the protocol layer that does that hooking up sometimes leaves
information in the environment. If clients are connecting over ssh, for
example, then you'll probably have an $SSH_CLIENT variable set. For
HTTP, you'd probably get $REMOTE_ADDR, I think.

How do you want to identify the CI system versus the Gerrit system? The
suggestions above would look at the source IP. If you're using ssh and
have different keys for each incoming entity, you could probably add an
"environment=" field to your authorized_keys file, and then check that
field in the pre-receive hook (or if you wanted, even use a "command="
field to restrict git-receive-pack to only specific keys).

Over HTTP, you'd have to look at how authentication is done for the two
entities. I _think_ you reliably get $REMOTE_USER if there was the usual
HTTP auth done, and you could check that. But you could probably also do
some server-specific magic to reject receive-pack quests. There are some
hints for Apache in the git-http-backend manpage, but you might also be
able to copy ideas from the test config we use in t/lib-httpd.

-Peff
