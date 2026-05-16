Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B221A6808
	for <git@vger.kernel.org>; Sat, 16 May 2026 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899883; cv=none; b=nF0ZMOxJDU3VV4c8kZ+frpzyEn2uZ9yrRP4iyES9eLyB8k1hRVHPpkg67Xeb9xckgag55KwcLf8IYrpII1x5EvLWEVGYF/y0Bhg28TguJ4BhgcHLnYR1yShTWW7RM0/9opv7XYmlD2EErZnEzFYxoif1KJklofIu/yBkIGdUZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899883; c=relaxed/simple;
	bh=pqVTqga7I2qD6iRbPCEO3fWRtGNquhJNu2nH3gIh31Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ2uQECpvDniLfmVZpEcmnLQfN+ejjTz4eWg2vOLtG0Y8HtSTmt2OCnaQ5gQNu2+K0w936PSWYSI+8P/+4JZ5mt5xVJDljPojHr0XVIJSNsLBDaOutcUtNSfV7YUxOHKaGTdCXLIMTn/k1FINROcXVFLSW7G0uJtZlQ8YpNZR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H7QebALv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H7QebALv"
Received: (qmail 3656 invoked by uid 106); 16 May 2026 02:51:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=pqVTqga7I2qD6iRbPCEO3fWRtGNquhJNu2nH3gIh31Q=; b=H7QebALvMuZGnlbvl+zzS1tMVwwgIqJgzFJH3LhDe1tHHV1RlEkhaMBPuFz4Oi3RRjTtvlDifXPDRMMmJoipd5eyXD4/xg8rKVqWg85yM9CR8RrRCik4f+HiY4CCLFbVPLJfvIakl4giWZlSOFifK/Yco7+SKBhXXNCAE1uOWdD8hRnjJKjyLVQ4uumToRkyiCRr3HszmOB+SYgqvRnDEldZZ6A4t8LjpHtNmnqci4sVIPAHLtXlCetCHENMhHuALCe7covcKJUPIRf3gvqlpwyocBiB7GwOfjhh5mX/uw5rIhEK9b7+JGCZdXGGx2CAMdojcpnVUvA5QMdgvbRx2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 May 2026 02:51:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7832 invoked by uid 111); 16 May 2026 02:51:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 22:51:19 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 22:51:19 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] evaluate the second argument of ALLOC_GROW only once
Message-ID: <20260516025119.GA832077@coredump.intra.peff.net>
References: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>
 <20260515190818.GA98370@coredump.intra.peff.net>
 <20260515195049.GA149960@coredump.intra.peff.net>
 <1d79d7bc-5441-4e72-9cb0-e8900f57172c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d79d7bc-5441-4e72-9cb0-e8900f57172c@web.de>

On Sat, May 16, 2026 at 01:01:05AM +0200, René Scharfe wrote:

> > I think as long as the behavior remains "slow, but we do not overflow
> > any buffers" when you reach these limits, that's OK. Nobody is going to
> > do it in practice, and we just want to make sure that malicious inputs
> > cannot get out-of-bounds writes. It might be worth adding a comment,
> > though, to make sure nobody ever swaps "alloc_grow_new_alloc_" for
> > "alloc" in that macro.
> There is no overflow check in either version (yet), so neither is safe
> to operate close to the boundary.  Close meaning the intermediate term
> (alloc + 16) * 3 being bigger than the maximum value.

Yes, but for some definition of safe. Both before and after your patch,
as we get close to the boundary the allocation will grow slower than it
should, but we'll never write out of bounds. The behavior for the "git
foo" I showed earlier is slightly different:

  - before your patch, ~2GB we stop doubling and instead start growing
    the array by one at each ALLOC_GROW() call. This is because
    alloc_nr() overflows to a small value, but the:

      if (alloc_nr(alloc) < (nr))
              alloc = (nr);

    check kicks in.

  - after your patch we grow to ~4GB, and then things get super slow.
    This is because we correctly compute the new allocation as a size_t,
    but then truncate it while assigning to alloc. So on the next
    ALLOC_GROW() call, we'll think the buffer is way too small and try
    to realloc again. I don't know why this is so much slower than the
    grow-by-one above, but it is.

Neither is really correct, but both are in the realm of OK: stupidly
large input doesn't perform well, but there's no buffer overflow
vulnerability.

What I was worried about is what happens if you tweak your patch like
this:

diff --git a/git-compat-util.h b/git-compat-util.h
index 2bc1f43f48..0730dd24ad 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -870,7 +870,7 @@ static inline bool st_alloc_nr(size_t nr, size_t alloc, size_t *outp)
 		size_t alloc_grow_new_alloc_; \
 		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
 			alloc = alloc_grow_new_alloc_; \
-			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
+			REALLOC_ARRAY(x, alloc); \
 		} \
 	} while (0)
 

In that case we really do end up with too-small allocations and
out-of-bounds writes.

Maybe you saw that coming and that's why you wrote it as you did. But it
is definitely subtle enough that I think it would merit a big warning
comment that "alloc" and "alloc_grow_new_alloc_" are not necessarily the
same type, and hence not necessarily the same value.

> Here's a demo program exercising the arithmetic part of the macros:

I think the difference isn't in the arithmetic values that come out, but
in what is fed to realloc() itself. And in your harness, realloc is just
"x = true". If you actually store the value that would be passed to
realloc() like this:

diff --git a/foo.c.orig b/foo.c
index 2fbce8c..7498f36 100644
--- a/foo.c.orig
+++ b/foo.c
@@ -11,7 +11,7 @@
 				alloc = (nr); \
 			else \
 				alloc = alloc_nr(alloc); \
-			x = true; \
+			x = alloc; \
 		} \
 	} while (0)
 
@@ -31,7 +31,7 @@ static inline bool st_alloc_nr(size_t nr, size_t alloc, size_t *outp)
 		size_t alloc_grow_new_alloc_; \
 		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
 			alloc = alloc_grow_new_alloc_; \
-			x = true; \
+			x = alloc_grow_new_alloc_; \
 		} \
 	} while (0)
 
@@ -44,7 +44,7 @@ int main(int argc, char **argv)
 	for (T i = 0;; i++) {
 		for (T j = MIN;; j++) {
 			T alloc1 = j, alloc2 = j;
-			bool allocated1 = false, allocated2 = false;
+			size_t allocated1 = 0, allocated2 = 0;
 			ALLOC_GROW1(allocated1, i, alloc1);
 			ALLOC_GROW2(allocated2, i, alloc2);
 			if (alloc1 != alloc2 || allocated1 != allocated2)

then you see the differences. For negative values, yeah, you end up with
big size_t values. But for an unsigned type you get different small
allocations.

-Peff
