Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8667BE4E
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629233; cv=none; b=Nnc6/PMqu7tZ9ROtAUD6Gn0IT8paqW5oxT5m5kRlVLdniwhQhRDKLQ6qyjI+9/HmliQuTRQj6cs9207gEK+lQ4iFbAm61tWiR63mZ9MvfwsnDPIeHOH6Q3YRLTO4Ao+mm4JTCOab0NUTAIG5YsgtuaVIuCOZMl97XJH7tnkT/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629233; c=relaxed/simple;
	bh=JBMlZSHHT3rZwaRPAluaGRFgBGVZ+G7GR71wXsIEmcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O+AhIm8bVzlG+En7HasPgYoEalc2gtzN6CS3MzzAf/lGHB9RwtBPPKUZP4P0IPf8ZXKZVfkjMxaQewgAwU4VhL2QJn4Igrf+JoR87L0MAucSFftCzqxsob2MTjO89x2AasLgCRa+T7FwVdKRUwrQIsfh27LJ1IO1XPuRQXIMzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ns3jDX58; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ns3jDX58"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EF092DF6D;
	Wed, 10 Jul 2024 12:33:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JBMlZSHHT3rZwaRPAluaGRFgBGVZ+G7GR71wXs
	IEmcw=; b=ns3jDX58jAGXkMajeT7PByL3zvQ0oYJDQZ0vOzxUEXxrruVI9PhkXP
	7W7bQe5FUDez5KLe0mohx1o9Av5SBw4DdIBxxKUfNA3yx+3MmUUA79vNQ2i8opCT
	7h6WRIRZITa5jNz2oXXtuV6tJ6tvMY+D1iJVaHdAYtHDs5tzKyAdQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 33B462DF6C;
	Wed, 10 Jul 2024 12:33:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1EDD2DF6B;
	Wed, 10 Jul 2024 12:33:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Piotr Szlazak <piotr.szlazak@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] http.c: cookie file tightening
In-Reply-To: <2d76e43e-db79-4572-8f41-60fbbea10af6@gmail.com> (Piotr Szlazak's
	message of "Wed, 10 Jul 2024 12:35:02 +0200")
References: <xmqqed82cgmj.fsf@gitster.g>
	<20240709234941.GA1525171@coredump.intra.peff.net>
	<2d76e43e-db79-4572-8f41-60fbbea10af6@gmail.com>
Date: Wed, 10 Jul 2024 09:33:46 -0700
Message-ID: <xmqqy169xl3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E9AAC44-3EDA-11EF-B659-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Piotr Szlazak <piotr.szlazak@gmail.com> writes:

> On the other hand there is no problem if http.cookieFile='' and
> http.saveCookies=true is used together. Git operation is
> successful. But if GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 is
> enabled, I can see following warning it the output:
>> 12:19:56.280263 http.c:820 == Info: WARNING: failed to save cookies in
> It comes from:
> https://github.com/curl/curl/blob/master/lib/cookie.c#L1758
> But cookies were accepted by the client and sent back to the server.

Thanks for your experiments.

I do not know if it is safe to call the above observed sympotom
"there is no problem".  What does it even mean to set cookieFile to
an empty string and ask the cookies to be saved?  What does the user
who makes such a pair of requests

	[http]
		saveCookies = yes
		cookieFile = ""

expect to happen?  The session begins with an empty set of cookies,
cookies that come from the other side are maintained in-core during
the session, and then at the very end of the session what do they
want to happen to their cookies?  "The system will try to save them
but without finding a sensible place to save, it gives a warning
without molesting the main goal of the process (which is to interact
with the other side)" sounds like a rather strange wish.

I'd consider "The system notices that there is no sensible place to
store, so it warns about the conflicting request and ignores
http.saveCookies" a bit more sensible behaviour in such a situation,
but obviously I am biased.
