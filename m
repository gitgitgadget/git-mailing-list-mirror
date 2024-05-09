Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5714B097
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271316; cv=none; b=RAJC/PPbSxTW16i4WYNN0YOIyOBy7aVTbxB90ZXvpvsFmIcvVHiScNMjqSKlrLmBQlf/Ov+L50ghwnmzgCyi3nMYnufvijcf0BeXQ63CwcrpT5PzI66ipPMm5kOuYP+ODhdbVZEwMCqzJibMswEQhUChF8HPx2XWu2GmMbgv9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271316; c=relaxed/simple;
	bh=Za4ql0yoSMJPCizmztknRu6F5F3JW1K0bFQRCzN0KRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QFXk1n2BN3T1hP3Q/6Oiaq1WGUTZxWw/29kB+JxF4GmdZzwyGx8eiwWtwbyfyXLyzfzTBb0jkx4DiPwMIeD4otAVPVUV7kTj4jhqIbX74Y8dw0de6hLU01O0b7TiFzZSMUiWNqaFyhKT19KHDZhkvJCyA6pzzpHyTum0J0xuA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6890 invoked by uid 109); 9 May 2024 16:15:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:15:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31061 invoked by uid 111); 9 May 2024 16:15:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:15:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:15:06 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] ci: update coverity runs_on_pool reference
Message-ID: <20240509161506.GA1707588@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit 2d65e5b6a6 (ci: rename "runs_on_pool" to "distro", 2024-04-12)
renamed this variable for the main CI workflow, as well as in the ci/
scripts. Because the coverity workflow also relies on those scripts to
install dependencies, it needs to be updated, too. Without this patch,
the coverity build fails because we lack libcurl.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of ps/ci-test-with-jgit, though that is now in master.

 .github/workflows/coverity.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 53cf12fe04..48341e81f4 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -45,7 +45,7 @@ jobs:
       - run: ci/install-dependencies.sh
         if: contains(matrix.os, 'ubuntu') || contains(matrix.os, 'macos')
         env:
-          runs_on_pool: ${{ matrix.os }}
+          distro: ${{ matrix.os }}
 
       # The Coverity site says the tool is usually updated twice yearly, so the
       # MD5 of download can be used to determine whether there's been an update.
-- 
2.45.0.414.g4009e73179
