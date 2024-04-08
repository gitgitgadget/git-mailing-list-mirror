Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483A7E8
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613182; cv=none; b=BURr7ZagAcF5OHoxF7XV7Qt8S4skZWVcJJGAVH6RGO7YxYxpzNtbrMumlhdpAKgIlgxNK3sOdIZowt7o/FygyuwD9TdqBlpW7O2fhZ7639TAucZtKNlE4d6MyZ2R6a8XFuqNraESc/cbyaNIr0RPcVbs6BM4hzO7dmdPf4RmlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613182; c=relaxed/simple;
	bh=pYGyC45y8ZnmQTBAMnQ9UJ//le69KxaWVsCS7gJb7YA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPpHwBgJXUIfX2fpxmH9cmoyNqNF5oTBStC28GfHOMtM3HhHeqDr7/e0TBI45WNDK2d+9bTvWiwRZ/zvL7i0ynjRXxte3txcMh7jkGN6EAHiPOwhItXIBFeYmBW3f9mSMjrTZ3MClKX5UxuIIsm2SR18BMnpyLelX5JnOk/ET9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x/j0Y1pw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x/j0Y1pw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E9BE1F51EF;
	Mon,  8 Apr 2024 17:53:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pYGyC45y8ZnmQTBAMnQ9UJ//le69KxaWVsCS7g
	Jb7YA=; b=x/j0Y1pwP+NMJbvqQY4ISoTApVmMlL8Hbb9m4WZ7nxy3f/MAQsKOaD
	a6dAmgoyegcgMHfwkyWCONe8twa8VXFErc1z58XZSqNm/9h5XFwIhzNXakz8D7AK
	sKExmiuM1Z70y77qI3mOyO4xUYUZySGzeCHBvd94oD2B9i1SevsrI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 25C951F51EE;
	Mon,  8 Apr 2024 17:53:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 827461F51ED;
	Mon,  8 Apr 2024 17:52:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  git@vger.kernel.org,  Han-Wen Nienhuys
 <hanwenn@gmail.com>,  Josh Steadmon <steadmon@google.com>,  Luca Milanesio
 <luca.milanesio@gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
In-Reply-To: <20240408172638.GB1629595@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 8 Apr 2024 13:26:38 -0400")
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
	<160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
	<CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
	<xmqqpluzet2z.fsf@gitster.g> <ZhQZsq5_NyXmWM-b@tanuki>
	<20240408172638.GB1629595@coredump.intra.peff.net>
Date: Mon, 08 Apr 2024 14:52:58 -0700
Message-ID: <xmqqbk6j8qth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5D8D42D6-F5F2-11EE-8A3C-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I.e. either:
>
>   for i in $(test_seq 10000)
>   do
> 	echo "create refs/heads/branch-$i HEAD"
>   done
>
> or:
>
>   i=0
>   while test $i -lt 10000
>   do
> 	echo "create refs/heads/branch-$i HEAD"
> 	i=$((i+1))
>   done
>
> I think the first one actually incurs an extra process anyway because of
> the $(). The second one would not. Of course, the second one probably
> needs &&-chaining and a "|| return 1" to work in our test snippet.
> ...
> Then you could just write:
>
>   test_seq -f "create refs/heads/branch-%d HEAD" 0 9999
>
> and I suspect there are several other spots which could be simplified as
> well.
>
> Anyway, I don't think it is worth derailing your series for this, but
> just general food for thought.

Yup, I agree with everything you said.

Thanks.
