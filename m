Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A314F9E9
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794652; cv=none; b=kdaRFyfsPTjpYJcm2tvGKFvD+27K3GaRhlP05e4cnE0wJa/BcUA9a+4rKygWeCyxWjz94sMSsytSE3Dv1lbo0hFCzjQHxZgxcglU54aRXffOUlRfVUk6Ywfeihte0pDrD/KHtFSbPzGQZtsPVPn60QuRW4uFHhshrKCht3aCxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794652; c=relaxed/simple;
	bh=LvdAq90kiTG8Ffbs4xSVjzE3iLdYHcxkHoXgKAiIk7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ST8QgRnvi2OASV78Z11ERl2LuVF8VEnhkE1j0uIl5231C8GmVoYqKkTrNRCevGg3u9oCPsXQAVceJRc7t1xgsDaqrcbZwUjAOFqUsT2jU1GVL8HUVroOkqTl3c0DDZXBtjfFztvwOZp6q/rZDDJs/KUhLVVaUPO3fAMQgVp3gVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P4MBRzqE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P4MBRzqE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D131B2E0EA;
	Fri,  7 Jun 2024 17:10:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LvdAq90kiTG8
	Ffbs4xSVjzE3iLdYHcxkHoXgKAiIk7w=; b=P4MBRzqE6O5wDoclBCL/3mAz5N/N
	EJWKbMKbAplWNmNDaChZDYh4ARliWCHj2B/VrkOdoKoEuUHdxqsXa2j/qi0FY9Uo
	hlavbR/dSLaMHxS87vv4Ia0/r0LKzqr8nyiz3kwnImQy8JHxU0dETe1IGF8ZzgJ6
	2hzXxhDtjhdvZ60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CABA82E0E9;
	Fri,  7 Jun 2024 17:10:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E72352E0E8;
	Fri,  7 Jun 2024 17:10:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/2] format-patch: assume --cover-letter for diff in
 multi-patch series
In-Reply-To: <91014071-13f2-46d3-aae7-75c8ea036786@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 7 Jun 2024 22:52:53 +0200")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
	<cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
	<9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
	<91014071-13f2-46d3-aae7-75c8ea036786@gmail.com>
Date: Fri, 07 Jun 2024 14:10:46 -0700
Message-ID: <xmqqsexoe9wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 696467AC-2512-11EF-AE6F-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> This iteration fixes some tests introduced in the previous iteration.

Looking good.  Let's mark it for 'next' and merge it down unless
somebody finds other issues.

Thanks.
