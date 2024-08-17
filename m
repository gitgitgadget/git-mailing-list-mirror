Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60DD12FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882929; cv=none; b=uc94dBzoOn/hSn+3Uf9H58p6hvj9DjnyUBuQ5X+LDrfSTXdIsVjSuzMlf5srAq4nstNhcWOW034AJjmyobInJ9q0ruDnt9vd+4DzKqZwIXKU+kLegMQ571+lLMxA7+hHtY9UC+EzCi52UyaCDIix810kwuNirK/dCYOAh5bjOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882929; c=relaxed/simple;
	bh=HDM8Gr27BOIroCbJaHqBmHiEQYBADP+vm00l62abY0s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVV2A17DND5+a8MlCem63DXCupH6Pbmu5BtDmbLm8iruOmX40YfLQAfElH5wzIKyRM7wX2GoWNdAgyM53LLrI+0Fxf232zKVIoyL40uXekAFBZ39BR3ZZOl8udi828F8UpXJ2+HRoVnTZrWMVvdXEPc/2dU6rZKjH/l4YX9RKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24682 invoked by uid 109); 17 Aug 2024 08:22:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:22:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27938 invoked by uid 111); 17 Aug 2024 08:22:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:22:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:22:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 03/15] refs: mark unused parameters in ref_store fsck
 callbacks
Message-ID: <20240817082205.GC10287@coredump.intra.peff.net>
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

Commit ab6f79d8df (refs: set up ref consistency check infrastructure,
2024-08-08) added virtual functions to the ref store for doing fsck
checks. But the packed and reftable backends do not yet do anything.

Let's annotate them to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/packed-backend.c   | 4 ++--
 refs/reftable-backend.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f00106df14..afd292ec6a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1733,8 +1733,8 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
-static int packed_fsck(struct ref_store *ref_store,
-		       struct fsck_options *o)
+static int packed_fsck(struct ref_store *ref_store UNUSED,
+		       struct fsck_options *o UNUSED)
 {
 	return 0;
 }
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8b7ffbf66f..7337d4422d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2309,8 +2309,8 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_fsck(struct ref_store *ref_store,
-			    struct fsck_options *o)
+static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
+			    struct fsck_options *o UNUSED)
 {
 	return 0;
 }
-- 
2.46.0.585.gd6679c16d8

