Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32315CD72
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088364; cv=none; b=tBKNT7Bh5eKnRwZ5Jhnrarn7ZB17thv6NnVIVyKsljMUt3eM+BaSWTkvhslsY38HwDfjynKUVv5zz0kpVRMJZDTmLluWrOvxeZKh9FqkcEljXiUcYx0B1fGCI25I5UF0jv7NsTF6uFh6SLeba2qZeandYDGZQ9SrjJ01ONb5k6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088364; c=relaxed/simple;
	bh=p05KChR3sxLxXfYCqerzwB+SJeU2RZbMsaPxr73tYzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuBzMWEPz70G3kwv7pwmxUzod3GoQT95xHfvRfUZMb5BBvd7/t5nkXNbsdTVTj32OV64Vr/M1zD51/ZEqrH8Vue5mlD6bXXrXlQa9Oaycm34JssbHvlEq9e69CPSeob32OKhuqs7GjJ/feuhOt4QRMSaOuiHTs/2a3rwP/3HQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7296 invoked by uid 109); 2 Apr 2024 20:06:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Apr 2024 20:06:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1113 invoked by uid 111); 2 Apr 2024 20:06:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 16:06:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 16:06:00 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH 2/2] INSTALL: bump libcurl version to 7.21.3
Message-ID: <20240402200600.GB875182@coredump.intra.peff.net>
References: <20240402200254.GA874754@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402200254.GA874754@coredump.intra.peff.net>

Our documentation claims we support curl versions back to 7.19.5. But we
can no longer compile with that version since adding an unconditional
use of CURLOPT_RESOLVE in 511cfd3bff (http: add custom hostname to IP
address resolutions, 2022-05-16). That feature wasn't added to libcurl
until 7.21.3.

We could add #ifdefs to make this work back to 7.19.5. But given that
nobody noticed the compilation failure in the intervening two years, it
makes more sense to bump the version in the documentation to 7.21.3
(which is itself over 13 years old).

We could perhaps go forward even more (which would let us drop some
cruft from git-curl-compat.h), but this should be an obviously safe
jump, and we can move forward later.

Note that user-visible syntax for CURLOPT_RESOLVE has grown new features
in subsequent curl versions. Our documentation mentions "+" and "-"
entries, which require more recent versions than 7.21.3. We could
perhaps clarify that in our docs, but it's probably not worth cluttering
them with restrictions of ancient curl versions.

Signed-off-by: Jeff King <peff@peff.net>
---
 INSTALL | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index c6fb240c91..2a46d04592 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,7 +139,7 @@ Issues of note:
 	  not need that functionality, use NO_CURL to build without
 	  it.
 
-	  Git requires version "7.19.5" or later of "libcurl" to build
+	  Git requires version "7.21.3" or later of "libcurl" to build
 	  without NO_CURL. This version requirement may be bumped in
 	  the future.
 
-- 
2.44.0.789.g5ea01f6724
