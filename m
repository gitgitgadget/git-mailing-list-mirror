Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064912E7E
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441698; cv=none; b=YCa9OXf0B39BiVSqd+PhAh8o16bwigop15JdhK4v2imsBu9sX2B+hHuAiN9ixjwGizUG4DosaBefNBLlq/cGBlDjb0/L2sglzTKbcz5ThTmY4/qWNhgoa48kS5S+edfry4MjO+Aq6evIHoUG99Wkhwa1/gAAeIGnGVlomHqEBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441698; c=relaxed/simple;
	bh=PESJS9FmR83Vi9fJPiphxLwmHvMHZRJpRq6kcucE+X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qm5zfrcXYvUwh6ow1jlxxavm1pWGRXqdAlaRnpiS7tRrJMlDjPhj8IoMYrXneDR/4HFkobYDbP8DAmEEqCsCJUsYwxp2nSHt3wFcGXeS3yh1dX9hgnIOx3T099NwfwASpSDeQ1pvXlPK5I5nv9c5Sw42UyOjgKnX7lbJF0vwTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ga2AoRrO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ga2AoRrO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AE7391C68C;
	Wed, 31 Jul 2024 12:01:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PESJS9FmR83Vi9fJPiphxLwmHvMHZRJpRq6kcu
	cE+X4=; b=ga2AoRrOUIVYvvQSyTJImdzD0Ooebhi/80+m4FKpBNyU6JM5bmdPQa
	oCP/f1z3txsmn1OruYaBv5QcyCTYAA6ishSOts4JRZI3VT2sr9aWIR1p8EdgOWjU
	oFm/YAntbsLHcDgo4UzmB2qrom2nx78+0YuMOVMOnI9vMUSQtpI0Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A59DB1C68B;
	Wed, 31 Jul 2024 12:01:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C43F91C68A;
	Wed, 31 Jul 2024 12:01:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] Introduce a "promisor-remote" capability
In-Reply-To: <20240731134014.2299361-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 31 Jul 2024 15:40:10 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
Date: Wed, 31 Jul 2024 09:01:25 -0700
Message-ID: <xmqqzfpx7dpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 246550F8-4F56-11EF-82EE-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Earlier this year, I sent 3 versions of a patch series with the goal
> of allowing a client C to clone from a server S while using the same
> promisor remote X that S already use. See:
>
> https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/
>
> Junio suggested to instead implement that feature using:

I actually do not see it as "instead".  The end result would be the
same when things go right.  The only "instead" part is that a protocol
exchange gives you a chance to make sure that the server can tell that
it is OK to omit objects available elsewhere and the fetcher knows
about it, instead of letting the server blindly assuming that it is
fine to omit objects.

> This patch series implements that protocol extension called
> "promisor-remote" (that name is open to change or simplification)
> which allows S and C to agree on C using X directly or not.

;-)

