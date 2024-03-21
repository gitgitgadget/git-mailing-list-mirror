Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659A135A53
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056256; cv=none; b=Y4iABm+2aU3t9pwpgv920APsKM4u234R1jeoUGNbO897RRKxK+ycE/nIoggfyydg1ydvm9IQs40MB9TKI6xBN6ukIKx+y3U4q5xxJjd8R8xO5JEwlNijjWFjKA6MRhZ+yX7XW10CAeSPhAJjVMFN76JoINu6dZd0GJP5yr7omrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056256; c=relaxed/simple;
	bh=TJGtLyjNL7gObf1DeOzau3UF9hFel1l+HmB+lFd7LYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0ojB8N/TTp5acLf50tGpKeAIAD8QYruA6ELzaH3OPKHhsyKVaDds1DCE9RjaQwxxOgV1ijfhpWElCJmFl92+zafIjZm6+Xh1GUWSc1+UZlpl4ei4BECdGfQ0zKrUWaEXaZUJqknppZGPo0HJL9PIax1YDiue7GRqc3iHx+QrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uhkR2QsY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uhkR2QsY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FB951F2039;
	Thu, 21 Mar 2024 17:24:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TJGtLyjNL7gObf1DeOzau3UF9hFel1l+HmB+lF
	d7LYM=; b=uhkR2QsYm2NdL8Yo+xYmNq8tr8Rg/tNTZYVuYmmqGq+MJ9KimPR3gW
	LViHU1XnhXOwuMAul6ZbJJhIrOjCw0VY36gk1+kaC4l1TkQyiY3g/f8Mz7i3v4vt
	z4QqKcTD0x2LtqXU+7gFOFu8Irq85ObqaibbwGAzZOPw+iTxvsKT8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 042831F2038;
	Thu, 21 Mar 2024 17:24:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 685311F2036;
	Thu, 21 Mar 2024 17:24:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 01/24] Documentation/technical: describe pseudo-merge
 bitmaps format
In-Reply-To: <76e7e3b9cca7fb957384ed98f2cd32cf11ff8488.1710972293.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 20 Mar 2024 18:05:02 -0400")
References: <cover.1710972293.git.me@ttaylorr.com>
	<76e7e3b9cca7fb957384ed98f2cd32cf11ff8488.1710972293.git.me@ttaylorr.com>
Date: Thu, 21 Mar 2024 14:24:10 -0700
Message-ID: <xmqqcyrn6zyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C158EFE-E7C9-11EE-8E83-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Prepare to implement pseudo-merge bitmaps over the next several commits
> by first describing the serialization format which will store the new
> pseudo-merge bitmaps themselves.

Before talking about what problem, which is not addressed adequately
with existing mechanisms, it will solve?

> +Pseudo-merge bitmaps
> +--------------------
> +
> +If the `BITMAP_OPT_PSEUDO_MERGES` flag is set, a variable number of
> +bytes (preceding the name-hash cache, commit lookup table, and trailing
> +checksum) of the `.bitmap` file is used to store pseudo-merge bitmaps.
> +
> +A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
> +follows:
> +
> +Commit bitmap::
> +
> +  A bitmap whose set bits describe the set of commits included in the
> +  pseudo-merge's "merge" bitmap (as below).
> +
> +Merge bitmap::
> +
> +  A bitmap whose set bits describe the reachability closure over the set
> +  of commits in the pseudo-merge's "commits" bitmap (as above). An
> +  identical bitmap would be generated for an octopus merge with the same
> +  set of parents as described in the commits bitmap.
> +
> +Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
> +for a given pseudo-merge are listed on either side of the traversal,
> +either directly (by explicitly asking for them as part of the `HAVES`
> +or `WANTS`) or indirectly (by encountering them during a fill-in
> +traversal).

"either side of" implies there are two sides.  Is it correct to
understand that they are "the side reachable from HAVE" and "the
other side that is reachable from WANT"?

> +=== Use-cases
> +
> +For example, suppose there exists a pseudo-merge bitmap with a large
> +number of commits, all of which are listed in the `WANTS` section of
> +some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
> +bitmap machinery can quickly determine there is a pseudo-merge which
> +satisfies some subset of the wanted objects on either side of the query.

