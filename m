Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F009605DC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744364; cv=none; b=HquIx1BUCFDCydSnFV1c12P+FolZRT/QoXBkWAyT9hvnFQOK+dgxY7AtnEgsaSjiGfdIhmxK8UUD2wSQgT4X9rUJ4s/K68kP6RO0w5MwSI2y6Egy+4ERQTjNjAlXifColLHvs/9CudgS7xmkgerRhVm4OPg0Ggaxf32b9dAjnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744364; c=relaxed/simple;
	bh=XS/mb30qaLlZA9IsDnA45hoJG8CQjBqgZcTvEURK4Wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nsDMivZT2KrS0Z5YsRON00zvt6xZzgmCEdzxD3EgIt565izgwE5mFXbKq4GHME1IT58JIieYz/oOuELRyjYa/yy2FkqauI3i/PbhyYeDd4Rja/yPF7IrSxXb3Mgl5HmbxNaOn/hap5YIa8STwXHnRNUaLlwhdd+HuKYnEru1Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CZDNTQP5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZDNTQP5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E53EE1E3EA9;
	Wed,  6 Mar 2024 11:59:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XS/mb30qaLlZ
	A9IsDnA45hoJG8CQjBqgZcTvEURK4Wc=; b=CZDNTQP5Xy0U1SUg3SLAJ9NsWGEr
	CosskD68WPI5fCiM80jl5aK9KXH6Z77Puz+dElSgJ/MxlLPblRb2I79tx0gqe8bf
	zQRFEQSS6gAXl5YYfDMJ1psrafRpuvC4pUckUKvfwtaXTeo+PAMXBAkwfPfGDm7r
	4scpwiyrV9uyF5U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC26A1E3EA8;
	Wed,  6 Mar 2024 11:59:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55F691E3EA7;
	Wed,  6 Mar 2024 11:59:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Josh Steadmon <steadmon@google.com>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>,  Emily Shaffer <nasamuffin@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v6 0/9] Enrich Trailer API
In-Reply-To: <CAP8UFD1Zd+9q0z1JmfOf60S2vn5-sD3SafDvAJUzRFwHJKcb8A@mail.gmail.com>
	(Christian Couder's message of "Wed, 6 Mar 2024 15:41:16 +0100")
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
	<xmqq5xy036a2.fsf@gitster.g> <Zedtd6esmIgayeoU@google.com>
	<CAP8UFD1Zd+9q0z1JmfOf60S2vn5-sD3SafDvAJUzRFwHJKcb8A@mail.gmail.com>
Date: Wed, 06 Mar 2024 08:59:20 -0800
Message-ID: <xmqqplw7s3dj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E0AAA550-DBDA-11EE-922C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Mar 5, 2024 at 8:07=E2=80=AFPM Josh Steadmon <steadmon@google.c=
om> wrote:
>>
>> On 2024.03.05 10:03, Junio C Hamano wrote:
>> >
>> > It's been nearly a week since this was posted.  Any more comments,
>> > or is everybody happy with this iteration?  Otherwise I am tempted
>> > to mark the topic for 'next' soon.
>> >
>> > Thanks.
>>
>> I scanned through v6 yesterday and have nothing new to add. LGTM.
>
> I took another look at it, and I am fine with it now too. Acked.

Thanks.
