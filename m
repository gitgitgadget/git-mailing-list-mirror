Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139414A0B2
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962117; cv=none; b=QukXGQTMQtYU3IUfSjn9i/93oHMXbHlgNZgS3BFk93iB7aIXO+CAvsU8jYrXpr1PxIxVSeOtyU0tInoSKLMLPEl3QQRq+OYN5hGpS3IwFVcb4VKfStuFqi/89QNEBcrp/Ro/aZDWNh/4O7zHSOjvBEkLUGKJWFjXnvediVmnSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962117; c=relaxed/simple;
	bh=suDSuXhF5ixCd75ic7rFNsxrAYUX4MzT5KDGqr33fMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHJq4PfD2yXoiIhkq2TFB8cJA/WYUJziqFLlC5R6WQ1NlrtE4Vme7Fa9UQWPnpRJhVmOitmrR786iIKf2gmbPIwQD2TSoRlaJ6TGuU2QhrGxT/2w7StrKdV1b2xc9icnkJnVXo3EmMnxf0zldfCYf7dJjNFG1PE/bQyi7Gbsl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5937 invoked by uid 109); 29 Aug 2024 20:08:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 20:08:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10740 invoked by uid 111); 29 Aug 2024 20:08:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 16:08:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 16:08:33 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] gc: drop MAYBE_UNUSED annotation from used parameter
Message-ID: <20240829200833.GA432235@coredump.intra.peff.net>
References: <20240829200807.GA430283@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829200807.GA430283@coredump.intra.peff.net>

The "opts" parameter is always used, so marking it with MAYBE_UNUSED is
just confusing.

This annotation goes back to 41abfe15d9 (maintenance: add pack-refs
task, 2021-02-09), when it really was unused. Back then we did not have
the UNUSED macro that would complain if the code changed to use the
parameter. So when we started using it in bfc2f9eb8e (builtin/gc:
forward git-gc(1)'s `--auto` flag when packing refs, 2024-03-25), nobody
noticed.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0e361253e3..7dac971405 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -260,7 +260,7 @@ static int pack_refs_condition(UNUSED struct gc_config *cfg)
 	return 1;
 }
 
-static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts,
+static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
 				      UNUSED struct gc_config *cfg)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-- 
2.46.0.761.g18aface1ae

