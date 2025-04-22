Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334127BF69
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320596; cv=none; b=L72jGSFO9RlzTS3ZSeyOr1rSh98WayKemGoipvszU4YaVf141gZiaGWdSk1YNGhJliMh/dfoww6SzZvZUXH5tu10MLhhbMTuLqRV7lO8kQfEMxE0BuMcvuWBgzPv8MAd56xOXNBrr0EoDSnOJ3Ygf6leGYj2mQqdKld1rjXOdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320596; c=relaxed/simple;
	bh=Hi9k3Jneh1sYV0UnRtlDZOPKh0ZIJ+oBnbtXlw6EekE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/eDNv1vtxggqg/d/0VdBckC2TNGR1ybQS+FFPuEENlOOtSrDqH3C6+k6EkwUj2qO0f5Spu0eo5tcvUx39rwzYbametIYKb14D3Z/dzf1tc9X6tKkkUluVtst/eCBilIWN7K7o/lw9b9CQNP3Q3WAydoBK+X5iZvYgo8rWFxzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LAxc6M02; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LAxc6M02"
Received: (qmail 18691 invoked by uid 109); 22 Apr 2025 11:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Hi9k3Jneh1sYV0UnRtlDZOPKh0ZIJ+oBnbtXlw6EekE=; b=LAxc6M02dv6NuCYqWLliXhsIi7dPOjoQ3i3cr9oliizzKnJquasBwJU/QgH3IkWxgHnMy7ecm0J3sf7KYmGpxauUH6oUEudsT8nYBWkOSuXUu69RCuQxpUGFy5inYu/D45dXsjDFpEnV6OdihfvZ4c6VyVYXbeP4heb637eRna7ObWYPZFR9wr8DZJLNzhTo0ezNUD7DME78g8Vvm4RetIPTPtXbBosExG1jphJVP93oCge9g2nVPKMjmSl+MpLB9WnSppxZ1tG0L4JmVAK472cBDhPwyCXgh1B2zjKqpfwZdikiollz2RJ4uhPxvMBidicn4pgPIeVLdW27Hk8XOA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Apr 2025 11:16:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 700 invoked by uid 111); 22 Apr 2025 11:16:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Apr 2025 07:16:32 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Apr 2025 07:16:32 -0400
From: Jeff King <peff@peff.net>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] p5332: drop "+" from --stdin-packs input
Message-ID: <20250422111632.GA1855088@coredump.intra.peff.net>
References: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com>

On Mon, Apr 21, 2025 at 10:01:25PM -0400, Philippe Blain wrote:

> I noticed that p5332-multi-pack-reuse.sh, which you added in 
> ba47d88795 (t/perf: add performance tests for multi-pack reuse,
> 2023-12-14) fails early on in the second test ("setup bitmaps for
> 1-pack scenario"). Since perf tests run with '--immediate', I do not
> know if further tests in that file also fail. It is reproducible on macOS [1] as 
> well as Linux [2] (I don't know if these logs are public though).
> 
> I also tested on Linux on version 2.44.0 which is the first release
> in which this test was added, and it also failed similarily.

I think the patch below is probably the right solution. With it I got
the output I'd expect (multi-pack reuse with many packs yields a CPU
speedup at the cost of increased size):

  Test                                                            this tree
  ----------------------------------------------------------------------------------
  5332.3: clone for 1-pack scenario (single-pack reuse)           6.66(37.73+0.19)
  5332.4: clone size for 1-pack scenario (single-pack reuse)               117.0M
  5332.5: clone for 1-pack scenario (multi-pack reuse)            6.89(38.71+0.25)
  5332.6: clone size for 1-pack scenario (multi-pack reuse)                117.0M
  5332.9: clone for 10-pack scenario (single-pack reuse)          5.67(35.65+0.37)
  5332.10: clone size for 10-pack scenario (single-pack reuse)             125.1M
  5332.11: clone for 10-pack scenario (multi-pack reuse)          2.47(5.71+0.15)
  5332.12: clone size for 10-pack scenario (multi-pack reuse)              134.3M
  5332.15: clone for 100-pack scenario (single-pack reuse)        14.50(130.54+0.55)
  5332.16: clone size for 100-pack scenario (single-pack reuse)            224.2M
  5332.17: clone for 100-pack scenario (multi-pack reuse)         3.34(3.69+0.18)
  5332.18: clone size for 100-pack scenario (multi-pack reuse)             307.3M

-- >8 --
Subject: [PATCH] p5332: drop "+" from --stdin-packs input

This perf script creates a midx by running "git multi-pack-index write"
with the "--stdin-packs" option. We feed that stdin by running "find" on
.git/objects/pack, using sed to strip off everything but the basename.

But that sed invocation also does something peculiar: it adds a "+" to
the start of each pack name. This causes the multi-pack-index command to
barf. The modified name does not match any pack it knows about, so it
ends up with an empty list of packs to put in the midx. And thus nothing
matches the --preferred-pack option we pass, which causes it die().

The fix is to remove the extra "+" (which also lets us simplify the sed
invocation a bit, as it is now just stripping the leading directories).

But that leaves the mystery of why it was ever there in the first place.
The answer is that an earlier iteration of the patch series had a
concept of "disjoint" packs in the midx. And one of its patches here:

  https://lore.kernel.org/git/c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com/

taught read_packs_from_stdin() to treat a leading "+" as marking a
disjoint pack. But in the second version of the series, which was
ultimately merged, that disjoint concept went away, and the code to
parse "+" did likewise. The regular regression tests were adjusted to
match, but this case in t/perf was forgotten.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p5332-multi-pack-reuse.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p5332-multi-pack-reuse.sh b/t/perf/p5332-multi-pack-reuse.sh
index d1c89a8b7d..0a2525db44 100755
--- a/t/perf/p5332-multi-pack-reuse.sh
+++ b/t/perf/p5332-multi-pack-reuse.sh
@@ -58,7 +58,7 @@ do
 	'
 
 	test_expect_success "setup bitmaps for $nr_packs-pack scenario" '
-		find $packdir -type f -name "*.idx" | sed -e "s/.*\/\(.*\)$/+\1/g" |
+		find $packdir -type f -name "*.idx" | sed -e "s/.*\///" |
 		git multi-pack-index write --stdin-packs --bitmap \
 			--preferred-pack="$(find_pack $(git rev-parse HEAD))"
 	'
-- 
2.49.0.682.g886cb1c59a

