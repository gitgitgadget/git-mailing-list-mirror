Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65AFAD2C
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508499; cv=none; b=nrVGh1xEUNYJt2I1cMqPCl3oMlJMH91qH7n1SyB2+3LTDw0jTr1os0GsIxVUkjrefbhY0s+X8DBAL/oyA+WyKNkQM2oeiQvKwznsZCAEXtZOfDO8pGT1BgjTRhv31s3V92WzKM2YUccW511zqx0cdCKZU0WJE9cPMx7FCAS9CH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508499; c=relaxed/simple;
	bh=g3F/ElCCuA53QIrdqiiMdlmuPkpsqqITyuQRD0JTY8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8+JXc7jQ3WkgeWkC/8bVoh+9xy56pOuft12wY80V4TqM7FXa0/K1DjfIISkV9U0ZQhV0rwDyWi+iEa9qFPpaDkOW4s2gcfAkkaUHKihb7RhJpMg6rLN9PA21/4YB/BGEtiZm1DtYk4eEVQ8VTYRqIJfJfdeNhnDArDZe9wcaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BmFqu08P; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BmFqu08P"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 353CD23D40;
	Thu, 23 May 2024 19:54:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g3F/ElCCuA53QIrdqiiMdlmuPkpsqqITyuQRD0
	JTY8Y=; b=BmFqu08PTWjjNQRxVvP50yjDZd6/XM3qccz5DA7HxSZ3R3Xaa0X9gf
	B49ahD1SJRBPJwZZqpAnt8nItEemBQ5bGCEbidEGwPlGo5aKEd0tg/KqIfyMWzbj
	RHaB9bBPyUNMjCUJwrf9p+annlWMxmUlcmGacq4Ajbgt0zkxpWKgY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D9B923D3F;
	Thu, 23 May 2024 19:54:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 749F423D3C;
	Thu, 23 May 2024 19:54:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <ba1c6fbac4424a4e2c68cb439f9918eb@manjaro.org> (Dragan Simic's
	message of "Fri, 24 May 2024 01:28:30 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
	<xmqqh6esffh1.fsf@gitster.g>
	<ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
	<20240521070752.GA616202@coredump.intra.peff.net>
	<5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
	<20240523090601.GC1306938@coredump.intra.peff.net>
	<xmqqjzjky6eo.fsf@gitster.g>
	<261636d461e58ac8a16180c4cd6e0460@manjaro.org>
	<xmqq7cfkqger.fsf@gitster.g>
	<ba1c6fbac4424a4e2c68cb439f9918eb@manjaro.org>
Date: Thu, 23 May 2024 16:54:52 -0700
Message-ID: <xmqqjzjkozhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9976682-195F-11EF-9BF2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-05-24 01:04, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>>> And for usability, perhaps giving a specific command would change
>>>> the default program a bare 'P' invokes for the rest of the session
>>>> until another specific command overrides.  Another usability hack
>>>> may be "[interactive] pipecommand = less -FX" configuration variable
>>>> gives the initial default for each session.
>>> I think that would be way too complicated.
>> It is modelled after how "less" and "vi" remembers the last pattern
>> fed to their "/" command.  You once give, say, "/test_<ENTER>" to
>> find one instance of "test_", then "/<ENTER>" takes to the next
>> instance.
>
> Huh, less(1) actually remembers nothing when the secure mode is
> turned on.

Are you sure you read me right?  I wasn't talking about storing
anything on disk for the "usability hack", and made it explicitly
clear with "for the rest of the session".
