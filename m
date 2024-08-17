Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848112FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882962; cv=none; b=YARudx4fR8jztXOwDMMUxtFRJsH1LcFTsBRnCNIJR0Ao72qH6ae46sUfjHlI48Hqcf28YQ7dOBpx2abV4Ig1QszM1/78j10jBKUVl4DCAtZ9dFf3kd9wJCgbsBflKk7erFqQwX0FpE+VN7e3PlwLCZBhtUq7U+gcb0EUjk98HDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882962; c=relaxed/simple;
	bh=8tHk3w//YoBkGXXwneucMawJXlJYMMyHGODCmkaL6D4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmD0lZWHUyTCPePW2S0G/qanqGbvz2K4C3vGCPo2orCySTYui7htSzxh09pOAg14RY8IVLh/qb8AF4MnjfwjIBfEdVbDVwjc4CqwJcsM1sr4209jqu4uLAWOCdLoekF8B3TBjRz08UzZ4QqHnWQntFxDckeSuqN0SQ3z1zJ8fJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24690 invoked by uid 109); 17 Aug 2024 08:22:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:22:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27947 invoked by uid 111); 17 Aug 2024 08:22:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:22:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:22:38 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 05/15] oss-fuzz: mark unused argv/argc argument
Message-ID: <20240817082238.GE10287@coredump.intra.peff.net>
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

The dummy fuzz cmd_main() does not look at its argc/argv parameters
(since it should never even be run), but has to match the usual
cmd_main() declaration.

Mark them to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 oss-fuzz/dummy-cmd-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/oss-fuzz/dummy-cmd-main.c b/oss-fuzz/dummy-cmd-main.c
index 071cb231ba..8ef776d06f 100644
--- a/oss-fuzz/dummy-cmd-main.c
+++ b/oss-fuzz/dummy-cmd-main.c
@@ -8,7 +8,7 @@
  * executed.
  */
 
-int cmd_main(int argc, const char **argv) {
+int cmd_main(int argc UNUSED, const char **argv UNUSED) {
 	BUG("We should not execute cmd_main() from a fuzz target");
 	return 1;
 }
-- 
2.46.0.585.gd6679c16d8

