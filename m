Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00DB13E8BD
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974852; cv=none; b=g9Eca6w+dTuv475sg1orEw9d5LI4WfEVIqdn+uwqGXVyRUVXeI0B1+BzSO70OdMnuo9FvgcS2/n6J81AHQq9+hjoJVR1whQ/K7uVJ1O0tf+O0JR6jVwDNb3bACH1nKsD228XZCyve3e3RhZ87R3DNU/sPV+ehuVieq62Cm2uNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974852; c=relaxed/simple;
	bh=SnrSwQBwhM3JpQ/TSxequVajauluJs2xxbKbTIGpFi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttgVA8JuWRHVd4WXzuEXLVyCGFfKudXEGzL8zj3kZe5Y3oPuPwU2x/CHAV7raLYA7k5Y2tUCgkXvikHrGvfpZn7qi7UgtGOuSRdqmc74zYqvvyzXnTxD4qstHaBYGeTvXG24Z62TIKYJ14TwVG6ua/rYBWxGb0QVePgulGm1G8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11476 invoked by uid 109); 29 May 2024 09:27:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 May 2024 09:27:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18357 invoked by uid 111); 29 May 2024 09:27:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 May 2024 05:27:27 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 May 2024 05:27:28 -0400
From: Jeff King <peff@peff.net>
To: Philip <philip.c.peterson@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <20240529092728.GD1098944@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net>
 <Zj8blb0QqC2zdOAC@framework>
 <ZkX9w6etjDVAh-ln@tanuki>
 <20240517081132.GA1517321@coredump.intra.peff.net>
 <ZkcUcPhrTrbSbZO8@tanuki>
 <Zkc_zJGjwg0fZkRG@tanuki>
 <CAJ6X7_VSswj6pw2gyfEp=Hmx237MJEJA4bW+QkKNs88iRf=Hwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ6X7_VSswj6pw2gyfEp=Hmx237MJEJA4bW+QkKNs88iRf=Hwg@mail.gmail.com>

On Sun, May 26, 2024 at 02:34:05AM -0400, Philip wrote:

> Part of the problem seems to be that the Github actions runner has a bug
> on OSX: https://github.com/actions/runner/issues/884

I think this may be a red herring. The issue described there is that
processes in the runner environment are spawned with SIGPIPE ignored.
But one of the things we do in common-main.c is make sure SIGPIPE is set
back to the default. So unless the problem is in a non-git program (say,
an issue with the shell, or prove, or something), I don't think this
would affect us.

That issue also goes back to 2020, and anecdotally, I would say that the
hangs we are seeing started in the last 6 months or so.

-Peff
