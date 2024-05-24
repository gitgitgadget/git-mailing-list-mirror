Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D066E5ED
	for <git@vger.kernel.org>; Fri, 24 May 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565757; cv=none; b=Eez1tKjbM2fosv0fY9jd0fUo3Zin5HlTyzmLO2vRPV5I7CNu57nv6gbYPGhEewwWGkVmXEINPrAaKLMQcsMAdv02i81DaFr4HU2o5AeEsklflUXVeUhoRFdAEfeXfz88N9skUUIdN97icTxfhVf6pJNgdqnutyeHfTVzbQDx5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565757; c=relaxed/simple;
	bh=/uSBT3Bsq08Q+Sy5crySKs77xZMHCvxiOLmQDmOzr8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SkiSnuF4Z0gcmGGL+J1L4U7zsaj1R9Tsf7CsU6kcWREALzC+cWUGpmfKbTQGdnTv/wpwGKFK4aEhYA4svdLbU6UMoY8pYmM3DdNt7pu0SOp3vlb1prDdaqWMHraeLyFPE0py8WPsLdeAl46k5U5+SCKksgS98vzRwDJ89cOPhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P+Y5k7eb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P+Y5k7eb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C5BB29816;
	Fri, 24 May 2024 11:49:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/uSBT3Bsq08Q+Sy5crySKs77xZMHCvxiOLmQDm
	Ozr8k=; b=P+Y5k7ebp5JxMmMA9MEW6rQE3YMDzDAvNIAqK4crK2ME82eZTVrg95
	av5K/xF7DL8xwXzYzaaSP6jda/RLZd7Z1FEx6ptQ90m1p982ywGyhC8GJ97hALu8
	0rd+gNMT1JR8+a/dvzjpAxgmAWQi3pBgjm90qV5W+1JVkfjQVk3Ww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 116D429815;
	Fri, 24 May 2024 11:49:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75FCD29814;
	Fri, 24 May 2024 11:49:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>,  ach.lumap@gmail.com,
  chriscool@tuxfamily.org,  git@vger.kernel.org,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 2/3] t/: port helper/test-sha1.c to unit-tests/t-hash.c
In-Reply-To: <CAP8UFD1=yjZEZWvMYKq1RyY8fMSHze4XcLbCZMSFhCLBheaM+w@mail.gmail.com>
	(Christian Couder's message of "Fri, 24 May 2024 16:08:09 +0200")
References: <20240229054004.3807-1-ach.lumap@gmail.com>
	<20240523235945.26833-1-shyamthakkar001@gmail.com>
	<20240523235945.26833-3-shyamthakkar001@gmail.com>
	<ZlCWcpcUkgUMWJYz@tanuki>
	<CAP8UFD1=yjZEZWvMYKq1RyY8fMSHze4XcLbCZMSFhCLBheaM+w@mail.gmail.com>
Date: Fri, 24 May 2024 08:49:13 -0700
Message-ID: <xmqqo78vnrba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2BCFE11A-19E5-11EF-B833-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> Can we refactor this test to stop doing that? E.g., would it work if we
>> used git-hash-object(1) to check that SHA1DC does its thing? Then we
>> could get rid of the helper altogether, as far as I understand.
>
> It could perhaps work if we used git-hash-object(1) instead of
> `test-tool sha1` in t0013-sha1dc to check that SHA1DC does its thing,
> but we could do that in a separate patch or patch series.

Yeah, I think such a plan to make preliminary refactoring as a
separate series, and then have another series to get rid of
"test-tool sha1" (and "test-tool sha256" as well?) on top of it
would work well.

>> > +     if (!check(!!data)) {
>>
>> Is this double negation needed? Can't we just `if (!check(data))`?
>
> As far as I remember it is needed as check() is expecting an 'int'
> while 'data' is a 'void *'.

It might be easier to read by being more explicit, "data != NULL",
if that is the case?  check() is like assert(), i.e., "we expect
data is not NULL", and if (!check("expected condition")) { guards an
error handling block for the case in which the expectation is not
met, right?
