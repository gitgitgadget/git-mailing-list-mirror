Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6F1422B8
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882975; cv=none; b=Nm3sK+EQB1cusVk2+xsYTTziAmhd/ADdWPP8p0C/g8HeToYhZ+At4KU8G9S832ZFqzdHWqB5Ukl0k56rKF8wYiUktS5w95EqI7KSToqCQcgAgwbUpz9m8hwUGcaOCWHrA7biME/jUgWZr4lGjk1IYrcroANPyR/4cWupDgWhPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882975; c=relaxed/simple;
	bh=Dqj3VjE3svxQw7vTnndn95/G/Kr+OXOpN4+6EIFIbaE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwwSra+5R1nCpa3jKBVO7CXbkTdmXz0sVIJmXAsJqgq+jT/2RHlk4bzxL1OOlA7Yv9xD7Lo4cb6YNDJm6s3kyHlZsJlcTvYJVchSME7ckl0uolKWl6xgPDQTy4gIvIYVcp9LRexpxcx0mBIBsDA0MMLC9TOGSRI2yQ1SsP6X6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24695 invoked by uid 109); 17 Aug 2024 08:22:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:22:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27950 invoked by uid 111); 17 Aug 2024 08:22:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:22:57 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:22:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 06/15] t/helper: mark more unused argv/argc arguments
Message-ID: <20240817082252.GF10287@coredump.intra.peff.net>
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

This is a continuation of 126e3b3d2a (t/helper: mark unused argv/argc
arguments, 2023-03-28) to cover a few new cases:

 - test-example-tap was added since that commit

 - test-hashmap used to accept the "ignorecase" argument on the command
   line. But since most of its logic was moved to a unit-test in
   3469a23659 (t: port helper/test-hashmap.c to unit-tests/t-hashmap.c,
   2024-08-03), it now ignores its argv entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-example-tap.c | 2 +-
 t/helper/test-hashmap.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index d072ad559f..f35667bd29 100644
--- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -70,7 +70,7 @@ static void t_empty(void)
 	; /* empty */
 }
 
-int cmd__example_tap(int argc, const char **argv)
+int cmd__example_tap(int argc UNUSED, const char **argv UNUSED)
 {
 	test_res = TEST(check_res = check_int(1, ==, 1), "passing test");
 	TEST(t_res(1), "passing test and assertion return 1");
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 195e6278be..7782ae585e 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -138,7 +138,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  *
  * perfhashmap method rounds -> test hashmap.[ch] performance
  */
-int cmd__hashmap(int argc, const char **argv)
+int cmd__hashmap(int argc UNUSED, const char **argv UNUSED)
 {
 	struct string_list parts = STRING_LIST_INIT_NODUP;
 	struct strbuf line = STRBUF_INIT;
-- 
2.46.0.585.gd6679c16d8

