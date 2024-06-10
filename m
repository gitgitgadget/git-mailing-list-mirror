Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E41422CA
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035993; cv=none; b=gstQuiOaRScgGtrOhinK7aFTIeQ+bkM+/u4tsCJDY7JHAqEJVzAdmfRutTa5sh10cExs+NWh2s+QMthNQbPiDkMb05QQl/Nf4UntIWPZ3GOqDawCtqTyvkvMZXD4MsCtXTuk7md8tJoAYeqxnWRsZZ8IMQzDR08PXI6QTYIcFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035993; c=relaxed/simple;
	bh=8/NoxqUUqpm3fzUnljS+2A0XHJqfjO0pmNA5G9uruMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0yuEeYVZxT1iaxnG5PfhwT9zqtTgprxVv2ATzlMZjDNCOdMq7HMSP+9anVtXAfps0dE9QILyA71BrPHJcuWWNqo+di3oD+ycCM0uBYJD8MnFJ3YjFrfuXCOOpyfVUrhQAHuxGTwrPB1MzVDkeZ20f4/C4Zlr/revt6hyHXJiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lqO0fg7X; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lqO0fg7X"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E7A91F938;
	Mon, 10 Jun 2024 12:13:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8/NoxqUUqpm3fzUnljS+2A0XHJqfjO0pmNA5G9
	uruMc=; b=lqO0fg7XNZKEPslXYzGwX5PNp2UD/9ESP6eV40mFhAzxlroJpDLCIs
	jNI1BezociwAEgFmGu6t3pvUJXFKNEocUtKZUaFS8yxCax8ylbdSz+gYFRSOUK3M
	HGl+2vyjUsDAoh/BhDfYYrMjm9bLzBmpeHUns/LBV5QujYXTNQTj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 14FD01F937;
	Mon, 10 Jun 2024 12:13:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73E1E1F936;
	Mon, 10 Jun 2024 12:13:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Dragan Simic
 <dsimic@manjaro.org>,
  phillip.wood@dunelm.org.uk,  Jeff King <peff@peff.net>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com> (Phillip Wood's
	message of "Mon, 10 Jun 2024 15:09:48 +0100")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<20240604101700.GA1781455@coredump.intra.peff.net>
	<xmqqikyo207f.fsf@gitster.g>
	<20240605090935.GF2345232@coredump.intra.peff.net>
	<6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
	<a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
	<219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
	<9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
Date: Mon, 10 Jun 2024 09:13:09 -0700
Message-ID: <xmqq34pk6aju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 54C0174A-2744-11EF-AEF1-6488940A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... We can make it
> clear in the documentation that the input to the user's command will
> contain escape sequences unless they pass "-c color.diff=false" when
> starting "git add -p". If it becomes clear that there is a use for the
> plain output we can add that at a later stage.

It is a reasonable stance to take, I would think.  I do not _mind_ a
non-colored mode existing once we identify a use case that needs it.
Those who want colored output already are known (i.e. users of color
capable pagers with customization).  Once we give output that are
colored only, those who want plain output can make complain with
concrete use cases they have.

Thanks.


