Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259A1514F8
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788005244; cv=none; b=dOtVyJymU92K0fjdiy9lCq3rtWc+nZNDMVBZVBF+KABcaauGcybmTj/CBzA1GULQ5NSu995KeOZ5BByJCAFCgxWUjJ+ktCnR5CxhYK3dYdRVZ8M863NZCsDBy/6zsRHWtASjoXCIiojcik50ixV8f32OA7gxoSWdo+m+w4a3eKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788005244; c=relaxed/simple;
	bh=PCjb1T17cFy0bL9wan0iAFzAGAOhCZoxsilc4aHbPJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQGmcn20YdRCqLZ5QPGuvdYqiGVAfrYu9Dk44HvIJp0v81QRYsJBP5GMHe8eR0NgTN3t/TZrnUoh+aZj7iVVLirZjg2BSYC/u6iNxL8g8IR98SXT8d8YuCKbHRuYhOcATDuOq0u0UKgPBQkdDWsvE1D4wcRuuHHp4ZhzfhsKcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fKQQQlUx; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fKQQQlUx"
Received: (qmail 47209 invoked by uid 106); 29 Aug 2026 12:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PCjb1T17cFy0bL9wan0iAFzAGAOhCZoxsilc4aHbPJQ=; b=fKQQQlUxX7TzZfdYkV4ho4CkPcL9KoO1rM80IAGkqsOIN7F8fe+2k8MByIzoizsw/gY7G//ifq63905GG9au2YUzd7hfZFwrNtqiX0kvEqiaF0eLvZmZt+iIOrjJDkr+X5+b63o7GS8wf5aHzj058f9zo1sPRYKqgxJIdb/ZInDJ48GCsIIhvcvNN7cUB0AZH5N/kaDy/GnVq9pkVJGslTU1oGoEUV1ytQX6jYQfnb7X3ArjvJnIxuDPxgSvJn7XNU2kbPIn2eaYyho4rb7YYFa0r2QiC9FtTSaqVYPgYIZL3ckWqXID4+ZUYenzeRA0EC1eAQHTnA6Nk05xzQA97Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Aug 2026 12:07:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 84147 invoked by uid 111); 29 Aug 2026 12:07:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Aug 2026 08:07:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Aug 2026 08:07:21 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260829120721.GF40814@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
 <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>

On Sat, Aug 29, 2026 at 07:00:31AM +0000, Elijah Newren via GitGitGadget wrote:

> +	/*
> +	 * Recovery for a concurrent-repack race: a stale MIDX may still name a
> +	 * vanished owning pack even though the object survives in another pack
> +	 * the same MIDX covers.  The regular fallback above skips MIDX-covered
> +	 * packs, and repreparing the on-disk pack set does not reload the
> +	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
> +	 *
> +	 * Do this only on the second read, by which point repreparing packs has
> +	 * already had a chance to find an object merely relocated into a new,
> +	 * uncovered pack; only a genuine hidden duplicate reaches here.
> +	 */
> +	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
> +	    (flags & OBJECT_INFO_SECOND_READ)) {
> +		struct multi_pack_index *m = store->midx;
> +		uint32_t i;
> +
> +		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
> +			struct packed_git *p;
> +
> +			if (prepare_midx_pack(m, i))
> +				continue;
> +			p = nth_midxed_pack(m, i);
> +			if (p && packfile_fill_entry(p, oid, e, bad_pack))
> +				return 1;
> +		}
> +	}

So I think this workaround is fine to do (as long as we are not going to
actually refresh the midx on SECOND_READ, which I agree is probably a
bigger change).

I always get confused about m->num_packs and m->num_packs_in_base, and
whether we are looking at the packs in a midx slice versus the whole
thing. I _think_ what you have here is correct, because we are iterating
from 0 up to the total number of packs, and prepare_midx_pack() etc will
look back through the incremental slices as necessary.

But I wonder if it would be simpler to just iterate over the actual pack
list in the usual way, since we already do that in this function. I
_thought_ this would work:

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 90d88c0a12..86e6a80d2f 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -33,40 +33,19 @@ static int find_pack_entry(struct odb_source_packed *store,
 	for (l = store->packs.head; l; l = l->next) {
 		struct packed_git *p = l->pack;
 
-		if (!p->multi_pack_index && packfile_fill_entry(p, oid, e, bad_pack)) {
+		/* ...explain tricky race case here... */
+		if (p->multi_pack_index &&
+		    (midx_result != MIDX_FILL_OWNER_UNAVAILABLE ||
+		     !(flags & OBJECT_INFO_SECOND_READ)))
+			continue;
+
+		if (packfile_fill_entry(p, oid, e, bad_pack)) {
 			if (!store->skip_mru_updates)
 				packfile_list_prepend(&store->packs, p);
 			return 1;
 		}
 	}
 
-	/*
-	 * Recovery for a concurrent-repack race: a stale MIDX may still name a
-	 * vanished owning pack even though the object survives in another pack
-	 * the same MIDX covers.  The regular fallback above skips MIDX-covered
-	 * packs, and repreparing the on-disk pack set does not reload the
-	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
-	 *
-	 * Do this only on the second read, by which point repreparing packs has
-	 * already had a chance to find an object merely relocated into a new,
-	 * uncovered pack; only a genuine hidden duplicate reaches here.
-	 */
-	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
-	    (flags & OBJECT_INFO_SECOND_READ)) {
-		struct multi_pack_index *m = store->midx;
-		uint32_t i;
-
-		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
-			struct packed_git *p;
-
-			if (prepare_midx_pack(m, i))
-				continue;
-			p = nth_midxed_pack(m, i);
-			if (p && packfile_fill_entry(p, oid, e, bad_pack))
-				return 1;
-		}
-	}
-
 	return 0;
 }
 

but it doesn't because we don't always load the midx'd packs into the
pack list (we do it on-demand as they become useful to us). So I think
you'd essentially end up needing to do a loop like the one you have
anyway to prepare_midx_pack() on them all.

And we want to avoid doing that if we can find it outside the midx
(since that was the whole point of waiting for SECOND_READ). Which would
happen...in that loop. So we really do want to have our own
midx-specific loop like you have here.

Sorry, I know that was a lot of text to end up at "you have already
written it the best way", but it took me a while to reason through it.

The patch looks good to me. ;)

-Peff
