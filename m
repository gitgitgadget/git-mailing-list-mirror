Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478451474A9
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411248; cv=none; b=q4XMtbUY3NOIaZIj+8K9EuTUBQn/vvPFhvF5QQWumF3Uemh2AYgYcxvfn3qU8RBZLv6tuAuf3zJQF9ZHQg9f/S2oIdXzgf25ReJvaJqcc3RwIuggOPQ+l+bBNdBalK9SxjvdR+UnVDMohBPVthW1YwlG6uEHpOUXmQ1ElK+lYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411248; c=relaxed/simple;
	bh=Dvd1T+DqwFtNpSi6xZd2LrowijJULPSzw3DDEP5o1UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPpQVXGU6WQq7HUQ5csu1Z3S2IrCqteKDVjLjOzfHghVNhHZDMZPH/uF7145+FCtzo7rjssz30av+c6RpY/vmYwrAL6nA1MsiM2v7Sgl8TO5kJwxTjO0hK+MfeTf+Rra3XuVtViyL0GmdmhsnPeWHtDcq4koUFHj57XNfWYhqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R5YQpFyp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R5YQpFyp"
Received: (qmail 25575 invoked by uid 109); 9 Jan 2025 08:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Dvd1T+DqwFtNpSi6xZd2LrowijJULPSzw3DDEP5o1UE=; b=R5YQpFyp2nM6jKNLC0Z/uY6X8P8TTbDUqbNpwRL4s38QvqFsburkGyeR+HVJxDO3MJQUAxPo+mvkblr82emDFinOZoytjppzCmuV5/ndgsg32ySGWyNxUeZ69y0uFq1GkPVIvhnuI8f5IuKcVy8+VysILwPzozHGZSlbO2NRiBSP+Eiy8TOFDcWaPpn82F0TzydKoET8jUSDstodZ1+n46I7/pjXXXrIes1jfTjd7D8k9EFFt2zpJ2Au9nsP0AY9oD/ZTeBikWTkMoCtKNZLxDV4TfX9rafKbYR485cCwFeg0+yo9AL1SYqkPTiXgO3vXaMIyemB5ocu3GGoGSJxuA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:27:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20044 invoked by uid 111); 9 Jan 2025 08:27:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:27:24 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:27:23 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 0/14] combine-diff cleanups
Message-ID: <20250109082723.GA2748497@coredump.intra.peff.net>
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
 <20250103204624.GE3212696@coredump.intra.peff.net>
 <CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>
 <20250104003154.GB3244554@coredump.intra.peff.net>
 <xmqq4j2fnv8p.fsf@gitster.g>
 <20250104033210.GA892381@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250104033210.GA892381@coredump.intra.peff.net>

Since Wink successfully nerd-sniped me into digging into the
combine-diff code, and since I had such a hard time figuring out some of
its logic, I spent a little time trying to put that puzzling to good use
to make it more readable.

Aside from a minor leak fix in the first patch, I didn't find any bugs.
So arguably this whole thing could be discarded as churn. But I hope at
least some of it is worthwhile, and I tried to order it to keep the less
controversial bits near the top.

The series can be split into a few sections:

  [01/14]: run_diff_files(): delay allocation of combine_diff_path
  [02/14]: combine-diff: add combine_diff_path_new()
  [03/14]: tree-diff: clear parent array in path_appendnew()
  [04/14]: combine-diff: use pointer for parent paths
  [05/14]: diff: add a comment about combine_diff_path.parent.path
  [06/14]: run_diff_files(): de-mystify the size of combine_diff_path struct

    These first six clean up most of the allocation and initialization
    confusion that started this thread. They can't go all the way
    because of the scariness in path_appendnew().

  [07/14]: tree-diff: drop path_appendnew() alloc optimization
  [08/14]: tree-diff: pass whole path string to path_appendnew()
  [09/14]: tree-diff: inline path_appendnew()
  [10/14]: combine-diff: drop public declaration of combine_diff_path_size()

    And these ones take it further, but at the cost of losing an
    optimization in patch 07. I don't think it was doing much (and I
    gave some timings there). But it's a judgement call on whether the
    cleaner code is worthwhile.

  [11/14]: tree-diff: drop list-tail argument to diff_tree_paths()
  [12/14]: tree-diff: use the name "tail" to refer to list tail
  [13/14]: tree-diff: simplify emit_path() list management
  [14/14]: tree-diff: make list tail-passing more explicit

    And these last four fix some confusion I had while reading the
    functions. I think they _could_ be done independent of 7-14,
    but there'd be some kinks to work out in emit_path().

    The final one is probably a matter of taste, and I'm not sure if
    people find it easier to understand than the original or not. If
    not, it can easily be dropped.

 combine-diff.c |  80 +++++++++++++-------------
 diff-lib.c     |  36 ++++--------
 diff.h         |  18 ++++--
 tree-diff.c    | 152 ++++++++++++-------------------------------------
 4 files changed, 102 insertions(+), 184 deletions(-)

-Peff
