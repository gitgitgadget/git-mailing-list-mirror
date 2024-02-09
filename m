Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71037BB02
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499850; cv=none; b=qbP+DGYnSNJ53egOn6L+lOFlGwbyx9PLrgDqBwYS6oNxJKcl6w9uRA7AefapMxoW7MBIjcGnmYm5TUkizg2v+PlCYw5/CGREbNH0WfUkpQbJ9vmUAXYSnpCkl66GjzCdSYQUNV2PkFyTpeARgHxKWvkV4WnoMtoKus68SqtoEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499850; c=relaxed/simple;
	bh=XKul0xF7n/tyG16uQlholJl+5LpbnwNE3kecrJbN/wQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETFT0BPTIlN/KdI46VSwOMOQntrz4JX0TZfpptK8tYhLj5Hc7nqS4pHewB4GerhDr8r2PdFbpTlKfxbk1hbl7qNeiu/nUTy8VeervG9C9z1xqs+7S7Q5yMc3W6Vr2DrPbZuABoiS2n4n9K3Afrnd/NhENkhs4L7GHoapjRM2MXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nLJJC6PC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nLJJC6PC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C13E1EC9B;
	Fri,  9 Feb 2024 12:30:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XKul0xF7n/ty
	G16uQlholJl+5LpbnwNE3kecrJbN/wQ=; b=nLJJC6PCV0usxC2T/DTIHjLMeOdS
	tT9TsqhSXCnEKvw2XSvLm/zHXnyyTBkfL4f2v74UmOqpQCl6QQoK/jLPcOMJeGeo
	CmYydRbfgt0gW06496w0DyIoVzw5Z3ZLW/o/7WqHXOda+h7vHfQdvgnkBpW3OH1J
	avSK8Np+/vS/0P0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 33DB71EC9A;
	Fri,  9 Feb 2024 12:30:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 56B181EC99;
	Fri,  9 Feb 2024 12:30:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Marcus Tillmanns" <Marcus.Tillmanns@qt.io>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even
 though --author is used
In-Reply-To: <5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 09 Feb 2024 12:02:43 +0100")
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
	<51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
	<60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
	<3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
	<26317088-7020-43EF-8B60-41D719A6D145@qt.io>
	<5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
Date: Fri, 09 Feb 2024 09:30:44 -0800
Message-ID: <xmqqfry1h7ej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F4E1027C-C770-11EE-AE2F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> So when a user gets this error:
>
> ```
> Committer identity unknown
>
> *** Please tell me who you are.
> ```
>
> And have never heard of =E2=80=9Ccommitter=E2=80=9D before=E2=80=A6 wha=
t is she to think? I
> think it=E2=80=99s very natural to conclude that =E2=80=9Cauthor=E2=80=9D=
 and =E2=80=9Ccommitter=E2=80=9D are
> the same thing. So she thinks:
>
>   =E2=80=9C Okay, so the program is complaining about the author not be=
ing
>     set. (It calls it =E2=80=9Ccommitter=E2=80=9D here for some reason.=
) But I have set
>     the author=E2=80=A6
>
> Maybe this is another case of: it all makes perfect sense if you alread=
y
> know all the concepts.
>
>>> Your report would have been more clear if you included the error:
>>
>> Had I had any idea that the report was different between with / withou=
t
>> =E2=80=94author I probably would have added it, or found out what the =
issue was.
>
> You don=E2=80=99t know what you don=E2=80=99t know. That=E2=80=99s why =
it=E2=80=99s best to include all
> context.

So, now, let's be productive.  When somebody who does not know much
about Git tries to commit without configuring anything and hits the
error, what is a more appropriate message to guide who does not know
what he or she does not know?

The user claims that "committer identity unknown, please tell me who
you are" were not helpful enough.  Would it make it more helpful if
we append how to "tell who they are" after that message, perhaps
with "git config" on user.email and user.name variables, or
something?

Or do we need three-way switch that does

	if (neither is known) {
        	printf("neither author or committer is known");
	} else if (author is known but committer is not known) {
		printf("author is known but committer is not"):
	} else if (author is not known but committer is known) {
		printf("committer is known but author is not"):
	} else {
		return happy;
	}

	printf("please tell us who you are...");

perhaps?
