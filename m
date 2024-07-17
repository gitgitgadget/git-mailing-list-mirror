Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775811C83
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721195618; cv=none; b=CUEcDaPQn4VZsgiixuR7pK7j6ege9kCvBqJiMo4v8PhqD/ib5oCD7Q8oToXE6arq2PdKh/i58PokBpyNYbFBqX0nvIsGPdpWy/YpnVLCsU4gMru7gSXuAWnWlRpdgC5zq4X9tCiMRvj+zTZd+inE5I4wK40VBqd14sCKUGN3Iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721195618; c=relaxed/simple;
	bh=lsHBwK/A2df8H4nakLaBNxobIYOwN9Hr/jdsLz+fGLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiOf9ZeUylushf2CeXy26OIn1yI19a2gk//DPt/4svqN4dlt3Rz02eANpZZO6fy3exKEzF9tGBUK3pncOvgP1Aptbuu9A08Ypb41g0OVU7xn1N5FgRlgdeT2/dNHXoWlN5kTcS6n4+/CkbqXQCHm8zRj206ytyIsrvjk4ZMd32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23407 invoked by uid 109); 17 Jul 2024 05:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 05:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18776 invoked by uid 111); 17 Jul 2024 05:53:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 01:53:34 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 01:53:35 -0400
From: Jeff King <peff@peff.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Moser <scott.moser@chainguard.dev>, git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
Message-ID: <20240717055335.GC547635@coredump.intra.peff.net>
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
 <xmqq8qy21k9f.fsf@gitster.g>
 <20240715235212.GA628996@coredump.intra.peff.net>
 <20240716192307.GA12536@coredump.intra.peff.net>
 <87jzhlf2i4.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzhlf2i4.fsf@igel.home>

On Tue, Jul 16, 2024 at 11:30:59PM +0200, Andreas Schwab wrote:

> On Jul 16 2024, Jeff King wrote:
> 
> > Again, it's possible that we could detect that no shell metacharacters
> > are in play and do the word-splitting ourselves. But at that point I
> > think it should go into run-command's prepare_shell_cmd().
> 
> This is what GNU make does (see construct_command_argv_internal), for
> performance reason.  But run_command is probably not performance
> critical.

Thanks, that's interesting to hear. I agree that run_command is not
usually performance critical. Generally if we find ourselves spawning a
lot of processes, the right solution is to accomplish the same thing
with fewer processes (or even in-process), not micro-optimize out the
intermediate shell.

-Peff
