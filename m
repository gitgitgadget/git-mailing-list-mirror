Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588D1361C4
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160388; cv=none; b=hbD2059Dx9jKXNNHDrdtMlBwAGq48II8BkQWED0thsMG7hNQZ91q8ROLB4Rk19ZxN5vg0asJKdutmcXnEmqWH13slx+0bne7cudlYgJ47o+sS7jx2OgaoKiT4hlzBcCK2VM82+rfs6kJR05bNQQ8okFo96OrTEfYr5oqY6FeVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160388; c=relaxed/simple;
	bh=RROliFKb2D2LispcDbhe4uN63+/E6h+yEJ7FUs5yVO8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mB0M0OST2PdO1lXJftdXwhX4EgEhPr6yeWJmHoQ5oCM3AauMHNiz/zHrXvUvzK8GB/Wds2WFfgOpuaIUv1PzIHWi+weKmvbQ+gJiEFth6MGBnueSXwemF85w7cYi5tcTHIKeVuJgGwT+YwEyXEAgy+0/5IoibZJiyYa0yg3MRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23761 invoked by uid 109); 28 Feb 2024 22:46:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:46:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26935 invoked by uid 111); 28 Feb 2024 22:46:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:46:27 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:46:25 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/4] some v2 capability advertisement cleanups
Message-ID: <20240228224625.GA1158651@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

While working on another series, I noticed that upload-pack will accept
the "packfile-uris" directive even if we didn't advertise it. That's not
a huge deal in practice, but the spec says we're not supposed to. And
while cleaning that up, I noticed a bit of duplication in the existing
advertisement/allow code.

So patches 1-3 clean up the situation a bit, and then patch 4 tightens
up the packfile-uris handling.

There are some small textual conflicts with the series I just posted in:

  https://lore.kernel.org/git/20240228223700.GA1157826@coredump.intra.peff.net/

I'm happy to prepare this on top of that if it's easier.

  [1/4]: upload-pack: use repository struct to get config
  [2/4]: upload-pack: centralize setup of sideband-all config
  [3/4]: upload-pack: use existing config mechanism for advertisement
  [4/4]: upload-pack: only accept packfile-uris if we advertised it

 t/t5702-protocol-v2.sh | 18 +++++++++++++
 upload-pack.c          | 58 +++++++++++++++++++-----------------------
 2 files changed, 44 insertions(+), 32 deletions(-)

-Peff
