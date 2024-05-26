Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550E2F46
	for <git@vger.kernel.org>; Sun, 26 May 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758822; cv=none; b=iiL2DWoqovtIwpcN76WkLAt5LUTrriuzcUJFTV/YkSaHg7qCbHSK2SsNhyxv5bBkZxqZai1QnQwOudd6BlxeJM71IIxXB9+7fbnoNjZ8RvASA7Zl2Bhyp3z6DROPGV04ebXOewSbd6CMmfZohJe5tebbFeuNGlQtn8jwdU7UtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758822; c=relaxed/simple;
	bh=9qCdxfO0dY6g6lPpo2BkuH/hWmtc5PQjYtErWuqt3KM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bu/b9U2IKV4UKBkK2lcB/g3xqBhkMZsAAt65vKRgH36/a/Pfmy4UYA0wRRB80DHhzPJY0/25Xvz4El7io/eAa0JyxRvzf943yApirLgCtLMSSjwTC/FTcPD0gX3f7EY1LdaW6jHTQ3+Bjpx8u5g1np+NSFkgIWkgk50U/nCaIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCeVcc4k; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCeVcc4k"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D910C2C4AD;
	Sun, 26 May 2024 17:26:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9qCdxfO0dY6g
	6lPpo2BkuH/hWmtc5PQjYtErWuqt3KM=; b=nCeVcc4kxuw6CTUyk39O654+ympR
	g6SIg1i77hsQsEcXEsbvMci3Sl2B9t8H2hGoFumRR/NqK1jig8bVXtW9FVUJNn5P
	bq4cLm/terLsNL27CAK5MGWHtEK0cj1j8CKWq/wXb21x4b49GsIrBtmCnV+o6ebZ
	24aKm34pLdS4+Ds=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D09F82C4AC;
	Sun, 26 May 2024 17:26:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41C212C4AB;
	Sun, 26 May 2024 17:26:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
In-Reply-To: <e6c4dc8f-ffbf-4749-8086-22c29da768a7@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 26 May 2024 08:48:55 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<80f15223-246e-4cfb-a139-e47af829c938@gmail.com>
	<xmqqo790fg8z.fsf@gitster.g>
	<a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com>
	<xmqqwmnm993k.fsf@gitster.g>
	<0574914d-8088-434d-8db2-013c1abe27c3@gmail.com>
	<xmqqikz6966t.fsf@gitster.g>
	<501a610c-550f-45da-a311-d4c941ae4870@gmail.com>
	<xmqqa5kh68zh.fsf@gitster.g>
	<e6c4dc8f-ffbf-4749-8086-22c29da768a7@gmail.com>
Date: Sun, 26 May 2024 14:26:51 -0700
Message-ID: <xmqqfru4e02s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AB383778-1BA6-11EF-A715-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Wed, May 22, 2024 at 10:40:18AM -0700, Junio C Hamano wrote:
>
>> Not really.  The name "old_fd2" strongly implies "where did fd#2
>> come from?" and it did not come from fd#0, did it?
>
> Perhaps "close_fd2" is a better name?:
> @@ pager.c: static void close_pager_fds(void)
>   	/* signal EOF to pager */
>   	close(1);
>  -	close(2);
> -+	if (old_fd2 !=3D -1)
> ++	if (close_fd2)
>  +		close(2);

That's a very straight-forward name that says what effect anybody
who assigns to the variable wants to see.
