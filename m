Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3164CCC
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667919; cv=none; b=nBIfYeypHE1RcIbmEMoMJdrcmHMuePIjpBjewKQLqIWm6FUrdszEkNhAiYQPrbdGHU1CNO/plbiJEuvAKHiIHEgeKZvCt+3cnDfh/PMrCtg0DW0ntTVpnISId7qxS3mQXivbSQXdKO1Fg8NtowsrANezqQbYj+JaRxcHae+O5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667919; c=relaxed/simple;
	bh=9OiH2SOeNJ+od0DBub6h6HB7VERv2UkURlbBGEZDi+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aedLcQVkWSKgbgWYHTItsWB0Vmd/wpWOCEHXfBwy/weBdkoATMzeigerfvUDSO25xEJ+YYVJAk1kW8USjC6HDURSKErUIDUKUCqd3EikrzoXAZyxWkAAzTNMVTXIxroj6imPg2OfWX5tBgDq2GzJsjYjZiY3LtBFI4IRNY0yWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R9Hsgwz2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R9Hsgwz2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A1F621AC2;
	Thu,  2 May 2024 12:38:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9OiH2SOeNJ+o
	d0DBub6h6HB7VERv2UkURlbBGEZDi+I=; b=R9Hsgwz2wGcWaUcvyzpc2zdkgVY+
	q2vu38LilRZ/2rlbP0MtxbxNHWghdedr9lhQ6Jt30SFKWLS87mweA8uubagEs8Zk
	+o/W7zxxcL1vlypkGM7DGYgeKqQHdFne8iZb+dfthjFzjuob+Mb44JV9ZYNZ5izp
	C8XmU/RbgHMFbm4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8215621AC1;
	Thu,  2 May 2024 12:38:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAB8821AC0;
	Thu,  2 May 2024 12:38:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
In-Reply-To: <0dc1f9f9-02ec-4394-9c25-7a7fee6147ee@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 1 May 2024 23:13:03 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
	<10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
	<27fbb12a-f2d2-459c-a27b-519f69242105@gmail.com>
	<ce11355e-25f3-4d76-91ae-bd561143dd49@gmail.com>
	<7a3fcf9c-a70f-47e8-9624-40b407f90242@gmail.com>
	<xmqq5xvx5x1u.fsf@gitster.g>
	<0dc1f9f9-02ec-4394-9c25-7a7fee6147ee@gmail.com>
Date: Thu, 02 May 2024 09:38:34 -0700
Message-ID: <xmqqcyq4f9th.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6BE71F6A-08A2-11EF-B245-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> But I'm not sure and I do not want to send a new iteration unless it is
> necessary.  I was already happy with previous versions ;-).

Let's call it done-well-enough and merge it down.

Thanks.
