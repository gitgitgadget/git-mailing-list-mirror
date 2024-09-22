Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C92632
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024184; cv=none; b=ZwZfEPyihwsqrq8BKV2gKx9IbnvwHmv0/0acZa+LnFgAmRo9xzJLrdw5hYX/EL6IPFRrhUq/mWD6n7lLDuP5N6YhDIAYAWPtUUstxbE3XHjK5eHHfJYz335cYEn5E44kcLhDzhOBNmetbgXmN2QPMUb8VvY+oq5Q+ubzQdX05kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024184; c=relaxed/simple;
	bh=mLad0MENM7/5YzD1GCwPMH0nc5JEF64BmYc6EJ1T6+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EFr538A4sxdl9WP+zr9yrVnoX6IvelHQR/2Sul/xcANyYjVeO76hHp8TS+Mr5nHm/sFYIt3FIN/k/plqAmlVPXuNj+2jsPNrHDWrF0LwYanRZxnCmLUh9oBV2EDHzNqHi7hq40v8n2mHgxvcWkLB9kRYkb88xLq2Myq4R32lbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aGUznwhn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aGUznwhn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7176F3D3CC;
	Sun, 22 Sep 2024 12:56:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mLad0MENM7/5YzD1GCwPMH0nc5JEF64BmYc6EJ
	1T6+w=; b=aGUznwhnAeKXpLYkMQWI6wjAkqu1KLFeCHU4w/juvxSF7KrY0a8zop
	sU91WTMjLNkRNaJjldxDHEnW/DRoUZIudM1O6eA5Dcc7oxVW4edWbSzEXCSBDqPH
	ZKwdPqY4PYUjUW/HxKT/AYstm9ZFCaY6mcakwBEf+nZFNjRfAuTaI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69AB33D3CB;
	Sun, 22 Sep 2024 12:56:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D24D93D3CA;
	Sun, 22 Sep 2024 12:56:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <phillip.wood@dunelm.org.uk>,  <git@vger.kernel.org>,  "Taylor Blau"
 <me@ttaylorr.com>,  "Patrick Steinhardt" <ps@pks.im>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] update_symref: add REF_CREATE_ONLY option
In-Reply-To: <D4CB89OCTXWW.2A4NL7RQP4IS@ferdinandy.com> (Bence Ferdinandy's
	message of "Sun, 22 Sep 2024 00:19:43 +0200")
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
	<20240919121335.298856-1-bence@ferdinandy.com>
	<20240919121335.298856-2-bence@ferdinandy.com>
	<7fecc442-8d5e-4542-8ce8-907c35db870d@gmail.com>
	<D4CB89OCTXWW.2A4NL7RQP4IS@ferdinandy.com>
Date: Sun, 22 Sep 2024 09:56:20 -0700
Message-ID: <xmqq1q1b8w5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 984C260A-7903-11EF-8356-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> On Sat Sep 21, 2024 at 15:40, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 19/09/2024 13:13, Bence Ferdinandy wrote:
>> > Add a new REF_CREATE_ONLY flag for use by the files backend which will
>> > only update the symref if it doesn't already exist. Add the possibility
>> > to pass extra flags to refs_update_symref so that it can utilize this
>> > new flag.
>>
>> I'm not sure we need a new flag to do this as it is already supported by
>> the ref transaction api.
>
> Thanks, I was not aware of ref_transaction_create. It also seems to return with
> TRANSACTION_NAME_CONFLICT so we should be able to see from the error code if
> indeed the existence was the problem or something else went wrong.

Thank you for working on this, and thanks, Phillip, for a useful
suggestion.

