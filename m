Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755214C601
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I/q7RSzl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC5B11C66F5;
	Wed, 10 Jan 2024 11:14:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dAcKXEbBCeC9/Dem7YzghYhxgAF0rNvhSIV5zM
	ev/LU=; b=I/q7RSzlwZh8V3uiXW5aiuF7qPEBh0MBWntZ1/wI05+8U3DDpV4cid
	1dqnTG1G1CDpmyfRF585Td2wS5DkunHG1rWJr7LWIgL1a5ZXCKpmasXPQWhhK+2M
	S/wWeivvWPFKUB9xVV4fWpYmIvzoGiliAnnUvMA9Gxpg0nc2i5ZwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C81951C66F4;
	Wed, 10 Jan 2024 11:14:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 013801C66F3;
	Wed, 10 Jan 2024 11:14:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <20240110110226.GC16674@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jan 2024 06:02:26 -0500")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
	<20240110110226.GC16674@coredump.intra.peff.net>
Date: Wed, 10 Jan 2024 08:14:01 -0800
Message-ID: <xmqqo7dtdv3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 454558AE-AFD3-11EE-B4D6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> If I'm reading your patch correctly, this is a single option that
> controls the extra line for _all_ advice messages. But I'd have expected
> this to be something you'd want to set on a per-message basis. Here's my
> thinking.
>
> The original idea for advice messages was that they might be verbose and
> annoying, but if you had one that showed up a lot you'd choose to shut
> it up individually. But you wouldn't do so for _all_ messages, because
> you might benefit from seeing others (including new ones that get
> added). The "Disable this..." part was added later to help you easily
> know which config option to tweak.
>
> The expectation was that you'd fall into one of two categories:
>
>   1. You don't see the message often enough to care, so you do nothing.
>
>   2. You do find it annoying, so you disable this instance.
>
> Your series proposes a third state:
>
>   3. You find the actual hint useful, but the verbosity of "how to shut
>      it up" is too much for you.
>
> That make sense to me, along with being able to partially shut-up a
> message. But wouldn't you still need the "how to shut up" hint for
> _other_ messages, since it's customized for each situation?

Thanks for saying what I wanted to say in my one of the messages
much clearly than I could.  The above is exactly why I would be more
sympathetic to "advice.foo = (yes/no/always)".
