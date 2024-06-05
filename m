Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB7E567
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624346; cv=none; b=FV1vtIcV7+g3t5foIizUA94FYIaEv82LwxRvWP5jObV/Jk9RCGraHWceOyNp0nnSPPxY0NPvMlnWh3i/pjq8JDX/JP9/CcK7E8eW+e2/VnKxHdkNTj/A8UX0Mf8WNmrtuEdmqbUBTwGuhW/BJ9xjw2xUW00Eg4WN9weLnytHr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624346; c=relaxed/simple;
	bh=WZOKaqSHbOtdTgRM0WcaMeEZd30mEllHEIrteHC2U8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Faig1SnIFqspsdWJD9n2ZV98J2fOwk2gShKgCN6Scyzo1+YuKXAHgqlMveGSayUJ6eVQg/qluxYo0rnkjitSlW1FETIbeek7onhh8Y7h/qDlZtkvjnV6QAKsIH8j2TrrKJyX3/n35lu28nZveCwCHgnWrlepz5oo7tCCVTMlRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TXugz42Z; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TXugz42Z"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84DAE27E5F;
	Wed,  5 Jun 2024 17:52:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WZOKaqSHbOtd
	TgRM0WcaMeEZd30mEllHEIrteHC2U8o=; b=TXugz42ZcTjF3odI9lo3g+OAW+Lf
	uWvpAVVuwmsUipbybfzvlNz9/KVJE8AKZpknWIi+6knby7S6EYCzioKrM61BpCXF
	OOaAYCoUviXnQP4JxjzzgDK6kZMDFRwzjT0AvFCG2rNsaPJFcI7nee/F+GjxhFXN
	1SvhpfYyUBM2Mmw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BE1C27E5E;
	Wed,  5 Jun 2024 17:52:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5B1B27E5D;
	Wed,  5 Jun 2024 17:52:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] format-patch: assume --cover-letter for diff in
 multi-patch series
In-Reply-To: <5aebe520-e540-46b4-a887-af488fe2663a@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 5 Jun 2024 23:24:53 +0200")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
	<cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
	<xmqqr0dbqfv8.fsf@gitster.g>
	<5aebe520-e540-46b4-a887-af488fe2663a@gmail.com>
Date: Wed, 05 Jun 2024 14:52:21 -0700
Message-ID: <xmqqv82noy5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E3B3013C-2385-11EF-968C-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> I'm curious, a test like:=20
>
> test_expect_success "format-patch --range-diff, implicit --cover-letter=
" '
> 	test_when_finished "rm v2-000?-*" &&
> 	test_must_fail git format-patch --no-cover-letter
> 		-v2 --range-diff=3Dtopic main..unmodified
>
> isn't it confusing?

It is, but what makes it confusing is that the title does not
describe what it tests, no?  It tests that --no-cover-letter
disables implicit cover-letter generation even with the presence of
--range-diff.

In the context of t3206-range-diff.sh, we know we are talking about
the "range-diff", and mention of "cover-letter" is a hint enough
that the "format-patch" is involved, so perhaps titles like

    test_expect_success 'explicit --no-cover-letter defeats implied --cov=
er-letter'

and

    test_expect_success '--cover-letter is implied for multi-patch series=
'

would be clear enough and convey what the tests are actually doing.
