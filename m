Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61716F840
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271743; cv=none; b=PJphWfh1jgziaIe2xPIxM4NZD0Ou/n0EiGk6WEULVtOuZyq2OKBLiMdCbkMn7KY7sq/iAlZf1ijKUfIJ/6/l7Ml3v6pgp8rnuM4ovnD3HroVVcyobXI+bWfvhUoWya60c4bBMYG09MfJbDaCqvPSuXWuceol4Hx0Vx49HRmLjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271743; c=relaxed/simple;
	bh=bjhE881OEtcmKJ7fVmFKcKJR93776o+voeiUCKOvDlw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ss7Cod3CEUbtXBn83H6YBoIVEKMs4N+8t5n5Runv9tTojNj307nQ5rQEt1OkkiUv+Ykvowr1NzNnNz08bK5ptSjvfcW6zLcmWiG+cKN4wdFXQtHX3KBUe823qvNBELe1NvyBhVF56RhCC0rdXXleAeku0RYYDemZGFYzZ2oU8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6909 invoked by uid 109); 9 May 2024 16:22:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:22:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31108 invoked by uid 111); 9 May 2024 16:22:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:22:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:22:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/3] un-breaking osx-gcc ci job
Message-ID: <20240509162219.GA1707955@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The osx-gcc job seems to break reliably for me, which started in the
last week or so (since the last time I actually triggered CI). The third
patch fixes it, but I noticed while investigating that the job is not
even running gcc at all! That's fixed in the second patch. And the first
one is just a cleanup I found along the way.

I'm not sure that this job carries a huge amount of value over the
osx-clang one, so we might consider just ditching it. But in the
meantime, this should get things passing again.

  [1/3]: ci: drop mention of BREW_INSTALL_PACKAGES variable
  [2/3]: ci: avoid bare "gcc" for osx-gcc job
  [3/3]: ci: stop installing "gcc-13" for osx-gcc

 .github/workflows/main.yml | 3 +--
 ci/install-dependencies.sh | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

-Peff
