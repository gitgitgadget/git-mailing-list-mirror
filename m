Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C756740
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365021; cv=none; b=LUGjH/4Ovr6INingNOmVK2aodZEwy1S9de1m2G+tF4ll265sMnjqIpxeUN4U0jjzRT0P93kuPxVqgZF+AbtZN7pRN3jAfLjo9fikmqQghgNCNj1fPywd+IK5lwfVPjRPnnf0mNyk9Z0LFu4Vz2YrofBMfvaeFLI8H7NC7D/ocgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365021; c=relaxed/simple;
	bh=5w2RjpRkxd5TTZquQIZhAU0oEI2T5tYrSdMIoGqK0aQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cJMp+Jf48xxcQF0dRLzi/2VgBlqrR2qY/d1Ar4Er3wgSA7cuGxXAXJl2Rre2Qgk2WqI5o9t8hrcTNSqJNkZpdSSDiyEsW3m7eGups/jg7TkINMR/C7qCZV4NEWI2SkAJuqP9IQk9KMYzZHS8bZeHyq52dhRb7alsMYSscKwR7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RjTb3zYf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RjTb3zYf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C72351DECA9;
	Wed, 13 Mar 2024 17:23:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5w2RjpRkxd5TTZquQIZhAU0oEI2T5tYrSdMIoG
	qK0aQ=; b=RjTb3zYfzxN5HTnMMYVBwZ9eg31JQR+1gEhPgmd/ZlbvrxqCWTTuDJ
	s+CbB7xBOF9cXAEY9SC9NM6jVbGnoZGECg1pC/Pxc3qpvQqvkN+l8nUc9KrXcAdy
	jhzIHcErHHeG6zgHC/Nm0/f7gxv7sCcu+Pwq4pdTLK/EJpOtJXRlo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDFC71DECA8;
	Wed, 13 Mar 2024 17:23:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 356F51DECA7;
	Wed, 13 Mar 2024 17:23:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/3] cat-file: add %(objectmode) atom
In-Reply-To: <xmqq34swo1p2.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 Mar 2024 15:15:05 -0700")
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
	<b836bc64ddc06069d1722ae89ca049e9dfce7eec.1710183362.git.gitgitgadget@gmail.com>
	<xmqq34swo1p2.fsf@gitster.g>
Date: Wed, 13 Mar 2024 14:23:37 -0700
Message-ID: <xmqqfrwtakrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F4FC53A0-E17F-11EE-92CA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index ac1f754ee32..6f25cc20ec6 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -114,9 +114,10 @@ run_tests () {
>>      type=$1
>>      object_name=$2
>>      oid=$(git rev-parse --verify $object_name)
>> -    size=$3
>> -    content=$4
>> -    pretty_content=$5
>> +    mode=$3
>> +    size=$4
>> +    content=$5
>> +    pretty_content=$6
>>  
>>      batch_output="$oid $type $size
>>  $content"
>
> I wonder if appending $mode as an optional thing at the end would
> have made the patch less noisy?  After all, the expectation above
> that does not have $mode, and the tests that are expected to produce
> output that match the expectation, do not have to change.  And the
> existing invocation of run_tests that do not care about $mode do not
> have to change.
>
> But I guess if the damage is only with the above 7-lines (which
> would become just 1 if we made mode the $6 last tthing), it is not a
> huge deal either way?

Unfortunately, not really.

If we made the optional mode as the last thing, and allow
run_tests() to be called without an explicit "", it may have avoided
unnecessary conflicts with eb/hash-transition topic.  Interested
folks can see how well these three patches plays with the other
topic by trying to merge it to 'seen'.
