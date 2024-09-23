Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A919E98E
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108478; cv=none; b=jtBuemUqo2lyM9h+d4VilrUT6qNdzeU4ovMe9q70S2ibPYhWjy1PKtZR1ANiCqC08ziLFHSnaHZYYHh3rkX80G1Q8wrty5Jfx9MRykUSZ+ckarWvrGYe6MfmPnzS46p1Q9ulsSRuZ7uneo0v9Fwq5/1nBKSb86p7KEwuuLa8r6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108478; c=relaxed/simple;
	bh=mt74XiivcUHB7EWxzLxU6FXrtciUbobkyp7Fq1rj3zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nbR4vDz0TIt3vFhq0w9arbfvP18vfXCAI71FZS+bnodnyX7H5Xd2XuKjs1mAjld0m3XawRZqgSt3nrHZqUeDuYE6mtHqj2vfBh4HjwmyMREMt/8ieHaMM2ASQ2R5Rs9DI3h9PE8lPRG/Syiul2CE0kQGsnGJ/8r3tjmz5yRYwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cHP/WvUi; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cHP/WvUi"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4101726B88;
	Mon, 23 Sep 2024 12:21:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mt74XiivcUHB
	7EWxzLxU6FXrtciUbobkyp7Fq1rj3zs=; b=cHP/WvUiUw9qe+nmWxG4E3QaIBzT
	ZbGTQWVAo9UvrnkQEAs5lYNI8jNr1Ct070ZWa2ukRSgyHbppimkKZPG0ZBUjc+BJ
	Fj+3NjnZ6pk3jdbvDY7w2OnrXItEFbyqYjsZ564kvw7J3x91ShHKGbsfE8gm03u0
	Ju46hgWYc9FddRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3866226B87;
	Mon, 23 Sep 2024 12:21:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DDD026B86;
	Mon, 23 Sep 2024 12:21:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,
  jonathantanmy@google.com,  sokcevic@google.com
Subject: Re: [External] Re: [PATCH 2/2] fetch-pack.c: do not declare local
 commits as "have" in partial repos
In-Reply-To: <CAG1j3zHJVrpK5JZtUXFwkZgWY1-CxqET+ygpaMqo5aM-KeWaxg@mail.gmail.com>
	(=?utf-8?B?IumfqeS7sCIncw==?= message of "Mon, 23 Sep 2024 11:44:57 +0800")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240919234741.1317946-3-calvinwan@google.com>
	<xmqqr09c89id.fsf@gitster.g>
	<CAG1j3zHJVrpK5JZtUXFwkZgWY1-CxqET+ygpaMqo5aM-KeWaxg@mail.gmail.com>
Date: Mon, 23 Sep 2024 09:21:13 -0700
Message-ID: <xmqqy13i49za.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DAB72D40-79C7-11EF-A491-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

=E9=9F=A9=E4=BB=B0 <hanyang.tony@bytedance.com> writes:

> In $JOB, we modified git-repack to pack everything into a giant promiso=
r
> pack if the repo is partially cloned.

I would imagine that would give you pretty much similar results as
the posted patch without incurring the cost of transfering the same
objects from the promisor remote.

> This basically does the same thing as
> you suggested, but without the cost of constructing the object list and
> removing the objects in the promisor packs.

Yup, repacking, instead of creating a new pack only to hold the
objects in the gap, would be much simpler.
