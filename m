Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54F30B527
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223404; cv=none; b=hDf/U5ZU8rTez3eOi0uYR1AQfgAr9G6+VRZJBDIX4ENXMsAX2eY3WI+kyH3xlXuAV4zDxjEJkJnCyymtzmGqM2LzOIpYPDC1J7g0+cWnd83FgTm2VUs3cDKCfn4SNB4hwkKH6MTyBN8rsTTkdpmDVSZ4xKZqyY5uAeamQA9ZMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223404; c=relaxed/simple;
	bh=PbWOmy9DKf7+xo+WvRxJXGxUo+2I1pkt8HMt7cjXzTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GauTftx/XK8pdXBShHkjwLnoi/fVZNieL0hEYlwQ2i2FE8VXsu5iFcXmOC2QfRkyQZ+MY8Ynqmsv4ia5cxFEhPObmh9F41aEqlrPNiHQuijzhykxUPJsKrpLR7kn68GxPlrIECMuLcGDHylIu7On0XQPuBStw27dAz9UemdIvj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GcDC9BGz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GcDC9BGz"
Received: (qmail 315689 invoked by uid 109); 23 Oct 2025 12:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PbWOmy9DKf7+xo+WvRxJXGxUo+2I1pkt8HMt7cjXzTY=; b=GcDC9BGzgWvlmrGZbFIuSMFBWij1zB3pOO5IbQjBAgUsbEQBqKSD4k25glWZVugValzWPr8vlkoYAZJd0qmUegUWnoXwXXxzV+g4kDdNZTFIeG5P7Kk97N0SIUmcPIUijBBrp1PZ0lhgOUWE7zQ7nOCi9CKJSMxBTUOUWBJqjnCH2QxwFLXafIWe0C71cr0DrKDPD0nKnhXLryx9epWiVaRWr+yIeHXSZ1zCSQcsG6+wUvZjKF0cwhFuHXAiacGgZh3x3Mg3G/I83Nh6zQu2gmi9lOI1Yk0YC10tbEVGw0QeC66zzg0YLFYMCu/OcEBYeqpZGdDExR7xkA+VwV2Q1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Oct 2025 12:43:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 490983 invoked by uid 111); 23 Oct 2025 12:43:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Oct 2025 08:43:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Oct 2025 08:43:20 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lauri Tirkkonen <lauri@hacktheplanet.fi>
Subject: Re: [PATCH] t7528: work around ETOOMANY in OpenSSH 10.1 and newer
Message-ID: <20251023124320.GA1163932@coredump.intra.peff.net>
References: <20251023-b4-pks-t7528-ssh-agent-socket-name-too-long-v1-1-f15eeec199f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023-b4-pks-t7528-ssh-agent-socket-name-too-long-v1-1-f15eeec199f3@pks.im>

On Thu, Oct 23, 2025 at 09:14:59AM +0200, Patrick Steinhardt wrote:

> As it turns out this is caused by a change in OpenSSH 10.1 [1]:
> 
>  * ssh-agent(1), sshd(8): move agent listener sockets from /tmp to
>    under ~/.ssh/agent for both ssh-agent(1) and forwarded sockets
>    in sshd(8).
> 
> Instead of creating the socket in "/tmp", OpenSSH now creates the socket
> in our home directory. And as the home directory gets modified to be
> located in our test output directory we end up with paths that are
> somewhat long. But Linux has a rather short limit of 108 characters for
> socket paths, and other systems have even lower limits, so it is very
> easy now to exceed the limit and run into the above error.

There's a secondary issue, too: even if the path is short enough, the
space in "trash directory" of the path will break the shell eval. That's
relevant below.

> Work around the issue by using `ssh-agent -T`, which instructs it to
> use the old behaviour and create the socket in "/tmp" again. This switch
> has only been introduced with 10.1 though, so for older versions we have
> to fall back to not using it. That's fine though, as older versions know
> to put the socket into "/tmp" already.

OK. I think this is an improvement over the status quo, though it leaves
a lot of loose ends, like:

  - what happens if "ssh-agent" does not exist at all; we do not notice
    the error because the eval succeeds anyway (with blank input)

  - one reason we did not notice this immediately is that the failure
    mode is to fall back to using the user's SSH_AUTH_SOCK variable if
    set (i.e., their real agent with their keys in it!). We should
    perhaps be clearing that variable in test-lib.sh.

But those are not really new issues, and I'm OK with just un-breaking
things in the most expedient way possible.

> An alternative approach would be to abbreviate the socket name itself so
> that we create it as e.g. "sshsock" in the trash directory. But taking
> the above example we'd still end up with a path that is 91 characters
> long. So we wouldn't really have a lot of headroom, and it is quite
> likely that some developers would see the issue on their machines.

I assume you mean here something like:

  ssh-agent "$PWD/sshsock"

Yeah, that is not buying us that much in terms of headroom. Plus it
would still run afoul of the space issue, since we know that $PWD will
always contain "trash directory".

If we are going to provide a fixed name, I think it would have to be a
true relative path like:

  ssh-agent ./sshsock

That does work (and SSH_AUTH_SOCK contains the relative path), but is
maybe a bit of a booby trap waiting to spring on somebody who tries to
access the agent with a different current working directory.

-Peff
