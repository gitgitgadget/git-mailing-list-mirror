Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2223183F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400160; cv=none; b=Sfr2AekPlLTf28iONUMWov3wGkOHmQIeqmigyJVNqpp3qxOaMdaD/xAIlQZ3Q0OGHzB3dWeUwKRsHkwcXjMpCUrquZKVY2frGAkhlBqTwplNdV33fUoaYVXfYAzbgWRO6ZvQ4mEjAsqSvBTCsR4w6BNYooBRZGLy2iMDZCumEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400160; c=relaxed/simple;
	bh=PLV0V1wQeeIX1UuC2v1FKhx6ObNRhRUfMfp9E9UJpDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oa4jpJflx9ial8hh0Roe46a0xb+7V2JSmHi2XpXmFakjqV5dnqAUXluccii1m57eBmR5CVQgvb+oTNc+iqyU3+/knLk49YAyCy8kGURg2TlBAKKtcCBcoSIfdXUsf14Lqy9LtvCUL5ktkWnvOsggLPuqKfzUbw7NtCDoHsnpULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RHLtU2Fz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RHLtU2Fz"
Received: (qmail 17422 invoked by uid 106); 7 Jul 2026 04:55:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=PLV0V1wQeeIX1UuC2v1FKhx6ObNRhRUfMfp9E9UJpDs=; b=RHLtU2FzlvutDr48szxbqiTlFMMyNADeVr7Ex5IK3Sdmvx1vHBt1/MWvnF2P0vKfeAXS14mUVqSxX6bxs1ol2CW6vHC+7NR/QMFrjc1shBEOoxqQjRiewbPWsHSy4XEMWtGB0nAP1YXqVPETGS/ZsSx4VS8Rbd2OIla32pPzKwaAgmqQSNM53vO9+h/WODGJmnn/oLFrXN/a184FXfX6BkweVUP8vVQ8MR2Lh69wXn00fkUvujwlQmE5nMhSiTqiL0E+MRydO//NjlqZD0ytfqY+BFlT4mxK/Mlw+P6lHINye/rFuWu4Z+0OjZmE9j9uKVKwtdA5fmONuT/O5ZQKTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 04:55:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22319 invoked by uid 111); 7 Jul 2026 04:55:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 00:55:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 00:55:56 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/7] git_hash_*() quality-of-life improvements
Message-ID: <20260707045556.GA1288172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This implements the "idempotent git_hash_discard()" discussed in this
subthread:

  https://lore.kernel.org/git/20260702080707.GG2029434@coredump.intra.peff.net/

with associated cleanups.

It should be applied on top of jk/hash-algo-leak-fixes.

  [1/7]: hash: use git_hash_init() consistently
  [2/7]: hash: convert remaining direct function calls
  [3/7]: hash: document function pointers and wrappers
  [4/7]: hash: make git_hash_discard() idempotent
  [5/7]: csum-file: use idempotent git_hash_discard()
  [6/7]: http: use idempotent git_hash_discard()
  [7/7]: hash: check ctx->active flag in all wrapper functions

 builtin/fast-import.c       |  4 +--
 builtin/index-pack.c        |  6 ++--
 builtin/patch-id.c          |  2 +-
 builtin/receive-pack.c      |  6 ++--
 builtin/submodule--helper.c | 10 +++---
 builtin/unpack-objects.c    |  4 +--
 csum-file.c                 | 23 +++++---------
 diff.c                      |  4 +--
 hash.c                      | 16 ++++++++++
 hash.h                      | 44 +++++++++++++++++++-------
 http-push.c                 |  2 +-
 http.c                      |  9 ++----
 http.h                      |  1 -
 object-file.c               | 17 +++++-----
 pack-check.c                |  2 +-
 pack-write.c                |  6 ++--
 read-cache.c                |  6 ++--
 rerere.c                    |  5 +--
 t/helper/test-hash-speed.c  |  2 +-
 t/helper/test-hash.c        |  2 +-
 t/helper/test-synthesize.c  | 33 ++++++++++---------
 t/unit-tests/u-hash.c       |  2 +-
 tools/coccinelle/hash.cocci | 63 +++++++++++++++++++++++++++++++++++++
 trace2/tr2_sid.c            |  2 +-
 24 files changed, 181 insertions(+), 90 deletions(-)
 create mode 100644 tools/coccinelle/hash.cocci

-Peff
