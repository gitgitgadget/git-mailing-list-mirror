Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6417B05F
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626813; cv=none; b=NMbbiYy0w+AVz7aTqsrlKax+nvdM1FBHjjvFqQdzVhXlsfRyoy7riQBa2tktA8/2I2LyfpTRTac0tVb8EnxqIoPD5o0NroJB9rxJOz8GnEH4xb6/XLagSUIktO/ozJJjRnj8Bh+C5WO7fDoslrIrBjM4P5XL0ozH0+UpJFSLE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626813; c=relaxed/simple;
	bh=O+DTghcRPmVotbz/xuxYoQ+3Y/F/i3Y6k4s+s2EybjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6gicmpPPswT5PGN3yTfzTu8GKc5kpYb5hCr21U8zg+3WH4eHnclZEYhCOE/YpMXTgLK6TmkasauLYAHpLuhbIRbMXWdzu3yJUvDpGIX8PCdi4q9F9r7JJz91Z1i7X1c/nRoROgJV46IA5TyDvX5ig1JG3yks2BJh8BLT5uLLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C8N84jIQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C8N84jIQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DA781DCA3;
	Wed, 10 Jul 2024 11:53:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O+DTghcRPmVo
	tbz/xuxYoQ+3Y/F/i3Y6k4s+s2EybjU=; b=C8N84jIQrZ1RA3fy01KtxiYfqRIi
	PTzzs0kWuHCfppEwxkn9Tg6njMK5ucG5erv5P8rdFV/2RUdLzBw5A5e/C+9zWGHb
	Or58BK26Cr2iqb9HseknCep1r1QM+fMpAnLb+MI9jU55IoH65CsB/Fk56f/KbPLn
	Fs0nIwTQhi6xuAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55FBF1DCA2;
	Wed, 10 Jul 2024 11:53:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB5E21DCA1;
	Wed, 10 Jul 2024 11:53:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Nathan Royce
 <nroycea+kernel@gmail.com>,  git@vger.kernel.org
Subject: Re: FR: Provide Out-Of-Tree Building; Provide Cross-Compile Parameters
In-Reply-To: <Zo3-FVT5EFyKsdGc@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
	"Wed, 10 Jul 2024 10:20:53 +0700")
References: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
	<CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com>
	<CALaQ_hr2Hzri6y4KwYOPmGzfvM8EjJpddvLL7CQ=d3H4QLCzJw@mail.gmail.com>
	<CAPig+cTaH+TiD9Ut5Q_BPinqdAirW51J56R_tUTSnL=XGzxvfg@mail.gmail.com>
	<xmqqjzhvejye.fsf@gitster.g> <Zo3-FVT5EFyKsdGc@danh.dev>
Date: Wed, 10 Jul 2024 08:53:29 -0700
Message-ID: <xmqqfrshz1ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8DFB4D16-3ED4-11EF-9B1F-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writes:

>> ...  And "cross compilation" is
>> one of the things that is so obvious "isn't it nice if we had..."
>> items.  At least the offer has to be a bit more, like "I'll help in
>> this and that area (e.g., organizing the effort, keeping track of
>> progress, researching dependencies, ...).  Any others who want to
>> join forces?"
>
> I thought in Git project, Makefile is the official build system, and
> the autotools build system is only an after-thought, no?

True.  In addition to autotools, there also is cmake "support" (only
meant to be used for Windows) in our tree, which us non-Windows
folks pretty much treat like how Makefile-only folks treat
autotools.

But even if they started as and still are after-thought, with enough
interest by other participant, there is nothing forbidding a
contributor to organize an effort to improve them.  The only
constraint from our side is not to butcher the main build system too
badly to make Makefile-only build less pleasant to work with and
harder to maintain.

Thanks.


