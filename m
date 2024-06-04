Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873112CD98
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522378; cv=none; b=V/aDSdG0e5Q6b6UdDlhpzBcn3ucBefHYjFv9bJX+TEjuCoptDVF+wupVNoqRRXa6Ri3LJdo3mZ2rlsrGHES5Vf0K7Vxa17UA756C+u4VFfNbpKVuCZBx28TlQNBrAxkLdQxUgpcAdBJ9UGW6kPP8wUYC3aapx0IpdJvROnBY2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522378; c=relaxed/simple;
	bh=U6UAPPHhL/f0+emtiQ9P6pibscElHt6IczRiV2Nw9FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WRBG46rOrsJ9DoMUt+G5J4oQyqhSpNIgpw0QHQtJeB3ketH0jCsF36yihE1ZslKdA7UVYBsxboQ5y7r4kibt5zzytAFA8DZXB+i4cnacLCix1i/4+74wS1nUYx+HaTqps/MN+rRlujJY37X2XiRdq+NofIRYeidph7unTHhyOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wYFIGrD/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wYFIGrD/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 90AF332497;
	Tue,  4 Jun 2024 13:32:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U6UAPPHhL/f0
	+emtiQ9P6pibscElHt6IczRiV2Nw9FA=; b=wYFIGrD/dgvG9pHNm5YAtLxpCqg8
	SnXEwnCE9bjGuSr2MVf+VTXFWYOg21rAWyHbSKBxyhrFqGcoixeIpIybs4Cbsg/N
	kQVf+hZo3FMvJxzOQT1XhCCRbPR2NSqgVUW8P0ZRh0QlsczsJDoGKxbUwuJjVFgS
	nrndCgJZDfvUCjw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 893A932496;
	Tue,  4 Jun 2024 13:32:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A988232495;
	Tue,  4 Jun 2024 13:32:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: assume --cover-letter for diff in
 multi-patch series
In-Reply-To: <Zl7J_Xr6Z7Ot6Hlk@framework> (Patrick Steinhardt's message of
	"Tue, 4 Jun 2024 10:02:05 +0200")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<Zl7J_Xr6Z7Ot6Hlk@framework>
Date: Tue, 04 Jun 2024 10:32:46 -0700
Message-ID: <xmqqplswwr41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 75B71BDE-2298-11EF-B5B5-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 04, 2024 at 12:49:35AM +0200, Rub=C3=A9n Justo wrote:
>> If either `--interdiff` or `--range-diff` is specified without
>> `--cover-letter`, we'll abort if it would result in a multi-patch seri=
es
>> being generated.  Because the cover-letter is needed to give the diff
>> text in a multi-patch series.
>>=20
>> Considering that `format-patch` generates a multi-patch as needed, let=
's
>> adopt a similar "cover as necessary" approach when using `--interdiff`
>> or `--range-diff`.
>
> What does git-format-patch(1) do right now in this situation?
>
> In any case, this change should probably have a test or two to
> demonstrate that it works as advertised.

Yes.  I think the existing tests for giving --interdiff to a single
patch series serves as the "it does not trigger when it shouldn't"
side of the test, so a positive "it does what it claims to do" test
should be sufficient.

Thanks.
