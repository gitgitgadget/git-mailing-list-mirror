Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9715CD67
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668796; cv=none; b=pFp4d5nbv4TI9PVJMmXg9GbP26J0Fh2iR9G/Eodo6imahCHYVvUwxXjQ59C6nPPimMbTPRquv5rBrEMPg+F9VSZQbIT/DILT8mCtDshsB8S9HLOnool99JgsoxP0jNqkvGfDxCb9+poe4patttjH+3F7HpRrMd19+nsmy7PZ/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668796; c=relaxed/simple;
	bh=4S+FFzRA63/4NnPcWNXWOAv7Vvq3/Jszi+3Yig1lAeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GVoXgCB4gEUX24seqK2CaandFCY7c/29TuCcWM/rwWmo/vSdeBfEB6/kOheGeJFRccdFe4eaDk2Cz5kN8y30FFgCdS6nzQuiOaZGuXcR/4D35aHIXcfSOEtsKxXP10ja52bWGVVWx9rZWHuSJei5jMYDBUoydsvmtFwtiX3FCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xtEkE4Jb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xtEkE4Jb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A7FAA30890;
	Thu,  2 May 2024 12:53:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4S+FFzRA63/4NnPcWNXWOAv7Vvq3/Jszi+3Yig
	1lAeA=; b=xtEkE4JbyaDyZh5PnWpZu7RR7TLdpuH/r0g7gZdGcI+6Gx3EuGDRTC
	1xt9+eJL1WYj0fc7zpnIuvtQFea2cXX1Kszsz2ROOdxVltmvXHwlewjHkcnBm5y3
	3T1j/DS4E0SdOzugKp3THAVyMLu44uDe908Ds0TasutavyTq6ITcg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A07BB3088F;
	Thu,  2 May 2024 12:53:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D9F83088E;
	Thu,  2 May 2024 12:53:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH v5 7/7] refs: remove `create_symref` and associated dead
 code
In-Reply-To: <ZjNFG5Ztnoj9DMzB@tanuki> (Patrick Steinhardt's message of "Thu,
	2 May 2024 09:47:39 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-8-knayak@gitlab.com> <ZjNFG5Ztnoj9DMzB@tanuki>
Date: Thu, 02 May 2024 09:53:09 -0700
Message-ID: <xmqqzft8dukq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 759309BE-08A4-11EF-9AD8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 01, 2024 at 10:22:29PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>> 
>> In the previous commits, we converted `refs_create_symref()` to utilize
>> transactions to perform symref updates. Earlier `refs_create_symref()`
>> used `create_symref()` to do the same.
>> 
>> This means, we can now remove `create_symref()` and any code associated
>> with it which is no longer used. We remove `create_symref()` code from
>> all the reference backends and also remove it entirely from the
>> `ref_storage_be` struct.
>
> Very nice.

Indeed.

The last paragraph reads well without "This means, ", by the way.
