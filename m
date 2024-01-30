Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758758612E
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630522; cv=none; b=gFJiH3Bll1tB3gHiT52HYiO3q9Lerc29v0ZTNa3GU1xxEXnpDVTVMSDrqLzTytNOR1wRUyPHzioOII38mpCn9n1VN3LJgwn64pJqtwLIL0RFWJscJyEn6OXYw7fMMRjuIID0CbAYpLDcX2TSDP1fHCr8+b5Lb0Q7nVjE9CYV5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630522; c=relaxed/simple;
	bh=xoMClEzvzXzZHDBqzo1hF6+ocL+fRrAlAR4fRYk6EX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ol6A2Pon/hvaefKZrde7+O74X6j1evA9HjNIkwpkgeM6xZWtva6iBUJeFZCe12z4ublPVwkDrr4BEGr2nzNpTtk98P9Vc2hj+H5Ivlckdsi+aOLP1f9hRWBxYmUPkhv4XQxGqJy4zAv+dOS4inhkO4jms2lyMJ7UkqvM+H2E1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oldrfW8b; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oldrfW8b"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 019DE1DFE9A;
	Tue, 30 Jan 2024 11:01:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xoMClEzvzXzZ
	HDBqzo1hF6+ocL+fRrAlAR4fRYk6EX4=; b=oldrfW8bcMPlR3XSDofNvMXU+kkV
	n3r+FGryq6CVflrVcKLogYy6AJQ2/8LTgD3lj71/rvBB9UgcC0pmKYvmh3GZa1cA
	xQVxlOUKT+Ybsvm59wwq6VP9K9iaFXz8QTxC8wySzyeFluWq1D8Ec15qDLFcK4bi
	r7P7pWYnkmXOrDA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDA191DFE98;
	Tue, 30 Jan 2024 11:01:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B8A61DFE97;
	Tue, 30 Jan 2024 11:01:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] mark tests as leak-free
In-Reply-To: <20240130055448.GC166761@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jan 2024 00:54:48 -0500")
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
	<20240130055448.GC166761@coredump.intra.peff.net>
Date: Tue, 30 Jan 2024 08:01:57 -0800
Message-ID: <xmqqr0hydd3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E59F1424-BF88-11EE-9CF5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Mon, Jan 29, 2024 at 10:04:10PM +0100, Rub=C3=A9n Justo wrote:
>
>> The tests: t0080, t5332 and t6113 can be annotated as leak-free.
>>=20
>> I used:
>>   $ make SANITIZE=3Dleak GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GIT_TE=
ST_SANITIZE_LEAK_LOG=3Dtrue test
>>=20
>> Rub=C3=A9n Justo (4):
>>   t0080: mark as leak-free
>>   t5332: mark as leak-free
>>   t6113: mark as leak-free
>>   test-lib: check for TEST_PASSES_SANITIZE_LEAK
>
> These all looked reasonable to me. Thank you for not just fixing them,
> but including the background for each case (e.g., leak-free as of commi=
t
> XYZ, etc).

Yup, the background description was very useful to read.

Thanks.
