Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2EA7F
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051200; cv=none; b=ee3O+OcI2PNEGeLKBg3yvQXgEKq2eJWEvZ6YibV8jNh1qwFha4xRHsVe3ekKOgCj+6VIatuITmA7J2q2r+2aaLX8E3EkKb8xu+6dy9RViol9pXQrRDwmN7dQodkOuLxbf9ftvEDU9aZZnjTdixRYq9eVuiglSymFFQy2abnyxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051200; c=relaxed/simple;
	bh=Gyk/6CBhQupVP+6ELjqE0d1HCDgE2ZaL6kp6+dVB9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Laptz9SFBSJpKi3HBP0wWKTg2xtQr0YbFNb5Upi/FYiSbf41js895S54O4orcUO7tBnFGt59TacwJjSft08M1YygjA4GhpI7TlPqgdHWfr52YsTXLItowm9xY3jLE0bTyCUpZLQUOfMdFARNzf1BrZ4g+AnBIoT/eTcKcG59faY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16775 invoked by uid 109); 30 May 2024 06:39:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 06:39:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27606 invoked by uid 111); 30 May 2024 06:39:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 02:39:54 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 02:39:56 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/5] t-strvec: mark variable-arg helper with
 LAST_ARG_MUST_BE_NULL
Message-ID: <20240530063956.GB1949704@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530063857.GA1942535@coredump.intra.peff.net>

This will let the compiler catch a problem like:

  /* oops, we forgot the NULL */
  check_strvec(&vec, "foo");

rather than triggering undefined behavior at runtime.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/t-strvec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index 6c1465ee61..d4615ab06d 100644
--- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -4,6 +4,7 @@
 
 #define check_strvec(vec, ...) \
 	check_strvec_loc(TEST_LOCATION(), vec, __VA_ARGS__)
+LAST_ARG_MUST_BE_NULL
 static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
 {
 	va_list ap;
-- 
2.45.1.692.gbe047d9c60

