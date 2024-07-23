Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448C2C9D
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721705670; cv=none; b=dEmZv2s1bxg6/ZmO69wej/VjCmTOs49GpH7B9Tc8Li8kzTY944J5uecttwTOwUDVa6Wr41XkOzIH32LilvRhRmm+fKWO1ffMCPuaDKHSF+KTMl9bOszAIJehReNk8tsWIlOl/fgdCUBtNm8aLTGZRm7SMKCck3ljcb11kgp9nO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721705670; c=relaxed/simple;
	bh=e7RRfWpTqjlAi4NfLjUgPUvGEPlTlWhiyjBjxeG2MCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw0VR7UEis7fP/XDnwXOT1Vj4187exm+N1N/bHpBQ+uubQFmYoqdJ9Ek3oYY5TFpiHVVYyxuGfjpiPlTNrtq30RYZM+8FC/btQ8KxMopMA9n6nDMUYGNkkQK21PUwMSczpnVAeM7Tu2tVcmdogJbGFgrq4qG/avsVo68441x4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15333 invoked by uid 109); 23 Jul 2024 03:34:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jul 2024 03:34:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28123 invoked by uid 111); 23 Jul 2024 03:34:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jul 2024 23:34:22 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jul 2024 23:34:18 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] CodingGuidelines: document a shell that "fails"
 "VAR=VAL shell_func"
Message-ID: <20240723033418.GA1838963@coredump.intra.peff.net>
References: <xmqqjzhd81la.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzhd81la.fsf@gitster.g>

On Mon, Jul 22, 2024 at 04:10:41PM -0700, Junio C Hamano wrote:

> Over the years, we accumulated the community wisdom to avoid the
> common "one-short export" construct for shell functions, but seem to
> have lost on which exact platform it is known to fail.  Now during
> an investigation on a breakage for a recent topic, we found one
> example of failing shell.  Let's document that.

My recollection was that FreeBSD's /bin/sh was the culprit, but I
couldn't find any mention digging in the archive. However, I just
checked on a FreeBSD 13 VM, and it does have the same problem (that the
one-shot variable is not exported). I don't think that changes anything
for your patch, but just reinforces this part:

> This does *not* mean that we can freely start using the construct
> once Ubuntu 20.04 is retired.  But it does mean that we cannot use
> the construct until Ubuntu 20.04 is fully retired from the machines
> that matter.

since now we have one other instance.

I thought it also had the issue that the variable would remain set in
the caller after the function returned, but it does not seem to do so
now (if it ever did).

-Peff
