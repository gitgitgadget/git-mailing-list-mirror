Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B64D5B0
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328817; cv=none; b=CrWYmzmEMyF/xRxpVwt8bQgY/98ps8NCWearrjImHrSmSzUOY7UUlnKsIsZipmdKhKpZGt1IF/pMElGILxuc5TWVN5rr/SnAcXxNhElvqpaH9tUXnlei4EtmaDtZtNoJVDqbFSe7uGZjRe9b9rwpRy2W1JEOuCV9QtPZ21yZaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328817; c=relaxed/simple;
	bh=xUY4Y9zlFoBtRvzKqfXKS5nsOG33gF/S3OoVf/fdOHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S7kIKLbmBJVjGSSnTdZnXzyNjcfuzUM3LRlTPeazeeFhe17YiWxHZOU+QxbsD41EFCrvEIkZB9zBbflb5dceUNPr3hePuljYkvyTB1RuZTNjmLSIjPozuxngfWd+uQOLZbl6AV+byP2ZV0QBHqP6TvSiXN/N35aDlGqcKaTiB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fvy6n0jw; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fvy6n0jw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F32C31DF7;
	Tue, 21 May 2024 18:00:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xUY4Y9zlFoBt
	RvzKqfXKS5nsOG33gF/S3OoVf/fdOHY=; b=fvy6n0jwSSLODocakZ6wMEwm2EcF
	KmRzs1gxa5T2bcNLC5+NgCwtu4xQ9SQGfqFLz6suLqxHwNgnCumtTnaV0UdREKEc
	YDrZk4/7H5720vIw15gNfolieW0VSRgJKFG9lAz9niQXM5eFZRjovefBeP3wu2hf
	npW3mZvHZd4Wo2o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83A7531DF4;
	Tue, 21 May 2024 18:00:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 301CA31DF1;
	Tue, 21 May 2024 18:00:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
In-Reply-To: <0574914d-8088-434d-8db2-013c1abe27c3@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 21 May 2024 23:35:17 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<80f15223-246e-4cfb-a139-e47af829c938@gmail.com>
	<xmqqo790fg8z.fsf@gitster.g>
	<a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com>
	<xmqqwmnm993k.fsf@gitster.g>
	<0574914d-8088-434d-8db2-013c1abe27c3@gmail.com>
Date: Tue, 21 May 2024 15:00:10 -0700
Message-ID: <xmqqikz6966t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7F349352-17BD-11EF-A87F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Adding logic to adjust when we close(stderr) in close_pager_fds() makes
> sense on its own, I think.

The feature may be.

> And, the values for the flag "do-we-want-to-close-stderr-at-exit", too,
> to me.

But the thing is, the flag is *NOT* named as such, and an
undocumented "value -1 means X, while value 1 means Y", do not make
any sense, either.
