Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3E539C
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913544; cv=none; b=YcS5YARftdD+VkUH1JpMA3niWfCbzygbelHifobFdm9KEUub6Xp7aqCJYfPe3HPSB9Vr4U1a0a7ktlbUx8vdsZ8bZTqX3rSr5oY10cI0NveIHIaIhaEO4IEkMXuWWIq6E/oJVDeqYY+GBUzWzymFbLmxKC9dD7JSGv9QqLnJ+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913544; c=relaxed/simple;
	bh=8oMEfUpvfJF6AColZSe+GzjJCOK2w/ltFV/Ih8nhihQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8KmjSZmY56f58cwcO6LfiOxWFGGAn6oOEdLJfM2U+6Hz7NO6FeLogFJrIGBeIPgOFKN3guZtUV/vfjj6LW6inFLCZyUIu+EvexGWEkugOJFJQJkj9o32sh7e3jPYHqrtyG03OGl5+hG1OgczU+Agva6GPnmpH0LEoD1TwkxB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AQK4/Ms2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AQK4/Ms2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 260C33036E;
	Fri,  8 Mar 2024 10:59:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8oMEfUpvfJF6AColZSe+GzjJCOK2w/ltFV/Ih8
	nhihQ=; b=AQK4/Ms2t0C073RwgEVHCMCIr5LUllPhKw9T2F4j/j+bOxGHQui5SF
	ORsBvfvb4T60z3CMadXbpvUCJR3YedoCiK2b1CWyH6q5W0+qulgaNc+iYDD/+aXm
	8A0Ml18L+wjBA6XXhN3YdjKfcoVl9ea58tsLDwUUrz67x6B5b8wwI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E35D3036D;
	Fri,  8 Mar 2024 10:59:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B7B33036C;
	Fri,  8 Mar 2024 10:58:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,
  git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Manlio Perillo
 <manlio.perillo@gmail.com>
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
In-Reply-To: <d82e11f2-15c1-4ecb-8c7c-19667d2c5fb4@gmail.com> (Phillip Wood's
	message of "Fri, 8 Mar 2024 10:17:37 +0000")
References: <20240307091407.GA2072522@coredump.intra.peff.net>
	<20240307092638.GK2080210@coredump.intra.peff.net>
	<3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
	<d82e11f2-15c1-4ecb-8c7c-19667d2c5fb4@gmail.com>
Date: Fri, 08 Mar 2024 07:58:54 -0800
Message-ID: <xmqqfrx0hg01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C4F4AEA6-DD64-11EE-B626-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I agree with your analysis. I do wonder though if we should reject
> whitespace and control characters when parsing core.commentChar, it
> feels like accepting them is a bug waiting to happen. If
> comment_line_char starts with ' ' or '\t' that part will be eaten by
> the strspn() above and so starts_with_mem() wont match. Also we will
> never match a comment if comment_line_str contains '\n'.

Another thing I was wondering is what we want to do a random
byte-sequence that may match from the middle of a multi-byte UTF-8
character.

The reason I haven't mentioned these "nonsense input" is because
they will at worst only lead to self-denial-of-service to those who
are too curious, and will fall into "don't do it then" category.

Also, what exactly is the definition of "nonsense" will become can
of worms.  I can sympathise if somebody wants to use "#\t" to give
themselves a bit more room than usual on the left for visibility,
for example, so there might be a case to want whitespace characters.

>> Not sure why lines that start with CR are considered comment lines,
>> though.
>
> I think it is a lazy way of looking for an empty line ending in CR LF,
> it should really be
>
> 	|| (bol[0] == '\r' && bol[1] == '\n') ||

My recollection matches your speculation. 

IIRC the lazy persono was probably me but I didn't run "git blame".
