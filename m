Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270FA20DC4
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404451; cv=none; b=oIcmSISFA/0yNmXQJUbZBvUA5n3LcddMvvWt5RYiPVA4PJm2fWGrQoQnSEL6Bo30mMW3og5/D4WP5yS3/cRncCZOGxaAGAbNjX4MydhyPvGM+ew5/y1MNbg0gfI8GMJ9AmFpcL9DFG2ewYgWh/7I0wKVjAN20MJdXW88IOB+Qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404451; c=relaxed/simple;
	bh=E/XKuvWTDQY2jLPzJNsSqflZySz+eBtHZwtF+Zn/zP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/UP013ZiqIMmbEyV9I4Jj1reJqCzyC/5BT3vpLqsJU+kWgqLXd2eXZlwmjGGUJ1TfAQPN+rT+sj3HhFEbO/nnmIVwTItDSlbDkP3VbALBBTrT3/zqfPJUUXAYd6fd+exLE5tquTPxg9tfYHAGynmFz2wN+6OlOSmLfQ8pIxwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cl6I28qX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cl6I28qX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 81E49192F0;
	Wed, 22 May 2024 15:00:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E/XKuvWTDQY2jLPzJNsSqflZySz+eBtHZwtF+Z
	n/zP8=; b=Cl6I28qXNVLAO/lDAn0plRJNAjn0u2fmnBdhIRBMDqZ34QLPm0BK6T
	eDyAjd5BLxcWqVV9C4UDBb0ribSdsq4PWCTKcwlfBa1gdsBhkrAz5suaw+hZorVU
	SFCNlUanoGeMrw48rxA6IVNySE44jkwmAr5pvUBDq2fhlDawQwbYc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A211192EF;
	Wed, 22 May 2024 15:00:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85D9E192EE;
	Wed, 22 May 2024 15:00:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Carlo Marcelo
 Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Eric Sunshine
 <ericsunshine@charter.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
In-Reply-To: <CAPig+cTfqk+tbTAVyPj8YP1uHx1D1swL84h-4p6OKBV=dDRX_Q@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 22 May 2024 05:05:26 -0400")
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	<20240520190131.94904-1-ericsunshine@charter.net>
	<20240520190131.94904-3-ericsunshine@charter.net>
	<m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy>
	<d655399efccfa6219cd982035c0408f9f084e344.camel@physik.fu-berlin.de>
	<CAPig+cTfqk+tbTAVyPj8YP1uHx1D1swL84h-4p6OKBV=dDRX_Q@mail.gmail.com>
Date: Wed, 22 May 2024 12:00:45 -0700
Message-ID: <xmqqh6ep4qoy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 98CA29D4-186D-11EF-91AA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> > > "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:".
>> >
>> > not sure if worth a reroll, but the "usual" syntax is "processor  : NN"
> ...
> Inclusion of the word "usual" is such a minor flaw in the commit
> message that I doubt it warrants a reroll and the associated cost on
> reviewers and on the maintainer (Junio), especially since it does not
> negatively impact the intent conveyed by the commit messages nor the
> correctness of the actual patch.
>
> As such, I'm not worried about it. Whether Junio reads this and wants
> to correct it in his tree is up to him, of course.

I think "usual" is not what was pointed out. The order between the
colon and NN is.
