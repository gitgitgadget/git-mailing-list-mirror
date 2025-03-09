Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748C25761
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489327; cv=none; b=Sq7Z05KDygEItwLZTE98ap0RUjaPJBUbiHzcKvDDCBYKy0cCHRMS/5IRpkyctGsYBnJdS++T7w7S35OzsnUoo52ur3YpVIYnqt0eg8Ry159jTpkInsgVWKxXqGEtrHVujynF5YPiW8HLbQopqr9yhlkT8zbbiut8tZuyp3+ps8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489327; c=relaxed/simple;
	bh=GYFVyiABaso/kWaT3cqmRkAlB2x73+9taSCNUwXIXEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGa8Rh5zsuyQud6MJZQ0Y3o7zmmUPTNYozf1+j9ZmlDOlyVPm0vsX+Eizt91h5vRZEfbAnRkYcSMwPt5mPtvRfrTeGuJq+LuQeLHqYy2RH+OTsjiX37IPcUhMz2qaH2gKv2n41aTrCF1GuIpPiiIpVjZ+8xZG+hJzxSTpx+SXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BVhmjI8G; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BVhmjI8G"
Received: (qmail 4658 invoked by uid 109); 9 Mar 2025 03:02:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GYFVyiABaso/kWaT3cqmRkAlB2x73+9taSCNUwXIXEo=; b=BVhmjI8GBImWC0nY+i4Fs6VU0qPn708M2BUNde46Q6svJrtzje/IapUiXBRaHf6K2xHjdJLosZpu0/40lGFC7zOUh/XKl35qmiGAK/V6nXA+bPV8kredJrdgxqWGfV6EclU6/iYrZvOML9vTunpNEQKwESZse0RboMwcsF6fcoSUU/rqI51sweVrqEgH62mtQcQZy24dFaTpfot6CvtU3EbANm5qLFLcEy6McNccHx+SMcM3OwHBEFNr1s8BUEQWhaidEtRApzzkhLH2CVCBxHmtLpYG3/OmyZrpTSvw876LRPm8MEQztYgqn5eVwZZy7xiKA/vAYMGvs0qy/MleXA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:02:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4824 invoked by uid 111); 9 Mar 2025 03:02:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:02:04 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:02:03 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 3/9] t5516: drop NEEDSWORK about v2 reachability behavior
Message-ID: <20250309030203.GC2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

When this test was added in 6c301adb0a (fetch: do not pass ref-prefixes
for fetch by exact SHA1, 2018-05-31), there was still some uncertainty
about the v2 protocol's looser behavior with serving objects that are
not directly pointed at by a ref.

At this point that behavior is well established, and I do not think we
would ever change v2 to match the v0 behavior (and if we did,
remembering to update this test is the least of our concerns).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index e7629fc536..e4008f3ca6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1312,7 +1312,6 @@ test_expect_success 'fetch exact oid in protocol v2' '
 	test_must_fail git -C child cat-file -t $the_commit &&
 
 	# fetching the hidden object succeeds by default
-	# NEEDSWORK: should this match the v0 behavior instead?
 	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
 '
 
-- 
2.49.0.rc1.381.gc60f5426ff

