Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D131411EB
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723891105; cv=none; b=SYyc4+0YEYSPJTo2FXjIJV/FotYO6UbxvJRdMIXSccpmXa5QH+y0sBzzJW1sMVygK1P6NbOI9tOpyR2xj8J51op2IL7R0M0fIUVxtTCvVskNeKreGEQy8B+EKjipW2lS6j8IP3j0wKPeLFi7EuZeyGpW3f6lbErti341LRcyp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723891105; c=relaxed/simple;
	bh=Ir45SUh7hhzb+pOfXa0L0kYBodUgyrghiUpI3SME6OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoEfFe/UWFjeAByP3H6KcRiTxIhmZmIKNR22AlFt+YNBHVhw/vpaMFqKQ7EfxdTIZ5ZeIXRBGch1p7cmvr9fwIIO7KQs3SEs+wsJ1VmwGb6vWTsPGM5DvEuN6XAPIkCAAfZfpQHCz+vrHAAACYgvr0906mSfgX3jQx3tXKDk1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25923 invoked by uid 109); 17 Aug 2024 10:38:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 10:38:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28903 invoked by uid 111); 17 Aug 2024 10:38:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 06:38:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 06:38:22 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] pseudo-merge.c: do not generate empty pseudo-merge
 commits
Message-ID: <20240817103822.GC551779@coredump.intra.peff.net>
References: <cover.1723743050.git.me@ttaylorr.com>
 <c7e0ee0712034f654f018361f52c09b1043a8441.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7e0ee0712034f654f018361f52c09b1043a8441.1723743050.git.me@ttaylorr.com>

On Thu, Aug 15, 2024 at 01:31:17PM -0400, Taylor Blau wrote:

> The previous commit demonstrated it is possible to generate empty
> pseudo-merge commits, which is not useful as such pseudo-merges carry no
> information.
> 
> Ensure that we only generate non-empty groups by not pushing a new
> commit onto the bitmap_writer when that commit has no parents.

Makes sense, and the patch seems pretty straight-forward.

It's a little tempting to suggest that we keep some way of writing
these, so that we can exercise the reading side in the tests (we
_shouldn't_ see these if we're not writing them, but as an on-disk
format, we may see examples from other sources). But it is probably not
worth the complexity. If we really want to test them, we can probably
generate a single example by hand (and we can probably even wait on that
until we see something in the wild that makes it worth doing).

-Peff
