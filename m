Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650051016
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585675; cv=none; b=Xj5MIC8WXMHYbW6sjqEB8iRZUZJBF4RwVTcVN2vXo2AnUUGXOSNwlAXJgagxZzN9TUkoFKBzuxhO8H4kPgCqBx1GmSrwxSBscAV4oTJW7dmCAGjBfHXn7ZJu0bqJzx8r2V2K53ZTRpkYxRliQLZaOVBjRiQnfuOlwJ3rSXk/l94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585675; c=relaxed/simple;
	bh=pc6ALm+bmd4jNPZepadpvkruQB0i7AzIKH7GJieW1Ak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CDmPD2DDlCnYwdqXm853sPS4wv/0IeDRlUwuOrqWu6vdFhlZ/qzjcYMu7a0hTNcTefCKLdUxqxXHRScuU/Xp3hGWAy8BPbsqY+hgM7wyr/oejoJe1wBLJM+0PgzOjec2BCzVVWPp+SOhb5Y0KGd+sjRwbnAiFLJJ8+QpiKr3Ma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=at3Ce9I2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="at3Ce9I2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BCF21E3182;
	Sat, 10 Feb 2024 12:21:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pc6ALm+bmd4j
	NPZepadpvkruQB0i7AzIKH7GJieW1Ak=; b=at3Ce9I2bzub6AvSUjWvFSVyP+6a
	stjodVpIiis77n3VNrCXsafsZpfValLA27+co5I6340E5ijsjeeHVgxNdxqhgdqw
	hn16CjFauiB4vpeV9mZvJi5yebrhB11JluM6N6SGCLNLQqS1Wo1eTDEh2RPvHahj
	v8Ct6ZKiTSxIVWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61DF91E3181;
	Sat, 10 Feb 2024 12:21:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9B421E3180;
	Sat, 10 Feb 2024 12:21:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcus Tillmanns <Marcus.Tillmanns@qt.io>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even
 though --author is used
In-Reply-To: <8DDFD548-1540-4E41-8AA3-84E273372F01@qt.io> (Marcus Tillmanns's
	message of "Sat, 10 Feb 2024 09:42:25 +0000")
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
	<51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
	<60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
	<3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
	<26317088-7020-43EF-8B60-41D719A6D145@qt.io>
	<5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
	<xmqqfry1h7ej.fsf@gitster.g>
	<d59a0e25-81c4-4ecd-826e-ef4b23423575@app.fastmail.com>
	<xmqqfry1fm2e.fsf@gitster.g>
	<8DDFD548-1540-4E41-8AA3-84E273372F01@qt.io>
Date: Sat, 10 Feb 2024 09:21:10 -0800
Message-ID: <xmqqo7cob5h5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C970FDFE-C838-11EE-B775-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Marcus Tillmanns <Marcus.Tillmanns@qt.io> writes:

> For me the issue was that I knew already about the global config
> setting, but in my case I specifically did not want to set that.
>
> What pulled my attention away from the important part was the huge
> wall of text about how to setup global stuff etc, making the
> single word in the top left basically invisible to my eye. I was
> thinking "I already knew all that, I=E2=80=99ve set the author, so you
> complaining still with the same error message must be a bug=E2=80=9D.
>
> I think, if a user tries to commit with =E2=80=9C=E2=80=94author=E2=80=9D=
, and git
> fails to figure out the comitter, it should have a specific error
> message about =E2=80=9Chey, you=E2=80=99ve set the author, but we still=
 have to
> figure out whom to set as the committer, or you can use
> =E2=80=9C=E2=80=94authorAndComitter=E2=80=9D if they should be the same=
=E2=80=9D.
>
> That would make it obvious to the user what=E2=80=99s going on.

I guess so, provided that such an additional text would not trigger
the "I missed due to the huge wall of text" again.  So in short, you
are saying that the three-way message would help?

Can I get you intereseted enough to care to come up with a patch
;-)?

Thanks.

>>>> Or do we need three-way switch that does
>>>>=20
>>>>     if (neither is known) {
>>>>             printf("neither author or committer is known");
>>>>     } else if (author is known but committer is not known) {
>>>>             printf("author is known but committer is not"):
>>>>     } else if (author is not known but committer is known) {
>>>>             printf("committer is known but author is not"):
>>>>     } else {
>>>>             return happy;
>>>>     }
>>>>=20
>>>>     printf("please tell us who you are...");
>>>>=20
>>>> perhaps?
