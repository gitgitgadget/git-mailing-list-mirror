Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162617554
	for <git@vger.kernel.org>; Mon, 13 May 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618076; cv=none; b=PCQQmq568TqkwdRa4Wi3aIdQObvqJEQo7PSWZ3aCpPh5WB2A48AOF7ExrKTFzDvPG9OclgxXxkb4bmQWXSBST+dem+36GbCMocN5enULKHDUr6cZk4WkGeSKcSqNqXHmkRhnOS27xNJ8TWFAnT3nXNWTaER+sZcUe4mzrRw4psM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618076; c=relaxed/simple;
	bh=uafo+gdK+e9hWD/UYwIh/odi2rUlyIMTb82QfYDzeWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DnwhJ7bmTAy2mdriW3U0qG5LXMfdnJU4ahDfYFk+HCQF4YPkJ/vbHxFpqu6tyi65u5/N+RIAZ67sEE7X6GgRfsHzBZask+0lfiMniUQE49+fmtmkbTaL86eMsd8adMUrqLM78QpclMBWQxva5XW+sh0HafMv/Zt4E3/HwQmC9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V5QSgqQP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V5QSgqQP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C6A23539C;
	Mon, 13 May 2024 12:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uafo+gdK+e9hWD/UYwIh/odi2rUlyIMTb82QfY
	DzeWQ=; b=V5QSgqQPrHSzTWBUWDwniQ4+iDtrhYJDK+QkLBnHaDxOCfg0Tg53cY
	3YEgC2IYD2YV7Zcg5NuTe+lVnpw6x6FAOK1u50LhMN7KZEqepox88HV4OJ0HOBgj
	ShkZ6fwE+0fywM7CtoiA48H5PNPslrcRBIfYsLUM1HrsEtHqRdzII=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 154A43539B;
	Mon, 13 May 2024 12:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BF363539A;
	Mon, 13 May 2024 12:34:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #05; Sat, 11)
In-Reply-To: <ZkGp9TqxO8Y5_kM_@tanuki> (Patrick Steinhardt's message of "Mon,
	13 May 2024 07:49:41 +0200")
References: <xmqqy18ghqqh.fsf@gitster.g> <ZkGp9TqxO8Y5_kM_@tanuki>
Date: Mon, 13 May 2024 09:34:23 -0700
Message-ID: <xmqqbk59hdrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A8A50E1A-1146-11EF-8614-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/pseudo-ref-terminology (2024-05-10) 10 commits
>>  - refs: refuse to write pseudorefs
>>  - ref-filter: properly distinuish pseudo and root refs
>>  - refs: pseudorefs are no refs
>>  - refs: classify HEAD as a root ref
>>  - refs: root refs can be symbolic refs
>>  - refs: refname `is_special_ref()` to `is_pseudo_ref()`
>>  - refs: rename `is_pseudoref()` to `is_root_ref()`
>>  - Documentation/glossary: define root refs as refs
>>  - Documentation/glossary: clarify limitations of pseudorefs
>>  - Documentation/glossary: redefine pseudorefs as special refs
>> 
>>  Terminology to call various ref-like things are getting
>>  straightened out.
>> 
>>  Comments?
>>  source: <cover.1715330206.git.ps@pks.im>
>
> There have been a bunch of comments on these topics already, and overall
> they have been positive. Is there something specific that you want to
> see here?

I did not get the feeling that we have given the series enough time
to be seen and get commented on; indeed v4 has not got enough time
to get any comments yet?

Also you haven't responded either positively or negatively to
comments on v3 07/10 by Peff?
