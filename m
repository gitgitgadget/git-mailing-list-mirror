Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E2173
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491028; cv=none; b=HYHyINscUtfHIHudob266f8XyQ3vmqLtKgN1vhN6wv1cMyvkMqLtgJy4XDA1Kxjq3g3aKpbrslP8HOlrwiBZNVeHXNUIJW/f5wAL7bpNbVk2u7ynpRX6avZqUCe3aEcbIEsXlnxfSQsYDOX2Gwa4z8nEF/oca5HLpPCEiEWzXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491028; c=relaxed/simple;
	bh=Z+AOT7OlNGrPFCdYa8BODZ6AdcOKS/FDz8zk2TUEhvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UYx4/EssqYhChxqBfTcaYdi4OoCMU+EEsjfU95dOLmU6jpU7C44eJ8sszqQHjv8/vhN0sEMhcUfZVq7PNoj/vY5gfb6mY0b9lDBVEuMI6VuvTcfQYTLUu+npkhsyqA5l3CusIq8KK1C1+eByNhTgCa8sf6MHTYCdHOGzTAVC7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VIGvo489; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VIGvo489"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C0EB1F30FB;
	Tue, 26 Mar 2024 18:10:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z+AOT7OlNGrP
	FCdYa8BODZ6AdcOKS/FDz8zk2TUEhvg=; b=VIGvo489pUBSOzy8ayr57UGrQoWl
	HjDPz5JfzfDLJ0krPMUIxTWXMzU9YQjxHfvWpyOV80f+k7YYYUW4XQTdQqXA7MU3
	gu7YTxwDElxDK5sGTGTai2B3ueLf2v9QtpW+DN6m9DOlJSV6G0JGYJdAqal8oISe
	+c3bmD/5N4UsOYI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3321C1F30FA;
	Tue, 26 Mar 2024 18:10:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DE061F30F9;
	Tue, 26 Mar 2024 18:10:24 -0400 (EDT)
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
Date: Tue, 26 Mar 2024 15:10:23 -0700
Message-ID: <xmqq8r247igg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A5145B74-EBBD-11EE-A5F0-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> So anyway, adapting your original suggestion based on discussion in the
> thread, maybe squash in (to the final patch):
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> index c86b8c8408..c5a8033df9 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -523,9 +523,8 @@ core.commentChar::
>  	Commands such as `commit` and `tag` that let you edit
>  	messages consider a line that begins with this character
>  	commented, and removes them after the editor returns
> -	(default '#'). Note that this option can take values larger than
> -	a byte (whether a single multi-byte character, or you
> -	could even go wild with a multi-character sequence).
> +	(default '#'). Note that this variable can be a string like
> +	`//` or `=E2=81=91=E2=81=95=E2=81=91`; it doesn't have to be a single=
 ASCII character.
>  +
>  If set to "auto", `git-commit` would select a character that is not
>  the beginning character of any line in existing commit messages.
>
>
> That's assuming we don't want to go the commentString route, which woul=
d
> require a bit more re-working of the patch. I'm also open to a more
> clever or pretty multi-byte example if we have one. ;)

It has been 10 days since this discussion petered out.

My preference is to introduce core.commentString to avoid confusion
coming from an older Git using the first-byte of a multi-byte
string, or dying upon reading a configuration file meant for a newer
Git, and then let core.commentString override core.commentChar, but
I would prefer to see the discussion participants to raise their
opinions and reach a conclusion.

Thanks.
