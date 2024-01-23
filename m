Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86481217
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032895; cv=none; b=R5QuufxosHoFrS4bwI1E9Tu1IXKH7NI1rGqoY9R1nB9TRx4Ae4bzQzvcMFbuL+cnvvJeXyni1EyfTJBZR2vDWw/D8rPv7DLLrmo3mPh+77v5xBfdb5XTJiKurDoKJqu41CvXtOM1NJLuiefM3uj+fGWJCmQxH5/9qnnxSxcLU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032895; c=relaxed/simple;
	bh=g9Q/1hHm01CDc1iQWD+cRsrWc9tL79iyXfmYWJV1xdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uH1KflEhyTfF2PnuBQKcRSWPM3sR44+2pTkXKMTFI7xpeDp6NmvYQODEsHoXoNNTynugvlAdz0REq9MUWZaYQG5RSitNlz3+FkJimCb+Z9BZ9RUppfr71Fm3EiPUnO2cW7T0G5DeVtkr2TxhfzlZSngW0Yu6k4di2M5azvZoRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vNo0xw6P; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vNo0xw6P"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B04FE32798;
	Tue, 23 Jan 2024 13:01:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g9Q/1hHm01CDc1iQWD+cRsrWc9tL79iyXfmYWJ
	V1xdk=; b=vNo0xw6PEqGx59TqzqTTo14ULLMX5i5QEHcP+ExMTCDODTDmER0F8a
	maYLgZjmy/6IZunFrhrVXoONWd5wguXHxhK28zt1mZVTs9PV0J2NuHHoOIuLBgeK
	KI90UzgGSb+120BjBjrK7zc9U1Y/ojoZxsqVijTA9dvWNeEvfzUew=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A866732797;
	Tue, 23 Jan 2024 13:01:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A5C332796;
	Tue, 23 Jan 2024 13:01:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: brianmlyles@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  newren@gmail.com
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust
 redundant commit handling
In-Reply-To: <b897771e-c60e-4e41-bfae-3bcfdd832be1@gmail.com> (Phillip Wood's
	message of "Tue, 23 Jan 2024 14:25:43 +0000")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240119060721.3734775-5-brianmlyles@gmail.com>
	<b897771e-c60e-4e41-bfae-3bcfdd832be1@gmail.com>
Date: Tue, 23 Jan 2024 10:01:27 -0800
Message-ID: <xmqq8r4gnd3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6EE5C8E2-BA19-11EE-BC99-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for the well explained commit message

;-)

>> The `--keep-redundant-commits` option will be documented as a deprecated
>> synonym of `--empty=keep`, and will be supported for backwards
>> compatibility for the time being.
>
> I'm not sure if we need to deprecate it as in "it will be removed in
> the future" or just reduce it prominence in favor of --empty

True, especially since --empty=keep is much less descriptive and the
part after "note that ..." below will take a long time before
sticking in readers' brain.

>> +--empty=(stop|drop|keep)::
>> +	How to handle commits being cherry-picked that are redundant with
>> +	changes already in the current history.

It might make it easier to understand if we moved the description in
'keep' that says something about --allow-empty here, as it should
apply to other two choices if I understand correctly.  Let me try:

    This option specifies how a commit that is not originally empty
    but becomes a no-op when cherry-picked due to earlier changes
    already applied or already in the current history.  Regardless
    of this this option, `cherry-pick` will fail on a commit that is
    empty in the original history---see `--allow-empty` to pass them
    intact.

or something.  Then the description of `keep` can become just as
short as other two, e.g. a single sentence "The commit that becomes
empty will be kept".

>> ...
>> +	The cherry-pick will stop when the empty commit is applied, allowing
>> +	you to examine the commit. This is the default behavior.
>> +`drop`;;
>> +	The empty commit will be dropped.
>> +`keep`;;
>> +	The empty commit will be kept. Note that use of this option only
>>   	results in an empty commit when the commit was not initially empty,
>>   	but rather became empty due to a previous commit. Commits that were
>>   	initially empty will cause the cherry-pick to fail. To force the
>>   	inclusion of those commits use `--allow-empty`.
>> +--
>> ++
>> +Note that commits which start empty will cause the cherry-pick to fail (unless
>> +`--allow-empty` is specified).
