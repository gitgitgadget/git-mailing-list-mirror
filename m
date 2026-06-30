Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E72777FC
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801850; cv=none; b=cuNwD6hgwRDHV9kw/mj1PQDQ52G3MtwYbAwkOA0ByRvG9A0phQn0XoyLtEWirzStD7ZNP9JiY7+p9ffYNHQwcgec5/FQVxvO+XPaRIt0axsfyNRVL7hfDz0ZMxULlZAya9T+LmvlkkRkP4wMYbHYl9FtXu/DqtJefAwsRrTGpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801850; c=relaxed/simple;
	bh=fI1FMvmp7zOwVnKmh2nQV2vaIN8x5W6UmYXsg87pcd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXg1uVGRu0+QNcOcBjcAmy2At2dlXO8YcUe/R0EJmYZ8IKiiPGhhpxey8RqeWeyJZ4zWvebXV4abYQk3SYQ6Fm43343grXzQxtvlHF1S3x9e8mMBxmwQE5qoKKvhbYaImI4ROOiUXAVqxjPWFy11w0H0gxm/DzwA9mPTCbPqI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZKdVFiEK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZKdVFiEK"
Received: (qmail 69932 invoked by uid 106); 30 Jun 2026 06:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fI1FMvmp7zOwVnKmh2nQV2vaIN8x5W6UmYXsg87pcd4=; b=ZKdVFiEKF6qORWlnWXUMi/k717wjpDSK1yKuZD9sxceYomrLSgRg9SDBNqX3XkE906Ku8UmkEa5kwUhMdzIsCRQmHmtcB8m+a6rmVI9jh+an3vj31s3j7gNfG0/qmgBEJMJISsUhEekcN6IO/loMr+pQgJZ5v6/FF6FCprKCNOKTHAUVbby1B0zT21+DWRmQtic3Of8DRHAEgmespsjB7YwwFWjDyk5RageizCe771KfkvBSfHY2dyN13pzL+9tkT9EQ4mpQ12OEByAdBYYbxIhku0JBgVBTTbELPlhQrF9Kg3KRt/28pQWOCfhd2MNR8a2qzkn9IsIELyWZmHHEDg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 06:44:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 141423 invoked by uid 111); 30 Jun 2026 06:44:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 02:44:06 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 02:44:05 -0400
From: Jeff King <peff@peff.net>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
Message-ID: <20260630064405.GF2495216@coredump.intra.peff.net>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im>
 <94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com>
 <20260630053825.GC2495216@coredump.intra.peff.net>
 <20260630055026.GE2495216@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630055026.GE2495216@coredump.intra.peff.net>

On Tue, Jun 30, 2026 at 01:50:26AM -0400, Jeff King wrote:

> t4014 also fails, but with a unique leak. I don't think it's the same
> thing; it looks like we may leak the slab from init_topo_walk().

Fixed over in
https://lore.kernel.org/git/20260630063944.GA3733670@coredump.intra.peff.net/.

I think it can be handled independently of your fix here. You might also
run afoul of the prove TAP-output thing fixed in that thread.

-Peff
