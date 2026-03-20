Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9108F48
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967419; cv=none; b=H/KQKmy9u51WJEHMe16NiIF2aoPyvHEcIfHJJG60gsvgPrnZPpalHchBnd3btQ3Q9FMZ9BjnR650uroRKbLihTLA8oZKxeUKSIqI+IWqA7hU5U39/SunC3Nce7z+cceQDHy1Sau0+DVzeWcXUJ02BuJxvE0Ozcv1aqWKspasJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967419; c=relaxed/simple;
	bh=8XdNp3meFRfcw3x3Ms/MjOAym4G7f7rQZiknEZbY8BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW+10YMPmKxe1ZEFU9rOSD3Hp6nC5+3GbO84keI2B+BcLsjc6bG+wG/3cPlEBwPLUajnNhzG2tyFLjAqLC6m8eLIQsJVOat11qGh+LTatXnlPPCwRft4+lushI1rpAe2anVzd65zaaHdAdcqlvD+RN309Fe4ZIYMFyA3YJc/G+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Br6uT4p+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Br6uT4p+"
Received: (qmail 62433 invoked by uid 106); 20 Mar 2026 00:43:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8XdNp3meFRfcw3x3Ms/MjOAym4G7f7rQZiknEZbY8BA=; b=Br6uT4p+4rnAoZT5xlGCEXUtYJfj4WUpnZ4QgrEjSlrx0DxLB2oeIszCKOM7ajt2yaI4h0XmsLjeUbbxRkDzguNFN8NWrf0kn1Mv6luf9gok1XBO68Bi+PI4e5OEBMLeFGtzQhZSZtHdeFOUzFY030GpBVZ5VRslJ0mZSEmHHlbt+CEuMhEhWJnlnWp/bJrAdlEkaLZfvFiGn7lzmd12pYBjrGi+T2P1WOspvpbnW3U9g5N/+e/bLu0gGQU3WXb0d/HaQTKcskbFv4/3YBcb6YUaAKdUU/aJx1YAJeiptY5i93RMeIJcj0zYMjpgX7W4QJYnwapxXpP+ecUAlw4J6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:43:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91644 invoked by uid 111); 20 Mar 2026 00:43:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:43:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:43:36 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 4/8] t: add matching negative attributes to test_decode_color
Message-ID: <20260320004336.GD3654226@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

Most of the ANSI color attributes have an "off" variant. We don't use
these yet in our test suite, so we never bothered to decode them. Add
the ones that match the attributes we encode so we can make use of them.

There are even more attributes not covered on the positive side, so this
is meant to be useful but not all-inclusive.

Note that "nobold" and "nodim" are the same code, so I've decoded this
as "normal intensity".

Signed-off-by: Jeff King <peff@peff.net>
---
This is the only patch that touches anything outside of
contrib/diff-highlight, but hopefully it is uncontroversial. ;)

 t/test-lib-functions.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 14e238d24d..f3af10fb7e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -48,6 +48,9 @@ test_decode_color () {
 			if (n == 2) return "FAINT";
 			if (n == 3) return "ITALIC";
 			if (n == 7) return "REVERSE";
+			if (n == 22) return "NORMAL_INTENSITY";
+			if (n == 23) return "NOITALIC";
+			if (n == 27) return "NOREVERSE";
 			if (n == 30) return "BLACK";
 			if (n == 31) return "RED";
 			if (n == 32) return "GREEN";
-- 
2.53.0.945.ge67b727e8d

