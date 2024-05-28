Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC014E2C8
	for <git@vger.kernel.org>; Tue, 28 May 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917080; cv=none; b=WBsFbm6UV1HQcd8ZOJ9QwcDJAyAQcHZ0QuXMeep3IPOHdnPYK+dtUQU3Ic6oTKYRrYxLmiSdZnLmLgn4eYVh3le9UkCPmaE52zsfKek13ysgjBF10KRfJ4HeTqTt6GzLfVCD6PJfX6APDGRBtt9KHdkssVS9EhNpCj5uTRB+Jk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917080; c=relaxed/simple;
	bh=V5xqhJjpL4le+5pOLWQLmR6FBB/i5Vp1RkCfg2gADqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hnEG7N57hVBFs5kVw6O+i7qBnwqQ22vHm1x+xu6LAS3FVAUA7RrMJHCOOckkikWDV55VeF+XZP7TqIPq90tW2yRMtfmmwY8RgJc0cDl4pVGIdAK/NA7qbmK3fxhVqyzItTDIcC+8ui+s6heXmRHmFBmwg7Nk/Zou/8AhgWLHdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BwN0+qOl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BwN0+qOl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B47E1B171;
	Tue, 28 May 2024 13:24:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V5xqhJjpL4le+5pOLWQLmR6FBB/i5Vp1RkCfg2
	gADqw=; b=BwN0+qOlintnq7d5DRZAitTEmMbYiLL80vdUDNQroBBG5FBJN7KEaN
	XDaznoKYzX11KGx46Nkv+Xk0tjXnQ46OmZqKMVGsEcKCCuwPPuk1dCwD3d2Zl9qC
	8AemNcwQA38+2bfxV7rIyfEJVzg9izrD9cuZuXz5HOziszIadY/EY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 818DE1B170;
	Tue, 28 May 2024 13:24:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4BBE1B16F;
	Tue, 28 May 2024 13:24:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  blanet
 <bupt_xingxin@163.com>,  Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 3/4] fetch-pack: expose fsckObjects configuration logic
In-Reply-To: <xmqqikyx6ew9.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	28 May 2024 10:10:46 -0700")
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
	<pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
	<67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>
	<ZlXIBrs5Q91r_-qU@tanuki> <xmqqikyx6ew9.fsf@gitster.g>
Date: Tue, 28 May 2024 10:24:35 -0700
Message-ID: <xmqqbk4p6e98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2850469E-1D17-11EF-BAC9-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> +int fetch_pack_fsck_objects(void)
>>> +{
>>> +	fetch_pack_setup();
>>> +
>>> +	return fetch_fsck_objects >= 0
>>> +	       ? fetch_fsck_objects
>>> +	       : transfer_fsck_objects >= 0
>>> +	       ? transfer_fsck_objects
>>> +	       : 0;
>>> +}
>>
>> ... can we maybe rewrite it to something more customary here? The
>> following is way easier to read, at least for me.
>>
>> 	int fetch_pack_fsck_objects(void)
>> 	{
>> 		fetch_pack_setup();
>> 		if (fetch_fsck_objects >= 0 ||
>> 		    transfer_fsck_objects >= 0)
>> 			return 1;
>> 		return 0;
>> 	}
>
> But do they mean the same thing?  In a repository where
>
>     [fetch] fsckobjects = no
>
> is set, no matter what transfer.fsckobjects says (or left unspecified),
> we want to return "no, we are not doing fsck".

The original before it was made into a helper function was written
as a cascade of ?: operators, because it had to be a single
expression.  As the body of a helper function, we now can sprinkle
multiple return statements in it.  I think the way that is easiest
to understand is

	/* the most specific, if specified */
	if (fetch_fsck_objects >= 0)
		return fetch_fsck_objects;
	/* the less specific, catch-all for both directions */
	if (transfer_fsck_objects >= 0)
        	return transfer_fsck_objects;
	/* the fallback hardcoded default */
	return 0;

without the /* comments */.
