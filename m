Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC7181D05
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247690; cv=none; b=kXfyRpHROPmx5z515PlcZy/BZ7pg7B1aHteDDjPL4VnyRUGMxCqu/bgWreW+200oRWoX+rdgcKuypc/r7nbrJIXIt2Y6+mkD3OHLcTxgVs2oEbwyoyZITKula5nMNWaAS69Dg6xMJIRUrAd6dhuA/eCbFTCIl9ne+caNqU3feOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247690; c=relaxed/simple;
	bh=NsLNBx30Ry6WcSfLw2TitOjTNnnCR50aZgS+ukw3tqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hmNd51tnlF6klQ+Fqy1OEvikX3K8+wCh3lKLitIv/vCnLsPY2GuGMCRREHBQdFwKxct3YKl3vQBfMISqYAPQ8boA7wzjNhPt4ueTpXNBU9KiwnRfqTFjXfHXxtoVfgAb8Ft4mEXyXj+6x0/NRU+dhBe1ejTFjPHeiyZxpr3cPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h5peXG3f; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h5peXG3f"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2E30226EB;
	Wed, 17 Jul 2024 16:21:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NsLNBx30Ry6W
	cSfLw2TitOjTNnnCR50aZgS+ukw3tqM=; b=h5peXG3f8V9KH0OOX7oT0jd0QqNm
	0UlyUfIHbesNBcXp/C+ra47cpjUQdbbqDpUASNWkKfjn8f9w5wdL8SuQY8G7KR2g
	UvUR8DmFmvHBbODoPaeESSzhLfxjnCg2VRT3QVzcyxqPjISJFo9npzwZ6xfoHfwk
	2mNZenVpWG6WMHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8AA8226EA;
	Wed, 17 Jul 2024 16:21:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD40A226E9;
	Wed, 17 Jul 2024 16:21:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood123@gmail.com,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,  Jeff King
 <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 17 Jul 2024 16:09:17 -0400")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<xmqqfrs723bp.fsf@gitster.g>
	<CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com>
Date: Wed, 17 Jul 2024 13:21:25 -0700
Message-ID: <xmqq8qxz22ii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 24F690F4-447A-11EF-8768-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jul 17, 2024 at 4:04=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> phillip.wood123@gmail.com writes:
>> >> -    test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal g=
it add -p
>> >> +    test_write_lines P q |
>> >> +    (
>> >> +            GIT_PAGER=3D"head -n 1" &&
>> >> +            export GIT_PAGER &&
>> >> +            test_terminal git add -p >actual
>> >> +    )
>> >
>> > That's surprising, why does running git in a sub-shell stop it from
>> > segfaulting?
>>
>> Yeah, it indeed is curious.
>>
>> The rewrite resolves another iffy point in the original---you are
>> not supposed to attempt a one-shot assignment to the environment
>> variable when you are running a shell function, as that is not
>> portable.  And the above rewrite is a common way to fix that.
>
> It's also curious that t/check-non-portable-shell.pl didn't catch this
> use of one-shot assignment when calling a shell function[*].

True.
