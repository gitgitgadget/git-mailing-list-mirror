Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC219D092
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244266; cv=none; b=jAPjZd/wvHdnd4B9z8NaAyWQ9NEfWyQBJOxhfLSxqw2gt1lvh/VO0A8XSwwqse6nKWzrEcvPB9reQpqbd4soVcUV/kaQFEV1qAhSvsweqU8onQYDMeV6M9E8+IQJ6VvAFNwF3+A+5ujptwt3a5idmqOVZ0zNGFIedAcgYFeDnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244266; c=relaxed/simple;
	bh=LbBHPKUCQXhhUtqJJQo55arNHvL7oBbT7Ell2ixeHf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBxolihhAqKa67a0ve/IFCwnSLB1E0wGpb1dcxrYFGQsL7zCpMsJrOq0HVOGme129KWFHZcG8vziVWxvtUBd1n2Jo4TL0FdgJYJcj3vLappcvQOQz3ACG0poWSIrVdK2rMYjyZ9HJu7tFQFk3uR1y/BpGnwfCW62FUDduq6AyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gD4jZQZs; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gD4jZQZs"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E76C2F28C;
	Mon, 24 Jun 2024 11:50:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LbBHPKUCQXhh
	UtqJJQo55arNHvL7oBbT7Ell2ixeHf4=; b=gD4jZQZs+LUTslxsetcMUGr72eC0
	XY72C+0QsDceqCg7OTRhV1SERviIWYkqD956AoYqFCbNiEeaJD4RRiAupqwPK/i9
	6HprasYwf9VXQXvsHaS/o3C9/ppr2lM6XnXcGOPt/t1LMAkI0cjZP/DNRsN5CGny
	UJ4sOBxU8ihcvMI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 06C0C2F28B;
	Mon, 24 Jun 2024 11:50:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 295AD2F289;
	Mon, 24 Jun 2024 11:50:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH resend] git-send-email: Use sanitized address when
 reading mbox body
In-Reply-To: <a55cc932-98b0-43cd-9dfa-ea21a4340bf6@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6Fz?=
	Bence"'s message of "Mon, 24 Jun 2024 09:37:51 +0200")
References: <20240621092721.2980939-2-csokas.bence@prolan.hu>
	<xmqqr0cqmck5.fsf@gitster.g>
	<a55cc932-98b0-43cd-9dfa-ea21a4340bf6@prolan.hu>
Date: Mon, 24 Jun 2024 08:50:54 -0700
Message-ID: <xmqqy16ue3vl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8B39356A-3241-11EF-B01A-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Cs=C3=B3k=C3=A1s Bence <csokas.bence@prolan.hu> writes:

> On 6/21/24 19:27, Junio C Hamano wrote:
>> Hmph, there is this piece of code before the block:
>> 			if ($c !~ /.+@.+|<.+>/) {
>> 				printf("(body) Ignoring %s from line '%s'\n",
>> 					$what, $_) unless $quiet;
>> 				next;
>> 			}
>> This is to reject strings that do not even look like an e-mail
>> address, but we called sanitize_address() call on $c way before this
>> check.  I wonder if we should move this block way up, even before
>> the call to santize_address()?
>> That was a relatively unrelated tangent.
>
> Hm, maybe. Should I add this to the patch as well?

No, it is an unrelated tangent.  We try not to mix unrelated things
into a single patch.  Perhaps as a separate "clean-up" patch after
the dust from the main topic settles, or as a preliminary "clean-up"
before the main topic, would be good (but see below).

>> It looks to me that there are many other places that we try to be as
>> faithful to the original as possible.  In the same block as the one
>> that handles "Cc:" I quoted above, an address on "From:" is also
>> sent intact into @cc and addresses on "To:" are handled the same
>> way.
>> The patch under discussion singles out the addresses on the trailers
>> in the message body and treat them differently from others, which I
>> am not sure is what we want to do.
>
> I think it is a reasonable assumption that the mbox headers will be
> conforming, whereas the message body is just freeform text and no such
> guarantees exist. But if we want to be paranoid about it, we could try
> and sanitize everything.

I actually do not think we want to be more paranoid.  I'd rather
trust what the user gave us, which was where my response came from.

Having said that, given that the "Ignoring ..." check we saw earlier
in this message triggers only for trailers, it may be a sensible
position to take that mail headers are more trustworthy and a random
address-looking strings on the trailer lines should be checked more
carefully.  Because the "Ignoring ..." check is primarily to reject
strings that are not addresses (things like bug IDs, or just
people's names without e-mail addresses to credit for a new feature
request) that we do not ever intend to actually Cc: the message to,
another sensible choice coming from that "strings on trailers may
not even be addresses" position may be not to add the $c to the Cc:
list, if $sc (the sanitized address) and $c (the original address)
are different.  That is, "the simple regexp check currently used to
trigger 'Ignoring ...' message thought that the string looked like
an address, but when we ask sanitize_address, it turns out that it
was not, really."  And if we were to take that route, "Ignoring ..."
check, which I called an unrelated tangent, would become very much
related to the topic at hand, as it would mean the resulting logic
would look more like this:

	my $sc =3D sanitize_address($c);
	if ($c !~ /.+@.+|<.+>/ || $sc ne $c) {
        	printf("(body) Ignoring %s from line '%s'\n",
		       $what, $_) unless $quiet;
		next;
	}

In any case, if we were to move forward with this topic (whether
"send to corrected $sc instead" or "$c is suspicious, do not add it
to $cc" is picked as the direction), the motivation behind the
design decision to treat the address taken from a trailer line
differently needs to be explained better, I think.  I had a chance
to ask you directly on list, and you gave a good explanation to me
in the message I am responding to, but you will not be around when
future readers of "git log" want to ask the same question "why are
we singling this out while we use the original address in all the
other places?".

Your proposed commit log message is the place to help them.

Oh, before I forget, is this something we can test easily in t9001?
We would want to protect a new behaviour from accidental breakage,
so adding a test or two would be a good thing.

Thanks.
