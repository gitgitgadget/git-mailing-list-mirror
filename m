Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA5158D9B
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022087; cv=none; b=qVg12j85r7Ye2wprULOX22nVatgRVerPDd6ng1LaUH6g7lt5YnBN1p3Rg8wv7jM6C7s8gH+w5faDiVZXd/ZuYFEc1mDMwNObC5B+zT717ORS7Y2EufUdVcwHAHtXk3jljKhWSojGU0l7chexQBYRQWICoR+32upiqLPZXJJ0k5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022087; c=relaxed/simple;
	bh=UHYzC8xLKUlXG8UQ/p8o6k+OxdM3Q6DAdQnUhveVvUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vC6A9WAhLgovt7RtO1WD/fRDOOXi7IBlT4YNF6sZBW9idIioslILLNBjFoIuLtjeGFDGOGCIjmTmMqTHP9Ogztfdb0hpvipnmCk+zedlE6E/by9lHKhdgtSWr09UXRiYH5g7N04RjnVHRVzQ5KbDLJzB20lsF3Ta3/GMaYCZVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W8uOoc+O; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W8uOoc+O"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F23F422A83;
	Mon,  6 May 2024 15:01:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UHYzC8xLKUlXG8UQ/p8o6k+OxdM3Q6DAdQnUhv
	eVvUs=; b=W8uOoc+O21o428Ft37C3TtseStDFvTVdwN8mmllxbcGpXBvexGVEhL
	4nc8diczQfc82bCrbD2u+gNikhaneytCC54G/2VMTxE224eeA/e3D4hD6Ks9gXhn
	3NSrzYOYm+MOyxzTo2yhNFupCIjKyO9jvxuMHkdl46cqFk3ZxVwr8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA35B22A82;
	Mon,  6 May 2024 15:01:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D62022A81;
	Mon,  6 May 2024 15:01:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Ivan Tse
 <ivan.tse1@gmail.com>
Subject: Re: [PATCH v3] refs: return conflict error when checking packed refs
In-Reply-To: <CAOLa=ZSre3f+0SR-_migfkPONqhinobKjU=NnGOJ_sTNM_L5ug@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 6 May 2024 04:40:46 -0700")
References: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
	<pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
	<CAOLa=ZSre3f+0SR-_migfkPONqhinobKjU=NnGOJ_sTNM_L5ug@mail.gmail.com>
Date: Mon, 06 May 2024 12:01:23 -0700
Message-ID: <xmqqttjaydbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08BB2148-0BDB-11EF-9663-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index a098d14ea00..97473f377d1 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -794,8 +794,10 @@ static int lock_raw_ref(struct files_ref_store *refs,
>>  		 */
>>  		if (refs_verify_refname_available(
>>  				    refs->packed_ref_store, refname,
>> -				    extras, NULL, err))
>> +				    extras, NULL, err)) {
>> +			ret = TRANSACTION_NAME_CONFLICT;
>>  			goto error_return;
>> +		}
>>  	}
>>
>>  	ret = 0;
>>
>
> Shouldn't we also do this change in `lock_ref_oid_basic` where we gather
> the same lock again for creating the reflog entry?

An interesting question.
