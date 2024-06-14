Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8B2F50
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718400223; cv=none; b=KFaFcAHKPq2lepJu2hIi1O7n6dqcfbqNXgUKC6BOSzrsRMyFzS6b5X9qypNRzsx5+hTU9Fa/RoJ8gbJ8QNJCTPaRi8hu/z5K8yHcqILFXljyf4Il28LplLl48AzzK2uJBa7YGrCRUqcHYICEZvdWauYhY1l8WFIlkytdA2UL1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718400223; c=relaxed/simple;
	bh=HtTP7CaTHP/fZn8Qy79UZu2hjje8ZdNNrWdAH2RGxUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l+AgseqXqZcPH2CAf0yVvgpPzhBJZqCbzThdeiYbVItVkBH0YHZyjm/zJ83QGp2NNzuHKkfUZ+oZAnaRZs3cmVvcL6x/s6qRiLHPnVFdq8Z1jvM1/RttgmwH3fpRCSEYMawnt2xBGhc4SY9ToOu7lzWlpMr13G2jdc3GtwhkXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b6AnUWZ9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b6AnUWZ9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AA73133FA1;
	Fri, 14 Jun 2024 17:23:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HtTP7CaTHP/f
	Zn8Qy79UZu2hjje8ZdNNrWdAH2RGxUg=; b=b6AnUWZ9PWr/6VSz8IjGZs13XwKf
	Oz2ZMgN1c1dR7hCTxIfRP/F5mOcd7gjeCiDRhupO3QX8c4ava4jcAyHnKNMValqp
	DhZrRX/IdYB13d8rdQ4/+d2P8dZNIPgBn6RO46KNNkgeUNYiz9dB7rwgBRideArd
	sKezKNVgZI0wwiM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A314A33FA0;
	Fri, 14 Jun 2024 17:23:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D55A233F9F;
	Fri, 14 Jun 2024 17:23:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/2] pseudo-merge: various small fixes
In-Reply-To: <CABPp-BF71VWMmSHNx7-dbs8ek+dK0kPTUnSv2OJmM9VYq-LOkQ@mail.gmail.com>
	(Elijah Newren's message of "Fri, 14 Jun 2024 21:08:53 +0000")
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
	<cover.1718392943.git.me@ttaylorr.com>
	<CABPp-BF71VWMmSHNx7-dbs8ek+dK0kPTUnSv2OJmM9VYq-LOkQ@mail.gmail.com>
Date: Fri, 14 Jun 2024 14:23:36 -0700
Message-ID: <xmqq1q4zdxrb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5D32E454-2A94-11EF-B3B9-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> On Fri, Jun 14, 2024 at 7:23=E2=80=AFPM Taylor Blau <me@ttaylorr.com> w=
rote:
>>
>> Here is a small reroll of a couple of patches I wrote to fix various
>> small issues with the tb/pseudo-merge-reachability-bitmaps topic.
>>
> ...
> Series looks good to me.

Thanks, it looked good to me, too.  Let's roll it into the base
topic that has been waiting in 'next'.

