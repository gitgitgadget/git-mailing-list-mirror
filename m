Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410161859
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009545; cv=none; b=TkgsgHnyiRXebfgxtoPyRvabk2dlsesmn7KM/oDRJ9oEac9rGS2T9oZQr/mPSwD11kRAGJviwt3PetLk0Q2r+PHMX4ZD7F8+fK1DtArWSz4xLun4l+u+z0ewrLhmVWoMForP7gqrTUPZRittqBWQ5KFbH8myz8OCqGrjz51mTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009545; c=relaxed/simple;
	bh=UWRH6YgIi75T5GxF2I2fFZDxmVs6t1azpwjgNVXlBRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPgA+5+l8Ke7I+FANjtWrIqVPxUfq6ef0kxrLetyi1h+wBiyKoRq7sGGXk/A5K0X3xmuWc6vkCYiX6Fkp55qCLJdAkzzEb1cnFCvx/iqS0F72Rx97JEuITaFduPzQRUJaOM4Lvp72A+fvUAiDkEXyx5KiHcAzhWOo2ui8zMCdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gQY/fPkt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gQY/fPkt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CEF3303A8;
	Fri, 26 Jul 2024 11:59:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UWRH6YgIi75T5GxF2I2fFZDxmVs6t1azpwjgNV
	XlBRk=; b=gQY/fPkt0bX7V9USTo+DidpxdzXD40Il3zL182Wb+1G1hJ/W1Dn8bl
	GkLUQce5Jnpvz/5flsxxAdReBar/ofNLKwsoAj269aeABjE0fO0PkfTmXiT1HT1P
	PRjcApBycRdM0CMuKVp0Byw5lMAfnK3i3BM335auzr56bezuSG91A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED411303A7;
	Fri, 26 Jul 2024 11:59:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FD01303A6;
	Fri, 26 Jul 2024 11:59:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kyle Lippincott <spectral@google.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,
  Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
In-Reply-To: <ZqOc9vxdD4qttkFs@tanuki> (Patrick Steinhardt's message of "Fri,
	26 Jul 2024 14:56:22 +0200")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<73465c3d-1be0-456b-9471-f875e819c566@web.de>
	<c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
	<CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
	<xmqqfrrxjw8f.fsf@gitster.g>
	<CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
	<xmqqv80szxgw.fsf@gitster.g> <ZqOc9vxdD4qttkFs@tanuki>
Date: Fri, 26 Jul 2024 08:59:00 -0700
Message-ID: <xmqqed7gxhyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA2D6D80-4B67-11EF-91CC-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> As I said when mentioning how libgit2 does it, I'd be happy to present a
> working prototype for this if others think it was potentially useful.
> Until now I didn't hear any positive feedback thoguh, you're the first
> one saying that this might be something that is worth doing.
>
> I just want to avoid wasting time on something that has no chance of
> landing in the first place.

It takes such a sizeable effort to make it pleasant to use the
TEST() thing, it becomes somewhat questionable that it is worth the
effort.  What I was hoping to see was hinted in the part you did not
quote ;-)

If there is an existing well-written framework for C unit tests we
can apply to our project, it may not have to be so much "magic".  If
you think theirs is not so good and worth copying, then let's not.

Thanks.

