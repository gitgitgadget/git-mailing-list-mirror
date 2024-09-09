Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE118D64B
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923325; cv=none; b=A8CVzcqZhjNYZKb0JtQi3RYahjtOCl6CWkdM59g9udXpcmOdYAP2O02+bF6vfWYz8XyxAtQuivm+bTazxkRQ31L/gQbzYGTSGK2xXTveKReHxx4HhD6695KHTviHl5+VfObK2LpqelGROcErp6MlT4Wd83VaLhLqf+s2eTNyjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923325; c=relaxed/simple;
	bh=uih5asZmotTVf5whyLGP2t0FY0DqanZiKbJNHSk6H/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfMgQlqEm1s1JdHv+I/92IO+lrLnlLjEvSF+OvtRtbIelOVULhbLAZ+0+liljLHsH2c7zCtTUuMRwMnedFOG1FVZSlnN0gQIgeSmQX4diTYDOEYcBfm5StNe9Yej4vhnnXqyMd/zUBzTe1N/cCgoWqeuomhXs0BwVug1jQ4HaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32189 invoked by uid 109); 9 Sep 2024 23:08:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:08:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24861 invoked by uid 111); 9 Sep 2024 23:08:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:08:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:08:41 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 1/9] t6300: drop newline from wrapped test title
Message-ID: <20240909230841.GA921834@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

We don't usually include newlines in test titles, because you get funny
TAP output like:

  ok 417 - show good signature with custom format
  ok 418 - show good signature with custom format
  			    with ssh
  ok 419 - signature atom with grade option and bad signature

where a TAP parser would ignore the extra line anyway, giving the wrong
title. This comes from 26c9c03f0a (ref-filter: add new "signature" atom,
2023-06-04), and I think it was probably just editor line wrapping.

I checked for other cases with:

  git grep "test_expect_success [A-Z_,]* '[^']*$"
  git grep 'test_expect_success [A-Z_,]* "[^"]*$'

but this was the only hit.

Signed-off-by: Jeff King <peff@peff.net>
---
Just an annoyance I noticed while running t6300 over and over.

 t/t6300-for-each-ref.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8d15713cc6..7c208e20a6 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -2003,8 +2003,7 @@ test_expect_success GPG 'show good signature with custom format' '
 		--format="$GRADE_FORMAT" >actual &&
 	test_cmp expect actual
 '
-test_expect_success GPGSSH 'show good signature with custom format
-			    with ssh' '
+test_expect_success GPGSSH 'show good signature with custom format with ssh' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
 	cat >expect.tmpl <<-\EOF &&
-- 
2.46.0.867.gf99b2b8e0f

