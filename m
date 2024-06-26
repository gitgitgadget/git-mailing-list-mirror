Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2718FDD0
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422930; cv=none; b=EPGgMZRJswnrxUeIhu/uqKpFYZsNYuCR4kAa2OoeO5tkaznSspe8KyiCu1uPPee2Izjm2GFU5OgkE1yryCxHu0ZJkxy2JBa7hUO/2mBQw9MED1KkTUAKYNSjF9xW3aQaWdZtr9d0qBEPVoi1S522H/f90jn5tUzLW1IM3uX0R4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422930; c=relaxed/simple;
	bh=baSoUoR0tOG1v4J1PqoeKeeBv/geC+TLI93+ivfVfvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PGdQ9g702TmhZlcRZKLXOeuktdMD+HEmGviKtfLCWDPA6b6YfB3i93JbinDT9LxVTJ9FXJoa1tzGBH0WrdAxG9gQq69pFcostprZoeankuW340JFkthROS1fYt31KUKNy0zakR646sMIWXMHq9+zOQttD+klpKR85lH9eznV6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oPa/1Xc0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPa/1Xc0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B1452FDA7;
	Wed, 26 Jun 2024 13:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=baSoUoR0tOG1
	v4J1PqoeKeeBv/geC+TLI93+ivfVfvg=; b=oPa/1Xc0dQQGPhFvOIjI1Nei41Gi
	e2LxrcuXSQDxAgBZh1HFpgajXYf0OijsdJPFHzsDjpx4/zpORvB5LdWZ2Bg755zC
	+NEKoG4J5PLBwbVTx5GrPtDREI7gEIZ9tTsoucro9AcCxMSzHI+dwrhMNcRLJo7T
	GvtKgQ0Q6/+GlXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3438C2FDA6;
	Wed, 26 Jun 2024 13:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B1072FDA5;
	Wed, 26 Jun 2024 13:28:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-send-email: Use sanitized address when reading
 mbox body
In-Reply-To: <20240626132440.3762363-2-csokas.bence@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6FzLA==?=
	Bence"'s message of "Wed, 26 Jun 2024 15:24:41 +0200")
References: <20240626132440.3762363-2-csokas.bence@prolan.hu>
Date: Wed, 26 Jun 2024 10:28:45 -0700
Message-ID: <xmqqy16r1ulu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8B1F3E5C-33E1-11EF-84A5-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> writes:

> Commas and other punctuation marks in 'Cc: ', 'Signed-off-by: '
> etc. lines mess with git-send-email. In parsing the mbox headers,
> this is handled by calling `sanitize_address()`. This function
> is called when parsing the message body as well, but was only
> used for comparing it to $author. Now we add it to @cc too.

The above is misleading, though.  We do use sanitize_address on
addresses we find on e-mail headers, but the result is not used
in @to or @cc, the addresses we use to actually send the message
out.

Perhaps phrase it more like ...

    When we check addresses found on the mbox headers to see if we
    want to add them to Cc:, we use sanitize_address() function to
    normalize the addresses before passing them to the suppression
    mechanism, but we use the original addresses for the purpose of
    sending the message out.

    We use the same logic on the address-looking strings found on
    trailer lines that appear in the message body.  Sanitized
    addresses are used for Cc-suppression purposes, but the original
    addresses as written by the end-user are used as the mail
    destination.

    There are certain quoting rules for e-mail addresses, and unlike
    addresses on e-mail headers that are generated by format-patch,
    hand-written addresses on the trailer lines are more likely to
    violate them by mistake.

    When adding the address found on a trailer line in the message
    body, use the sanitized address for both sending the message
    out, as well as checking with Cc-suppression mechanism, to
    reduce the risk of malformed hand-written addresses to get the
    message rejected (but keep using the original addresses found on
    the e-mail headers in the input message for e-mail destination).

... or something like that?

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 58699f8e4e..7e0b8ae57c 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh

This test uses mixture of test_grep and grep, so use of "grep" below
is fine (but in the longer term we should make sure the tests use
the former for better debuggability).

As I always say, we should resist the temptation to write our tests
just to demonstrate our shiny new toy.  In this case, the test is
too focused to show that the system will give a best-effort output
when fed invalid and/or malformed addresses, but it does not see
what happens to a well formed addresses (ideally they are passed
intact, but is that what happens with the new code?).  Perhaps add
one or two trailer lines with valid addresses (and non-address, like
"BugId: 143421", that should not appear at all in the output) on
them?

Thanks.

> +test_expect_success $PREREQ 'cc list is sanitized' '
> +	clean_fake_sendmail &&
> +	test_commit weird_cc_body &&
> +	test_when_finished "git reset --hard HEAD^" &&
> +	git commit --amend -F - <<-EOF &&
> +	Test Cc: sanitization.
> +
> +	Cc: Person, One <one@example.com>
> +	Reviewed-by: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@exampl=
e.com>
> +	Signed-off-by: A. U. Thor <thor.au@example.com>
> +	EOF
> +	git send-email -1 --to=3Drecipient@example.com \
> +		--smtp-server=3D"$(pwd)/fake.sendmail" >actual-show-all-headers &&
> +	test_cmp expected-cc commandline1 &&
> +	grep "^(body) Adding cc: \"Person, One\" <one@example.com>" actual-sh=
ow-all-headers &&
> +	grep "^(body) Adding cc: =3D?UTF-8?q?F=3DC3=3DBC=3DC3=3DB1n=3DC3=3DBD=
=3D20N=3DC3=3DA2m=3DC3=3DA9?=3D"\
> +" <odd_?=3Dmail@example.com>" actual-show-all-headers &&
> +	grep "^(body) Adding cc: \"A. U. Thor\" <thor.au@example.com>" actual=
-show-all-headers
> +'

>  test_expect_success $PREREQ 'sendemail.composeencoding works' '
>  	clean_fake_sendmail &&
>  	git config sendemail.composeencoding iso-8859-1 &&
