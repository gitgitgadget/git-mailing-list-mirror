Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDA14291E
	for <git@vger.kernel.org>; Wed, 29 May 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998962; cv=none; b=FE4WKcTG2XlMcgZLrCq+UFppC1qBu16TQ3zeXQf5uz/rx3mefp8CCOf9nqF/c2y9k6sS4QnRGB2xa0u8hj7YaYY081pj+32upWT3BM8VCW20QwD+dis8hUUReOPCxggw983WeZ9QXlEZTej4A6QlnKZm/M/ZtcrczvSOnWT4L0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998962; c=relaxed/simple;
	bh=0PN+tJzSwUpVVLUTxBRy4S6cn2D7WspJI4GJ3sgECMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BmRg6g8aqufUelywgRrI56D9dTBHF1+2/3wKGxYJ6s5zaKQOv0A69daull/P58nLq5h4y6UGuUSi5LmrZQAzfuZ/6tEaPBWYMJ/flb1LLWpwR/lNPH/phWmhvgnRZkgR5PED2i53HKA7PCjRlagvIAu69h2Aa77ZcqcJwFwe6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W1f08KcK; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W1f08KcK"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 425D22A381;
	Wed, 29 May 2024 12:09:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0PN+tJzSwUpVVLUTxBRy4S6cn2D7WspJI4GJ3s
	gECMk=; b=W1f08KcKzjKWxPJhzAGbXgVJo42KceMrOxIoNSIFYHGufEpkBh/pUs
	ZPOZTv0gkpR+c8vzQABzg71TNVXYXcz4IQoeHHeuHLVEwyFBT1Nv95REHFZ+DVve
	BYAXBV2nmSCTTtDu4x6kbi+HfFnsLnAi2+byVDaKU2SQYGE5pMvac=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 37E482A380;
	Wed, 29 May 2024 12:09:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4747A2A37F;
	Wed, 29 May 2024 12:09:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  ach.lumap@gmail.com,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,
  git@vger.kernel.org,  kaartic.sivaraam@gmail.com
Subject: Re: [GSoC][PATCH v5 0/2] t/: migrate helper/test-{sha1, sha256} to
 unit-tests/t-hash
In-Reply-To: <ZlbzOVgvSpUZOv8F@tanuki> (Patrick Steinhardt's message of "Wed,
	29 May 2024 11:19:53 +0200")
References: <20240526084345.24138-1-shyamthakkar001@gmail.com>
	<20240529080030.64410-1-shyamthakkar001@gmail.com>
	<ZlbzOVgvSpUZOv8F@tanuki>
Date: Wed, 29 May 2024 09:09:15 -0700
Message-ID: <xmqqle3szjkk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCCE0C24-1DD5-11EF-8AB2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 29, 2024 at 01:30:28PM +0530, Ghanshyam Thakkar wrote:
>> Changes in v5:
>> - addressd Patrick's feedback about formatting
>> - changed macros to be in do while loop instead of simple block,
>>   according to Patrick's feedback
>> 
>> Ghanshyam Thakkar (2):
>>   strbuf: introduce strbuf_addstrings() to repeatedly add a string
>>   t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
>
> Thanks, this version looks good to me based on the range diff!

Thanks, both.
