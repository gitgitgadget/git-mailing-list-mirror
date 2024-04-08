Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B64757FF
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592459; cv=none; b=RttGur0gBBDgnRR2uwGkCXtW9rjiQzCvxaTHJAtHNCHQdRdKlGfJhwpGQfOgfbMe/f7aryLN7jUNuhTjIjIRt+iEhIcBlLW9+SOf7u1c4ACNGMFv2zb2iYafUwKWoISZghfSKhHDm8x/9cEfLj6uT/upjJ64S2g24gZLxXHKabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592459; c=relaxed/simple;
	bh=QJ7012bzykWHr+2dGw3UGI30a7NGz1qdSYWJe9wn+QM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOhScQy+qDJlQASrpid3K+Vsp31Jc5g5E/GIczISHCcgrtWDXYj8aK4xIOJlzbt/GoZEYMdWBwkqk5JvuJMZ1L8ECkyIJ4RghO0GEczXtA8VZj4gS5yc7UrbfwtWinOQ7g+qMBFKQrcFWIk3jd8IioILVMxYtRd1CPHwF3uEA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lSRrON7I; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lSRrON7I"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9763C390B7;
	Mon,  8 Apr 2024 12:07:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QJ7012bzykWHr+2dGw3UGI30a7NGz1qdSYWJe9
	wn+QM=; b=lSRrON7IlTOVa8tZExh1kSq53Sg6jM9wQVBsCt0mVQKZ3GiqP8ekCQ
	iEkLSTmEUhi2h20zqCLy8nUzp6dJgY8ZaAau6mlwKd8t7fgiWqqZQ5WJtVkwecoa
	9h6XjlhsZlT70hpWC8KAywgecR7daa7ZZ7G++ZDP0nxDqVcAl+aZw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FE4F390B6;
	Mon,  8 Apr 2024 12:07:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 958D6390B5;
	Mon,  8 Apr 2024 12:07:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Han-Wen Nienhuys
 <hanwenn@gmail.com>,  Josh Steadmon <steadmon@google.com>,  Luca Milanesio
 <luca.milanesio@gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
In-Reply-To: <CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 8 Apr 2024 03:10:59 -0400")
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
	<160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
	<CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
Date: Mon, 08 Apr 2024 09:07:32 -0700
Message-ID: <xmqqpluzet2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1BF0D89A-F5C2-11EE-8716-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> I was going to suggest that you could accomplish this more easily
> directly in shell (without employing `awk`):
>
>     {
>         echo start &&
>         printf "create refs/heads/branch-%d HEAD\n" $(test_seq 0 9999) &&
>         echo commit
>     } >input &&
>
> but then I realized that that could potentially run afoul of
> command-line length limit on some platform due to the 0-9999 sequence.

As xargs is supposed to know the system limit, perhaps

	test_seq 0 9999 | xargs printf "...%d...\n"

should work?
