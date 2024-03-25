Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D2803
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385805; cv=none; b=blt01JqktyJjjBCk1VbcgPm85O7/ckrjP/+JtVwyPF6Ge5dDAAzy7zwdpqO7d38sdMUFVRFDWPf1+4qv+Bf5b8Z3F/awFIwBXg04uKJnMvbk1fyRq0wZj5UwYEBksbPlEqk9OTUJwYc/HW6E1CsQ6BkNdDQzLiGj46V7KR+1yLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385805; c=relaxed/simple;
	bh=1eZqmeaYIdP0yky+Dpkk4fQYz6kJPjdM6fEG55Ey69U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DP9GFYFOr8CzZVxM/WmxsUebQwVmy4Cr16FCQG3zr6UBExvd3giFJnuEcFof/AzzswQavNK2F8rhUkCtswg51lJRpLDB32kHOpKJt/jyL+kFJOrs+iv828Jlz0L/pRxOp5jyYNan9eKc+6M6pjUt/HzeDIRxLKADq6DhiHXGNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I4PNlrIv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I4PNlrIv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6351D1E72FE;
	Mon, 25 Mar 2024 12:56:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1eZqmeaYIdP0yky+Dpkk4fQYz6kJPjdM6fEG55
	Ey69U=; b=I4PNlrIvz358kSxsL74AEbXutp+L/rAMjWWdJRFnNKj8s35ulA1Yp/
	m0T6AXldp1F3YPttLrui0rPWgvTc04o5dz4BpRc+yJPgXdayFxoJj/WzxJWxcdcB
	xblTQeqKCaSDEIJbgARLnL4YvW5AbVykojw+F+66SDcxK8ITZ95HE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C1031E72FD;
	Mon, 25 Mar 2024 12:56:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB1B91E72FC;
	Mon, 25 Mar 2024 12:56:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 00/15] refs: introduce `--auto` to pack refs as needed
In-Reply-To: <CAOLa=ZRAEA7rSUoYL0h-2qfEELdbPHbeGpgBJRqesyhHi9Q6WQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 25 Mar 2024 04:23:42 -0700")
References: <cover.1710706118.git.ps@pks.im> <cover.1711360631.git.ps@pks.im>
	<CAOLa=ZRAEA7rSUoYL0h-2qfEELdbPHbeGpgBJRqesyhHi9Q6WQ@mail.gmail.com>
Date: Mon, 25 Mar 2024 09:56:35 -0700
Message-ID: <xmqqplvimerg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A473AB8E-EAC8-11EE-B0FB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> this is the second version of my patch series that introduces the
>> `--auto` flag to repack refs as neeeded to git-pack-refs(1), git-gc(1)
>> and git-maintenance(1).
>>
>> Changes compared to v1:
>>
>>     - Clarified some of the commit messages.
>>
>>     - Adjusted the stale comment of `stack_compact_range()`.
>>
>>     - Added a unit test for failing auto-compaction.
>>
>>     - Clarified a comment to explain why it is fine for auto-compaction
>>       to fail.
>>
>> Thanks!
>>
>> Patrick
>>
>
> The range diff from this version looks good.
> Thanks!

Let's mark the topic for 'next', then.

Thanks, both.  Will queue.

