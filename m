Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93618FC73
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984454; cv=none; b=O6iZU/EJWcwwqFcS9X58+pMdvgkJBrJqPbKc+/srqVcJjWR4A3TZmFvn2YGu3LFvzE80CzvrxwnasxPtBToyGkTxT5bqCsanqJ6ZBPN/OrxbS5hqw4yUGKTur1uyQCZpY3x7aAr7orIjA/uSOyqyW904JgB2BgDHjrxjxAk8fkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984454; c=relaxed/simple;
	bh=KGYYtOw/dH76+uyvciLeRRBnT3E/TQBzq/GQ261mmX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQZsHDSL0I6AMndqnTpGQfzki7GUG7iwJGrzfpoNfEgizBUNvrBPCAIHSAAc777TFkhwMuV/9AonHMIJgezy0MCXfkc5ZaNC8vN7ivarKC3F7/1lNR9lBA6huniY9J845xTBNjOQMGKlT9FCTTujVn/Iy8NgClXyh3lKqPWbPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZT0EWToH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZT0EWToH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20991316E3;
	Tue, 10 Sep 2024 12:07:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KGYYtOw/dH76+uyvciLeRRBnT3E/TQBzq/GQ26
	1mmX8=; b=ZT0EWToH1IjADfTeqyW8KOmd33bMVdJlxC7w4eq7N5ci3Nb8ccs2OJ
	F8fJGtkPuigkkUX0ePClrN9ba/tTjRwBG9P9/TrkC2Q9wMsj2wtonH/OGXOy8dFL
	lzlfOIjnZRztXt9IDBJRX/mgesVlE6UrODNtmcGoyiHTuFOiwI0tI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15C46316E2;
	Tue, 10 Sep 2024 12:07:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D528316E1;
	Tue, 10 Sep 2024 12:07:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
In-Reply-To: <0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com> (Derrick
	Stolee's message of "Mon, 9 Sep 2024 22:37:30 -0400")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<xmqqjzfkr9b0.fsf@gitster.g>
	<0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com>
Date: Tue, 10 Sep 2024 09:07:29 -0700
Message-ID: <xmqq4j6nlcfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C81F356C-6F8E-11EF-A3D1-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> The thing that surprised me is just how effective this is for the
> creation of large pack-files that include many versions of most
> files. The cross-path deltas have less of an effect here, and the
> benefits of avoiding name-hash collisions can be overwhelming in
> many cases.

Yes, "make sure we notice a file F moving from directory A to B" is
inherently optimized for short span of history, i.e. a smallish push
rather than a whole history clone, where the definition of
"smallish" is that even if you create optimal delta chains, the
length of these delta chains will not exceed the "--depth" option.

If the history you are pushing modified A/F twice, renamed it to B/F
(with or without modification at the same time), then modified B/F
twice more, you'd want to pack the 5-commit segment and having to
artificially cut the delta chain that can contain all of these 5
blobs into two at the renaming commit is a huge loss.

Compared to that, a whole history clone is a very different story,
as we will have to chomp delta chains at some depth anyway.  Before
the rename, it is reasonable to assume that A/F have evolved
incrementally for number of revisions, and after that rename it is
expected B/F will evolve incrementally for number of revisions
before it gets renamed again.  It is just the matter of choosing
where in that long stretch of content evolution we would cut the
delta chain, and the commit that renamed the path may just be a
good, if not absolute optimal, point.

So I do agree that this is an important case to optimize for.  At
some point, even when taking only the blobs at the same path as
delta base candidates, your true best base may be outside of the
--window in the list of candidates (sorted by size in decreasing
order), but at that point you would be increasing window to find
better delta base, not to skip unrelated blobs that happened to have
thrown into the same hash bucket due to the design that optimizes
for different case, so we can say that it is worth spending the
extra cycle and memory, if you need a larger window to gain even
better packing result.

> Funny you should say that, since the RFC I finally submitted [1]
> actually does just that. The --path-walk option changes the object
> walk to consider batches of objects based on their path, computes
> deltas among that batch, and then does the normal name-hash pass
> later. This seems to really strike the balance that you are
> looking for and solves the issues where small pushes need to stay
> small. It also fixes some problematic cases even when pushing a
> single commit.

;-).
