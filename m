Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975581D522
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361905; cv=none; b=Vooh7VFMEItFeWPZJYOPMHCXZKbEbDDtbS/g1K1W6d0ix3UDnWT5VnKBwvCPBFRA5j7zJas/eHTsR5ebL7G1H9XQn4TO5zAf/Y2fh0e/1c7YaLOpxNAWpxgBqIp7dl29XwpV6k2wZ++OKbzdBEDQqdNlpfHjNVuvJtckCUTSd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361905; c=relaxed/simple;
	bh=EO35Z+PvTpzn0ay8vwj9tXzoj3i17xLCKYGxRlvLKX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OsLpOEU4LpeH9MmLNJ5LHz19yHWA5u1dMnd7cJeWzQyUNEFobPmFAAMQEuj0alirroydwn2RhlESWuFO715hLbpl69G1IJiYGwDj9RwCR+w49zLnSydOfJfbIsXvd4ztH/+NSRb8h/Lvu28kE4W3nyvJMYgklbMNsZl2w/QO4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XP0IuqjN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XP0IuqjN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 34D1C1DC1AC;
	Wed,  7 Feb 2024 22:11:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EO35Z+PvTpzn0ay8vwj9tXzoj3i17xLCKYGxRl
	vLKX0=; b=XP0IuqjN+bG6CDANdbU+lUCTFNyuVa6A7R2sxVT3Hg6ViYF6I1bi2e
	Jp0QbT68aQMEEO6cA34H69hy03Bv8nleRPJg3MxWKRca6RBaUT5h6/EVjh/hLmbr
	p3v7//TbZajuw5B665r+Vc3DN6dqmo9b6jdSmA9rVPg+6dAJdWMbw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C3271DC1AB;
	Wed,  7 Feb 2024 22:11:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C9A61DC1AA;
	Wed,  7 Feb 2024 22:11:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] ref-filter.c: sort formatted dates by byte value
In-Reply-To: <pull.1655.git.1707357439586.gitgitgadget@gmail.com> (Victoria
	Dye via GitGitGadget's message of "Thu, 08 Feb 2024 01:57:19 +0000")
References: <pull.1655.git.1707357439586.gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 19:11:40 -0800
Message-ID: <xmqqzfwbps43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C7F0CBF4-C62F-11EE-BDAC-25B3960A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Leaving the default (unformatted) date sorting unchanged, sorting by the
> formatted date string adds some flexibility to 'for-each-ref' by allowing
> for behavior like "sort by year, then by refname within each year" or "sort
> by time of day".

Hmph, what a strange use case, but understandable.

>     I came across a use case for 'git for-each-ref' at $DAYJOB in which I'd
>     want to sort by a portion of a formatted 'creatordate' (e.g., only the
>     time of day, sans date). When I tried to run something like 'git
>     for-each-ref --sort=creatordate:format:%H:%M:%S',

Hmph, this indeed is interesting ;-)

I wonder if there are other "sort by numeric but the thing could be
stringified by the end-user" atoms offered by for-each-ref
machinery.  IOW, is the timestamp the only thing that needs this
fix?

Thanks.
