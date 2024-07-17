Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B9FC1F
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248280; cv=none; b=Oep0VjuYK0/J2Z0TymMtAX5PUC32JvejbLKQ/ddq3dWqmC7BJyCmeIgaOD3ZuT2ESp3IfCDqF3X3au86EaDDXkgJip05vRxo940H2JrtiBtICaf8BCUUqoE/oidIrgz0UtE02da9F9yj5DHFQU7s9XFXXfQzpv/aJ3lLWjAY90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248280; c=relaxed/simple;
	bh=AHQGTvP354EsbrJdiFf78E1o+UWkwg4yTI8BFBck5ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VqOspAcMUpCuyxVNhl7c66JrZcFRNdVJGtF8aJXcQCYuPvZANLyGjfpJxBikFOInb8ZDPYDBf/iTyOie+Va+FZzoNprRnDG5+bOsTYBu7d/w4w2HqopkhXTqU8HKPPzmocxRQYqSx55cnDKTcpS22Hm+Qd9kZZARnWrntr8UeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QZamJmQ9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QZamJmQ9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF72E228F7;
	Wed, 17 Jul 2024 16:31:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AHQGTvP354Es
	brJdiFf78E1o+UWkwg4yTI8BFBck5ww=; b=QZamJmQ9wO+wchhJr7vD2w4eKwGv
	et549g+GehkiJAzPtg7yj9amvuXpfvvudYGwl8L07qZnzxpBE7MayEFXfvHkPObk
	wx2QKbw1xk+jqP1alsM6Vdkcoqyz9h8bwqGcK1lNl2YXeJrXprIojutjgnqRZVd3
	3FBTaBkkyOnwsW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6828228F6;
	Wed, 17 Jul 2024 16:31:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EE40228F5;
	Wed, 17 Jul 2024 16:31:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <88f9256e-04ba-4799-8048-406863054106@gmail.com> (phillip's
	message of "Wed, 17 Jul 2024 20:39:12 +0100")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
Date: Wed, 17 Jul 2024 13:31:16 -0700
Message-ID: <xmqqy15zzror.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 84F4310E-447B-11EF-B570-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

phillip.wood123@gmail.com writes:

>> -	test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal git add=
 -p
>> +	test_write_lines P q |
>> +	(
>> +		GIT_PAGER=3D"head -n 1" &&
>> +		export GIT_PAGER &&
>> +		test_terminal git add -p >actual
>> +	)
>
> That's surprising, why does running git in a sub-shell stop it from
> segfaulting?

Another difference besides the sub-shell is where the output from
test_terminal goes.  If the above change fixes the issue for Rub=C3=A9n,
I wonder if it still works if ">actual" gets removed.
