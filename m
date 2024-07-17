Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515F1CF90
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246639; cv=none; b=o+HNM6J1Rw9htKGAL6kl4U5sqo89gr7TOoZfZ1okd6ZsqW6A9Yv0YVTSwH90s/EnNvxMJxi7uW67RUnZOLEZJa9TtFQC4OB6CnX7ujnfSdlxL3ZkJhGIq5EPCxIODvD7C+FLK9gU1gmTSMJnFTki+nMduqkRf92IpdZ3CaUwd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246639; c=relaxed/simple;
	bh=7OEZcTA2LqEd9Cpcltrxwg0RU+jKXhuUpkkyR8KAsJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MVuWwUQwq7ZNJEeqyEc5sCUs939shBxWV3hp7JQkld/n+4tGCSs+qWdkoP/ZNct94qhagqZhY218OBpChre18yf/QGJZCbsNGEKjVaiSMNGyd1SQhFaUCgfRFUvFqg8KOv69dSA/nZrrV1HAqURLU4KZRq/NhOoliC3S6OY8HnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bCoHEd5D; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCoHEd5D"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FE67192B1;
	Wed, 17 Jul 2024 16:03:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7OEZcTA2LqEd9Cpcltrxwg0RU+jKXhuUpkkyR8
	KAsJY=; b=bCoHEd5DD4t5kQNfS6amsyzIgEtBWnnx3IOmqd5vCOT73RoGid/vKJ
	m6wY92t6xgtefDydMTuUjQbQICj4hvTr2P4tmVq79mx7XoSAj6z2F+R+ajCVhlMM
	HiVBDlsNAKM8XK/r1tw57T0L9u4LdpI6u84y7nRCQU4ooTYB9coTU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95BC4192B0;
	Wed, 17 Jul 2024 16:03:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED3CB192A6;
	Wed, 17 Jul 2024 16:03:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <88f9256e-04ba-4799-8048-406863054106@gmail.com> (phillip's
	message of "Wed, 17 Jul 2024 20:39:12 +0100")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
Date: Wed, 17 Jul 2024 13:03:54 -0700
Message-ID: <xmqqfrs723bp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2982F38-4477-11EF-9A0F-965B910A682E-77302942!pb-smtp2.pobox.com

phillip.wood123@gmail.com writes:

>> -	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
>> +	test_write_lines P q |
>> +	(
>> +		GIT_PAGER="head -n 1" &&
>> +		export GIT_PAGER &&
>> +		test_terminal git add -p >actual
>> +	)
>
> That's surprising, why does running git in a sub-shell stop it from
> segfaulting?

Yeah, it indeed is curious.  

The rewrite resolves another iffy point in the original---you are
not supposed to attempt a one-shot assignment to the environment
variable when you are running a shell function, as that is not
portable.  And the above rewrite is a common way to fix that.

But still, yes, it is curious why the original segfaults.  Is there
some race there and having a subshell shifts the timing, or
something?

> My worry was that this would paper over a bug as we shouldn't be
> calling wait_for_pager() without setting up the pager
> successfully. How easy would it be to fix the source of the problem?

;-)  Nice to see people trying to do the right thing.

Thanks.
