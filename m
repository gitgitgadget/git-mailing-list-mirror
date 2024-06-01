Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEC2D61B
	for <git@vger.kernel.org>; Sat,  1 Jun 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717235014; cv=none; b=FeL5ofLOaEA1vig0wAp1fS2PjZR0M7sNpHs6qf83EraMyeq74hWkwblw9IhNWwg3XsXJ/g4F0Knzh7hQvxVZuOfhz16L3HlZIqYhgbiqLwQ48xAaxLBdaxj0vR/UrVJUDyFh4BEC+MyIbFh5H8Fm6+kaI9k8YQyJoiyIr+GHqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717235014; c=relaxed/simple;
	bh=H+eP1la8Qb3k40ZycONw3rhzBQCpCuRdlHTGZIm42nM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bErSuQlTdCsGFmvTUGX9GtJch4CdrRIjdK/CxO/tfFGOzidjTzQw02hiVLqhAkAUZFEdQfuVR4r/x/YT2EWJqUO2d130k0vx0Q1t4ZXKddREVkC9Pb1v9ml03dJlO7R7RG3IGQALAr/aJnbs2NASjLo7cUriNT73Pb+cAZe4qp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mJZCMjhs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mJZCMjhs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C81CE19A9D;
	Sat,  1 Jun 2024 05:43:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H+eP1la8Qb3k40ZycONw3rhzBQCpCuRdlHTGZI
	m42nM=; b=mJZCMjhs0HLGVzaguMNd1zYi/m/jOEspLu03C4RnhrOrxaP3rgSS4j
	m4ZSySuxyUPRQRxhWSVLe/YsMdzTEqgmjPnPUdMi7cOa2gXa10bKuCcBEWHHaFxI
	iWujFGf2I6sYWtVu3WI3GvV+YwdYo6b10tLLJnZxUmhPwuPIV1R60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BF90419A9C;
	Sat,  1 Jun 2024 05:43:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCFA319A9B;
	Sat,  1 Jun 2024 05:43:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
In-Reply-To: <CAP8UFD18Y=NhnnzcHoBOiO7bu_VrxnHOeLgUeqiADQPcgtMW=A@mail.gmail.com>
	(Christian Couder's message of "Fri, 31 May 2024 22:43:33 +0200")
References: <20221012135114.294680-1-christian.couder@gmail.com>
	<20240515132543.851987-1-christian.couder@gmail.com>
	<20240515132543.851987-4-christian.couder@gmail.com>
	<xmqqv83fvw7p.fsf@gitster.g>
	<CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
	<xmqqjzjikhdz.fsf@gitster.g>
	<CAP8UFD1_aHwbhF12v-miCTWEbbgjtpjTCmkRmFHu4Vusezq6dA@mail.gmail.com>
	<xmqq34q27wzg.fsf@gitster.g>
	<CAP8UFD18Y=NhnnzcHoBOiO7bu_VrxnHOeLgUeqiADQPcgtMW=A@mail.gmail.com>
Date: Sat, 01 Jun 2024 02:43:27 -0700
Message-ID: <xmqqwmn9athc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 66881F40-1FFB-11EF-8D9A-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> Hmph.  If C asks a partial clone and S is willing to be the promisor
>> for C, S is essentially saying that it will serve C any objects on
>> demand that are reachable from any object it served C in the past,
>> forever, no?  It might not get from S initially all the objects, but
>> if it wants later, S promises to let C have them.
>
> This promise is not broken, as S can still get the missing objects
> from X and then pass them to C. There is even the following test case
> in the patch that shows that it works when uploadpack.missingAction is
> unset (and thus default to "error" which is the same as how things
> currently work):

And the whole point of that configuration is to make it easier for S
to break that promise, no?  uploadPack.missingAction is set at S and
is not under control of C, right?

> So S keeps its promise to let C have any object through S if C wants.
> It's just that having large objects through S (instead of directly
> from X) is not a good idea ...
> ...
> So if it's Ok for other features to require an additional server to
> fulfill the promise, why is it not Ok in the case of S + X?

I am questioning the design that does not give C any say in the
decision if it is a good idea or not to ask S relay large objects.
S unilaterally decides that it does not want to and does not serve
such large objects to C, and without even checking with C if it can
reach X to fetch directly, silently assuming that C will do so,
right?  It is quite different from the contract between C and S in
the simpler world.

> I don't understand why you compare this to a "broken" implementation
> of promisor remotes. What could then be a non-broken one that would
> store large blobs on a separate server in your opinion? I am really
> interested in answers to this question. It's not a rhetorical one.

You as S would tell C "I want you to go to X because I am not
serving objects X and Y".  Or at least make sure that C knows about
X before deciding to omit what X ought to have.  Not doing anything
and silently assuming that C will get them from elsewhere is simply
irresponsible, especially if C is not even told about X over the
protocol, no?

