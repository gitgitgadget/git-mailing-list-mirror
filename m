Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0A377EC2
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333377; cv=none; b=BWnXvWNkQM761Rb1B+L3P7vzDwDwzjjM3mIP2tzYzGbEW70Ma2sbkug8TXxW/rBNRWbBx42Hy2wxG98sTxbxRbkY/0NJ9MedvQj1vaSLWf/D7Xe8Tm3BUd62HV9uR9Qrr4h8qjKDg6vp6CQnvZs90KjvYCWRi/wElUUCF32M/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333377; c=relaxed/simple;
	bh=teJzNAHbdB0amf8Nh/fviW2K+Q18jSFVQi3gp6i5YUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUfKCFKwjqTcE7uKaNx+iFyqkxdNDEVt8bWoQWQ2mGMN8+kJkW4bCpPyBSKE1cV/KrsaeA2MWg8NVstx4Wtnq0qlaTPJeEwTjSS7h29k2J8EZQnqoKPubS7q3AvKcClXpRqP9fxin4oLl0sF/MuNQDCSfUhIYdbDrkiagb0GtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZNgdQsAU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZNgdQsAU"
Received: (qmail 10158 invoked by uid 106); 2 Sep 2026 07:16:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=teJzNAHbdB0amf8Nh/fviW2K+Q18jSFVQi3gp6i5YUI=; b=ZNgdQsAUrKS8VvxY0/RmPDx3M/SuWc6J011ahdMCTwqs/dXYyZIl9r7XauyAZ5XUv6Z4cdpODTyqyJ9OZdtV5lOCtQXYytY25Do+j4okn84fqOMY0pLGBAdeWJAVTt8LRyXF0rgTR8gTC65chtm6L2KPETeFyxAaxvFtHQecpus1QMdumavxKSnDSz5g1D5cg4eJQMC6wnPe1wJOrH5BYiUlKpaItbdKKnK5ys7Y9oeKFiEqAXofUg8MohBg5XyVc8cxQ4Fj2Er3UNTHOJ1uAEbpCjh4A3cHZ+N4Vmt1KKitMjeOevFPTwVaYL2xC3VqbpPBzaPX+AdURYHQN7DE+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 07:16:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47538 invoked by uid 111); 2 Sep 2026 07:16:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 03:16:14 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 03:16:13 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: [PATCH 2/2] ci: use system asciidoctor
Message-ID: <20260902071613.GB641414@coredump.intra.peff.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902071113.GA70165@coredump.intra.peff.net>

Our CI Documentation builds have pinned asciidoctor since 615a6c37e1
(ci: stick with Asciidoctor v1.5.8 for now, 2019-03-29). Back then a few
changes were needed to build with the then-new v2.0.0.

We've since made those changes, in f6461b82b9 (Documentation: fix build
with Asciidoctor 2, 2019-09-15) and other commits. So it is not only
safe to use newer versions of asciidoctor, but preferable: it's what
people are likely to use for actually building the documentation in
practice!

I don't think there's any need to pin to a specific version. We can just
use what ships in our Ubuntu image, which should give us an arbitrary
representative version (and if it changes and something breaks, we'd
want to know).

Signed-off-by: Jeff King <peff@peff.net>
---
Confirmed that this successfully ran CI via GitHub Actions. Looks like
the image there uses asciidoctor 2.0.20, which seems reasonable (it's
from 2023, but stable images tend to lag about that much).

 ci/install-dependencies.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2f61fbb07c..d57dce5663 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -164,9 +164,9 @@ sparse)
 		libexpat-dev gettext zlib1g-dev sparse
 	;;
 Documentation)
-	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby
+	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby \
+		asciidoctor
 
-	sudo gem install --version 1.5.8 asciidoctor
 	sudo gem install concurrent-ruby
 	;;
 esac
-- 
2.55.0.1074.gcd259ea853
