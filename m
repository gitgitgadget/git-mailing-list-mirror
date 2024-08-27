Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB4747F
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723402; cv=none; b=NktNz51e7UCg4jKtxvxGzGFyvycy19iYnRJ2iQUth/xoizjS6DeMU15hhJ5zbLg+BgaPt6WprfTkDzgpmRF39efbed4KjCOoTcmYb8ozTk1n68j5OlmTe+Zuf3c3D4x2Fc9dLn1NXpuj/hsxdaEsHXl6wtbrd3fcrx8LBnJshPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723402; c=relaxed/simple;
	bh=brq5UsUszfFHz59Ft/DhU5sRbzg80+/kQE7ZKQs1gNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lWd8UB442+aJMpT0QD4YoR9XIQhdXw7NJaPDCJRr7EVgS2l7QLy9DTZPGwBNtVneRb1g4a8WUTqZ6d78jKfPxS8ZDU+IngxWwUJnYjS+G0v2u9P6W6+m4ZzWTIRy6dmkCeIsd8DO0g8+62MODXX4hhRPsl670gM5vyk1U/TgA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iXm6Ehse; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iXm6Ehse"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C93B2B0A5;
	Mon, 26 Aug 2024 21:50:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=brq5UsUszfFHz59Ft/DhU5sRbzg80+/kQE7ZKQ
	s1gNs=; b=iXm6Ehsebj+XnkLjLWkhRbyZINSNftof21bWepYlqmzYqLriJP1U93
	kfLZs4pk0sA6fXz27AtnR5jRnOJ43jQ8o/3J71dBoXbPK8Jnsx/AenQ2+cK4EeV/
	XMiONhM65XD6PJrzy1LNb6DLO2KuPD33F/zZKzONTD7Lw6TRZtR1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75EE02B0A4;
	Mon, 26 Aug 2024 21:50:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBC7B2B0A3;
	Mon, 26 Aug 2024 21:49:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] apply: whitespace errors in context lines if we have
In-Reply-To: <xmqqo75eeqx0.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 17:43:39 -0700")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<5da09529-e95b-407b-9e66-34ebac4b4128@gmail.com>
	<xmqqo75eeqx0.fsf@gitster.g>
Date: Mon, 26 Aug 2024 18:49:54 -0700
Message-ID: <xmqqv7zmd9a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A8F59C54-6416-11EF-8002-BF444491E1BC-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Hmph.  0a80bc9f (apply: detect and mark whitespace errors in context
> lines when fixing, 2015-01-16) deliberately added this check because
> we will correct the whitespace breakages on these lines after
> parsing the hunk with this function while applying.
>
> It is iffy that this case arm for " " kicks in ONLY when applying in
> the forward direction (which is not what you are changing).  When
> applying a patch in reverse, " " is still an "unchanged" context
> line, so we should be treating it the same way regardless of the
> direction.
>
> But at least the call to check_whitespace() from this place when we
> are correcting whitespace rule violations is not iffy, as far as I
> can tell.

Having said all that, I do have to wonder how much value we are
getting by supporting that odd "feature" that makes apply take input
in a single session a patch that touches the same path TWICE.

If we can get rid of that feature (which I consider a misfeature),
we can lose quote a lot of code (anything that touches fn_table can
go) and recover the code quality that got visibly worse with the
addition of that feature back.

And without the "input may touch the same path TWICE", we do not
have to worry about this "context lines after applying a single
patch with whitespace=fix will have to be matched loosely with
respect to the whitespace when another patch modifies the same file
around the same lines", making your changes in [3/5] trivially the
right thing to do.

So, I am inclined to say that

 * we propose to get rid of that "a single input may touch the same
   path TWICE" feature at Git 3.0 boundary.

 * we at the same time apply [3/5] (and possibly others, but I do
   not think we want [1/5]).

But until we can shed our pretense that the "single input may touch
the same path TWICE" is seriously supported, I do not think applying
this series as-is makes sense, as it directly contradicts with that
(mis)feature.


