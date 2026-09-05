Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E2368D55
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616706; cv=none; b=PwANIAUrIbj78HLAy8VJf2jlDyh0XPE6DuHM6pt3RFTjdRHb23e44FUB9oZomE9q/meai9TnSAM3DUNkpEWPRM1qqeHXOSt5FX0eO96WhdrOnGtyH7kUJYcKSaLvBIs9u1lx/afJaG+HRI2FW6xT3mQdvN6uKTrJMSk4gxPijhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616706; c=relaxed/simple;
	bh=dXeujyQp8yl0winnLK07c2OOPVFTFYqds2WaqYFFhRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=suJhdofXwusY/pCQ+dP0Z+pJggwborjovbpwa75B0u7zC4xYjAKyX2Huj5aUaUZB10hhFUSJEKoe+3nuQZUXJkkRyst2MowEwA6PnAnlJcUpqzUOHrvuaxbiUvr2tLtObrChwE1WtnA5ETYExhN/to3BuA1v2txI2jgGmU36yCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VwwvwlWT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VwwvwlWT"
Received: (qmail 18738 invoked by uid 106); 5 Sep 2026 13:58:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=dXeujyQp8yl0winnLK07c2OOPVFTFYqds2WaqYFFhRs=; b=VwwvwlWToYg+V7TflGSe4X3hJyUM2Ojqs7D3d6LooYbCxvL3SI7p0eWCNKt1dSsY8KWg+nenc0rmgD/VKyKws/FZ2FiQzSLMEcm7noR95p55KHnfotrpIXCpdpIpD8NjwuRQQVO3HTaL0dZOpJ84M/9Zn5m2qJtaEovhiAs0y1eVMXzLF3BEQIO5jOzY7sX918a6fEXPnJ9YI4m2RmYJEQErhVrAoy8NO5VhQyI8fjmX9qtwvQesYK7qaiSxxHCbrnM3ulSXbHY0oUGSmLRXBeccuvmCJO8ZmRyOmK8+aOp4Z8B6aZCZjCJdUtjuCoG/cDPdnXKntOb2UYn9LN5zfA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Sep 2026 13:58:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 93257 invoked by uid 111); 5 Sep 2026 13:58:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Sep 2026 09:58:22 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Sep 2026 09:58:22 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] ci: bump debian-11 job to debian-12
Message-ID: <20260905135822.GA3914811@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Debian 11 just recently went out of its LTS period, and is unmaintained
by the project (there is "Extended LTS", but it is a paid service
provided by a third party).

The point of the debian-11 job was to cover older releases in the LTS
state, per ac112fd4f0 (Add additional CI jobs to avoid accidental
breakage, 2024-10-31). Bumping to debian-12 will cover us there for the
next 2 years.

Signed-off-by: Jeff King <peff@peff.net>
---
I started looking at this because I got an apt failure on a debian-11
job today. It might have just been a transient mirror failure (although
it reproduced for several minutes afterwards). But this seems like the
right step forward anyway.

I tested the GitHub job, but not the GitLab one. They should be pulling
the same docker images, though, so I would expect it to Just Work.

 .github/workflows/main.yml | 6 +++---
 .gitlab-ci.yml             | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 205325eb33..a0c3f53c6d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -411,9 +411,9 @@ jobs:
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
-        # Supported until 2026-08-31.
-        - jobname: debian-11
-          image: debian:11
+        # Supported until 2028-06-30.
+        - jobname: debian-12
+          image: debian:12
     env:
       jobname: ${{matrix.vector.jobname}}
       CC: ${{matrix.vector.cc}}
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0242283c3c..cd6fd4a504 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -71,9 +71,9 @@ test:linux:
       # A RHEL 8 compatible distro.  Supported until 2029-05-31.
       - jobname: almalinux-8
         image: almalinux:8
-      # Supported until 2026-08-31.
-      - jobname: debian-11
-        image: debian:11
+      # Supported until 2028-06-30.
+      - jobname: debian-12
+        image: debian:12
   artifacts:
     paths:
       - t/failed-test-artifacts
-- 
2.55.0.1127.g25100ff258
