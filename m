Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C126D4DB
	for <git@vger.kernel.org>; Mon,  5 May 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468205; cv=none; b=qH9pCvVeHDN3nW+IyKSaFo0o7N9n+KTm3GhgqOhxfatwPzhk5+SwvLDcWXPhNIl0S6YacaV3f5weK0UfDXSEBGyCmqeBuL8hXY1z7tPv8bwZLeIzhQrsxYH4XmdYbkwfKbB/zd9GNJkN+/lIggLcxnuyH735zmGq2Ily+muYM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468205; c=relaxed/simple;
	bh=0rOPmL/urVcRqK17/OiCQ3TkjlUS7Efbuu7l3nBawA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnJ8wS3NbvuTD/HMoitbClXni6xvEzO4QhULvUMcJHgkxIXpeUtMCO+1diGDkcty+Kww1zZySd82CHRX5Q+IUPFmNAQlfvQ720yJlSpX9hnCRfvJlQK1LRC5whca0nokO6bufs/R5nmbfbMDezvkos2Fc3wRsFX0ISDvBj8VKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Km5bIFKH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Km5bIFKH"
Received: (qmail 29470 invoked by uid 109); 5 May 2025 18:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0rOPmL/urVcRqK17/OiCQ3TkjlUS7Efbuu7l3nBawA0=; b=Km5bIFKHziM2534W1eY5DLtG1y48FaPOEtLbLOVlCxptw8y6ZHIlq185Ok7hLy96H+iMTpCgKGYZTQSE6ogXdIg4qtxX4K1nTb9dpKyM9Ofdeg4QY/mNKp7HRyWiMWl/WVhABi3lqlDuccoJRnErpMs5BPRtzili5o35wZUN4Zb8DU1O7H0dShs0tV8K4ZUeH+ItHsoCvW1iTHrOhEL4cY9QU+6RwnAyfl2301pLifOVHkm1au/jap48SqJGvdtMLFSuRt0O6rUNHJ0XrgdAzdksEnAen7cml/AMvhsUDPEAo2gtLKB4OSHHz8WVmkoHzVnGooo50KSvp6mBCInoJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 May 2025 18:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5103 invoked by uid 111); 5 May 2025 18:03:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 May 2025 14:03:13 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 5 May 2025 14:03:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <20250505180311.GA29783@coredump.intra.peff.net>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
 <20250503133158.GA4450@coredump.intra.peff.net>
 <xmqqtt5zoyg9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtt5zoyg9.fsf@gitster.g>

On Mon, May 05, 2025 at 08:43:18AM -0700, Junio C Hamano wrote:

> But for other kind of requirements, we want to fulfill them on all
> platforms that we claim to support.  Using open_nofollow() to
> achieve hard atomicity requirement would be a bug in such a
> situation.  Should we somehow warn our developers against its use?

The comment above the declaration says:

  /*
   * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
   * may be racy. Do not use this as protection against an attacker who can
   * simultaneously create paths.
   */
  int open_nofollow(const char *path, int flags);

though that may not be enough. 00611d8440 (add open_nofollow() helper,
2021-02-16) discusses a way that it could be made less racy, at a
slightly increased cost.

IMHO that is somewhat orthogonal to the issue here, though, which is
purely about the case where O_NOFOLLOW does exist (ironically, our
racy fallback code consistently returns ELOOP ;) ).

The issue at hand is that particular errno responses are not always
portable. The patch discussed here improves that. My point was more that
I'm not sure to what degree we should care about errno consistency in
our wrappers (which is inherently a bit whack-a-mole as we find new
cases), versus trying not to care too hard about specific errno values
in calling code.

I can see arguments either way (and as I said, an argument for making
errno values consistent even if we try to rely on them less). Mostly I
was just a little surprised to see open_nofollow() being used in this
way (especially since we have to end up stat()-ing anyway to check for
other cases).

-Peff
