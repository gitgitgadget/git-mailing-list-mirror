Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D130F92D
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328288; cv=none; b=P63YvoHNwdMPIvm6jvohJb28kCZKAL4SG1wwYIb2qFF0XUA2JALDkJbwMld6U8il6W88387tVtBmbGe8LYXYYvaMpaH4o0Ad2iRkq/JY/Z5RgVo2pxdsKFr0J/P3b+QprXcuAEzlf0IhMV1YeuV+kL28h1NXVzaoIlzh5ZysWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328288; c=relaxed/simple;
	bh=4vnRRCyRWzHk4/1L3limI86k2NUVtGAHQqzO9LxLfqo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LNGXL5CuDEX5IY62krhUcjyy2B8pk8moaWNBo6R0VcL/vuD2jt7TtPiuwwAWLQcFzWaQnVFag6+QPB04stx52ZFPeL9CNSwUS840+gsoSoJWqyqxYcEvYF2eEKzvXu24tx2V8bx2Ue7ohdCDfcbi07Xm+j62IAL5XfubTYzh6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KFgT6E37; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KFgT6E37"
Received: (qmail 9956 invoked by uid 106); 2 Sep 2026 05:51:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=4vnRRCyRWzHk4/1L3limI86k2NUVtGAHQqzO9LxLfqo=; b=KFgT6E376wgKm79fZLUQtYvaSB+p24oWNCexODkdLSPb3SSCgFqQkQL+H/u5E0QIMBmB+Nlqrt6aGqRnC77hDA7caDmkJ+nGk8NIQswQ0H9eooT0AAF86gh1RrITrLNVJ0btjSML1cDgapUvxm2tPIjfbst7yCN4z4qCr/x7D8zszUSXnM7Fcpymi7/nmMHXxtZRnNeoFKcIpj2kBta97L7GC04jqrndN8zt5z1dXHPuRiXqNw3kjkfCuvrhcKg6qb/Er9K+9UEjvg0BSoDR+AUYnS2yHUTjstNu2FuSVjtEuW8DBuktfi9wOW0APYpjk53UawIcjGhcxiYewbse2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 05:51:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46793 invoked by uid 111); 2 Sep 2026 05:51:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 01:51:18 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 01:51:17 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/2] fix a leak in submodule error path
Message-ID: <20260902055117.GA41587@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This fixes a small leak noticed by Coverity. I think it has been there
for a while, but nearby code movement caused it to be marked as "new".

  [1/2]: repository: make repo_clear() idempotent
  [2/2]: submodule--helper: free URL when repository setup fails

 builtin/submodule--helper.c             | 10 +++++++---
 repository.c                            |  3 ++-
 t/t7426-submodule-get-default-remote.sh | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

-Peff
