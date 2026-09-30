Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03934DAF99
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803228; cv=none; b=eW2p2Nvmsquyha3Y4qdNzM7MVRFsxFfqjyhfPEya903bOPSx37vvL0d0hIPH2zBgOpBLVu48iO/f/QkZOWlLJz4H8qFoxo9jDIZM8CrWMn2ouaVHETNJvEOHZNQEP5WB7tc5u8MoQNdAfRuGMI+UK2XhG2nhZRuaLM5ZcS2zgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803228; c=relaxed/simple;
	bh=t48RSpapjj4zd6ukY+i9UeGgGt3TxhxZDOTTidhjhBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iafW8xIq10STxxAkz+e9zLlxxglaPgHckdjJpfwYmTyqGhnY6f9mlHqCVjUbUOKCv1VV7RTCIV4nvwJJKDQSJ3h6wCYOtCoWrkPwsR6m03tSQFi1duSHHlFJBa6bsglr5q6mUHGeMZssYTzRgounsjOigXvckmoR1DuUb1yaeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4hw7HV6n52zRpKh;
	Wed, 30 Sep 2026 23:20:22 +0200 (CEST)
Message-ID: <35417989-d31e-470c-b366-f6632246112b@kdbg.org>
Date: Wed, 30 Sep 2026 23:20:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] checkout -m: recreate conflict labels
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 git@vger.kernel.org
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <223c99ea-64d9-46da-9631-ed8035f1a062@kdbg.org> <xmqqmrsy8ocd.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqmrsy8ocd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 30.09.26 um 22:40 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 30.09.26 um 11:48 schrieb Phillip Wood:
>>> When "git checkout -m <path>" recreates a merge conflict, it uses
>>> the labels "base", "ours", "theirs", rather than the labels used by
>>> the original merge. This short series teaches the ort machinery to
>>> write the labels to ".git/MERGE_LABELS" when it switches to a merge
>>> result containing conflicts, so that "git checkout -m" can then read
>>> that file and use the same labels.
>>
>> Would an index extension not be a better place to store auxiliary
>> information about merges?
> 
> Wow.  MERGE_HEAD, CHERRY_PICK_HEAD, and all others replaced with
> index extensions?


Absolutely not. IIUC, MERGE_LABELS should not be a pseudo ref, but a
file carrying auxiliary information.


>  That would unclutter $GIT_DIR/ quite a lot (for
> some reason, I find ORIG_HEAD is a bit of eyesore).  It makes the
> information less accessible, so I am not sure how I feel about the
> proposal, but it is an interesting thought.

I don't know how accessible data in an index extension is. But if it's
prohibitively difficult to access, then the idea is dead on arrival.

-- Hannes

