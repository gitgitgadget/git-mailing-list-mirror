Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855012F398
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972446; cv=none; b=p3AxSMP1hrV9MHAKqEyshrnA09uFFEt7lpVRoMV8lMqp9rQdejvfKselhoDgmNjCezGRLEKtgWgDMgmj6eL1rswUN6guKKaiYHMJ2/HPJhXAoLp+NBmbJFlDR7fIC5F7oUBFAETvBeI5Y53jnT3w8pnSjvspth7FgX/su2dEHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972446; c=relaxed/simple;
	bh=WVwNrecAfBVqvA8YyJD5NhUAkcFcDIoFHR2L1AEkjEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AfgGGKQYuPoRXHjPEJMlepIeS1orFe+xgoGuHcI6VIm2UK6Pavo3aaxAEeRuLBH+/Y7Rt4AXAzIjV6kajexVYNvTww4ljufwJbHDTcFCbDfI5BuEfoZ+dos4GCTtXV5PB/dPnSvub0fpW5NkqSvQSPL771X5jx7BqU3kupfwC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GLKaDzSg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GLKaDzSg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A5DA1D30F8;
	Mon, 26 Feb 2024 13:34:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WVwNrecAfBVq
	vA8YyJD5NhUAkcFcDIoFHR2L1AEkjEI=; b=GLKaDzSg7yz/RBKRA7M8vZvN9KPh
	l6Ca8BklmM6aow0XTlWtmCJlWlU2cTv097+1r5AlSn220Gk3uReLbK6hlgze6lw3
	3PQ1lw76K6Y/LZ9tyzu4wFwCj4HHWw6D7UzoZ0WVorBC9Z5zR9NmIcV40jp9ysET
	5x24AHP4DKGdLWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 212241D30F7;
	Mon, 26 Feb 2024 13:34:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73C461D30F5;
	Mon, 26 Feb 2024 13:34:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Glen Choo
 <glencbz@gmail.com>,  Elijah Newren <newren@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] merge-ort: turn submodule conflict suggestions into
 an advice
In-Reply-To: <c00617b0-b673-b52c-db15-278a67370e75@gmail.com> (Philippe
	Blain's message of "Mon, 26 Feb 2024 13:14:08 -0500")
References: <pull.1661.git.git.1706534968589.gitgitgadget@gmail.com>
	<pull.1661.v2.git.git.1708954048301.gitgitgadget@gmail.com>
	<xmqqh6hvfb6c.fsf@gitster.g>
	<c00617b0-b673-b52c-db15-278a67370e75@gmail.com>
Date: Mon, 26 Feb 2024 10:34:02 -0800
Message-ID: <xmqq34tfnkh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9DC2DC6E-D4D5-11EE-A7C6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2024-02-26 =C3=A0 11:22, Junio C Hamano a =C3=A9crit=C2=A0:
>> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>>
>>> Add a new advice type 'submoduleMergeConflict' for the error message
>>> shown when a non-trivial submodule conflict is encountered, which was
>>> added in 4057523a40 (submodule merge: update conflict error message,
>>> 2022-08-04). That commit mentions making this message an advice as
>>> possible future work. Only show the advice if it is enabled.
>>=20
>> When specifically called out like this, it makes it sound as if this
>> one is disabled by default, while everybody else is enabled unless it
>> is disabled.
>
> Yes, re-reading myself, this did not come out as I wanted. I'll update
> the message to read more like "Adjust merge-ort.c::print_submodule_conf=
lict_suggestion=20
> to use the advice API" or something like this.

I've replaced the last sentence with """The message can now be
disabled with the advice mechanism."""

   =20
