Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A0374185
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775769052; cv=none; b=KqX4vQqsv5ipoknQPtDZdNM4C70WZxGh+Z3Qtuj/nTcDfgHBwcTlPlxNQcs9CvIlyTuUu0cJ4w9M12s/hPsJkdO8DyYwTbapxHFPsCz2nCO9+MsQz8DyxvqevgF2cI+OedHmsa95WbiAfIlza3lJwy7fIe7F3cqRQw/fMT60rnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775769052; c=relaxed/simple;
	bh=f3U9HMbevKFI5fVGLklUFO/3+SQnDOB31SH3i9BqeHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3LAKTLsLib1Wjk5iUj92IJVe20UnVki+KATY/XJHgkTCMhn+TBPaPRf8OvwZA6cA9XtZyMQtr6ESre9fC+G/2Rm9qSF5KK+QN7A8bX4kDJrXIdfkLfzz4GBb61/pyajDAGGD+c5UsuRFGSBxhGlHpeI4sxuGnKCcNYRlPz6nsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HaA8dNHM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HaA8dNHM"
Received: (qmail 295126 invoked by uid 106); 9 Apr 2026 21:10:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f3U9HMbevKFI5fVGLklUFO/3+SQnDOB31SH3i9BqeHE=; b=HaA8dNHMSCEKA7c15u0jZhfo2PanavKX3mZu/Wx0fATl0fazmUA5f4oE8Am3FJol+chBZ23ScrgtQkDGhBt4O37hIIMarLbh2p9D8f/Q3QhEqEk97VvKdQWQ2hzG+jjsdC3Vbga/bq/Y7iV/PFCiHHGOUvdpEygtRRdcHoPANpiVp0lbNu/YwNagQcYWdS0La1R4NWpPJ9Ahz9NXIz12FHVMWCEC+RhmpCf9ObSNPus8SnrXe2StHaNPjDFc/KEVqLR0jxzxtVrchxKiRLaCCVbsxZX4Gc5VwMm6Lay4qlkMRvAngttLbZW9ACfxFTTH4OVFz6wqBb3HAzvNQamCtA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Apr 2026 21:10:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 488095 invoked by uid 111); 9 Apr 2026 21:10:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2026 17:10:50 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Apr 2026 17:10:49 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: 2.54.0-rc1 NO_WRITEV=Nope  does not work
Message-ID: <20260409211049.GA3119065@coredump.intra.peff.net>
References: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>

On Thu, Apr 09, 2026 at 03:48:16PM -0400, rsbecker@nexbridge.com wrote:

> With a completely clean build, we are getting writev() being used anyway on
> NonStop:
> 
> /usr/coreutils/bin/make NO_TCLTK=NoThanks NO_WRITEV=Nope V=1
> prefix=/usr/local-ssl3.5 CFLAGS=-g -O2 -D_LARGEFILE64_SOURCE=1
> -D_FILE_OFFSET_BITS=64 -Winline -I/usr/local-ssl3.5/include
> -I/usr/coreutils/include -I/usr/tandem/xml/T0625L01_AAE/include
> LDFLAGS=-D_LARGEFILE64_SOURCE=1 -D_FILE_OFFSET_BITS=64
> /usr/coreutils/lib/libz.a -L/usr/local-ssl3.5/lib -L/usr/coreutils/lib
> -L/usr/tandem/xml/T0625L01_AAE/lib SHELL=/usr/coreutils/bin/bash
> GIT_VERSION=2.54.0.rc1

Hmm, the plot thickens. I think our fallback wrapper is being overly
picky. It does:

           for (int i = 0; i < iovcnt; i++) {
                  if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
                      iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
                          errno = EINVAL;
                          return -1;
                  }
  
                  sum += iov[i].iov_len;
          }

so you are probably hitting that EINVAL! Which is trying to emulate how
a system writev() would work, but the fundamental problem is that it
_doesn't_ work on your system, because ssize_t is too small for how
we're using writev(), which assumes we can pass in 64k at a time.

It is tempting to just delete the EINVAL check shown above, but then the
rest of the fallback function needs to be more clever, and return a
partial write before incrementing total_written over the ssize_t limit
(otherwise we have no way to report to the caller how much was actually
written).

Yuck. I think for 2.54 we either have to truly implement MAX_IO_SIZE
support, or we have to revert the use of writev() in send_sideband()
until we do.

-Peff
