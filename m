Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90967A48
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701869; cv=none; b=q1ko71dxREBIwum2Mn0Y1ODPFRkQEr/e+jWdrWrVdbiEsbA9n5vsihwgCul+Pjr93atYxzj4Lrb+fPWVbSu5Ui6DuvsOgURzIvzsbIo3bM6H4oEnIeMVzG5IgyQ3kTooiC9GE8Kwh80zFppvMF2V8xt3VLftZoELTNLhE7NSLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701869; c=relaxed/simple;
	bh=3/iNAl439s3W9EEerauOs/FU0DKOSIPpv3hFDvfIroU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dh3hvXjEhp+zmpqI28Aidvg0DZRxU3a9WGiYX2AtOehDqVn3hit4LHt4imZWg3G94rtfg1QYCyCK2Fah+/8Mdhaxapw+zS26YgOdtfOA3D4YicV7lruhcovrF94VWUDUv5Ph/R2ZQZUDhMRGS1er8UzxW+O7K71QT3r4F1RG48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i7ZSc9PK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i7ZSc9PK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5568725A03;
	Mon, 22 Jul 2024 22:31:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3/iNAl439s3W9EEerauOs/FU0DKOSIPpv3hFDv
	fIroU=; b=i7ZSc9PKNuBGBPgBFEQwqTgVGn7rEUaRbWS+HCxs4B1J7bhn1ejE/z
	Ib1EoFihGysLs0zCx0CQfMeZdeHtQdVEqnOblWB4dC4UnO1nL9M+mKHUbYDNZ6QQ
	0CNjcYqlvCmVd8JAFo6WVdtcll4FgcnKweyNwsq6RIenhIdreO3Mc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C1D625A02;
	Mon, 22 Jul 2024 22:31:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D4B925A01;
	Mon, 22 Jul 2024 22:31:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,  Jeff King
 <peff@peff.net>
Subject: Re: Re* [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <CAO_smVhd4LY_F0Wgt1CfsidFAB1n_8Rv3sXaBCgrCuOVMxS5cw@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 22 Jul 2024 16:12:21 -0700")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
	<xmqqv80xcpe5.fsf@gitster.g>
	<079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
	<xmqqa5i9b51m.fsf@gitster.g> <xmqqbk2p9lwi.fsf_-_@gitster.g>
	<CAO_smVhd4LY_F0Wgt1CfsidFAB1n_8Rv3sXaBCgrCuOVMxS5cw@mail.gmail.com>
Date: Mon, 22 Jul 2024 19:31:04 -0700
Message-ID: <xmqq4j8g6dqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C9FC966-489B-11EF-AF54-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> I was also able to reproduce both aspects of this behavior (doesn't
> export, value is retained) with ksh (sh (AT&T Research) 93u+m/1.0.8
> 2024-01-01), which is the current version on debian testing. So maybe
> "some versions of ksh (tested: 93u+m/1.0.8 2024-01-01) and dash
> (0.5.10.2-6)"? Or maybe we move the 'some versions' around, because I
> think it's probably all versions of ksh :)

Makes sense, but I think "POSIX guarantees that the behaviour is
something you should not rely on by telling us that these are
unspecified", which you found,  is a much better rationale to
explicitly forbid "VAR=VAL shell_func" construct.

Besides, as another thread recently discussed, our test scripts,
with really heavy uses of "local", do not work at all with AT&T ksh
(other ksh clones are reported to be OK, though).  So it may be OK
to write it off as "unusuable to run our tests", at least for now.
