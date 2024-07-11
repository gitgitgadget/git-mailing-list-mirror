Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2C16C68C
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714569; cv=none; b=MBJ8ajcGx8X2pJJEo08fUhpAjzXmsOsZolWEMfgshw5MbXo6tp5SG8tLxTS+LCvExhYys1CW4jny0pFggePhQkwrWKlIxGmMez1QxzmmJuSfYj08V14G6LiaaBq73EZym35xQKcoZSbx434ivrVgQ5Mi2QMcdSYLuHJspQrOmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714569; c=relaxed/simple;
	bh=eDrQuBpPRlVH4anp8u6RA+slWBulaWtXDjSNZ1P1V8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2I6F/dmhLKdtgJg1djD6nnp9WJ7bz/7OM8a08wTTbfwbNObyTW21cF7/a8bw+ipEhLZt+KhBzVZgD49S30zN15a1vpLXFniugb2wvp3bJLnuYPRJN0yJQf9OKCYs2ljMfe9UuqCdybL743lQ5Tgwl6Zj4JGxP+8/Hvepc/8ghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVmnkYsR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVmnkYsR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BC55E1810B;
	Thu, 11 Jul 2024 12:16:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eDrQuBpPRlVH4anp8u6RA+slWBulaWtXDjSNZ1
	P1V8E=; b=kVmnkYsRsY1UHygqi2iNlR4An5Q+OV5TFifdnkXqLmqU/45bMY25tx
	cx0SgGqkdXp+tT/MFsY65wWVntzEqefmJYjcch/oj95sZb2JUY5DM1ATC4GYU2E0
	fB30cgVXp8mo6h1YBlrI3I9zBuR2ghWG3rWduMjn5vTwnA6qxeb7Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B44401810A;
	Thu, 11 Jul 2024 12:16:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C881918109;
	Thu, 11 Jul 2024 12:16:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  chriscool@tuxfamily.org,
  git@vger.kernel.org
Subject: Re: [PATCH v2 8/8] check-whitespace: detect if no base_commit is
 provided
In-Reply-To: <zq2x3k5gshs5jgx6zglfdzu4kx6vrrzugfvd4w4pjfh6uyjc4r@4x2zt2ftfmsq>
	(Justin Tobler's message of "Thu, 11 Jul 2024 09:48:48 -0500")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240711083043.1732288-1-karthik.188@gmail.com>
	<20240711083043.1732288-9-karthik.188@gmail.com>
	<zq2x3k5gshs5jgx6zglfdzu4kx6vrrzugfvd4w4pjfh6uyjc4r@4x2zt2ftfmsq>
Date: Thu, 11 Jul 2024 09:16:02 -0700
Message-ID: <xmqqikxbsy4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DEE0F0A6-3FA0-11EF-9E64-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

>> +      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
>> +        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
>> +      else
>> +        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
>> +      fi
>
> Not worth a reroll, but it would be nice to have a comment here
> explaining why we have this fallback as, to me at least, it is not very
> obvious.

FWIW, it is not obvious to me, either ;-)

Another thing that I find somewhat disturbing is that the
conditional seems the other way around.  It shouldn't be saying "If
B is not available, use A, otherwise use B", as if A is known to be
usable always.  It should be more like

	if test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
	then
		ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
	elif test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
	then
		ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
	else
		... noop?  barf? ...
	fi

shouldn't it?

>>    rules:
>>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>>  
> [snip]
>
> Overall the GitLab CI changes look good to me. Thanks :)

Thanks for a review.  Very much appreciated.


