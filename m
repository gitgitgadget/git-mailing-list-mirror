Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C41E4BE
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055148; cv=none; b=ETWxYefZZ8UcYK7ZpqO+Pz1FMwbkkhCG8LGI4nrbYfvqx2TBpfwcuIpKY6zm8eMvTPOe8XJ86on/WX8A9jMrd7TP1cvCpLq6vNZ3QOKZa+jicB6Td/Tc22VQ6RqSRl9PUX1G+uEALwxjyZKnzcaurZLNmcor2kLDZzQ5Cf0E0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055148; c=relaxed/simple;
	bh=nMtCea+kKZ7TlEn6s+kFqTjiZVCqBpt6qbCvGRv+ISo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g10Yd7U7RlNb1w83uBdywbDSa6nQaf7GeBGB9sTgJoNfqlekK7tc45zlRl2jjmQtsRaczWwM1BzMIOGYWcdqYYcNTQs7Sgax00cZp2D8JwJHYKV+G4oV3nZEDd9Gnpv2af6392h33lllNLNIUxhepviSVrcybD/Fw3wDho8e2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YjWjs2MU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YjWjs2MU"
Received: (qmail 56943 invoked by uid 106); 26 Jul 2026 08:39:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nMtCea+kKZ7TlEn6s+kFqTjiZVCqBpt6qbCvGRv+ISo=; b=YjWjs2MUpNrgssTkTZTDvpoS3Mqi4IBGQIn5JtXpF1luSWILmXoj1EstfzDogMjpg4paCVe5KaEyhDVb7WbHj5GbBATsh7bHR7ND+b5m0w7Ujv/clTr3V/z2wd1IqWLxVVf+ImMH68nUJkZl0GCItqxs/ma90A3wDKKW34BxrECKNkNdNaeO6hiWOGT/xcQzYe8XEoF4NAcNdCeK2r+y2yZkkxjBAeukztADv+/q8wJWRrxaKkMVHEgdMgPlgBg/NzM9rNqj+XR+MRaAFgvy81/KMrdbh2zdIYbeHSeoYRRuODNq2ZnqV8MhstXHgziLgcEhacKu3MSe01gO15cymw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 08:39:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57860 invoked by uid 111); 26 Jul 2026 08:39:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 04:39:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 04:39:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: tnyman@openai.com, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
Message-ID: <20260726083905.GB3529069@coredump.intra.peff.net>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726083254.GA3528497@coredump.intra.peff.net>

We recently ran into a case[1] where old versions of coccinelle ran very
slowly, but newer ones are fine. The version we use in GitHub's CI was
the old slow version, leading to timeouts of the static-analysis job.

We get the old version because we ask for the ubuntu-22.04 image. That
has coccinelle 1.1.1, but the "fast" improvement is in coccinelle 1.3.0,
specifically their 58619b8fe (break up envs for e1 & e2, 2024-08-18).

Bumping to ubuntu-25.10 would be enough to get that new version. But I
don't see any need to ask for a specific version at all. We originally
used a specific version because coccinelle wasn't available in ubuntu
20.04, so we pinned to 18.04 in d051ed77ee (.github/workflows/main.yml:
run static-analysis on bionic, 2021-02-08). Later that got bumped in
ef46584831 (ci: update 'static-analysis' to Ubuntu 22.04, 2022-08-23)
when 18.04 support was dropped.

It seems like the absence of coccinelle was a blip in 20.04, and we can
just stick with "latest" going forward.

I tested the result on GitHub's CI. I bumped the matching line in the
GitLab definition, but didn't have a simple means of testing (but it's
such a trivial change nothing could go wrong, right?).

[1] https://lore.kernel.org/git/20260724091152.27794-2-tnyman@openai.com/

Signed-off-by: Jeff King <peff@peff.net>
---
 .github/workflows/main.yml | 4 ++--
 .gitlab-ci.yml             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 85cfedf5b0..205325eb33 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -460,8 +460,8 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: StaticAnalysis
-      CI_JOB_IMAGE: ubuntu-22.04
-    runs-on: ubuntu-22.04
+      CI_JOB_IMAGE: ubuntu-latest
+    runs-on: ubuntu-latest
     concurrency:
       group: static-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1c4d04da9d..0242283c3c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -227,7 +227,7 @@ test:fuzz-smoke-tests:
     - ./ci/run-build-and-minimal-fuzzers.sh
 
 static-analysis:
-  image: ubuntu:22.04
+  image: ubuntu:latest
   stage: analyze
   needs: [ ]
   variables:
-- 
2.55.0.742.gf2bff09aa6
