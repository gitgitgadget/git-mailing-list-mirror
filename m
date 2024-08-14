Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5A3A29F
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660903; cv=none; b=OpdmopRafUu+wESKsNBcRZyEEnvaPZSA370loTCX0dusdsYsmA67Zi3F2EKyjAptV5Chmrh7tatDliPv3zcTlYXdzOPAVhQMJqbfQ38S+yFECKfxgyBRaBDnzuOUgnKrkpN+moQ5aZTM9m98zH9Ui3lfTVTtxDmGjgyhU10ngkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660903; c=relaxed/simple;
	bh=p6RTXWlU6SsyC1vZfmCjZQX5tbLGvbc6hDqxpAzENcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ByJ2y6D/6wfvXGzXWe1zdhoHxuvHFuJqK+jQCrlB+RhnYA91fULErPGU2aqbzcy8OmE7jUWNBgZ9L8s12Tk1HzHWMAlr8j9BKR2AfAsKXe7752gQ7HeMeIP2reMZa0eSUp3v/GZofwh+Klx1J+XXBAX/SCT2Hcn40nXNjViqnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYSH5e24; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYSH5e24"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C4EA319618;
	Wed, 14 Aug 2024 14:41:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p6RTXWlU6Ssy
	C1vZfmCjZQX5tbLGvbc6hDqxpAzENcY=; b=MYSH5e24MNerKe2PVBD0LZR94kHY
	NmN2a7FPgA5Cd3dQvw2S97mY94ko5/yl2T+O1jgkDdb3h7p2hNMtTa5Sr61ZKf40
	4Uf3Hxj6oNyQxESQTk1R5vqsetvQy1kf0cEiTkYnqhRBIvt9Rl+c7uaklh+QwQSe
	sFB0cPNKqO6JpsQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD47919617;
	Wed, 14 Aug 2024 14:41:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2827F19616;
	Wed, 14 Aug 2024 14:41:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org,
  Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] send-email: teach git send-email mode to
 translate aliases
In-Reply-To: <CA+P7+xrKBqWVwkFH=WrGoLJbqVtE3AO=CBb0=UTw=E8AA+xv4g@mail.gmail.com>
	(Jacob Keller's message of "Wed, 14 Aug 2024 10:45:21 -0700")
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
	<xmqq34n711uy.fsf@gitster.g>
	<CA+P7+xrKBqWVwkFH=WrGoLJbqVtE3AO=CBb0=UTw=E8AA+xv4g@mail.gmail.com>
Date: Wed, 14 Aug 2024 11:41:37 -0700
Message-ID: <xmqq4j7nymji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D7988B56-5A6C-11EF-8AAC-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Aug 14, 2024 at 9:54=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>> > ---
>> > Jacob Keller (3):
>> >       t90001-send-email.sh: fix quoting for mailrc --dump-aliases te=
st
>>
>> Nobody noticed the typo in the filename since the previous iteration
>> was posted?
>>
>
> I certainly did not :D Woops. If you had pointed this out in the
> initial review, I apologize as I missed that comment.

I do recall raising an eyebrow but I do also recall saying nothing
about it ;-)
