Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD41862BB
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477809; cv=none; b=QHtS3gDF1SFBMneNw0/a3O+waGKs2LMztY3WFNqoXAv6SwXmzxz2bZfcDqQJaUKEFGoLOudTvU0szOWcmxmr/LrTdnEG0JI44TX6wlRkUq+lmcWNROUaevkpVSK2LePgg1MwHATBp4tFioXwIg8eZzhLRDxXQMYmLFt5QE/PMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477809; c=relaxed/simple;
	bh=vTyMHH8HyaJJW6S1JkxHieZuv+Mmwrb2sm14Ufp7YGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tbEO5a3tdcox3FtbNQ8nhZ6J2g/qHJVkNBiEjehZT3tPBjKsH+RIofPcONVYj7o+5kD6SkTH7ngeL2KY3UXkwcsnE1yucZoe6dOuo5IaX/z9yuM5r1RJ2WQMCS7db94LoS3tQasa4NRBHULZTSYPNnxrTbVjUg4NMbLGKTHwbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DTBr1aKc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DTBr1aKc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AC3983C73F;
	Mon, 12 Aug 2024 11:50:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vTyMHH8HyaJJW6S1JkxHieZuv+Mmwrb2sm14Uf
	p7YGk=; b=DTBr1aKcDMt6smHJjtuYK0lJbD+C/grz2Bb3ydBoLtcjgfyuJD3yCY
	AO/Ti0Q8m7KzGR0oEAMmKRLMfzuXooQJgQM/VJMmZjbKJSf6hPog/eKjFZ6gz96A
	NO6PFb6oQBC5lEasxDTaiIkbuIJVm5kPmp4OoUwhq7J/yuOlsaDSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A4B463C73E;
	Mon, 12 Aug 2024 11:50:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4EAC3C73B;
	Mon, 12 Aug 2024 11:50:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  James Liu
 <james@jamesliu.io>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.4)
In-Reply-To: <CAOLa=ZSCLZU=eeBqx9cpHkUJ+SOHXToVwMKjmCKLc+54MfxdRQ@mail.gmail.com>
	(karthik nayak's message of "Mon, 12 Aug 2024 04:13:47 -0500")
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im>
	<CAOLa=ZSCLZU=eeBqx9cpHkUJ+SOHXToVwMKjmCKLc+54MfxdRQ@mail.gmail.com>
Date: Mon, 12 Aug 2024 08:49:59 -0700
Message-ID: <xmqqbk1x7nbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8994B782-58C2-11EF-8B99-E92ED1CD468F-77302942!pb-smtp21.pobox.com

karthik nayak <karthik.188@gmail.com> writes:

> I went through the series and apart from some typos, everything looked
> great. I don't expect a reroll for those typos though, since they're
> minor.

Thanks for a review.  A final reroll that shows only the typofixes
in interdiff/range-diff is not a huge burden, but having to deal
with many separate "here is a typo", "here is another typo" patches
over a period is annoying and it is even worse that many readers
have to get their reading distracted when seeing these leftover
typoes, and get annoyed but yet not annoyed seriously enough to send
these typofix patches to leave them unfixed to cause other readers'
reading hiccupped.  Let's always remember that there are 100x more
readers than those of us who write.

Thanks.

