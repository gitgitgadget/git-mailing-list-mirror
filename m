Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E283502A7
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054778; cv=none; b=j93BNWzDkZnYs6f7kqI7G1aEjetsQHM90bao6Yc7qUi72JtRDAVtH+eCrZVxo2nFvX5P+v9GmV88y/Zq++37DxCHl2dZBgXv4juijBhrPrA+aQwwpe2HLWXl/CWbP56/gSZxnvgKeTQiHfLO3IpBoN3PpeoeuyZZOfOTov080j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054778; c=relaxed/simple;
	bh=bhm6xO70embeWAtBNyXJtIB1A4hyuLr2n+NrlVu2cug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WkKVjuDyEtrBwyCXIVOEf1yx32LoJQiXhEfj/40spw3zxIvbvnq5d12jniyOFFgoAq70s8e4AtWOlvhJqCIbTqHhvlwoAdNa5PkNepuUukTyK+C5+RJWNN93voMEehk8jGZJNPc+r6SnnXrJ4P/LCNyDu+Y3WStNNxyxAun+5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IBHyr3Xp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IBHyr3Xp"
Received: (qmail 56876 invoked by uid 106); 26 Jul 2026 08:32:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=bhm6xO70embeWAtBNyXJtIB1A4hyuLr2n+NrlVu2cug=; b=IBHyr3Xp4PGOj30uZS9CUK+IomGa4BYTZBYkjsC/xR24HRlVGMIieKJ7KQ3C3Lep6KkRdeT/XCoS510WU1fGtTB/+3ilGl3OOJXGsPpEJiPUxutvZvTrxfWNebU6F0bnyCLtV9f7cj6HSdpsHfKRhCWfedShAQ+gLzpNo3b1maz1Ogs3UxC7qY2vlDgVs4Gymd3jEDZiYde28XrzqFKsLiDRtm1ke5U2o0w5bbCImzGTMD3rGN2Jh5HfRLjP3uWSBIJURUHM/S5PufUUmt/zGoqys7wXTOIW3d/ehOMHsxixUexNpbIqjJjyauSBBkNf/D6h+jUCSH0ymsANFCJoag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 08:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57772 invoked by uid 111); 26 Jul 2026 08:32:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 04:32:59 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 04:32:54 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: tnyman@openai.com, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] bump static-analysis ci image version
Message-ID: <20260726083254.GA3528497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is another way to fix the slow coccinelle run discussed in:

  https://lore.kernel.org/git/20260724091152.27794-2-tnyman@openai.com/

by using a newer version of coccinelle.

We tweaked the code there to avoid the problem, so this isn't urgent.
But it is worth doing to avoid running into the same problem again (and
because in general I think it makes sense to run newer versions of our
dev tools than older ones).

The second patch is the interesting one. The first is a necessary
clean-up (+cc Elijah as the relevant author there).

  [1/2]: bloom: silence CHECK_ASSERTION_SIDE_EFFECTS false positive
  [2/2]: ci: bump ubuntu image version for static-analysis job

 .github/workflows/main.yml | 4 ++--
 .gitlab-ci.yml             | 2 +-
 bloom.c                    | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

-Peff
