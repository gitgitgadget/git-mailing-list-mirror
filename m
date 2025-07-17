Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5E258A
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717249; cv=none; b=TQepHPig1vzCQbvaI8GZVexHho2B354HsWfDqm2U5K8s3rSHKCwVrC6WdJJP/Kg5BavjzlLucVyinIQ9Bo+42evt/Z5vv3/OOwRelL6V7omD/g1BI80lN5mia16tIynlWn6lyVcK5Fcwhegs9d4sjnV88fCWxTBEgQGZNjk2ZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717249; c=relaxed/simple;
	bh=HRLfVIvBr72tWmPGWtX+bFsn5MUffpiQGvSK/lqCqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u50ia7dsM4ZsKJ9P/XR9ZIbNKUNbwVn1xJhEgrjOdMAkGt+oeHa0j+Hbt+Wu3yc8GkR6ZXqpibrv0eGLAlPkVjis76Y8jN6PYa6fL+9DIpnUysz/otbeW7+OO9QapASL0DtG1B4sYN5p5W+k4dHmFa38kpLLXCOde9Db9+b+8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GEWj7X60; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GEWj7X60"
Received: (qmail 8968 invoked by uid 109); 17 Jul 2025 01:54:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HRLfVIvBr72tWmPGWtX+bFsn5MUffpiQGvSK/lqCqJc=; b=GEWj7X60V2lcPEKzt72D+5P6Q17Ktfs3no29nhycWFDL43CMth1a3OwhNQ2RtORxVQ/i2R/41neIfRhZX5biNMzK/H0jnOfsh9sFNpTt2jX3qFd7S7Do+BStP/l7vQAAIifRWsKy03+3kn/jtR6z0Q64xNV9ZD0APmWnic+5oMxFyxlAylILrDtqJEgYfZQ+C3I2FjCbCxJdxhodkVK/Q3bHLEkBkt/jbC/hUIziJ+YFd1PsVZ98039DuGU1inASU/A0JT3i+kLKvdZID89oBuh/1f0xLkWCy0y4uS8BuI8u0dwIb9Jk/ncoZ9U6Nbdm0wVmk0zeZ4nujy1AODwh0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Jul 2025 01:54:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28468 invoked by uid 111); 17 Jul 2025 01:54:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 21:54:06 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 21:54:02 -0400
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	ps@pks.im, schwab@linux-m68k.org, phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via
 '--start-after'
Message-ID: <20250717015402.GA2127425@coredump.intra.peff.net>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g>
 <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>

On Wed, Jul 16, 2025 at 06:19:32PM -0700, Kyle Lippincott wrote:

> Unfortunately I can't provide great instructions for reproducing this
> locally, because it relies on our internal build stack (which uses
> blaze). Getting MemorySanitizer running can be quite annoying, though
> you might not have any issues if this test doesn't invoke any third
> party libraries (like zlib).
> 
> I need to sign off for the night soon, but if this isn't sufficient
> enough information to identify what's happening here, I can try to dig
> deeper tomorrow. This run was executed on an import of upstream commit
> 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc (Junio's merge of this
> series)

valgrind can often find the same issues as MSan without as much headache
to get it running (the downside is that it is _way_ slower). And indeed:

  git checkout 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc &&
  make &&
  (cd t && ./t6302-for-each-ref-filter.sh --valgrind-only=48)

yields:

  ==2177572== Conditional jump or move depends on uninitialised value(s)
  ==2177572==    at 0x3BC380: cache_ref_iterator_advance (ref-cache.c:409)
  ==2177572==    by 0x3B69D7: ref_iterator_advance (iterator.c:15)
  ==2177572==    by 0x3B6CC3: merge_ref_iterator_advance (iterator.c:179)
  ==2177572==    by 0x3B69D7: ref_iterator_advance (iterator.c:15)
  ==2177572==    by 0x3A9770: files_ref_iterator_advance (files-backend.c:902)
  ==2177572==    by 0x3B69D7: ref_iterator_advance (iterator.c:15)
  ==2177572==    by 0x3B7457: do_for_each_ref_iterator (iterator.c:478)
  ==2177572==    by 0x399B43: for_each_fullref_with_seek (ref-filter.c:2718)
  ==2177572==    by 0x399C09: for_each_fullref_in_pattern (ref-filter.c:2756)
  ==2177572==    by 0x39B031: do_filter_refs (ref-filter.c:3263)
  ==2177572==    by 0x39B2B7: filter_and_format_refs (ref-filter.c:3364)
  ==2177572==    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c:115)
  ==2177572==  Uninitialised value was created by a heap allocation
  ==2177572==    at 0x484BDD0: realloc (vg_replace_malloc.c:1801)
  ==2177572==    by 0x44E941: xrealloc (wrapper.c:140)
  ==2177572==    by 0x3BCAD9: cache_ref_iterator_begin (ref-cache.c:580)
  ==2177572==    by 0x3A988A: files_ref_iterator_begin (files-backend.c:995)
  ==2177572==    by 0x3A295E: refs_ref_iterator_begin (refs.c:1776)
  ==2177572==    by 0x399AF6: for_each_fullref_with_seek (ref-filter.c:2710)
  ==2177572==    by 0x399C09: for_each_fullref_in_pattern (ref-filter.c:2756)
  ==2177572==    by 0x39B031: do_filter_refs (ref-filter.c:3263)
  ==2177572==    by 0x39B2B7: filter_and_format_refs (ref-filter.c:3364)
  ==2177572==    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c:115)
  ==2177572==    by 0x128C90: run_builtin (git.c:480)
  ==2177572==    by 0x1290EB: handle_builtin (git.c:746)

Bisecting doesn't tell us much, though (the first commit that introduces
the test shows the problem). I didn't dig further than that.

-Peff
