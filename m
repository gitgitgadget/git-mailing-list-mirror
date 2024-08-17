Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52DD12FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883136; cv=none; b=kz+ZsUwZVDMI5GpbIu/1Hy6NbZsfM9XgVkXXLMtZv+rZydpwplhx6P4RexBNO1JhqHy+OPvTewn/cyFq43a8gBYRohLkzimJMWyfk+GdwAIBSdNZWEiXTgtWFyoii2JJRdAmh5VSl9+mvNZTLYLiHyelOeWHDVoyQIOMYW9otuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883136; c=relaxed/simple;
	bh=qAAAHN0tP7tyR3CeeOpYZZENbGFJIjcMDi5B9Hy896o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCv6s4H7Hs6i4wd5f++wuzOfHALom8NUirN9FtTZ1D531bHnOjWJreSaeJoeQhioq7nBneWAmwe29Qvb5EacDNxjNLKmL1dRc5ywHw6842bipmcZvvMwinxR++WIURITdXIMwBPt1SURO6fLmEGmDdeF0Yxk/FiJ+gIJ8NF8boU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24755 invoked by uid 109); 17 Aug 2024 08:25:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:25:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28043 invoked by uid 111); 17 Aug 2024 08:25:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:25:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:25:32 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 14/15] daemon: mark unused parameters in non-posix fallbacks
Message-ID: <20240817082532.GN10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

If NO_POSIX_GOODIES is set, we compile fallback versions of a few
functions. These don't do anything, so their parameters are unused, but
we must keep them to match the ones on the other side of the #ifdef.
Mark them to quiet -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 daemon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 17d331b2f3..428a445559 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1175,13 +1175,13 @@ static int service_loop(struct socketlist *socklist)
 
 struct credentials;
 
-static void drop_privileges(struct credentials *cred)
+static void drop_privileges(struct credentials *cred UNUSED)
 {
 	/* nothing */
 }
 
-static struct credentials *prepare_credentials(const char *user_name,
-    const char *group_name)
+static struct credentials *prepare_credentials(const char *user_name UNUSED,
+					       const char *group_name UNUSED)
 {
 	die("--user not supported on this platform");
 }
-- 
2.46.0.585.gd6679c16d8

