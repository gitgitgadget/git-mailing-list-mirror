Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67BB14388F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597026; cv=none; b=Nk56wTt6A71RsMqILB9QR6BlBuADfRvB9TLpyWMhrTNGOusH/A885+VlTi7tC5zhqPOP+0khuqVhMh4qk9WDMbZ0Kx+SQixXN+KLYcDtr2CHXKIKN+nThLlHjFmahepFV2qqD14MH9axtiPj55b04yOv4k7daV4MQ/Rz84my5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597026; c=relaxed/simple;
	bh=orVe00HxiHZN+KiDRsZxr78jzbGsSwLawcXhh8DJUhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GgNNdor55PITGB0UJCmWYH5vhW9H0t7aO3ccAnyMohK2UIM1J2jkCqXFvHeOLLO3aSVCLIX/Q37cPiwgTqsggzwYKeiDJGVDEfAviXP18Lq2bFGxEATAooKCQh62rW3EcUrBLYev1PYU8AhTIQDk70vD6SZLRpBXv27oPvOYacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LEHBrIu1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LEHBrIu1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2AF41DA2C7;
	Mon,  8 Apr 2024 13:23:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=orVe00HxiHZN+KiDRsZxr78jzbGsSwLawcXhh8
	DJUhA=; b=LEHBrIu144s2oInDgDxvqvxNsVFkYe755ag8wUjju0Ie5NaKkFWC7T
	ElljwkRAiK75XIIgoOzIE7LyZzbUx2obt4RUrzXxtDqKPN9zIDcp57/UR+yQo6DU
	evU+1Re4KBkDRBcjOliwKATD3K+ZN9iEMdVgo06aM+zaxa56iP7Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9875E1DA2C5;
	Mon,  8 Apr 2024 13:23:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B5F11DA2C4;
	Mon,  8 Apr 2024 13:23:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] t: local VAR="VAL" (quote positional parameters)
In-Reply-To: <ZhQNq4ITp68ikVVy@tanuki> (Patrick Steinhardt's message of "Mon,
	8 Apr 2024 17:30:51 +0200")
References: <20240406000902.3082301-1-gitster@pobox.com>
	<20240406000902.3082301-4-gitster@pobox.com> <ZhQNq4ITp68ikVVy@tanuki>
Date: Mon, 08 Apr 2024 10:23:41 -0700
Message-ID: <xmqqil0rdazm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF88CBAC-F5CC-11EE-9DE1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 05, 2024 at 05:08:59PM -0700, Junio C Hamano wrote:
>> Future-proof test scripts that do
>> 
>> 	local VAR=VAL
>> 
>> without quoting VAL (which is OK in POSIX but broken in some shells)
>> that is a positional parameter, e.g. $4.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  t/lib-parallel-checkout.sh | 2 +-
>>  t/t2400-worktree-add.sh    | 2 +-
>>  t/t4210-log-i18n.sh        | 4 ++--
>>  t/test-lib-functions.sh    | 2 +-
>>  4 files changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
>> index acaee9cbb6..8324d6c96d 100644
>> --- a/t/lib-parallel-checkout.sh
>> +++ b/t/lib-parallel-checkout.sh
>> @@ -20,7 +20,7 @@ test_checkout_workers () {
>>  		BUG "too few arguments to test_checkout_workers"
>>  	fi &&
>>  
>> -	local expected_workers=$1 &&
>> +	local expected_workers="$1" &&
>>  	shift &&
>
> I was wondering a bit why this is a problem in t0610, but not over here.
> As far as I understand it these statements are fine in practice because
> the expanded values cannot be split, right? So if "$1" expanded to
> something with spaces in between things would start to break.

Correct.

> In any case, changing all of these to be quoted feels like the right
> thing to do regardless of whether or not it happens to work with the
> current values of "$1". Otherwise it's simply a confusing failure
> waiting to happen.

Again, agreed.  That is where my "Future-proof" comes from.

The true objective of this change is so that the last patch does not
have to learn too much exceptions ;-)  As long as expected_workers
is expected to be a number (an unbroken sequence of digits), even if
we add more callers to this helper in the future, $1 we see here is
expected to be $IFS safe.  So in that sense my "future-proof" is a
white lie.