Here you only talk about WANT but still mention "either side of".
How would the HAVE side of the query contribute to the computation?

> +  ** `commits_bitmap`, an EWAH-compressed bitmap describing the set of
> +     commits included in the this psuedo-merge.
> +
> +  ** `merge_bitmap`, an EWAH-compressed bitmap describing the union of
> +     the set of objects reachable from all commits listed in the
> +     `commits_bitmap`.

"union of the set of objects reachable from all", meaning if an
object is listed here, all commits in commits_bitmap are guaranteed
to reach that object?  It sounds more like the intersction of sets
than union.

> +* A lookup table, mapping pseudo-merged commits to the pseudo-merges
> +  they belong to. Entries appear in increasing order of each commit's
> +  bit position. Each entry is 12 bytes wide, and is comprised of the
> +  following:

"a pseudo-merged commit" is a new term.  It was explained what "a
pseudo-merge bitmap" is already, and it was explained that "a
pseudo-merge bitmap" consists of a pair of bitmaps (commit bitmap
that records which commit belongs to the "pseudo-merge", and merge
bitmap that records objects reachable from all commits in the commit
bitmap).  But we haven't heard of "a pseudo-merged commit", or what
the verb "to pseudo-merge a commit" means.

Does it merely mean "a commit that is recorded in the commit-bitmap
half of a pseudo-merge bitmap"?  It still is unclear at this point
in the description if a commit can be part of only one such
commit-bitmap and makes readers reading hiccup, until a few
paragraphs below where extended table is there to help a commit
recorded in commit-bitmap of more than one pseudo-merge bitmaps.

I'll stop here for now, but this made me even more convinced that
the presentation order needs to be rethought to sell why this whole
thing is a good idea by telling readers what problem it is solving,
why a new data structure helps and how, etc.  Perhaps you can start
by trying to write a paragraph of description for the topic suitable
for the "What's cooking" report, which needs to do a good elevator
pitch.

Thanks.

> +  ** `commit_pos`, a 4-byte unsigned value (in network byte-order)
> +     containing the bit position for this commit.
> +
> +  ** `offset`, an 8-byte unsigned value (also in network byte-order)
> +  containing either one of two possible offsets, depending on whether or
> +  not the most-significant bit is set.
> +
> +    *** If unset (i.e. `offset & ((uint64_t)1<<63) == 0`), the offset
> +	(relative to the beginning of the `.bitmap` file) at which the
> +	pseudo-merge bitmap for this commit can be read. This indicates
> +	only a single pseudo-merge bitmap contains this commit.
> +
> +    *** If set (i.e. `offset & ((uint64_t)1<<63) != 0`), the offset
> +	(again relative to the beginning of the `.bitmap` file) at which
> +	the extended offset table can be located describing the set of
> +	pseudo-merge bitmaps which contain this commit. This indicates
> +	that multiple pseudo-merge bitmaps contain this commit.
> +
> +* An (optional) extended lookup table (written if and only if there is
> +  at least one commit which appears in more than one pseudo-merge).
> +  There are as many entries as commits which appear in multiple
> +  pseudo-merges. Each entry contains the following:
> +
> +  ** `N`, a 4-byte unsigned value equal to the number of pseudo-merges
> +     which contain a given commit.
> +
> +  ** An array of `N` 8-byte unsigned values, each of which is
> +     interpreted as an offset (relative to the beginning of the
> +     `.bitmap` file) at which a pseudo-merge bitmap for this commit can
> +     be read. These values occur in no particular order.
> +
> +* Positions for all pseudo-merges, each stored as an 8-byte unsigned
> +  value (in network byte-order) containing the offset (relative to the
> +  beginnign of the `.bitmap` file) of each consecutive pseudo-merge.
> +
> +* A 4-byte unsigned value (in network byte-order) equal to the number of
> +  pseudo-merges.
> +
> +* A 4-byte unsigned value (in network byte-order) equal to the number of
> +  unique commits which appear in any pseudo-merge.
> +
> +* An 8-byte unsigned value (in network byte-order) equal to the number
> +  of bytes between the start of the pseudo-merge section and the
> +  beginning of the lookup table.
> +
> +* An 8-byte unsigned value (in network byte-order) equal to the number
> +  of bytes in the pseudo-merge section (including this field).
