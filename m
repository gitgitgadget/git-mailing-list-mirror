Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7A1DA21
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818187; cv=none; b=AyzE3zNL1wu1JBxi249NU5AwTWFI/80nHOL1/wbnuiflaaWKXHOWl04jmBYKYwHP6oXhUpYKkllQb+1TTDoWbY+oSh1V/ANWCFbQGTI1OQM0/vcF1PP5StqqSH/SToUBpS+Lxh2NODjZWzxX0ou17rGgQc0lzpkZZt20zI2O54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818187; c=relaxed/simple;
	bh=lncYEdLZvbzWfJ1Vys2vnDBnNuSOmnwcwe9r/J4lPhw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DwywxRr364AEhSM/02dMO1VSOQO9ANEuWsH2Q+kSySncBqaXsA3DVWKPnpO+Mj/AkmPshVZkY2G+cl0pqFAMoikZ8B2wv5zDmC3REFABe1QwWCZ5reqr+QwIQGBuZ3wKy5G2Zr6ITh979h8HbTbuzPZTfg8wWOGUc+aQaSNAYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20571 invoked by uid 109); 28 Aug 2024 04:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 04:09:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23161 invoked by uid 111); 28 Aug 2024 04:09:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 00:09:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 00:09:44 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] reftable: mark unused parameters in empty iterator functions
Message-ID: <20240828040944.GA4005021@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

These unused parameters were marked in a68ec8683a (reftable: mark unused
parameters in virtual functions, 2024-08-17), but the functions were
moved to a new file in a parallel branch via f2406c81b9
(reftable/generic: move generic iterator code into iterator interface,
2024-08-22).

Signed-off-by: Jeff King <peff@peff.net>
---
This should go on top of ps/reftable-drop-generic. Arguably this could
have been done as part of the conflict resolution when merging into next
alongside jk/mark-unused-parameters, but at this point I think a
separate patch is the best way forward.

 reftable/iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 97a4642ed5..1d99fe4f7d 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -25,17 +25,17 @@ int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
 	return it->ops->next(it->iter_arg, rec);
 }
 
-static int empty_iterator_seek(void *arg, struct reftable_record *want)
+static int empty_iterator_seek(void *arg UNUSED, struct reftable_record *want UNUSED)
 {
 	return 0;
 }
 
-static int empty_iterator_next(void *arg, struct reftable_record *rec)
+static int empty_iterator_next(void *arg UNUSED, struct reftable_record *rec UNUSED)
 {
 	return 1;
 }
 
-static void empty_iterator_close(void *arg)
+static void empty_iterator_close(void *arg UNUSED)
 {
 }
 
-- 
2.46.0.754.g24c813f009
