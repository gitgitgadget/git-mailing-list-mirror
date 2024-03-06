Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD08BF1
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684798; cv=none; b=ER45xulRdCUhQ8pgPa5u8jdmZsDKD4EI92gYm189SZhjWwCpot1ZXx6hfvrSPsGjzLsUw+/eHiYTdczd3OcpcbWRYYsb7vL0jZSmXhuoDNSMRIPRBLOA+pNc4I9t3SLrChIsYdF/PpfOS9B2R39yAMhyFjjW7Y8AAd1aEeMGadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684798; c=relaxed/simple;
	bh=D3d0f9uGyQpc81RtWgeZXDBVA0hVmvteVhDFwx15tNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QndaJIefsC6+A06q7GxBw5KlY8SPEzMR1rjzBmeQvRo+AT7jSuR2E2kfuVFxRGSDFOC/WXWzIq1ueFBR8QxoVsvoPrsHbM1XlYb0csI4EFxiG6B7WLaGkb9JluX+9zlSUzrVF9lCE85ZXA5//vB9MA7kQ/m2pEX2lmfG4rZsncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mcOSAxQ7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcOSAxQ7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55CD81DD405;
	Tue,  5 Mar 2024 19:26:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D3d0f9uGyQpc
	81RtWgeZXDBVA0hVmvteVhDFwx15tNk=; b=mcOSAxQ7EEgrzGbw20EpdE5MzCQ1
	XcpEeWxrney0FyXh23ODlZx6n6L/4fBVE8VSRfd3HNr1zRg1PeWWKRY7Q2kauyd6
	e817/Bvk49paklzQwmXmVPVBVjXUBfWDxFkRLwjAQMcDnvLX55mdDPV1gZ10M656
	T0NbI8+8RTObiMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D15F1DD403;
	Tue,  5 Mar 2024 19:26:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B54D41DD402;
	Tue,  5 Mar 2024 19:26:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 04/22] t/annotate-tests.sh: avoid redundant use of cat
In-Reply-To: <bdae6d2d-af56-4bc0-a000-5cf2ef44cd44@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 6 Mar 2024 01:04:36 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-5-dev+git@drbeat.li>
	<xmqqplw8xqio.fsf@gitster.g>
	<bdae6d2d-af56-4bc0-a000-5cf2ef44cd44@gmail.com>
Date: Tue, 05 Mar 2024 16:26:27 -0800
Message-ID: <xmqq7cigxl1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2C9FA9D2-DB50-11EE-8A22-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Tue, Mar 05, 2024 at 02:28:15PM -0800, Junio C Hamano wrote:
>> "Beat Bolli" <bb@drbeat.li> writes:
>>=20
>> > Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> > ---
>> >  t/annotate-tests.sh | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>> > index 5e21e84f3884..87572459e4b8 100644
>> > --- a/t/annotate-tests.sh
>> > +++ b/t/annotate-tests.sh
>> > @@ -532,7 +532,7 @@ test_expect_success 'blame -L :funcname with use=
rdiff driver' '
>> >  		"$(cat file.template)" &&
>> >  	test_commit --author "B <B@test.git>" \
>> >  		"change" "$fortran_file" \
>> > -		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
>> > +		"$(sed -e s/ChangeMe/IWasChanged/ file.template)" &&
>>=20
>> Obviously correct, but=20
>>=20
>> 		"$(sed -e s/ChangeMe/IWasChanged/ <file.template)" &&
>>=20
>> might be a more faithful conversion (when "sed" looks at its ARGV[],
>> it did not find anything before, and it would not find anything
>> after this patch).
>
> Good point.  Thank you for being careful.

Heh, I actually consider it the most irrelevant one among my
comments.  I actally do not think there is a way tell if your "sed"
invocation is reading from one of the files listed on the command
line, or reading from the standard input, from your sed script,
unlike say Perl that has access to @ARGV.  Certainly a simple s/A/B/
would not care.

Compared to that, rewriting $(cat file | wc -l) to $(wc -l <file)
does matter, which was done in [05/22].
