Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0EE1353E8
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134023; cv=none; b=LsV1ybslfZkenkOvvsBftQ5GDxO6FdX2Zo4MuA7S9+wsE5s9NW4C/QpK7iuDQXq+ItGlqU+jfhIi4jahxj9P9NbyRgAh2oPYJip7/t9eB7D1xu+I/C4OFvrI3UKFmSDSeCcO+letqbxLgCkSGH8zOG30m+jIGtQJuwdN62T9huw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134023; c=relaxed/simple;
	bh=hmKYz46P1rLtyE/R2A2fr9Cor4Qai2UTUcU9puqB6sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1/XX4eCFjLdC3MrCLsm1GUcQFUGJ2H+tlECZWp+vD9E2fhJxdWcK0hRdqvQQ9ffzqtjV4P5NPgzlWd2cuvJW6gA00kJPSVi12zkQ/i0qYHvsSPvb1HZDfnY4flB45B2WRsUNGlD8TSXiOsPdXGQmpzYRG/6CiLMWub3tJeHqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4TKyjb4bRqz5tnj
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 23:06:59 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4TKyjQ53wjz5tlC;
	Wed, 24 Jan 2024 23:06:49 +0100 (CET)
Message-ID: <0a061bee-9b78-419f-9f1a-ced69ca96002@kdbg.org>
Date: Wed, 24 Jan 2024 23:06:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] revision: Implement `git log --merge` also for
 rebase/cherry_pick/revert
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mi.al.lohmann@gmail.com>, git@vger.kernel.org,
 phillip.wood123@gmail.com
References: <xmqqzfxa9usx.fsf@gitster.g>
 <20240117081405.14012-1-mi.al.lohmann@gmail.com>
 <20240117081405.14012-2-mi.al.lohmann@gmail.com>
 <CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
 <dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org> <xmqq1qa6ecqr.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq1qa6ecqr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.01.24 um 20:46 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Good point! IMO, REBASE_HEAD should have lower precedence than all the
>> other *_HEADs. It would mean to reorder the entries:
>>
>> 	static const char *const other_head[] = {
>> 		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
>> 	};
>>
>> (and perhaps adjust the error message, too).
> 
> And probably give a warning saying that we noticed you are rebasing
> and cherry-picking and we chose to show the --merge based on the
> relationship between cherry-pick-head and head, ignoring your rebase
> status, or something.

I don't think that's necessary. When rebase stopped with a merge
conflict, neither of the other commands can begin their work until the
conflicted state is removed. That should be a concious act, just like
when thereafter one of these other commands is used and leads to a
conflict. At least I would certainly not need a reminder.

-- Hannes

