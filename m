Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13991427C
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aJYOrryx"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA2091
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 16:53:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 48448196CF;
	Sun, 29 Oct 2023 19:53:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c8GB5GxVCHMBa+lkcK8Mv8NERKaIsIm/RIywOL
	Qf5c8=; b=aJYOrryxAyfebp54Ob48t7rWHfLTV5AsQ3RtsazIi03kQX9X9EQqCo
	f2vBXrpEkz3VaszgIMo10GecQz2eidgchyIOAxZDWnrX/wR32015HFAeWI9U5ZJ1
	pTuVbkFe/FnRkUxwRADZbXVw78z9u4HkH5wR8l77ljUFIK2XogRHs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 40AA1196CE;
	Sun, 29 Oct 2023 19:53:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2931A196CD;
	Sun, 29 Oct 2023 19:53:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  Liam Beguin
 <liambeguin@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
In-Reply-To: <20231028021301.GA35796@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 27 Oct 2023 22:13:01 -0400")
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
	<20231027184357.21049-1-five231003@gmail.com>
	<xmqq7cn7obah.fsf@gitster.g>
	<20231028021301.GA35796@coredump.intra.peff.net>
Date: Mon, 30 Oct 2023 08:53:01 +0900
Message-ID: <xmqqv8apgf4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C54D56C-76B6-11EE-916D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Sat, Oct 28, 2023 at 09:12:06AM +0900, Junio C Hamano wrote:
>
>> Grouping @gmail.com addresses do not smell all that useful, though.
>> ... 
> One way you could directly use this is in shortlog, which these days
> lets you group by specific formats. So:
>
>   git shortlog -ns --group=format:%aA
>
> is potentially useful.

Exactly.  That is what I meant by "Grouping", and I agree with you
about "potentially" part, too ;-)  Throwing all @gmail.com addresses
into a single bin would not be very useful.

> ... If we could spell it as
> %(authoremail:domain) that would remove the question. But given the
> existence of "%al", I'm not too sad to see another letter allocated to
> this purpose in the meantime.

Another line of thought is perhaps it is potentially useful to teach
the --format= machinery to be a bit more programmable, e.g. allowing
to compute a substring of an existing field %{%aE#*@} without having
to waste a letter each for the local part and domain part.  But as I
already said, we are now talking about "postprocessing", and adding
complexity to our codebase only to have incomplete flexibility may
not be worth it.  A more specific %(authoremail:localpart) and its
domain counterpart may be easier to explain and understand.

In any case, it is a bit too late to say "let's not waste the
precious single letter namespace to add useless features", as we
have come way too far, so I do not mind too much using a currently
unused letter $X for yet another author and committer trait.

