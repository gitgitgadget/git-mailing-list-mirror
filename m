Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E028A408
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340705; cv=none; b=HnPmf3PtshhJBcbdVRL/ZNivppz8y65cqa7bQ8gvk5Ur2e14RocDDuQGFNSFvHSY4fGmBqbOjMGb0jHbPQeZB/l8Z8HFEpXsBszjWLW6uKNRQVVvsd3Bnbxr4S1K7Yl1ek0MBn6pxaAC1rJuK+4nFjEWisGCSayrbXU26Ywtuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340705; c=relaxed/simple;
	bh=+YeOY41+6H+Qq6TXZQBbKv3djiQwIKZKjYj8Ba1bYkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7+wLBumLsHILEDfvcXuUCwU1IibVeIUhzflRuLqHHflj3QmEjDg8EVegVHLCbeSnMMPkshwNSCqNt+5eafkRUAnBdLg3iFF9ryR+SbMofQfg/JHkhhUX+3ZipiVPSOVG8eySoIOFNEMoF3QpvdBJXxTkrVAyzuzzGZ3QcY2n5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GL4TJXrm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GL4TJXrm"
Received: (qmail 907 invoked by uid 109); 15 May 2025 20:25:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+YeOY41+6H+Qq6TXZQBbKv3djiQwIKZKjYj8Ba1bYkw=; b=GL4TJXrmm+57o6drF+d9AjnivI+Vju0Ez3iDJaAguev75q+BW7t+rX49ZFCPZ3gs1LWcXtl4FoUKw2TdfTcnxdwPPVsWd2wbgbe5zz401Rfr32MZ1m9OpmNGWnIKTl8GI/b9u5ukgG5jcz2DQWqsMMrOFKVg069Ult+zk68ZsPllExmQzd6dCmZfoAqQFUeMjl24/vQmxD1Vob5c4SnS7zZ1+ZhZ8U5s+7czaLcmClr9dbzltBweLTFBNs8a6VEyoPfoLtLeZwrrDJzoISM+SQHoVxPQBaYxfesOT45k8a1bOUOoHkmkdrD0utzkKZbJD5EK1VFAM1KyzAvYoYfmAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:25:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30886 invoked by uid 111); 15 May 2025 20:25:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:25:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:25:02 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] bundle-uri: avoid using undefined output of
 `sscanf()`
Message-ID: <20250515202502.GK3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <4dc3e2335afb42e5006ead7b9b18d33bdae7238f.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dc3e2335afb42e5006ead7b9b18d33bdae7238f.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:48PM +0000, Johannes Schindelin via GitGitGadget wrote:

> In c429bed102 (bundle-uri: store fetch.bundleCreationToken, 2023-01-31)
> code was introduced that assumes that an `sscanf()` call leaves its
> output variables unchanged unless the return value indicates success.
> 
> However, the POSIX documentation makes no such guarantee:
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sscanf.html
> 
> So let's make sure that the output variable `maxCreationToken` is
> always well-defined.

Definitely an issue, but...why are we using sscanf() at all?

Wouldn't strtoul() be the usual thing in our code base? Or even just
repo_config_get_ulong()? The behavior of the latter would differ in that
we'd complain about a garbage value in fetch.bundlecreationtoken, but
wouldn't that be a good thing?

-Peff
