Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481351BED74
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714515794; cv=none; b=QsK3uDejLvIwby0z8TFgwA8MM0vgEH5971wXiGrns9+X6Dm0f71W2H4wSAwVa3deOEyWuQG90cbPJUQSxPrPmGj+zdNNq33Tf5EmoD8hdSpQGwVLo5S2QPZBUkiSPE6SgObljPm5B7qQI5EwwUyx+PO22ax3IzDz96s8q9I/0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714515794; c=relaxed/simple;
	bh=/Mez6wgvCqsa1Meiy8TBs1WsB2QyIfMp1LTo3rwXv9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PliZleE7nyqetuuUGEUAsI7DSYDRT/ThD44tWOC8cXX0YyeByWwWYxy9JB8XQhqb7Zf9HjVCrKzf5M3QYhiy6z0zW12lh68ZOOfye0GKF9eyg9h89S7oU0XN2cun6JuI81f48gitIYzzwq4tPwQ22+Fx7A+8t7ijq8QM43W36KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gv/z6ZFv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gv/z6ZFv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A85122A49;
	Tue, 30 Apr 2024 18:23:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/Mez6wgvCqsa1Meiy8TBs1WsB2QyIfMp1LTo3r
	wXv9E=; b=gv/z6ZFvxw2+CJKw8YNwge43SMv0XB1yX+09LITYxqmsIpaivJN721
	Gy8NdsYsKn0p1vAbiqlxOAio094kX5VCxHDJxlJjSKvyGOk22mxHdaA/atSsbbkl
	uG+x4HqJRrV1EOCkjO2Nf/8OP+CDONdeh8PrQaeUmdXMgijoWnkw8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 834F322A48;
	Tue, 30 Apr 2024 18:23:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EE6B22A47;
	Tue, 30 Apr 2024 18:23:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Passaro <john.a.passaro@gmail.com>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/3] builtin/tag.c: add --trailer arg
In-Reply-To: <CAJdN7Kggv-y8xRhdFanTyxa5wP-bG0omBPuETW6qijA67gn8oQ@mail.gmail.com>
	(John Passaro's message of "Tue, 30 Apr 2024 17:48:14 -0400")
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
	<pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
	<5b6239167b8d7c26f96e5c23d0d82b7a3a9b01fe.1714416865.git.gitgitgadget@gmail.com>
	<xmqqv83yrduw.fsf@gitster.g>
	<CAJdN7Kggv-y8xRhdFanTyxa5wP-bG0omBPuETW6qijA67gn8oQ@mail.gmail.com>
Date: Tue, 30 Apr 2024 15:23:05 -0700
Message-ID: <xmqq4jbixzg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3848BFAA-0740-11EF-9BD0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

John Passaro <john.a.passaro@gmail.com> writes:

> There's also project-specific trailers. For example, on my team,
> we use "Deploy-Strategy: ..." to tell CICD what deployment routines to run. This
> is pretty specific to us but worth calling out. Maybe could translate to a
> documentation example with something like "<Project-specific-trailer>: foo"

The last one that uses placeholders for both trailer tag and value
may be generic enough.

> However, in service of helping users find workarounds, shouldn't we tell them
> --trailer may be the culprit?
>
>> Failed to read '%s'. Try again without --trailer (use -e or -F to add trailers manually).

I dunno.  

If -m/-F that wrote the original using the open/write_or_die/close
sequence succeeded, the "amend_file" thing successfully spawned
"interpret-trailers --in-place" and got control back, yet we fail
to read that message back, it does not smell like a failure with
that "--trailer" option to me.  A failure with "--trailer" that
could be worked around would have been caught in "amend_file" thing,
before the control reaches this point, no?

