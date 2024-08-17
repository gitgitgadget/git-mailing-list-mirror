Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84E12FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883090; cv=none; b=MtTsJR9Hq61VP3oIxHPAV2s3HazUNLC8+rboa3uK+SqJQP4mK6CgJVsT/megyJQ6eOHmKbwT3plja4BBZG69VnssX4aWlG7Dah/+HWCxeIvN8xfQ+jVV6tFa+7Gjy8fxuNMuXTzukPI2Qn0bRcRZTQuD2sMKuur+PMR2V6Zqtz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883090; c=relaxed/simple;
	bh=Gmt6cuJyp20lDjpvE3qI/WdWaKr8Ucc8fpkcsJn5eos=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTL6xxnRv69v9Prqvo4Xd8zvuFQBkykUA8QDrw3NpXNCWdQS45FBrlq2iuIqfCtayy7xco8cR7101NuDKozOgzu/ITEHIfY97oWgtGK3UMcXxuqdOE/wfSsUFaTbPaCW5z2tl6W+KJk5rBObpSA4ErNPOIOCRXJIRIGX8/pd6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24736 invoked by uid 109); 17 Aug 2024 08:24:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:24:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27966 invoked by uid 111); 17 Aug 2024 08:24:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:24:52 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:24:47 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 11/15] t-hashmap: mark unused parameters in callback function
Message-ID: <20240817082447.GK10287@coredump.intra.peff.net>
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

The t_intern() setup function doesn't operate on a hashmap, so it
ignores its parameters. But we can't drop them since it is passed as a
pointer to setup(), so we have to match the other setup functions. Mark
them to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/t-hashmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
index 09a48c2c4e..da102eb541 100644
--- a/t/unit-tests/t-hashmap.c
+++ b/t/unit-tests/t-hashmap.c
@@ -322,7 +322,8 @@ static void t_alloc(struct hashmap *map, unsigned int ignore_case)
 	free(removed);
 }
 
-static void t_intern(struct hashmap *map, unsigned int ignore_case)
+static void t_intern(struct hashmap *map UNUSED,
+		     unsigned int ignore_case UNUSED)
 {
 	const char *values[] = { "value1", "Value1", "value2", "value2" };
 
-- 
2.46.0.585.gd6679c16d8

