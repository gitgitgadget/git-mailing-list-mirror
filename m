Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07542F6165
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694433; cv=none; b=iPw5pnIRUxmu7Xyaoe1TPo/lP6Sg700L0upqYBh5EOZWteCJ7CPzbqRcpPELdyduxKBV92pLIueGcJ25/3+W0J+MjMUNWPyCx8jO098dK+usCJxpFsJx1w4vpfqbJlEzR6Tj8hWtx5JR4UGdm048iezyZh8esUH9CoPLy8Y1+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694433; c=relaxed/simple;
	bh=SGAsfJplf9SVweijfF5D+OmFtlaBdKZRiY0NgYOKevI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HodBfV2t0l51l8kciFgbBOOojYJwLZ66NWN85y3E3EBNc+YpbPm0Q3rM0YP1gQFrIvr+wPiaU5KpIC+EjWygisHuoOQ5nw09lsmnfugXA054PwowCWA9uCT4fGHm0hKj/lSYFO9NKE3DV4moD8cTEl2iAX7UbgUlSBfNRZxtk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UHoqizyn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UHoqizyn"
Received: (qmail 600949 invoked by uid 109); 6 Jan 2026 10:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=SGAsfJplf9SVweijfF5D+OmFtlaBdKZRiY0NgYOKevI=; b=UHoqizyn8jmfyMROM04/cLSjFwmi2JOdBNbYod9eaTAuvHgsm4x7WrnT3pcU18x8LBVdArh2K/ppQYI43hAs6OxDdYpR9z8h35aVGuuf6JfVi2rIPXI2w2eiXf75kW82mc8W5xqzrcDPCYj44l+HFj+kpxfSSDzIGp7E6Cm1JyAzCgem7ZqkQcEnY6GZwZQk85extoc7QlewLGS01ags7g2INY3/l5OjMRzWsN9DUe7obqvwiapytNCDJkAvGDw5+pi/R7w7JXCTYeZ6TFCryQRnHXNyVJjs29NGulXR7R5qdGmeMfCM9zXARi+kqewk97KFPIjft237PL0Kz51hzA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jan 2026 10:13:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 789055 invoked by uid 111); 6 Jan 2026 10:13:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Jan 2026 05:13:54 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 6 Jan 2026 05:13:49 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] t/perf/perf-lib: fix assignment of TEST_OUTPUT_DIRECTORY
Message-ID: <20260106101349.GA3727538@coredump.intra.peff.net>
References: <20260106101043.GA3723319@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106101043.GA3723319@coredump.intra.peff.net>

Using the perf suite's "run" helper in a vanilla build fails like this:

  $ make && (cd t/perf && ./run p0000-perf-lib-sanity.sh)
  === Running 1 tests in this tree ===
  perf 1 - test_perf_default_repo works: 1 2 3 ok
  perf 2 - test_checkout_worktree works: 1 2 3 ok
  ok 3 - test_export works
  perf 4 - export a weird var: 1 2 3 ok
  perf 5 - éḿíẗ ńöń-ÁŚĆÍÍ ćḧáŕáćẗéŕś: 1 2 3 ok
  ok 6 - test_export works with weird vars
  perf 7 - important variables available in subshells: 1 2 3 ok
  perf 8 - test-lib-functions correctly loaded in subshells: 1 2 3 ok
  # passed all 8 test(s)
  1..8
  cannot open test-results/p0000-perf-lib-sanity.subtests: No such file or directory at ./aggregate.perl line 159.

It is trying to aggregate results written into t/perf/test-results, but
the p0000 script did not write anything there.

The "run" script looks in $TEST_OUTPUT_DIRECTORY/test-results, or if
that variable is not set, in test-results in the current working
directory (which should be t/perf itself). It pulls the value of
$TEST_OUTPUT_DIRECTORY from the GIT-BUILD-OPTIONS file.

But that doesn't quite match the setup in perf-lib.sh (which is what
scripts like p0000 use). There we do this at the top of the script:

  TEST_OUTPUT_DIRECTORY=$(pwd)

and then let test-lib.sh append "/test-results" to that. Historically,
that made the vanilla case work: we'd always use t/perf/test-results.
But when $TEST_OUTPUT_DIRECTORY was set, it would break.

Commit 5756ccd181 (t/perf: fix benchmarks with out-of-tree builds,
2025-04-28) fixed that second case by loading GIT-BUILD-OPTIONS
ourselves. But that broke the vanilla case!

Now our setting of $TEST_OUTPUT_DIRECTORY in perf-lib.sh is ignored,
because it is overwritten by GIT-BUILD-OPTIONS. And when test-lib.sh
sees that the output directory is empty, it defaults to t/test-results,
rather than t/perf/test-results.

Nobody seems to have noticed, probably for two reasons:

  1. It only matters if you're trying to aggregate results (like the
     "run" script does). Just running "./p0000-perf-lib-sanity.sh"
     manually still produces useful output; the stored result files are
     just in an unexpected place.

  2. There might be leftover files in t/perf/test-results from previous
     runs (before 5756ccd181). In particular, the ".subtests" files
     don't tend to change, and the lack of that file is what causes it
     to barf completely. So it's possible that the aggregation could
     have been showing stale results that did not match the run that
     just happened.

We can fix it by setting TEST_OUTPUT_DIRECTORY only after we've loaded
GIT-BUILD-OPTIONS, so that we override its value and not the other way
around. And we'll do so only when the variable is not set, which should
retain the fix for that case from 5756ccd181.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/perf-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b15c74d6f1..2ac007888e 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -20,7 +20,7 @@
 # These variables must be set before the inclusion of test-lib.sh below,
 # because it will change our working directory.
 TEST_DIRECTORY=$(pwd)/..
-TEST_OUTPUT_DIRECTORY=$(pwd)
+perf_dir=$(pwd)
 
 TEST_NO_CREATE_REPO=t
 TEST_NO_MALLOC_CHECK=t
@@ -58,6 +58,7 @@ then
 fi
 
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+: ${TEST_OUTPUT_DIRECTORY:=$perf_dir}
 . "$GIT_SOURCE_DIR"/t/test-lib.sh
 
 # Then restore GIT_PERF_* settings.
-- 
2.52.0.664.g9f53c65b4c

