Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7E41C77
	for <git@vger.kernel.org>; Mon,  6 May 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016717; cv=none; b=B/1d01hySZpU1tNsfTAS6duRmlxW4K2HJ34UiCQiEDlMqzL+DHxdr7xQE+r9tZPBMhuuFbSDSzZScEFW5EMJP/XeGGSoXRKVg/FpYM8+Hz06wZ1d3PiccVXIO0B6MmRwRogQrRxTzd4lebaGLolAGxM7tkS5rTBHjb7EBxspmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016717; c=relaxed/simple;
	bh=VHhH1ytdBmbWxHzcghwy/YKiDe27PlXRLFNKR3IntVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSeYCxprwck6lgRLmsnqWuqBEmzHzshDUgx+mgjTEA329AEsmAoXEyoNq34pMgecDctTO9VG2gszBN5frZMd0hjwgOWB2Q16H08R16ARG+8dRTh7zSldjM8GruYypB+3o7NKTLzKCBBohjMHKq50+FB/lNu+pK0l07dkW5y+n+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JPFeXtu/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JPFeXtu/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FD353ED43;
	Mon,  6 May 2024 13:31:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VHhH1ytdBmbWxHzcghwy/YKiDe27PlXRLFNKR3
	IntVo=; b=JPFeXtu/+lcjk7PdktSRUW0WAAF9jpsnJwRZ/Tv83sOLrXGD39oOlv
	umkZ4NniKvS0E8XIG45ek0KHmEz900YgL4WrryYP1TTi5WYpoPyer7Sm9ilO6p1k
	/0YAPi1ca8iGU6bcAko/6uaeI0taxt5o8Wu4WohQnSGHakr8mi7bA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 055723ED42;
	Mon,  6 May 2024 13:31:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 596763ED41;
	Mon,  6 May 2024 13:31:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  German Lashevich
 <german.lashevich@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: fix --exit-code with external diff
In-Reply-To: <99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com> (Phillip Wood's
	message of "Sun, 5 May 2024 16:25:52 +0100")
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>
	<e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
	<99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com>
Date: Mon, 06 May 2024 10:31:53 -0700
Message-ID: <xmqqcypyzw1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87F46AD0-0BCE-11EF-95EC-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Finally, capture the output of the external diff and only register a
>> change by setting found_changes if the program wrote anything.
>
> I worry that this will lead to regression reports like
> https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/
> as the external diff will not see a terminal on stdout anymore.

Hmph.  If it were Git that the external diff script eventually
invokes that changes the behaviour (e.g. color and use of pager)
based on the tty-ness of the output, we could use tricks like
GIT_PAGER_IN_USE to propagate tty-ness down to the subprocess,
but Git is not the only thing involved here, so it is not a very
good general solution.

> I'm
> not really clear why we ignore the exit code of the external diff
> command. Merge strategies are expected to exit 0 on success, 1 when
> there are conflicts and another non-zero value for other errors - it
> would be nice to do something similar here where 1 means "there were
> differences" but it is probably too late to do that without a config
> value to indicate that we should trust the exit code.

Yeah, that thought crossed my mind.  If we were designing the system
from scratch today, that would certainly be what we would do.  I
suspect that it is because external diff drivers were invented way
before "diff --exit-code" was introduced.

Thanks.
