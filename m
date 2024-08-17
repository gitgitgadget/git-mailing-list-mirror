Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7212FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883012; cv=none; b=PSHRyAtG43XiAgK1C7R+DrbAEhOtj2eOJogPyGlym1fhdI48EVjwZyuBesuSTt4QUlB8ztHqbkE8QQ7IyQwEtqdBf0Nmjzl6f2Ar3OAYAwcYVnef6YhXr/bsuA94C8yflVZ3dLGpjq3bw4Nzf0VvTDo07Nr92GXV+iOA+fTkUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883012; c=relaxed/simple;
	bh=ufWibANIImAKdfpVfk/wGrGZEHwzNQUI2q/p1lF39LU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPlIP7U6UZ0RJMyddWVu2/7y4MMlADqmlaCryCIeksPuS5NrGFXpRZ6rccYZ7MbY3jlLMqccDWYTe04o+rY40Z/1cpJvjHzuu9XYSJAkiezFri7IIi9iou6wux8QmR1Wzh0uWlC+NaYALU9f3Ufqc5Vm6Kqbv331xb3PqoLJDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24709 invoked by uid 109); 17 Aug 2024 08:23:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:23:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27956 invoked by uid 111); 17 Aug 2024 08:23:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:23:34 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:23:29 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 08/15] reftable: ignore unused argc/argv in test functions
Message-ID: <20240817082329.GH10287@coredump.intra.peff.net>
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

There are several reftable test "main" functions that don't look at
their argc/argv. They don't technically need to take these parameters,
as they are called individually by cmd__reftable(). But it probably
makes sense to keep them all consistent for now. In the long run these
will probably all get converted to the unit-test framework anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 reftable/block_test.c     | 2 +-
 reftable/readwrite_test.c | 2 +-
 reftable/stack_test.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/reftable/block_test.c b/reftable/block_test.c
index 90aecd5a7c..f8e31d2d3c 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -116,7 +116,7 @@ static void test_block_read_write(void)
 	}
 }
 
-int block_test_main(int argc, const char *argv[])
+int block_test_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	RUN_TEST(test_block_read_write);
 	return 0;
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index f411abfe9c..15a113b78a 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -951,7 +951,7 @@ static void test_corrupt_table(void)
 	strbuf_release(&buf);
 }
 
-int readwrite_test_main(int argc, const char *argv[])
+int readwrite_test_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	RUN_TEST(test_log_zlib_corruption);
 	RUN_TEST(test_corrupt_table);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 8c36590ff0..f84b92f312 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -1084,7 +1084,7 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	clear_dir(dir);
 }
 
-int stack_test_main(int argc, const char *argv[])
+int stack_test_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	RUN_TEST(test_empty_add);
 	RUN_TEST(test_read_file);
-- 
2.46.0.585.gd6679c16d8

