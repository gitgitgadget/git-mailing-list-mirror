Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C10128805
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655781; cv=none; b=oAINYkYT5JjZjUv1yXWZw0uuUJO9Hsyx23udYKrpfWI6J1ADfONuAfbm2cIfoYItsQe2yDpopSq0ZPVKbS/5F4Ne0tQRfjDlIQtaJieQ35veu6MDsSMloQk2Lt/TSfJkOArUvyXjGV8WoCmsTl6cZ5hFaq69tMX4EIuWhIq4h+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655781; c=relaxed/simple;
	bh=+dbu287/uYUFBaPhugo0MJ1S75uVcRZZW+C++sx5JMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3RdykIzaRSRrIowCKS+hX4PmH6Oj+oYQZkp/r0dlnN6dBDrPPPCqwsBkUuAmwPhbO+xHMP7fVflzH0egD7azYgRAOTFKswkzpIPqy79G9N7epE49Pk9St7NNtgkbFzpq4lEJQbg7WmPlEwI8GXUHbroOtnSL6MWKP4RnMS8Y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=irishmD/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="irishmD/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADDDC1D9777;
	Tue,  5 Mar 2024 11:22:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+dbu287/uYUFBaPhugo0MJ1S75uVcRZZW+C++s
	x5JMo=; b=irishmD/1Z+nEv6aUuUuDyz3UWbNLHN9RJ+zzsVGYVZHQMU67efdaF
	N4qWhrrN6ELX1Kjjnw6pO7tDfsWaZvHI8V8t1XndAeypdHNv/niqlBs27oLcOMvD
	/hFwAucs5myjrB+JD4YdV8jtdQ2NZjJRSmlTp6U86d+StnZq/kth8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A7C31D9776;
	Tue,  5 Mar 2024 11:22:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 119D11D9774;
	Tue,  5 Mar 2024 11:22:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org,  Derrick Stolee <derrickstolee@github.com>,  Elijah
 Newren <newren@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Christian Couder <christian.couder@gmail.com>
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
In-Reply-To: <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de> (Stefan
	Haller's message of "Tue, 5 Mar 2024 08:40:13 +0100")
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
	<354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de>
Date: Tue, 05 Mar 2024 08:22:56 -0800
Message-ID: <xmqqsf144pi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A0EA9CAA-DB0C-11EE-801D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

>> Both of these cases could be fixed by --update-refs not touching any
>> refs that point to the current HEAD. I'm having a hard time coming up
>> with cases where you would ever want those to be updated, in fact.

The point of "update-refs", as I understand it, is that in addition
to the end point of the history (E in "git rebase --onto N O E"),
any branch tips that are between O..E can be migrated to point at
their rewritten counterparts.  So I am not sure how it fundamentally
solves much by protecting only refs that point at a single commit
("the current HEAD" in your statement).

When I want to see how the rebased history would look like without
touching the original, I often rebase a detached HEAD (i.e. instead
of the earlier one, use "git rebase --onto N O E^0", or when
rebasing the current branch, "git rebase [--onto N] O HEAD^0") and
that would protect the current branch well, but --update-refs of
course would not work well.  There is no handy place like detached
HEAD that can be used to save rewritten version of these extra
branch tips.

If branch tips A, B, and C are involved in the range of commits
being rewritten, one way to help us in such a situation may be to
teach "git rebase" to (1) somehow create a new set of proposed-A,
proposed-B, and proposed-C refs (they do not have to be branches),
while keeping the original A, B, and C intact, (2) allow us to
inspect the resulting refs, compare the corresponding ones from
these two sets, and (3) allow us to promote (possibly a subset of)
proposed- ones to their counterpart real branches after we inspect
them.  The latter two do not have to be subcommands of "git rebase"
but can be separate and new commands.
