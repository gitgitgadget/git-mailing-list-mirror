Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C971849
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685481; cv=none; b=k6yoWYA6zNRiQ/BZWixZU4XWZ50lQ/Ydib36eYKjFuPSNSk3lA6P5zKO+Jeo4Awg6R5crIqNcE3asClRqSqVsM1h3RCjwzcF0GevqEeXWX74NndGIW33t4FsyfwVakv31irLeyVPxPJSbDO6jyCzTFRuxmGZdyeRg+JYeBuj57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685481; c=relaxed/simple;
	bh=nPAo++6lXItDlCXbrS07QN6GGfNixgvwDdwcQyM1Rg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4XckSjPLcgZxljg0Dd4dB3bixJ+yELmtAg/n8ww0bdMqjmurjAO3vyL/pTngoTMBTUXMyH70Y4wTWIAHRSQJb6vf3Y9Chqzsq0yY49t6BUn1/rRnj6gngU8hY5vQIWRqU0fls4dZACNwaU6lJOiQL0s9sTJlbuALfkB+2KmBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lCK3/AE3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lCK3/AE3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CFF913D523;
	Mon, 22 Jul 2024 17:57:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nPAo++6lXItDlCXbrS07QN6GGfNixgvwDdwcQy
	M1Rg4=; b=lCK3/AE3C2fmq/pDz81xH1BlYBYHyPorC7wynzPrRIsIEcJMuAlzU9
	GT/pWDnOf6YiSOlx8fZZ5lf2+aC2WiobgJR9CgmXokn2/fp+LnEzuniOFSWnJ5S5
	RRGFJYoybvkZ/L7al+cJcfVP0kOuGTTygQj1Qg2gs5ms1yCeCclSI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C80A83D522;
	Mon, 22 Jul 2024 17:57:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55B2E3D521;
	Mon, 22 Jul 2024 17:57:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Eric Sunshine <ericsunshine@charter.net>,  git@vger.kernel.org,
  =?utf-8?Q?Rub=C3=A9n?=
 Justo <rjusto@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] check-non-portable-shell: improve `VAR=val
 shell-func` detection
In-Reply-To: <CAO_smVhd_fWkC1=9r_ASCEPoM_rRap3DAWq--nq+6dQ8M8qzjQ@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 22 Jul 2024 14:35:18 -0700")
References: <20240722065915.80760-1-ericsunshine@charter.net>
	<20240722065915.80760-4-ericsunshine@charter.net>
	<CAO_smVg8+WCG0dWZNPVbDM4gBJLLHrg96nOCzje6B3hUGneDGg@mail.gmail.com>
	<xmqq34o1cn6b.fsf@gitster.g>
	<CAO_smVhd_fWkC1=9r_ASCEPoM_rRap3DAWq--nq+6dQ8M8qzjQ@mail.gmail.com>
Date: Mon, 22 Jul 2024 14:57:54 -0700
Message-ID: <xmqq34o19jj1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73D7B7F8-4875-11EF-B227-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> Having just looked at the POSIX standard (I don't think I'm allowed to
> copy from this document), the POSIX standard (POSIX.1-2024, at least)
> explicitly leaves it unspecified whether the variable assignments
> remain in effect after function execution.

True.

https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_09_01_02

also says that it is unspecified if the variable gets exported, and
older version of dash that comes on Ubuntu 20.04 chooses *not* to
export, which was the test breakage that triggered this whole
discussion.  The thread can be seen here:

https://lore.kernel.org/git/xmqqbk2p9lwi.fsf_-_@gitster.g/

> Thanks for indulging my curiosity; should we include a statement in
> the linter along the lines of `# POSIX.1-2024 explicitly does not
> specify if variable assignment persists after executing a shell
> function; some shells, such as ksh, have these variables remain.`?

Giving a review (either positive or negative is fine, as long as it
is constructive) on the update to CodingGuidelines

  https://lore.kernel.org/git/xmqqbk2p9lwi.fsf_-_@gitster.g/

may be a good place to start.

Thanks.
