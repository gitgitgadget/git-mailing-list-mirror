Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889B12FB34
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541743; cv=none; b=HxZT+0U5R2YQTCBlXMq6U8jOK27gLdk38BchQ+Lkyk4hXNUh2zIHgqIWIN+BvrOEy6G0BWhTW+bdcgO5CuC3aXHHiMD4CnI6SHxvg7b1dEVLdhawNaiBY6DE6fC+oR89/DSeR8YLGQlmm+F4MIoLYLYia2uOI3sSGy5KSsI3X9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541743; c=relaxed/simple;
	bh=pV2rqE6ThzgJpz7GHRfTABdkTeg0hMW2BbqiZxP/W7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzdhZToxus+IwwKvGyMACl5vn4iXoP3FHar4CNHNpiP2QmSwaxkAvZcAf9TkMQMSPMP+8Xp7KFAbyPJND/n/6P0I4Vp9cegyOyKkly2V8zw7rqe6rgaP5gPkl1JcO2C7RywiWP9YK9wSjUp5UaMBrZV0gydxf67SBgAx7/mzuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KK/QRCmW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KK/QRCmW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F14BE2AF72;
	Fri, 19 Apr 2024 11:49:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pV2rqE6ThzgJpz7GHRfTABdkTeg0hMW2BbqiZx
	P/W7M=; b=KK/QRCmWFZV1T5DZc/Tp+3A/hkEeCxdBk+G0OBtP34+4PFPLn+fFSc
	4Q/tvi7xiczikz7Rd1/PPi1jDRNt108K1HeKd0lnYOobLkpTkj5Loj4kiAzfKMBH
	owGlHGB4FTE3KV5jXcy3LmMqJq1pArSUfuJgidFWbd+LJ91RSIGQU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E84C42AF71;
	Fri, 19 Apr 2024 11:49:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6FB2B2AF6E;
	Fri, 19 Apr 2024 11:48:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  chris.torek@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] update-ref: add support for symref-create
In-Reply-To: <ZiI8GaGupNzbLqnE@tanuki> (Patrick Steinhardt's message of "Fri,
	19 Apr 2024 11:40:41 +0200")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240412095908.1134387-1-knayak@gitlab.com>
	<20240412095908.1134387-6-knayak@gitlab.com> <ZiI8GaGupNzbLqnE@tanuki>
Date: Fri, 19 Apr 2024 08:48:56 -0700
Message-ID: <xmqqil0dmjyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55CCD078-FE64-11EE-BD11-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	if (!new_ref)
>> +		die("symref-create %s: missing <new-ref>", refname);
>> +	if (read_ref(new_ref, NULL))
>> +		die("symref-create %s: invalid <new-ref>", refname);
>
> This restricts the creation of dangling symrefs, right? I think we might
> want to lift this restriction, in which case we can eventually get rid
> of the `create_symref` callback in ref backends completely.

True.

>> @@ -2609,6 +2609,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>  		}
>>  	}
>>  
>> +	if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
>
> Let's add braces around `(updaet->flags & REF_SYMREF_UPDATE)` to make
> this easier to read.

Yup, the language may not require the extra pair of parentheses, but
human eyes are helped by them.

Thanks, again and as always, for carefully reading.
