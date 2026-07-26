Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCA1F09A5
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055586; cv=none; b=Iy7nb1r8c/4SMXHdeCHjQZOyVmh55Moy+kGFA6kOwNDETlqIpyIpnwiD4SBkYKo68O/hwUmmxay6bwRI5Hn/02eBf/NzTRXuCPLeSkowLMLDhcN4/duP5VBMkbj/XfUNX53ncCeVsqXiDjyFr4NZTw23fcfstmHSp7Q4noh0Z64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055586; c=relaxed/simple;
	bh=uXIiH0XQgmrQqHEZfc1eZ2cb0TE/304+4+phuSAROTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWKfVqEFH5DKCKUyNxXyVjSg3Lqo/nT1oc64TeRUIQ0sE9mEdU/xoUHKToGQUXkbie+YwG0u2SdnQNm/Ov0qqRmWA0X+r1GrDeeWhMQIp6HH5ZG3EVYulTwKD9IlnAzAcX4uWnBzUD+Aqi/OEChzybYmn7gW3AMLhiuY/gT2bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PETpVeMJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PETpVeMJ"
Received: (qmail 56989 invoked by uid 106); 26 Jul 2026 08:46:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uXIiH0XQgmrQqHEZfc1eZ2cb0TE/304+4+phuSAROTg=; b=PETpVeMJGa3uKLfFdU1aO+kUDUEuPceePIEH2IbtJFiGjdBBqMKIIqsHdfGYj4nBV5DQjLpU7PIesbaNgFrZf4vQnBFSv48+EqSITfudUYYo+kC5lz1KNwpj/wEHHmd6Q96ZDD4x4GeloC2BAtIxvbra38g+fSWAHGM1OmnY35C8lBCX70Rqco9p1zVq3Cgql1I0V1Tz5bc7TlBwbA2sGoB0z9Gc1IBVV888gEpKGjYvEhFhkfS6Kmn66ib/Ulbl75HrBM1P/fio1sWuQta5XDvEbM6bXnP1nlVP0E62WBYHIMBONSOkvG9PGfyFncWWdxoLgSrc8Lqzr3Jr6FSs4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 08:46:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57961 invoked by uid 111); 26 Jul 2026 08:46:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 04:46:28 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 04:46:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 1/2] diff-lib: drop stale comment about advancing o->pos
Message-ID: <20260726084622.GA3529698@coredump.intra.peff.net>
References: <20260726084550.GC2366012@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726084550.GC2366012@coredump.intra.peff.net>

The comment above oneway_diff() claims that the callback must advance
o->pos to skip index entries it has already processed. That stopped
being true in da165f470e (unpack-trees.c: prepare for looking ahead in
the index, 2010-01-07), which moved that bookkeeping into
unpack_trees().

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index a23119b852..95f920a9a0 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -508,11 +508,9 @@ static void do_oneway_diff(struct unpack_trees_options *o,
  * For diffing, the index is more important, and we only have a
  * single tree.
  *
- * We're supposed to advance o->pos to skip what we have already processed.
- *
  * This wrapper makes it all more readable, and takes care of all
  * the fairly complex unpack_trees() semantic requirements, including
- * the skipping, the path matching, the type conflict cases etc.
+ * the path matching, the type conflict cases etc.
  */
 static int oneway_diff(const struct cache_entry * const *src,
 		       struct unpack_trees_options *o)
-- 
2.55.0.742.gf2bff09aa6

