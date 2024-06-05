Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B439481B3
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602007; cv=none; b=fimHJmjizd7mt99sV3LzLTOkndQbgxS5vXZ9HqVYJFUwsiOLc8+/sj7DTJD2ryrTUJigYV/tULokFLQtuKSkFa0C5HYUZbspjpz4jKsCNPf7Yk9gPJd+PjwIiXkQ9NiF+ipX6XWF6NLLFr+fvDmiLNt8oOQDah8ea1wOLeVXTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602007; c=relaxed/simple;
	bh=YRooPe0GWdXr19Q5FA/GsPj7GPZHg92yRwoRpVDKg0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oghiJljmG41tZGZlV6Wf9A7QHyUhiGAvuK+1KqEdoyLXCvQwd/1kqi/vugBg0zdbsr3jO04irQ7S6GvMiE3id6jo3ZCxfCMr8j84ej1o3RHOwIaNegXspTYP25A02AhTbjB6VzHu6Jq6unEeZo3HBCvWjt763oxY8ZM4DIgiLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dnr0h7y7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dnr0h7y7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 18D081AA40;
	Wed,  5 Jun 2024 11:40:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YRooPe0GWdXr19Q5FA/GsPj7GPZHg92yRwoRpV
	DKg0Y=; b=dnr0h7y7Vkxm1JNMp6ikeqXruPI+ulQfhDoe8ckGrONalzpDun66XG
	bztWoMLAnnQ92/2lOFn+tmYKuHYMpD90usIH0T2qfXMgo7/dOehlwq4KQcT0ZD3x
	2fh/QPqzWrjglN+bcp4fzwFzR3WrheE8GkmrDRsu6JwJwaDSr7nhs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 10D751AA3F;
	Wed,  5 Jun 2024 11:40:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2183F1AA3A;
	Wed,  5 Jun 2024 11:40:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
In-Reply-To: <20240604103305.GB1781455@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2024 06:33:05 -0400")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
	<d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
	<600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
	<20240604103305.GB1781455@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 08:39:59 -0700
Message-ID: <xmqqfrtrxusw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DEF2F6AE-2351-11EF-AF43-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> IMHO we should consider getting rid of it entirely. I think the only
> thing that uses it is t4153 (AFAICT it is luckily not racy because it
> does not actually read stdin, but only checks isatty).

Sounds like a better approach than piling another workaround on the
test helper.  Reading the old discussion, we seem to have been in
agreement that we generally do not have to insist reading from a tty
and certainly the "add -p" codepath is not one of those "if your
other payload must come from the standard input, your instructions
to specify how to handle that data needs to come from elsewhere, and
that is /dev/tty" cases.

Thanks.
