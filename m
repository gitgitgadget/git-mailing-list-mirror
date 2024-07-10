Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C483AC0C
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601227; cv=none; b=El7A46VtnFGS4YDwbQORqAr0ixyX+bHe6C/1zxnMCB78Y/KK1VWJydPcy2pHECvX8Mil/8AJMi3864kkY1/Cj6xKfZ3IrgnU0QC/Pvpsc1zjR5qrBWp6vw6AJY5cSgBhTByw8xMNlIT82ypaFr5fw7+11VDQOhPMWnJ53kBB+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601227; c=relaxed/simple;
	bh=eArgSZ/5sF9q6c5u8kXLW1ndsq1tLa0XAefdghjwToM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbeg2X9Xp3rKOftTWbw1SpE8V3lbsw/FpnG+tc7hIsay9oS3viyS0qQwzDCB9yHLkIzvrRZkCOr9OE6Wy4og2vKjLfWOhXJVSdR4uBrwfLuwurkJGr5Sb32bH6ac0GTC1I6r6SbU/51CWCRYra2BzQBiRwUE9liB26gwHqRB2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1742 invoked by uid 109); 10 Jul 2024 08:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:47:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10572 invoked by uid 111); 10 Jul 2024 08:47:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:47:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:47:04 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 10/9] t/.gitattributes: ignore whitespace in chainlint
 expect files
Message-ID: <20240710084704.GA2061142@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240710083416.GA2060328@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710083416.GA2060328@coredump.intra.peff.net>

On Wed, Jul 10, 2024 at 04:34:17AM -0400, Jeff King wrote:

>   [5/9]: chainlint.pl: check line numbers in expected output

I just noticed that this one throws off a bunch of whitespace errors
when you apply it. We might want this on top of the series:

-- >8 --
Subject: t/.gitattributes: ignore whitespace in chainlint expect files

The ".expect" files in t/chainlint/ are snippets of expected output from
the chainlint script, and do not necessarily conform to our usual code
style. Especially with the recent change to retain line numbers, blank
lines in the input script end up with trailing whitespace as we print
"3 " for line 3, for example. The point of these files is to match the
output verbatim, so let's not complain about the trailing spaces.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/.gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index b9cea1795d..7664c6e027 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,5 +1,5 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
-/chainlint/*.expect eol=lf
+/chainlint/*.expect eol=lf -whitespace
 /t0110/url-* binary
 /t3206/* eol=lf
 /t3900/*.txt eol=lf
-- 
2.45.2.1249.gb036353db5

