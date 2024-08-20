Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1661AD9D9
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172958; cv=none; b=FULAlSuQAraiA8okmTXcH7NdnxIPwH2a5brQARNq80nTeTLIr41/q/48e0GQfaDPEtlWHRm98Y60hofZZcoMqy+SMVEh5fKY7+AIHRDCfNgrmcjn5MxjKPRU+D6rIZUo0P2FDrYC64Mxe01bOuKskS1trXQmihSckAXOcHOKnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172958; c=relaxed/simple;
	bh=qWuN4R9BzMIpqn7BOQ0IM8TksZQ6m/4Ec2VBNJl90BY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KDRPrUyjEcxnmbXY3m6j/hkpYEr+Vz5qdU1cx68HxMWJvNBL++DNQOxY3MFCEnZwBat8VQDhEvHLu9hWU6BnwpiE/wpg+6UhciT7r00Svw2gNmwgfpwoVcwsE2VQgSBVzh8KaFCkhsmXovLWYRx6Jzj/KfZX5fPI+m2LggBJck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BT25W1uq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BT25W1uq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 34A7218BCE;
	Tue, 20 Aug 2024 12:55:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qWuN4R9BzMIp
	qn7BOQ0IM8TksZQ6m/4Ec2VBNJl90BY=; b=BT25W1uq17YiMpbruD+BznjTl6cu
	bDmQlgK6zggVG4KJ5Go5cIo2qNDocrvuRARvpZrFRMlvZY9UMIs4ZJ1rMCDGcvtL
	jAUPYjF4ExCnFuzShAG0PUTh9ziNO+i5VyR02euXo/09ka099gjeCO9TDHBkotoS
	Btgi/WdAg10oxlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CD4418BCD;
	Tue, 20 Aug 2024 12:55:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 960E518BCB;
	Tue, 20 Aug 2024 12:55:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <CAP8UFD2OR=5QvyFT6EGQkekFBtjRWoMShQ=_eT=ypH=FswUaRA@mail.gmail.com>
	(Christian Couder's message of "Tue, 20 Aug 2024 13:32:30 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-4-christian.couder@gmail.com>
	<ZqpjV/A9ZVPDiGgA@nand.local>
	<CAP8UFD2OR=5QvyFT6EGQkekFBtjRWoMShQ=_eT=ypH=FswUaRA@mail.gmail.com>
Date: Tue, 20 Aug 2024 09:55:54 -0700
Message-ID: <xmqq7ccb9lr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 11055372-5F15-11EF-8C33-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Jul 31, 2024 at 6:16=E2=80=AFPM Taylor Blau <me@ttaylorr.com> w=
rote:
> ...
> I am not sure how NUL bytes would interfere with the pkt-line.[c,h] cod=
e though.

Heh, you had 20 days to compose this response, which would be
pleanty to see that pkt-line.[ch] is about <length> and <bytes>.
After all, it is used to transfer the pack data stream that can have
arbitrary bytes ;-)

