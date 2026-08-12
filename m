Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BE3FFFA7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570482; cv=none; b=jIuIeD0G3JCXCpl6eOA2X1cTRhGpV1Io4WRTAxvJNdL6CWyE73bjTe6817Dce0iqMj/ALxngghdQGACl1rQfmnRl4EKlUbFJCtXJQ96NYM0Fmz3Z6b2UviHa7bFENzw/z2oMsI52paNLAS39+TDNWjjut06whdDE4NLPPYCe+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570482; c=relaxed/simple;
	bh=dNt2dZI3xpM7HgP0Q5iCGpFZQlyfiusMJcAqNT+hEWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/48JNfRJg4wrY2UGe8bLYcb6eJtbV4fDo7dmWsk6uF1si6T3AJXctqjj4EhEWtEHtgLuIwGaaeeOIlesf1qdTrbiFdQW0ZIQUFkwM7UibONSB240HVZthmRWBtJJjPHMUncjIxLzQ1GnofDvltLGEKB4//4NGOkmXgMFkk7QYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A8qWB+QC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A8qWB+QC"
Received: (qmail 44862 invoked by uid 106); 12 Aug 2026 21:34:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dNt2dZI3xpM7HgP0Q5iCGpFZQlyfiusMJcAqNT+hEWU=; b=A8qWB+QCuD1Yke2IJwy/+SQqoz370evrTZe1OLuBV0LREveEnHKw6gAiALk9kzWM1Pn+pg8sm2r+OxvV7vkIGRL4xloxQNhF4gO1TuRUuHn4kfQIXNPdvaMXtMBwZ9h5tgKJAKjhG/xC2gzeL5PUSg4Wj0EV2O+KqhvDdvZ+j9MfDZUvsc/NbGdzzQT0Hz0DpuGqg7gkTGW2+Ef5khVZmMN2yg7rFWIzWeR2EuaT5LGrIiNRLmxAfn5iAxaJwo1RP9dHS1MxTprDQyX3arHLFTmanOgxzkye3njUQbWkK4IwCiqlgdfyLI6bO5cME0bfQBhG+RFtnbvkWEvtg1zTmQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2026 21:34:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31435 invoked by uid 111); 12 Aug 2026 21:34:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2026 17:34:39 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Aug 2026 17:34:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/12] coverity: fix unchecked returns
Message-ID: <20260812213438.GC152730@coredump.intra.peff.net>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
 <xmqq5x1fxn5u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x1fxn5u.fsf@gitster.g>

On Wed, Aug 12, 2026 at 10:29:33AM -0700, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > This is the next batch of fixes in response to issues reported by Coverity.
> >
> > Changes since v2:
> >
> >  * Added a new commit to handle block-writer initialization errors (instead
> >    of ignoring them).
> >  * The bw->zstream attribute is now also deinitialized in the error case, as
> >    suggested by Junio.
> >  * The commit message of "reftable/block: check deflateInit() return value"
> >    was rephrased to stop suggesting that silent corruption by zlib would be
> >    possible before that patch: This turned out to be provably incorrect.
> >  * When aborting the bisect because dup2() failed, a left-over saved_stdout
> >    is now also cleaned up.
> 
> Everything looks sensible.  I am fine with declaring victory, but
> does anyone want to second it?

I cannot claim to have read all of the patches carefully, but this
version addressed the sole concern I raised, and in the few other
patches I glanced over I didn't see anything to complain about. So maybe
consider that a weak second. :)

-Peff
