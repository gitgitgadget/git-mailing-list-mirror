Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E85239E88
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967307; cv=none; b=KF99rfAYe8wf36eFejugw9M+kGYBDOTk/agzInfyzBl0GzAJg68TlkcAdqUT+Fhz+3esZv3bDOtIFd1HT2h3uiIowvqmUuRIeZsp+KbhpiHPPyW8LAhJ3SihaLWSd1I1UVBbqFrMarq7wxQg+pUDaauaTLSUZB3idmHS+LPr7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967307; c=relaxed/simple;
	bh=nT7yQfPNjHlhefm3IC/Dcro0iX0IEgZ1BvTrTc3Bwx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CDTBldDkVzr3RAkE4tNuBDCpEhxp5quDqi8KDDU/wgzb8IOzQHDzcd1aJjjNZ23al9vMGT9+4s9SZ6YgS7md+QWclcNo15pFyyOgUQB1GpOKMWf47bincAp5up49t+s6xCQWGP9ewtLyEfbYcxPiAPBVPx2uKuEsN1eIrVMDi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IjSEk3QH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IjSEk3QH"
Received: (qmail 62394 invoked by uid 106); 20 Mar 2026 00:41:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=nT7yQfPNjHlhefm3IC/Dcro0iX0IEgZ1BvTrTc3Bwx0=; b=IjSEk3QH4TaeMGK5IkjriPrvy6m/21CRJCmFkJYJSNQ4WVy3aXBBvFwG7mvyy5U/iNU4JldAA5NCPUogQU+tgVKCSgX+NorEb8YlMfc9+ZThDcpgIHEfhj2V1cThKD9hTzDON9NuFIQMNTrcigVodVpsabTA+uw8WF5JQ/NxCwjJXsiWPaQpVD4o07YOhBHiHbwXOEPZ+ZDjObR2zvfe4KXl43m/m7WnX6tiJqk3yi+sPyw+wtT1vFFShsFUo8VTkjS4QnFZGO+4AQvvVxf4IPCpxHAbC6bK5X94ujsIMtDtlJmDy8pl+Ww928zay+pu5RmrEJzzLOhLqrLkasg2xA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:41:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91615 invoked by uid 111); 20 Mar 2026 00:41:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:41:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:41:38 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 0/8] some diff-highlight tweaks
Message-ID: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Here are a few small changes to diff-highlight. The main motivation is
working better with diff-so-fancy, which uses DiffHighlight.pm under the
hood. But it was a good opportunity to polish up the tests and README,
and the final patch implements a small optimization I'd been meaning to
do for a while.

I based these on the bugfix patch I sent a few days ago in:

  https://lore.kernel.org/git/20260317230223.GA716496@coredump.intra.peff.net/

They don't _need_ to come after that, but there are otherwise textual
conflicts as they both add new tests in the same spot.

  [1/8]: diff-highlight: mention build instructions
  [2/8]: diff-highlight: drop perl version dependency back to 5.8
  [3/8]: diff-highlight: check diff-highlight exit status in tests
  [4/8]: t: add matching negative attributes to test_decode_color
  [5/8]: diff-highlight: use test_decode_color in tests
  [6/8]: diff-highlight: test color config
  [7/8]: diff-highlight: allow module callers to pass in color config
  [8/8]: diff-highlight: fetch all config with one process

 contrib/diff-highlight/DiffHighlight.pm       | 57 ++++++++++++----
 contrib/diff-highlight/README                 | 19 +++++-
 .../diff-highlight/t/t9400-diff-highlight.sh  | 67 +++++++++++++------
 t/test-lib-functions.sh                       |  3 +
 4 files changed, 111 insertions(+), 35 deletions(-)

-Peff
