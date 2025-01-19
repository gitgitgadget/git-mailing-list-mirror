Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86E1C3BE7
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737292348; cv=none; b=stzucqpgCb1calJD9f1WBjZK7tdzGKw6n4HSXN8JPh4R4ah9QdCQbim7sNphT2IsZUPRZMBr7De9yo6ywTF5edyuPY9TqGpeEiFVGa1h26ijEdWcZMWV6lPAKn3oZmI5Q4kKWEoTcnKqYOCvdR1EWPA6SIGYl4Lxl9voG1Ugrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737292348; c=relaxed/simple;
	bh=YXUqi/BQ1NyR/q2r7kCFqepPFJ4cRrsWMAGIbB3a5/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAH7d35sNOYXyKKV4PdFRglwVBm7nNDV0nySmJibzTvtuwRenBff0uaoOA6xf9FR89RXr3RJIN/pTzOksqHUlvvFC0bw2c8RPUrf+u1C0prwFT1SKraaAXRxhWosDL5hdoL2MosuG19nFV+dLtuW3gIm1haV6IO0rsXGUwQyF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TRrY4oum; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TRrY4oum"
Received: (qmail 7938 invoked by uid 109); 19 Jan 2025 13:12:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YXUqi/BQ1NyR/q2r7kCFqepPFJ4cRrsWMAGIbB3a5/s=; b=TRrY4oumTSBwg9ln53i6OcBERoV1Xwzt1CKOBHB3cLaNK8nFKpqS4rLdjq1KLSXBSncQlmxy+464ssM9xs3G1l+H7c4UOGwdwv/i/yDtTDJKGj2L7mSMzYLGGhVB11GapjywpsI+IekHl1kk0JnQaTUIOEkYx75lWxqLp93TCefojgo3h8DJPcu0eB2/2VgnFKQ/vc6hZFELxwF7zQTYe563XfB+GgUrhPHK9cVfc7FBUE0y3KBFGncNK8DMzMkI9AyplxwNE+CH2TEyZc6jQV0SUStV0Yo1uGTpqP518kqqt3oRpUPhN7NFAayP0ji8y81qgacCOC4NaQLhrQSC3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 13:12:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 654 invoked by uid 111); 19 Jan 2025 13:12:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 08:12:25 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 08:12:24 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 0/5] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <20250119131224.GA1541095@coredump.intra.peff.net>
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com>
 <20250117121121.GA2356599@coredump.intra.peff.net>
 <20250117125207.GB2356599@coredump.intra.peff.net>
 <nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com>

Here's a v2 which fixes the reading side, as well. I think this should
let you get through a full run of unpack-objects, but please confirm. :)

This also includes Junio's put_be32() tweak to silence sparse.

  [1/5]: bswap.h: squelch potential sparse -Wcast-truncate warnings
  [2/5]: packfile: factor out --pack_header argument parsing
  [3/5]: parse_pack_header_option(): avoid unaligned memory writes
  [4/5]: index-pack, unpack-objects: use get_be32() for reading pack header
  [5/5]: index-pack, unpack-objects: use skip_prefix to avoid magic number

 builtin/index-pack.c     | 30 ++++++++++++------------------
 builtin/unpack-objects.c | 31 ++++++++++++-------------------
 compat/bswap.h           | 24 ++++++++++++------------
 pack.h                   |  3 ++-
 packfile.c               | 20 ++++++++++++++++++++
 packfile.h               |  6 ++++++
 6 files changed, 64 insertions(+), 50 deletions(-)

-Peff
