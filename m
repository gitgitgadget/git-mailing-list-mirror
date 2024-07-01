Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2D29CEC
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859662; cv=none; b=txaQKaONaJRJsiUDpoamjGNEyJ4BHc0POtiv6a96A9DsZYPDZPohL19/VcTfSLrQLjyFBH+J88f+fGcPVPuN2PvWoR1HfIj4KMmkLRirYmpq8Xdyv7mrWkAbFy94rVH0mR1ggB9Gc0vF0sMFi4WVKb/NBr7+jA0mapg0r46dmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859662; c=relaxed/simple;
	bh=i5IlZcMQs3ZJQfO1Yk082+3p/B4+dcSa117lzC1Wn8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4vWcEV8Q/0QvELc7+7FAlmTj81UnhRW7GeLdlLkPFn1KS4TGmvHulhbxt7KAsuTjsUoUta9K4yE+9cZYf8UUQgJfaWfNEegJZ+BOtWKik6N9dwrvM2sWkrGR6VdG3YyoBfA2+3D/x0kgpct775ts1GprzofREtiAUwvbOsPSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A/PYv4QR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A/PYv4QR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E8671DBE8;
	Mon,  1 Jul 2024 14:47:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=i5IlZcMQs3ZJ
	QfO1Yk082+3p/B4+dcSa117lzC1Wn8E=; b=A/PYv4QR+GSFYvTjPL+cdrLr+1M2
	G4hbVc/QGDt6+JG17RLLUohWrA5Qm33hwP+XtavUNEhVeTayPTAIL5CnNMfaAIKW
	uEEZo6uQjbV+ptcU8VEMWnCZTwrNfTekrG0XnCstPn+nvod2hqWu9ggK3ZCMN7ch
	As6G9hf/YVk3u2g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 06B851DBE7;
	Mon,  1 Jul 2024 14:47:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9AF991DBE6;
	Mon,  1 Jul 2024 14:47:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4] git-send-email: Use sanitized address when reading
 mbox body
In-Reply-To: <20240701090115.56957-1-csokas.bence@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6FzLA==?=
	Bence"'s message of "Mon, 1 Jul 2024 11:01:16 +0200")
References: <20240701090115.56957-1-csokas.bence@prolan.hu>
Date: Mon, 01 Jul 2024 11:47:34 -0700
Message-ID: <xmqqy16lvtix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 627CAE88-37DA-11EF-84BB-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> writes:

> Addresses that are mentioned on the trailers in the commit log
> ('Signed-off-by: ' etc.) are added to @cc (unless suppressed),
> passed to the SMTP server. However, these hand-written
> addresses may be malformed (e.g. having unquoted commas and
> other punctuation marks in the display-name part).
>
> The code was already calling `sanitize_address()` for suppression
> purposes, so we just have to use the result ($sc) for adding to @cc.

There is a leap between the description of the status quo and your
conclusion.  "we just have to" becomes valid only after explaining
that sanitize_address turns the address-looking string into valid
addresses (and we do not want to send to malformed addresses--but
that goes without saying).

> Also note that
> `sanitize_address()` does not process the mailbox addresses,
> so it is up to `sendmail` to handle special characters there
> (e.g. there are mailboxes in regular use with '+'-es in them).

I do not quote see the point of this final note.  mailboxes with
'q'es in them are also in regular use, and singling out '+' does not
make much sense in the context of explaining this change.

>     Changes in v4:
>     * t9001: use ${SQ} instead of double quotes
>     * re-worded message again

OK.  The additional recipient address=20

> +	Co-developed-by: "C. O. Developer" <codev@example.com>

to contrast with

> +	Signed-off-by: A. U. Thor <thor.au@example.com>

is a nice touch.  We make sure that, with or without necessary
quoting in the original, we produce the correct result ;-).

Let's mark it for 'next' soonish, with proposed log message
rewritten somewhat.

Thanks.

----- >8 -----
git-send-email: use sanitized address when reading mbox body

Addresses that are mentioned on the trailers in the commit log
messages (e.g., "Reviewed-by") are added to the "Cc:" list by "git
send-email".  These hand-written addresses, however, may be
malformed (e.g., having unquoted "." and other punctutation marks in
the display-name part) and can upset MTA.

The code does use the sanitize_address() helper on these
address-looking strings to turn them into valid addresses, but it is
used only to see if the address should be suppressed.  The original
string taken from the message is added to the @cc list if the code
decides the address is not suppressed.

Because the addresses on trailer lines are hand-written and more
likely to contain malformed addresses, when adding to the @cc list,
use the result from sanitize_address, not the original.  Note that
we do not modify the behaviour for addresses taken from the e-mail
headers, as they are more likely to be machine generated and
well-formed.

Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
