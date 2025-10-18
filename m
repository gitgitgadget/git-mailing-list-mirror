Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438D23C506
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780568; cv=none; b=KhEtF64rhvNwrq00cGbAkLYzkBTdOiMOaiyBhjNubZpdS8G8I5iIimZ94Rw6KI0YBsTvUrbw/cPlrHhx2+hVqPUgvt1OqFkzVdpV8YDKTqMGGhztY+itz6faEf0pY3nDo6xd5A/snDf7rNNtY0S8J0XvTvKma7e+JnTXpDuE+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780568; c=relaxed/simple;
	bh=UTlBr0mYTZO8h8K5JuRej+BRy8D14tB65gvUN7pfCMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTOKg/rFU3WD96AsA7hLCNWybstKTgKHJzePNgXUCPuPDmVxaXkH80GfiL0ewbqZVSvMGnv+bOS/eUdvVBesazdoYn3AmYjvUz3d+myNyRZLFgqcThjWSQM/5PSE66iP4QIYN7jFcIN//L+3AaTnwu7OKgBKOkLqGzzfurkPkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DVKroqDY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DVKroqDY"
Received: (qmail 261194 invoked by uid 109); 18 Oct 2025 09:42:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=UTlBr0mYTZO8h8K5JuRej+BRy8D14tB65gvUN7pfCMg=; b=DVKroqDYhi2qKuQrgN7lDMSCq4rxJ6cEknNF3FSfJbBXj1a6Bz2uce0SXFuhbL8KkKcdlIt4WaQM40TQdgOX3RJHt5bkqV/HhYBzjGdcAPVeIWhCflUWtM53jZJYVSprb8qDuFXMj74OzLIG7QHpHdnohrjCEU4eBqCWTWMmCNUSuFoznHpx8vcXa62YQY+qvewec00PRvoV2eYyI6g7sUEZ2ano83Ggz2i0lAsOwN3akmTqEJJy2CVnA2UQde9aDLR2ZKIoWZPYGot1iFxCBnMEDT2R9au3VUE1A0yW+s01S+MDT5i+TBxgrcFm/2Tjsqt1uvRyMFkQ8Agb15l03w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 09:42:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 409625 invoked by uid 111); 18 Oct 2025 09:42:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 05:42:45 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 05:42:45 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jake Zimmerman <jake@zimmerman.io>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251018094245.GB1060824@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <918E56B8-7009-4E8E-A98E-AC5B9CE4DD7C@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918E56B8-7009-4E8E-A98E-AC5B9CE4DD7C@gmail.com>

On Sat, Oct 18, 2025 at 09:04:40AM +0800, Lidong Yan wrote:

> I believe we can move Peff’s code from diff_flush() to diff_flush_patch_quiet().
> However, I'm unsure whether we should remove the dry-run logic. In dry-run
> mode, we would halt as early as possible in xdl_diff by using quick_consume().

Yeah, exactly.

I am OK to put the /dev/null code into diff_flush_patch_quiet(). That
would give all callers the same belt-and-suspenders protection.

The patch I posted put it where it was because that's where it was prior
to b55e6d36eb. It is essentially a revert (because I only wanted one
hunk I didn't call "git revert", but rather did a reversed patch
application).

But after that revert, I think it would be reasonable to move the code
on top (with the justification that it is helping the other caller of
the _quiet function).

-Peff
