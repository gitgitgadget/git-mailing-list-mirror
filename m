Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBD40C04
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XsWtSE62"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 85DB51BBB1C;
	Wed, 20 Dec 2023 10:57:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p5SVlEEF+V9K
	s5uebk4qzD7ziVP5TuspX2DgX2xwYHM=; b=XsWtSE624VBFmwtbEMfBevmATDwN
	IFa4Q3F+vvZtnFmC3knPgqHbOYg0BkiD89w6yidiruNI68yoHrFlxASIkn1Lz8Bl
	a0mkfSjTeC2NcljJc7zbO17f+Sk+H3FkgKW2QIdkF8UyB62HxptKXygVRRZYj/NG
	E198maIscuo6W0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 79C851BBB1B;
	Wed, 20 Dec 2023 10:57:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0F4C1BBB1A;
	Wed, 20 Dec 2023 10:57:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: use strvec_pushf() for format-patch revisions
In-Reply-To: <47089803-c45b-4f33-b542-146c313f0902@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 20 Dec 2023 09:04:35 +0100")
References: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>
	<xmqqmsu6ce0u.fsf@gitster.g>
	<47089803-c45b-4f33-b542-146c313f0902@web.de>
Date: Wed, 20 Dec 2023 07:57:13 -0800
Message-ID: <xmqqmsu4uasm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 71B2063C-9F50-11EE-AC67-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 19.12.23 um 18:12 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> In run_am(), a strbuf is used to create a revision argument that is t=
hen
>>> added to the argument list for git format-patch using strvec_push().
>>> Use strvec_pushf() to add it directly instead, simplifying the code.
>>>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>
>> Makes sense.  Between the location of the original strbuf_addf()
>> call and the new strvec_pushf() call, nobody mucks with *opts so
>> this change won't affect the correctness.  We no longer use the
>> extra strbuf, and upon failing to open the rebased-patches file,
>> we no longer leak the contents of it.  Good.
>
> Ha!  I didn't even notice that leak on error.  Perhaps the two release
> calls at the end gave me the illusion of cleanliness?  Or more likely
> the opportunity to use strvec_pushf() grabbed my full attention (tunnel
> vision).

Perhaps I'll amend the end of the log message, like so, before
merging it down to 'next', then.

    ..., simplifying the code and plugging a small leak on the error
    codepath.

Thanks.
