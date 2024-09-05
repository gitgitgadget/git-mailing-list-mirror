Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB11494B0
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558878; cv=none; b=Q5DVku1nfPMVPY7Cfw7VZ+7Nzmld4qLY597rfVsvDqTl/kJpywzlS9VeSUyrQy8+vaV3VJfvxCjLmIqp7Lu6ZrBk1SgFOP7YIg2hC5JWa0qBn90SZeKr0oftQXDXtWr9JYHAVQ82hW6J/rk7S9qy0XGhZ6cdmAMzrNFJ9M1e+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558878; c=relaxed/simple;
	bh=Wnk5j50v4l50A9TWfQokdpQlK0BZ+jEWWtnG7dNLPA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=moUbqKX8zmwDUBttnPS1HfpePdLfB0gMWwjX6ikVznrcmqX7qLPAIUBETv1XmWUXxdTwHnmaI6yHWHAOzNuwFpryydpDVHpRGhEANb1ta2csnkqdcL8jw98nQcobThuB48ER8OHc8RoLmcTKadlis7CHppO8h+qhyLQcjQkTEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uj2mVuo+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uj2mVuo+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 886D326B81;
	Thu,  5 Sep 2024 13:54:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Wnk5j50v4l50
	A9TWfQokdpQlK0BZ+jEWWtnG7dNLPA8=; b=uj2mVuo+ZWDVxfaPsQ0Mfh5Wd1AQ
	RdB3vg07KgEyagnjfMvgUqxm9AsOBxSW2MAfdn/wfzJklBwxNfUc1o44dCItJD2z
	aqhM0uXAvfoM/i34KWo4oRkZcrhH7WmXL44g8aURJIrZ8xisnnacSk8x33hz9jk7
	+W9tYr+M4B0u8VU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F30526B80;
	Thu,  5 Sep 2024 13:54:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E186A26B7F;
	Thu,  5 Sep 2024 13:54:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] remote: prefetch config
In-Reply-To: <CAG=Um+0P8SgWo2sN3St8+PpBneQfDBoqnpnC6uMmYu2YOOaWmQ@mail.gmail.com>
	(Shubham Kanodia's message of "Thu, 5 Sep 2024 22:49:15 +0530")
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
	<pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com>
	<xmqqcyli3x1w.fsf@gitster.g>
	<CAG=Um+0WinvE4CQPTwKdxMxj4xBJ9Z1SBWVrGzTMKM3CbMni0w@mail.gmail.com>
	<xmqqy1462gc2.fsf@gitster.g>
	<CAG=Um+0P8SgWo2sN3St8+PpBneQfDBoqnpnC6uMmYu2YOOaWmQ@mail.gmail.com>
Date: Thu, 05 Sep 2024 10:54:33 -0700
Message-ID: <xmqq1q1y2dgm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E94DA45E-6BAF-11EF-9F5C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> On Thu, Sep 5, 2024 at 10:22=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>
>> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>>
>> >>
>> >>         int prefetch; /* is prefetch enabled? */
>> >>
>> > ...
>> > Updating my patch =E2=80=94 please let me know if there's anything e=
lse I can
>> > improve here.
>>
>> Renaming the .prefetch member to .prefetch_enabled would eliminate
>> the need to add any comment on the member in the header file.
>
> Do you mean for the struct member here or also the config?

I do not think I mentioned anything about the name of the
configuration variable, but if I did that was a mistake.

End-user facing configuration variables are often named after a
feature that it enables or disables, so it can use the name without
"enable".  An int variable on the other hand can mean many other
things, ranging from "how many times have we prefetched from here"
to "does this remote allow prefetching?", so a more explicit name
would often help.

Thanks.

