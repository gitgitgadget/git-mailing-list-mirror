Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328438005A
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321679; cv=none; b=V2tOCQ4Aj1Lc/9MnctW4HMbBt/ruRxKW70CLDjSaowTkfdTHRCTBFl1GEST7fN3Ns/2l5x0chuXCiTSXFwf/rNpEiIx/G9IofyB6JAit9Ka0DRDvQg8QaxMxzl/7cZ9DMi+PW6qZtk7amwVlRSX5qKDCeZxr/TZ6ulSemCPm+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321679; c=relaxed/simple;
	bh=V/AL/Q96aYbX0S+JKn7A8jRpooTvORDP12sz93Vk6xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vt9rIGnkl7CROFHJwsN2FXIMzNuH/KsCM4wK6o19wdh+J8TFCklKHhMoSpzxAOs/lGtaNQmYx9P8o5YE2K5KvW8auwFIw9R6NRFvXNWzNCzdliAGhQtPftwD8KzQTxOFkvFwuF5/S0dMrkfxoio+Ecm9k3MkItSuNzUGSNL/f6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GsYPTkRX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GsYPTkRX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BF7BC2CA2E;
	Wed,  7 Feb 2024 11:01:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V/AL/Q96aYbX0S+JKn7A8jRpooTvORDP12sz93
	Vk6xw=; b=GsYPTkRXPHvWocxB0gW1ObKHZkVsqKgkonEDZZEl3RLD21qTXARYhJ
	IdMOcU0KkwGEdMFRdXvn6qv/Vq5JKZLPVxh53cw5PD/dx3R8QIl/56dykDVsPTdL
	+b8a5K2EB+hcNx3vIAzYUmdQ1s2Ixye7d3r1Ue8QVYpDZMKZb0/zY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B7E042CA2D;
	Wed,  7 Feb 2024 11:01:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 492C12CA2C;
	Wed,  7 Feb 2024 11:01:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <ZcM1wTrS3cqln8yF@tanuki> (Patrick Steinhardt's message of "Wed,
	7 Feb 2024 08:48:17 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
	<20240129113527.607022-5-karthik.188@gmail.com>
	<98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
	<CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
	<92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
	<xmqqle7xjzic.fsf@gitster.g> <xmqqr0hph1ku.fsf@gitster.g>
	<CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
	<ZcM1wTrS3cqln8yF@tanuki>
Date: Wed, 07 Feb 2024 08:01:11 -0800
Message-ID: <xmqqwmrgclh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E0E91F0-C5D2-11EE-80B9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> I also think that the reftable integration branch can go forward though,
>> since the difference between v2 and v3 of that series was simply that
>> v3 was rebased on top of kn/for-all-refs. So we can continue using v2.
>
> I've sent a rebased v4 that evicted the kn/for-all-refs dependency. This
> also allowed me to adapt to some fixes for the reftable library which
> have been merged down to `master` now so that the corresponding tests
> are now with `test_expect_success`.

Thanks, will take a look.
