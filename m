Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53F3A16B0
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460672; cv=none; b=L+L7QZYcfriqxUO2BIiswymQP9FT5qxEXW9cA9d1D+XI3XU0VY8tGQW84ZWbkHVrapRxPJPMynVf8oPZEUv9sXu0AJcWZF8ybkVpTfNICnqmit2CARYH480b7hfFyyUkwLWPV2Y0fFTWYslxTKAmDUte2U2NEjKQcX+1SP2s9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460672; c=relaxed/simple;
	bh=pqwQ7CEk6x821jDD1lQacIUyQtJn5NLVX6Y7mxjtsvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxYu85ia0sSY/RvRwKdPsHId9OU6Kq3FVUOhsrHq61PAVV5KaggYsrFJyEo5iPhp8PVCfCG7oFpKMkkKdDMaIpWuLXd+baLEfl33TJ0vtln+TafsK39NzophVv/iQAcsFQbxnMLjxoZD6adHktTqKvOndyYphFYvZxqFH3IY7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4fgvRS6CJRzRpKn;
	Wed, 25 Mar 2026 18:44:20 +0100 (CET)
Message-ID: <251cbdd8-26ca-4569-9801-5eb278de7e0c@kdbg.org>
Date: Wed, 25 Mar 2026 18:44:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v4 0/3] graph: add --graph-lane-limit option
Content-Language: en-US
To: Pablo <pabloosabaterr@gmail.com>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <fae2f8e3-029a-43c7-aa6e-45a452026853@kdbg.org>
 <CAN5EUNTXy+cFyHApdrhGKUqrvBGO0bb9X-=MaAWgp4DWOAkA-A@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAN5EUNTXy+cFyHApdrhGKUqrvBGO0bb9X-=MaAWgp4DWOAkA-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 25.03.26 um 13:28 schrieb Pablo:
> Johannes Sixt (<j6t@kdbg.org>) writes:
>> Let me suggest a different separation.
> 
> I'll merge 1st and 2nd patch together into a single one, adding the option
> together with the actual logic that does it. This fixes what SZEDER said about
> the first patch alone breaking the build.
> 
> And the documentation + tests on a separate commit.

It is better to add documentation and tests in the same commit that add
the feature, because both serve as a specification what the code is
supposed to do. This way reviewers can decide whether the code does
indeed work as designed. On top of that, when the code has to be
inspected later, the commit that introduced the code shows immediately
whether a certain behavior was intentional or not.

So, you would end up with a single patch.

But to make reviewing easier, I proposed a different split:

>> 1. The first patch limits the graph width with a hard-coded limit, say
>> 15 lanes. It limits the graph *always*. Choose a limit that is large
>> enough to pass all tests.

This change will touch the graphing engine, but almost nothing else.

>> 2. The next patch adds --graph-lane-limit and its documentation. Let it
>> do its thing. Revert to the default limit value 0, i.e., unlimited.

This change now introduces all the plumbing that passes the user's
option through to the engine.

>> 3. Next, add additional eye-candy. I am alluding to the line that marks
>> where a graph lane was truncated.

If possible, this change provides final touches that can reasonably be
left out from the first patch without compromising its basic functionality.

>> (4. If more detailed document is warranted, e.g., an example chart, do
>> this as a separate patch that can now show all bells and whistles that
>> the earlier commits have implemented. Whether this makes sense as a
>> separate step, or whether documentation grows with the earlier patches,
>> is a judgement call.)

This could be a new paragraph in the manuals with example charts if
doing so makes sense.

-- Hannes

