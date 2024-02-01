Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F53127B43
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815273; cv=none; b=CJ1kYS71QmZhCuN9V+WeJ4P+SX1QRv3oHGKUxx/7yYnNTzpOtXshDXZK1qMa7gJK3pc+joRFIDhzhxiE/GqpjpnPJPo+7nsrfpD7ir3ImoMu5MJOBKQ8oIf1zT5r3GAhRjeY2oUMaJe3Rkgps2CLNspJuoOO6KcPdAOPOaEfEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815273; c=relaxed/simple;
	bh=1sRjJL6hCPbLq84D9OJQHDQpcgeNJYUfzALPh79BFM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onkxKkcvbw0S75sgr0KYIj0nrFbHhnnd5//XzakSG+7z4sxTjBk40BcAs2aLYSMDq0e5zSBQ6HVxecDzdl7yVfbMiQ/IUL0e6qf2CpKbXrzvhFQCpfyHWlISlqC6jtH4FCkOgXC8MTSXzKiJas/LsMU72qbQFGc8QWNdEKkGpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LixhWiWi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LixhWiWi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68A961BC133;
	Thu,  1 Feb 2024 14:21:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1sRjJL6hCPbLq84D9OJQHDQpcgeNJYUfzALPh7
	9BFM0=; b=LixhWiWiRBaM9S25+tB7ShTTDsM029Mha7PZkLF2rm1p557/vCAcrN
	gAkI2zWORpBlecI2BwUk5MA+JVhiX69zCCkzwqxn3wLX3MME4FCo5FmmVqrfHJwK
	igUrSjQdiHXHpNKC1mW/sRiFEHEPIDnUEOSfhEjFQJg6qi3Cl6fMo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CDFD1BC132;
	Thu,  1 Feb 2024 14:21:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14E051BC131;
	Thu,  1 Feb 2024 14:21:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <owlyo7d011no.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 01 Feb 2024 10:26:35 -0800")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
	<xmqqy1c545y0.fsf@gitster.g> <xmqqa5ol409k.fsf@gitster.g>
	<owlyv879106s.fsf@fine.c.googlers.com> <xmqqfryd2drm.fsf@gitster.g>
	<owlyo7d011no.fsf@fine.c.googlers.com>
Date: Thu, 01 Feb 2024 11:21:05 -0800
Message-ID: <xmqqa5okyori.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D0A0302-C137-11EE-82AC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Linus Arver <linusa@google.com> writes:

> I am planning to spend today trying to break up this patch into smaller
> preparatory chunks that still end up at the same state as this patch.
>
> Will post another update on how this goes by EOD. Thanks.

I stopped reading the function after noticing the double unfolding,
so there may be similar "why do we do this unexplained new thing in
the function that the original didn't?" issues in the "same state",

In any case, if I understood your plan I heard from you in the
discussion yesterday correctly, the unfolding should not be added to
format (to make it double), but would be moved from parse to format
in a single step.  It would avoid making it double, and would make
the parse step about purely parsing without modification, which is a
very worthwhile thing to do.  So I am not sure if we want to end up
with the same state in the first place, though.

THanks.

