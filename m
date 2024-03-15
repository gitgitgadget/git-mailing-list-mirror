Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E733D56A
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517263; cv=none; b=WvfRsp0IMCZUqfJZ1yH6eI2rnyMjFeC9l7XL97XGqjBbx4qcWTS2ydXXnlFd2Ryy7QHesvcCvQ0tG4/DABlPxDPWvbAlBGanJ0G6Q4qE6880v7Q43bZTcOQ+QstlXu6Y3oIdJaC/NpQM38GiqSWpcTb15o34J59nCy622TETLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517263; c=relaxed/simple;
	bh=f2UzakrLowY6gUrXeff6a8tWX5+BopJwjP/bMGeeTHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LYcpvF3uDgQKxaBX4gAYDZpfqCGVNcc2WyAY9R+ySQYbl93knUdk63TZbaY4b0C6o5SKK3I+6M9jvuDxAZv2gWQnkzYZdGJr9W9iq2TeuEeUhNbpTjzVI+PMFRgn8FVcetJhdQdCtMzJ0xMz59WzEqfsAAjHiPjGOkeOC8OBCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YGv3jC0C; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YGv3jC0C"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E5892B649;
	Fri, 15 Mar 2024 11:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f2UzakrLowY6
	gUrXeff6a8tWX5+BopJwjP/bMGeeTHI=; b=YGv3jC0CumKSKo+Djy/Tt19B42qh
	p7Nr7yJ95TttOpBNXSysb0hUFOtRZzEHIAZHIWHHFzK6ncwP9sXI7cT7bysawDEF
	knWAsiP6gOGAhpksVMOQrYO8pdHo/F2PRXrQLq6DkRYEDc1Y9/Uv4/tQ99WdR6XB
	VZL0xR+4Jie/CTE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 26B3C2B648;
	Fri, 15 Mar 2024 11:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAB5E2B646;
	Fri, 15 Mar 2024 11:40:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Dragan Simic
 <dsimic@manjaro.org>,  Manlio Perillo <manlio.perillo@gmail.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
In-Reply-To: <20240315081041.GA1753560@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 15 Mar 2024 04:10:41 -0400")
References: <20240312091013.GA95442@coredump.intra.peff.net>
	<20240312091750.GP95609@coredump.intra.peff.net>
	<0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
	<20240315055944.GB1741107@coredump.intra.peff.net>
	<6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
	<20240315081041.GA1753560@coredump.intra.peff.net>
Date: Fri, 15 Mar 2024 08:40:56 -0700
Message-ID: <xmqqr0gbtsdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6AD3ABCE-E2E2-11EE-B247-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> +	(default '#'). Note that this variable can be a string like
> +	`//` or `=E2=81=91=E2=81=95=E2=81=91`; it doesn't have to be a single=
 ASCII character.

Looking good.

> That's assuming we don't want to go the commentString route, which woul=
d
> require a bit more re-working of the patch. I'm also open to a more
> clever or pretty multi-byte example if we have one. ;)

Adding core.commentString can be done long after the dust settles
and I would expect that most of the changes in the patch would not
have to be updated.  The parts that use comment_line_str variable do
not have to change, the documentation needs "core.commentString is a
synonym for core.commentChar, the latter of which is understood by
older versions of Git (but they may use only the first byte of the
string)" or something, but other than that, the existing text after
this patch does not have to be updated.  If we add a proper synonym
support to the config machinery, that would be a sizable project,
but otherwise it would be just another "if (!strcmp()) var =3D val".

Stepping back a bit, one thing that we do need to mention in this
round is what happens when you use multi-byte sequence and have it
accessed by existing versions of Git.  "use only the first byte" I
wrote above came out of thin air without experimenting or reading
the code, but something like that ought to be part of the "Note
that" paragraph above.

	(default '#'). Note that this variable can be a string like
	`//` or `=E2=81=91=E2=81=95=E2=81=91`; it doesn't have to be a single AS=
CII character.
	Also note that older versions of Git used only the first byte
	(not necessarily a character) of the value of this variable,
	so you may want to be careful if you plan to use versions of
	Git older than 2.45.

or something like that, perhaps.




