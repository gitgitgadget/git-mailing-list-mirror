Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846639FEB
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416752; cv=none; b=W3z6LJ/HDOR9gD6FyMHRLmw3rcfpgfnFxCsO2X1PzpQ7yr/KfWngoszKCY3r4HbZQT2vdup5Tt8lLoFqnf+YGijN3VqXNkjVM8GdH+BPLUOBPfJp8yIXnpdvATiBBoaRkPr+Ji7wroBawdAYxuzEJKSjJVg++SxzHLW0nP1VMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416752; c=relaxed/simple;
	bh=OeTE7kuj/tg4tLmCLjBVZ2K2NWRfddk6PEIn73BGahc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ol3bhhVlYnTTrbvXpQShPeI2bgux7BDFWrzDt8/+aECkRBaaEbvey1zJmlZj+VaNuPS4fj+uQEKUEX15MbCVR5aVfhZfEIghy9oe25emqWG4T9BEq2NpTyf6sc+igCDjSshBDHXD9C7m8p7FcqAmtYMiVbRZcO8vRJRTRCb+5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWSwgBwf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWSwgBwf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7298A295F4;
	Sun, 15 Sep 2024 12:12:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OeTE7kuj/tg4tLmCLjBVZ2K2NWRfddk6PEIn73
	BGahc=; b=BWSwgBwfbUs6Qb30fztN97kFQWPOFpbDQFTyxMqYFlpd+LUmRNmXax
	QqC0sbIg9r+ySSElonTkhdDlJgEkeKi7hOgAeIWR7AGRFT2liLHCd1ZYHFcjMXOl
	JRPqRV9RXJa/tXi6jMKa9CEpIZPWqjmKHQfVKX+8fkDcB4rB3Cb2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6762B295F3;
	Sun, 15 Sep 2024 12:12:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8CFD295F2;
	Sun, 15 Sep 2024 12:12:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Derrick
 Stolee [ ]" <stolee@gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
In-Reply-To: <xmqqo74qro6f.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	14 Sep 2024 13:11:04 -0700")
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
	<xmqqzfogsrqo.fsf@gitster.g>
	<CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
	<xmqq5xr4r818.fsf@gitster.g>
	<CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
	<xmqqplp7ze0h.fsf@gitster.g>
	<CAG=Um+2e7kSL8wGFJcJtFAJt8AxyNwpemJNnxDNfsrm1SVVw1Q@mail.gmail.com>
	<xmqqo74qro6f.fsf@gitster.g>
Date: Sun, 15 Sep 2024 09:12:27 -0700
Message-ID: <xmqqbk0osxp0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4DFE7DCC-737D-11EF-B077-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Existing logic filteres them down to what matches configured
> remote.$name.fetch variable.  filter_prefetch_refspec() may further
> reduces the result by removing those whose .src side begins with
> "refs/tags/".
>
> Now you only look at what survived the above existing filtering, and
> further narrow it down by picking only ones that match the prefetch
> condition.  If the refspec that survived the filtering by the fetch
> refspec (and existing logic in filter_prefetch_refspec()) does not
> satisfy the prefetch condition, it won't be prefetched.

Sorry, but I misread the code.

By the time filter_prefetch_refspec() is called by get_ref_map(),
this caller has "remote_refs" linked list that describes each ref it
is going to fetch, so conceptually what is left for the prefetch
logic to do is to selectively discard the elements on this list that
are not worth asking the remote to send new object data for and use
the remainder of the list in remote_refs list, and the logic to
further limit this list with the prefetchref configuration would fit
well here, but filter_prefetch_refspec() does not work on this list
at all X-<.  So the prefetchref limitation needs to come outside the
function.
