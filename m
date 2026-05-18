Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE33AB26E
	for <git@vger.kernel.org>; Mon, 18 May 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089415; cv=none; b=TWiMHAhV9YQ9X5Ht02YV9jbxDxvuRCt8UUXHMVgq0Xc3Ottry40MYWzaaEwt+G18L2UFZ3sI2ouKu9TIchjFY4JN8y5RvLWYEbVO4iUbg6oVdbUGDKkcMZRZ+s+dIVrZGhRhus2qAmYbVtHlnS87YWTOr+qpnPYiEjJoew9npCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089415; c=relaxed/simple;
	bh=y64WkoCM0SwlKOqElBjw3ScJly8HSwhklxYiUOGdcfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loa2T1h30K6WICrML05ddtdJOgh+HmwK7E0OolYnNjJtjABppyKMby7ExmHssA7gPh668OlVweeScxQ8jhn3Xo1LNYltN196VnoyhuMaMCLDr2LySX7RH7OKt4bTthwk67n5Xz+WT53QgBm07qW/K32oGB+gHQ4Fmed7M8o/ntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gJqFm1NRrzRpKl;
	Mon, 18 May 2026 09:30:04 +0200 (CEST)
Message-ID: <89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org>
Date: Mon, 18 May 2026 09:30:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: vincent@vinc17.net, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g>
 <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 18.05.26 um 05:30 schrieb Michael Montalbo:
> On Thu, May 14, 2026 at 12:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Michael Montalbo <mmontalbo@gmail.com> writes:
>>
>>> @@ -457,6 +457,11 @@ endif::git-diff[]
>>>  +
>>>  Note that despite the name of the first mode, color is used to
>>>  highlight the changed parts in all modes if enabled.
>>> ++
>>> +Word diff works by finding word-level changes within each hunk of
>>> +the line-level diff.  The line-level alignment determines which
>>> +changed lines are compared to each other, which can affect the
>>> +word-level output.
>>
>> The added text may not say anything wrong, but I am not sure how it
>> helps the end user to know the way machinery works internally.
>>
> 
> I see what you mean. Maybe the doc should focus more on calling out
> the user-facing implication:
> 
>   `--word-diff` finds word-level changes within each hunk of the
>   line-level diff, so changes that only affect whitespace may still
>   appear in the output.
I don't know what this paragraph is trying to explain. I don't see how
this would explain Vincent's observed word-diff.

The thing is, "word-diff" is such a descriptive name for the operation
that it is difficult to find a description that is even better. The
manual page doesn't even give it a try. It defers to --word-diff-regex
right away, which then only talks about low-level details and doesn't
attempt to give a higher-level description what a word-diff is.

I don't think you can summarize the algorithm in a single sentence. But
then I have to ask: why write it down anyway? How does it help the
reader? Only so that they are able to derive an explanation for a
particular observed output? Would it have saved Vincent to write a bug
report?

If we document the algorithm in such detail, we cast it in stone. I
wouldn't want to paint ourselves into that corner.

-- Hannes

