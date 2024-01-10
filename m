Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6A4CB2C
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UbLvyMKq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 730411C6799;
	Wed, 10 Jan 2024 11:22:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rdG+WxvcU9F8EwxPmv0a/ekzZyoF1noPp0KwJ7
	tbX78=; b=UbLvyMKqG57V9p2ItZoRy/bML1aj1x1oB7OqwZ0/9QThYfuEd7wzJ0
	KoHYVy+5R/WgTOFqlUv2RX+x/qeuLM9pDS4T36ZTofaNLmJq7t3C17nvld0y8ZSA
	exJih/lzZkDq2HRyFYx1zTNbuSzARSEcYLkRWWBa6iG0EhXZ5oZHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A4711C6798;
	Wed, 10 Jan 2024 11:22:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCFFA1C6797;
	Wed, 10 Jan 2024 11:22:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Jeff King
 <peff@peff.net>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <a97b03a305a7b8b95341b63af1de0271@manjaro.org> (Dragan Simic's
	message of "Wed, 10 Jan 2024 15:44:41 +0100")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
	<20240110110226.GC16674@coredump.intra.peff.net>
	<aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
	<97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
	<a97b03a305a7b8b95341b63af1de0271@manjaro.org>
Date: Wed, 10 Jan 2024 08:22:56 -0800
Message-ID: <xmqqil41duov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 840EB39A-AFD4-11EE-AE3C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> No worries.  Regarding disabling the advices for disabling the advice
> messages, maybe it would be better to have only one configuration knob
> for that purpose, e.g. "core.verboseAdvice", as a boolean knob.

I am not sure if you understood Peff's example that illustrates why
it is a bad thing, as ...

> That
> way, fishing for the right knob for some advice message wouldn't turn
> itself into an issue,

... this is exactly what a single core.verboseAdvice knob that
squelches the "how to disable this particular advice message" part
from the message is problematic.  Before you see and familialize
yourself with all advice messages, you may see one piece of advice X
and find it useful to keep, feeling no need to turn it off.  If you
use that single knob to squelch the part to tell you how to turn
advice X off.  But what happens when you hit another unrelated
advice Y then?  Because your core.verboseAdvice is a single big red
button, the message does not say which advice.* variable to tweak
for this particular advice message Y.
