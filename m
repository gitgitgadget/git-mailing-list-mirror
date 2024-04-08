Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0218C05
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619885; cv=none; b=XAsEoHPPqw1PUXXegVZYd7gamEYRnvTjyM299+yCNqlwkNkLhr//grAdpWHP7wpwYJPkAiJ/655VT1nApY4ddCpJk82uCt+PVm0i0NpKenIO+gV5U3jcMlKmEssOs9meGnE2ZlGnDdw3Z6kn+iIykDut1TmIqhqTEO5PKuq5fF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619885; c=relaxed/simple;
	bh=XZ1fbrOik9B/oWcZfWQRAeirPBZg0u2VQ7ceBiDg6cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gP/3g1ZXxZSVG+gnrgpDHvW8l1+n+PA5eq3P7muX+0wMQlXl8NMI/5Dy32vubzYBLzBg1FEO8SR20WeD3no89cJegfrOZcuP/U8ViK3YM6ePNvRWwVRyl6qz6oHDtp8dGO8qV4dCp+xIlCDJKYQSZ7qAZGHfkDvm7ol1iGs4gWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UUvihcic; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUvihcic"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2A781DD2FE;
	Mon,  8 Apr 2024 19:44:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XZ1fbrOik9B/oWcZfWQRAeirPBZg0u2VQ7ceBi
	Dg6cg=; b=UUvihcicFJVpAblxkjY1dKWIsehTRnqSD172RtNCLT3qP6qmaFlPcW
	tg3eBSY5zHkA3sNZ46v7EeQSuD+IlRPRYqXqvVADJs/1GsAiUvvlFImr1ZwIzZCO
	SvHeDiDcfpQRUYrYjrlhu/22TbweQwMk8MsTu8qoTPEUq/Dgx3b38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA4271DD2FD;
	Mon,  8 Apr 2024 19:44:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 605801DD2FC;
	Mon,  8 Apr 2024 19:44:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Smith <psmith@gnu.org>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Dario Gjorgjevski
 <dario.gjorgjevski@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional statements
In-Reply-To: <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org> (Paul
	Smith's message of "Mon, 08 Apr 2024 19:24:16 -0400")
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	<9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	<xmqqle5n8rcr.fsf@gitster.g>
	<606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
Date: Mon, 08 Apr 2024 16:44:41 -0700
Message-ID: <xmqqcyqz5sie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F8C4AFD2-F601-11EE-ADA4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Paul Smith <psmith@gnu.org> writes:

> I'd love to do that as well but unfortunately there's just no way to
> get coherent behavior out of GNU Make if this TAB prefix is allowed. 
> If the original authors of GNU Make had followed the lead of the BSD
> make folks (or C) and used some reserved character to introduce
> preprocessor statements (BSD make uses ".if"/".else" etc. which would
> work) then we wouldn't be in this predicament.  But make's parser is so
> ad hoc that it's impossible to fix issues like this in a completely
> backward-compatible manner.

I wonder if you could ease the transition by leaving the current
parsing rule for conditional constructs that are indented with HT
and clearly mark them as "works as best-effort basis---the parsing
bug for them may remain", introduce BSD compatible .if/.else and
friends, and nudge the users in that direction.

Having to use two different indentation style in the same Makefile
is simply a nightmare, and that might be a good enough incentive for
users to move to the new "you can write with dots like .if and that
way you can continue indenting with HT".
