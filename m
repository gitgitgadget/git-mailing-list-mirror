Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325C4E1A2
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508622; cv=none; b=k5bp4U6FaL/1qsy1yFesb98uxhZpNUopiX2TTFSKsDzMgJKz7W4ocP38Om44Q5bGDSP7Uc0uJyQmM1ODUutYFVd5q3Imyov7ZHJdPB7e70VlFsnwTFhzOwugfyxi+5v/BgDdtu3JsSlUU9snN+tePqGPJZpzhRZjnTBM67dCTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508622; c=relaxed/simple;
	bh=d409UbZSg5emj+lL9DveNPDN+1IJrfWej0K4gFYMyxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSzbEUdWVOxH7gArwZflbXHlGYLGigF71W7IIXrR0RO4zsl2RMxyGaVa+dvDFJnOewnxBe3TUehlzgdTvzupvIX/pNaoC0KoQ391qLPK92T5wjI3q7/BJFIP6EAPbu+VOHqiyEKrIy9cfMC55YWUNQpMKro6av/hbXVmm5vgNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SMX/nZTC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SMX/nZTC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F1D51C3E75;
	Fri,  9 Feb 2024 14:56:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d409UbZSg5em
	j+lL9DveNPDN+1IJrfWej0K4gFYMyxY=; b=SMX/nZTCIItQX5+Xc8D11l/s7V2l
	Mi40TgE3oBv4Bjxh1f0sartgEVnrhvr6RmAwtoirn5Sh8rp0/VWhX4/blDJkcZRB
	kuPjm3N5oEJJ4NILjDGcodQnd7tER92M3VXiNMBAumi/8x+NRjQTWSZdnSZCqSXw
	Qx/HB4n+GxuQS8I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 43D5A1C3E74;
	Fri,  9 Feb 2024 14:56:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C1D51C3E72;
	Fri,  9 Feb 2024 14:56:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Marcus Tillmanns" <Marcus.Tillmanns@qt.io>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even
 though --author is used
In-Reply-To: <d59a0e25-81c4-4ecd-826e-ef4b23423575@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 09 Feb 2024 18:38:37 +0100")
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
	<51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
	<60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
	<3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
	<26317088-7020-43EF-8B60-41D719A6D145@qt.io>
	<5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
	<xmqqfry1h7ej.fsf@gitster.g>
	<d59a0e25-81c4-4ecd-826e-ef4b23423575@app.fastmail.com>
Date: Fri, 09 Feb 2024 11:56:57 -0800
Message-ID: <xmqqfry1fm2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 622A784A-C785-11EE-85B5-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Fri, Feb 9, 2024, at 18:30, Junio C Hamano wrote:
>> So, now, let's be productive.  When somebody who does not know much
>> about Git tries to commit without configuring anything and hits the
>> error, what is a more appropriate message to guide who does not know
>> what he or she does not know?
>>
>> The user claims that "committer identity unknown, please tell me who
>> you are" were not helpful enough.  Would it make it more helpful if
>> we append how to "tell who they are" after that message, perhaps
>> with "git config" on user.email and user.name variables, or
>> something?
>>
>> Or do we need three-way switch that does
>>
>> 	if (neither is known) {
>>         	printf("neither author or committer is known");
>> 	} else if (author is known but committer is not known) {
>> 		printf("author is known but committer is not"):
>> 	} else if (author is not known but committer is known) {
>> 		printf("committer is known but author is not"):
>> 	} else {
>> 		return happy;
>> 	}
>>
>> 	printf("please tell us who you are...");
>>
>> perhaps?
>
> I think a three-way switch looks good. With the amendment that it steer=
s
> you towards `user.*` instead of setting both `author.*` and
> `committer.*`.
>
> Something like
>
> =E2=80=A2 Author is set, not committer
>   =E2=80=A2 Message: author is set but not committer: you might want to=
 set
>     *user* instead (prints suggested config)
>
> I can try to make a patch later.

Wait. I didn't realize this when I wrote the message you are
responding to, but we *do* already suggest settig user.* variables.

If the user chose to ignore that, then there isn't much we can do to
help, is there?

Puzzled, but I'll stop here.

