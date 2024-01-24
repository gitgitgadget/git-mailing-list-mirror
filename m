Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435F133419
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127654; cv=none; b=ngx8QWxkjGdLdyBUR3VkZLrCsoPj1jUxe8QWKEvewLUoiWLGMqzD+iA8rAAkacFAwoWa8JY3Q8SA8hqPZER4wAQlohNOiG8OFx9ASi01YGVkUGBzGRgIRL9f3Cno5TS05Sv36i/wadOORrAi6N5+vnZRv4jUxUw6KLE7ke/CISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127654; c=relaxed/simple;
	bh=Nrbu2l9qjuATpve8GUTg/6huLqRF+sdoUVSZ/Sbwboc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GN3izfJ1kdtlzHI22eGk0Ms7Xr1R0LW8CAyWwV2H68Lvs8ILByk+teYdNM35lGEE2i/wL/SYX94XXlgFYJvRVWBmS4G8YwgM47OJAqRCdQvWI2NoQZn7kH6XN+2wvNXCNl2HvW4mMk6/Q6wl3Id+xtje11Y4q5jc3f6UQ91iZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VLuxMuqy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VLuxMuqy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8095C1BF9C;
	Wed, 24 Jan 2024 15:20:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Nrbu2l9qjuATpve8GUTg/6huLqRF+sdoUVSZ/S
	bwboc=; b=VLuxMuqyCqnbCd+sdy18R5gXw8GNoCdVnAnB9AQBGqZADymEm0MiI/
	XrQKXfVtO5cl/0Vu3QQqxZQ3rLNCgqNEnl0afN1Qa9RSYFFQUKlaECYRSewV1qGd
	Kh48Or1G5tJKypUe3FsN/k1lGgkjjU5Uu+43taggcPDAYlksTkpAI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 78E111BF9B;
	Wed, 24 Jan 2024 15:20:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F02431BF9A;
	Wed, 24 Jan 2024 15:20:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mohit Marathe <mohitmarathe@proton.me>,  Mohit
 Marathe <mohitmarathe23@gmail.com>
Subject: Re: [PATCH v4 1/2] git-compat-util: add strtol_i_updated()
In-Reply-To: <60ea85a701a05831b0adf1e3f9a7a97fd31ef43f.1706079304.git.gitgitgadget@gmail.com>
	(Mohit Marathe via GitGitGadget's message of "Wed, 24 Jan 2024
	06:55:03 +0000")
References: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
	<pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
	<60ea85a701a05831b0adf1e3f9a7a97fd31ef43f.1706079304.git.gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 12:20:47 -0800
Message-ID: <xmqqede6cwkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 101ADE64-BAF6-11EE-A9DD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mohit Marathe <mohitmarathe23@gmail.com>
>
> This function is an updated version of strtol_i() function. It will
> give more control to handle parsing of the characters after the
> integer and better error handling while parsing numbers.

i2 was horrible but this is worse.  What would you call an even
newer variant when you need to add one?  strtol_i_updated_twice?

To readers who are reading the code in 6 months, it is totally
uninteresting that strtol_i() is an older function and the new thing
was invented later as its update.  What they want to learn is how
these two are different, what additional things this new one lets
them do compared to the old one, namely: we can optionally learn
where the run of the digits has ended.

Perhaps call it "strtoi_with_tail" or something, unless others
suggest even better names?

Thanks.
