Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA460250
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744953; cv=none; b=h0Y7zTOH5BiMp7WP2l1ylhMiG2qVOGVjbN+unwwObIlstx1cnRqRRoWdhPBT++HPGi4Y1iSZDVzVHasUzb52amRGWg0rvzUio1FhkDhEM1EebrTr8TNcsyBUzM7E7HAfUQvKvOrPHhJo2tpXnnyy5FEqJskJnHY0hNmiJ7bx2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744953; c=relaxed/simple;
	bh=XS/mb30qaLlZA9IsDnA45hoJG8CQjBqgZcTvEURK4Wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qh1IFCl47SWuX3y4zoZlWP6oXPdAYh2DoTsK9HRGR+nVePmHW8M/fMAXN0EsVKHM1E7/bd9K/9oGyfaY5gPhzi3zCOxgNlC+6xVuEa9NHlVWF1ZX1L0ATzjjsztbz7k5qCen4DJ+o+3JVpEPhdGO/NxEqIlXsP3Rhr9MrkFF+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o89NJLpN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o89NJLpN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE42F1D8DC6;
	Wed,  6 Mar 2024 12:09:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XS/mb30qaLlZ
	A9IsDnA45hoJG8CQjBqgZcTvEURK4Wc=; b=o89NJLpNk6lyLAQVNyd1MKgEXYZl
	YzWOHUPPN9QwKOhOM0klHDw1ANCGZtZeSbO9gGug97n1FMS29DEFfOPg0JgREnpN
	77S8N7iu0E39V2Fh3WwZnRqZUf63fruTkvWltA660zenkIK1t4Jy0/VuUihgi658
	GydtJQ5nEABm4qw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A057A1D8DC5;
	Wed,  6 Mar 2024 12:09:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 053071D8DC4;
	Wed,  6 Mar 2024 12:09:09 -0500 (EST)
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
Date: Wed, 06 Mar 2024 09:09:08 -0800
Message-ID: <xmqqedcns2x7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3F8B40BA-DBDC-11EE-BD45-25B3960A682E-77302942!pb-smtp2.pobox.com
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
