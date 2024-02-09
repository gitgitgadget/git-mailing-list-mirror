Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CF60DDF
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460321; cv=none; b=DvgrHrAT8S3AozPlF/xJAnbvIHSvMoLEhiM18e+1iOyT3GrT9gtEdJ+riXBpNjBNUwPBimhnuL4DwBfMJrFT0vhsI41ztPbd+LelzyICPDPnK4CR4KG3QQzk3C5tgsbDUiRUmFfvui1rnN1521gEpWBH3xPxA4UHtncjWEs8YkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460321; c=relaxed/simple;
	bh=bT9vTXAT2pEP9TXR4PuNAbRu2hw8fro2+M/ClxIyECU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLqDt4OKeZdBb6640MHmtm0zSgmCiXUuT9xhyXX/EK3SdVpaKeYPbs6wqw1bzN45atLJcVqqcza1ntugoCPwddPKv0ue/WU5VwMcuAuwioHQnC3jmaFUC3gkQUPZNiLazh0oS1D1GIDJ/bwwyfWmXsVf6MFh9Up48CiAg8y55lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FS/FJ/xX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FS/FJ/xX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AC0EE374AA;
	Fri,  9 Feb 2024 01:31:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bT9vTXAT2pEP9TXR4PuNAbRu2hw8fro2+M/Clx
	IyECU=; b=FS/FJ/xXzM150IaMW+XoO+6TlLsIogpiGpzaiQzvxFbpiD58zmwKxu
	NaDr6EbyLHYZkXLX6h8F/wfTO9k1Qpteh8rtdKeBQ3qFzIoXXsFpF3AiJ+vB5KpP
	w5HlfKbYyJNI6VsSqUvA2fe7J4WhqaM/Lcrm+jQYkn+1yJ3/09dyE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 97553374A9;
	Fri,  9 Feb 2024 01:31:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3CE4C374A8;
	Fri,  9 Feb 2024 01:31:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] ref-filter.c: sort formatted dates by byte value
In-Reply-To: <5ed018da-2150-42d8-995e-59a35a2e3821@github.com> (Victoria Dye's
	message of "Thu, 8 Feb 2024 18:46:50 -0800")
References: <pull.1655.git.1707357439586.gitgitgadget@gmail.com>
	<xmqqzfwbps43.fsf@gitster.g>
	<5ed018da-2150-42d8-995e-59a35a2e3821@github.com>
Date: Thu, 08 Feb 2024 22:31:53 -0800
Message-ID: <xmqqeddmkv1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB19B2C2-C714-11EE-95CA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Victoria Dye <vdye@github.com> writes:

> Junio C Hamano wrote:
>>>     I came across a use case for 'git for-each-ref' at $DAYJOB in which I'd
>>>     want to sort by a portion of a formatted 'creatordate' (e.g., only the
>>>     time of day, sans date). When I tried to run something like 'git
>>>     for-each-ref --sort=creatordate:format:%H:%M:%S',
>> 
>> Hmph, this indeed is interesting ;-)
>> 
>> I wonder if there are other "sort by numeric but the thing could be
>> stringified by the end-user" atoms offered by for-each-ref
>> machinery.  IOW, is the timestamp the only thing that needs this
>> fix?
>
> The only non-FIELD_STR atoms other than the date ones are "objectsize" and
> "numparent". "objectsize" has an optional ":disk" modifier, but that doesn't
> change formatting (just the value of the integer printed). "numparent"
> doesn't have any modifiers, it just prints the integer number of parents.
> Otherwise, everything is sorted by string value, so I think only the date
> atoms have this kind of mismatch between formatted value and sort value.

Thanks.
