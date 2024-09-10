Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715618EFCE
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990368; cv=none; b=Hngq9HeCC7C1363S1UOn8btxPNR5Ew+abk60u6uGv5/4xO7yst/YdbbUtInM1lONh5UHvOpNngTPmTcxzNnSH+93nXMIm5d9cHhikiYg71ZcW6VQ/QZJoZE8/hSZ/uFoo16c7qz4SQIQz4xxWfhHrvV4b/0lCMFpJPQBRP/sNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990368; c=relaxed/simple;
	bh=4keyHvggRTZIrCkmjz6pqDtoCN/lFSh862TxZC5Dinw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSmz8jPDTpKmkShz+qoE+kSAMy4Ai4BrrwI2HY3RPdNRNe898HcAG9m25zseDeUAYIhudnJCuGB4hkoZoxcUs/zjdEFBH5WLkgj2fAJ30YrFmYS1eUXmL44yeFaliu+JEtlYnUCuXjQofwEyWbv5VIt3YnWl/D+m7IYfdVyoMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FAkAaKzk; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FAkAaKzk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A8C832DF4;
	Tue, 10 Sep 2024 13:46:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4keyHvggRTZIrCkmjz6pqDtoCN/lFSh862TxZC
	5Dinw=; b=FAkAaKzkEIqF16dcyH3GrSwDp/x65OO5UGi8Oug7JVlBvt4VQs2UJI
	Non3kmW2ehlwpqWCT/8aFx9WfgL7jqKii5nUMH6WLNt7l7C8VveD7D8NT5FtYJE2
	ANo7H2N55PpxhvL1GDwrmz+RBMU/7oJ5aFOxFT+JoUUwakDyKuMW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E4D632DF3;
	Tue, 10 Sep 2024 13:46:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67EDF32DF1;
	Tue, 10 Sep 2024 13:46:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <CAP8UFD1DQ6jGcnc_t=GQPmnfx2s63NLxyvSJ6V+vVQBU9m_MCA@mail.gmail.com>
	(Christian Couder's message of "Tue, 10 Sep 2024 18:32:02 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-4-christian.couder@gmail.com>
	<ZqpjV/A9ZVPDiGgA@nand.local>
	<CAP8UFD2OR=5QvyFT6EGQkekFBtjRWoMShQ=_eT=ypH=FswUaRA@mail.gmail.com>
	<CAP8UFD1DQ6jGcnc_t=GQPmnfx2s63NLxyvSJ6V+vVQBU9m_MCA@mail.gmail.com>
Date: Tue, 10 Sep 2024 10:46:03 -0700
Message-ID: <xmqqy13ze71g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D172570-6F9C-11EF-BAD7-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> > > +     pr-infos = pr-info | pr-infos ";" pr-info
>
> [...]
>
>> > I wonder if it would instead be useful to have <pr-infos> first write
>> > out how many <pr-info>s it contains, and then write out each <pr-info>
>> > separated by a NUL byte, so that none of the files in the <pr-info>
>> > itself are restricted in what characters they can use.
>>
>> I am not sure how NUL bytes would interfere with the pkt-line.[c,h] code though.
> ...
> However I still think that capabilities have been using a simple text
> format for now which works well, and that it's better to respect that
> format and not introduce complexity in it if it's not necessary.

Yup, especially when we are in control of what goes into "pr-info",
I do not see much reason to go binary.  It helps debuggability
greatly to stay in text format when you can.

Thanks.
