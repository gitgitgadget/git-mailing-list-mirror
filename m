Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8415482
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i2Hwaata"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAEA41C0A0F;
	Tue,  2 Jan 2024 11:35:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PvZvWjtJUsw1
	/K44UNz3BSVX3KzMmOok49ruZsM345o=; b=i2HwaataoN0BV57+kH8K7uRD5PuJ
	qgWw+W7f6cGa+oZtfHQXc1qGLt6Gn2GlVxcXs2NdEmUuDHdNZCCjc2a95Srs32N5
	De3WC5E+D9FprDAvotxrFDmD/bPJS03qCkRU8DgyZCFfXAIM37RL9mnlzQBixc6E
	wsla+jod96j1v8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B13011C0A0E;
	Tue,  2 Jan 2024 11:35:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F5D11C0A0C;
	Tue,  2 Jan 2024 11:35:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Achu Luma <ach.lumap@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,
  phillip.wood@dunelm.org.uk,  steadmon@google.com
Subject: Re: [Outreachy][PATCH v3] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
In-Reply-To: <435a03c7-dbf3-4ddb-b183-cac86ed0467d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 1 Jan 2024 17:41:06 +0100")
References: <20231230001102.9220-1-ach.lumap@gmail.com>
	<20240101104017.9452-2-ach.lumap@gmail.com>
	<435a03c7-dbf3-4ddb-b183-cac86ed0467d@web.de>
Date: Tue, 02 Jan 2024 08:35:29 -0800
Message-ID: <xmqqbka3g0by.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F1C0723C-A98C-11EE-90E6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> ...
>> +	for (int i =3D 0; i < 256; i++) {				\
>> +        	if (!check_int(func(i), =3D=3D, is_in(string, i))) 	\
>> +        		test_msg("       i: %02x", i);		\
>> +        } 							\
>
> This loop is indented with spaces followed by tabs.  The Git project
> prefers indenting by tabs and in some cases tabs followed by spaces, bu=
t
> not the other way array.  git am warns about such whitespace errors and
> can actually fix them automatically, so I imagine this wouldn't be a
> deal breaker.  But even if it seems picky, respecting the project's
> preferences from the start reduces unnecessary friction.
>
> The original test reported the number of a misclassified character
> (basically its ASCII code) in both decimal and hexadecimal form.  This
> code prints it only in hexadecimal, but without the prefix "0x".  A
> casual reader could mistake hexadecimal numbers for decimal ones as a
> result.  Printing only one suffices, but I think it's better to either
> use decimal notation without any prefix or hexadecimal with the "0x"
> prefix to avoid confusion.  There's no reason to be stingy with the
> screen space here.
> ...
> Each class (e.g. space or digit) is mentioned thrice here: When
> declaring its function with TEST_CTYPE_FUNC, when calling said function
> and again in the test description.  Adding a new class requires adding
> two lines of code.  That's not too bad, but the original implementation
> didn't require that repetition and adding a new class only required
> adding a single line.


Thanks for an excellent review.


>
> I mentioned this briefly in my review of v1 in
> https://lore.kernel.org/git/f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de=
/
> and showed a way to define character classes without repeating their
> names.  You don't have to follow that suggestion, but it would be nice
> if you could give some feedback about it.
>
>> +
>> +	return test_done();
>> +}
>
> Ren=C3=A9
