Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808B1C33
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309938; cv=none; b=SEceK7WrWUMXhS7Lh48b/EmBnrPpSdKQMbFxhscAwhOO7ApRhs7lz9jZhrq50l9X4v4rRsytO+VjadaSgZc8cwAWx27PHfSa7gGC5XsRVAT0DLwve8jHIW0KefFeFhftJCUB3N+HUxv47v3vEKwkO4H1TWJNZuVMslQ42iGz44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309938; c=relaxed/simple;
	bh=+zqPWYCSONFo6ARstJKnJB+uCKrj7nH/mYGvwmY9UWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CcKXpFUmpO3wvePP34HTnbkdD+sQidBxReV9smsyy07/XE00nLikQu9TOtK/UyWdaxgDXZQWotoS7BPTgEf+dGVWiG2Z/SwWQIGDJxAGJ8jf+1idFLfry6/nrNZ27SP46oY3SUWYEp8jmYWkxPkp+ejQAWKHTEB0i0EZHeQvCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XBsQDixN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XBsQDixN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ACD6B1D3CC;
	Fri,  1 Mar 2024 11:18:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+zqPWYCSONFo6ARstJKnJB+uCKrj7nH/mYGvwm
	Y9UWY=; b=XBsQDixNLE/envhK2OMJSBigKReMdf+iKkrZYKHrjYuxGhdYNu+nTY
	+r3DjFftMnqZWX5dYQBHGR3j7GJIC4oKV+SLJ6lXd7SdO5A9nZNp+1Z6/xZlHYZz
	vCnzagjBgltW6FeGmAXjFpb8YRNf2ovfQCFRt5PDX2PbYNxGdSLNo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A4E0F1D3CB;
	Fri,  1 Mar 2024 11:18:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A168B1D3CA;
	Fri,  1 Mar 2024 11:18:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Dirk Gouders
 <dirk@gouders.net>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 03/11] commit-reach(repo_in_merge_bases_many): report
 missing commits
In-Reply-To: <20240301065805.GB2680308@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 1 Mar 2024 01:58:05 -0500")
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
	<1938b317a49f4d688bfefd7e5a74ad750a55a91a.1709113458.git.gitgitgadget@gmail.com>
	<20240301065805.GB2680308@coredump.intra.peff.net>
Date: Fri, 01 Mar 2024 08:18:51 -0800
Message-ID: <xmqqo7by7wno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 64FCAD28-D7E7-11EE-849E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Feb 28, 2024 at 09:44:09AM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> @@ -1402,6 +1436,8 @@ static int merge_mode_and_contents(struct merge_options *opt,
>>  							&o->oid,
>>  							&a->oid,
>>  							&b->oid);
>> +			if (result->clean < 0)
>> +				return -1;
>
> Sorry, I accidentally commented on v2 of your series a moment ago,
> rather than the most recent version. But this hunk was untouched between
> the two, so the comment still applies:
>
>   https://lore.kernel.org/git/20240301065647.GA2680308@coredump.intra.peff.net/
>
> -Peff

Thanks for spotting.

The topic now is in 'next' so let's fix it incrementally while I'll
hold it there.  If all of us thought it has seen enough eyeballs and
is good enough for 'next', yet we later find there was something we
all missed, that is worth a separate explanation, e.g., "The primary
motivation behind the series is still good, but for such and such
reasons we missed this case we are fixing."

