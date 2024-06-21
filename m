Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1612D76F
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951608; cv=none; b=RrD1TXDG/9Sa6ANfz17bR4lWFx3cDTlJbcfAVkFP7qoPvES+hoU2nUu3+4iGPQbTMEgA65hIT9fs+f8/tx/1wD9h4R0FSDqb4LsYjnXtTXkhoKjP7LnBROp5PZMYBXxbZWVJp0u8Mk56gS/g/IYB3XLg7Rv/im9K6q3nlJejmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951608; c=relaxed/simple;
	bh=Vy2SCW4luPGg2cbVHXdn8y65/87rAF4YHzYT0qPShHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpuXa7d/OVZNDtdFTMijycriWccnXAfmBdvh0pj8Us63Z6N+7i9CsATUg2c/BxB43wOsl2KYGI4MZ+pXg75hj/glHSYUOwwwoPj+9Y/kC3+qzfydWdXoPp/CuRPVLYB5Vtf354BoTPknA0ppYFZMWHn5QYdXdKsN/AS8kXB94YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=idIbH3Vc; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="idIbH3Vc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1718951603;
	bh=5O5lYuoyssz4lNOhx+Em6TLyU6qz6RWsJ8aa2hF0Rpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=idIbH3VchyQXtuJstxwfSjM3FKcSj3NQLW8i3BvUKI/gsjQf9NYSZ8HIED8ri02TR
	 Wq2nmTHjzxBfvx5/vP7ysJOjkAoisPHxN/7nICUxejNkey0AjxgYQgigekbj7EwAQz
	 xNHYfdKkMww0ru1m3CmYdSfgglq7VL1rQEgTUdzrR4yHbCzPaHdo5BqjNUxqIKEEwL
	 5or/dYUHHW6UwFpsjsq/gqAI2paNSnCo/ynlp1iABofgWY84/MAmGtqcLKKJeNJIdL
	 U0e70vw7YRsoZvt9G1VJs8N2qJ4lk54qGh9G/Fwj4AQGSjuen6fL2DVyHJybLlUBOk
	 M9NRj3TQejeRw==
Received: from [192.168.42.22] (i5C74DC1D.versanet.de [92.116.220.29])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id D3C633C09AB;
	Fri, 21 Jun 2024 08:33:22 +0200 (CEST)
Message-ID: <dd58a60d-a551-4726-85a7-f47b851914be@haller-berlin.de>
Date: Fri, 21 Jun 2024 08:33:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thoughts about the -m option of cherry-pick and revert
Content-Language: de-DE, en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
 <xmqqa5jfoxvh.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqa5jfoxvh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 21.06.24 04:03, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> - Wouldn't it make sense to default to -m1 when no -m option is given?
> 
> Given that the current behaviour was chosen to make sure that the
> user is aware that the commit being reverted/cherry-picked is a
> merge and has a chance to choose the right parent (as opposed to
> blindly picking the first parent that happened to be the right one
> by accident), I am not sure if it is prudent to change the
> behaviour.

Hm, in all example scenarios I experimented with, picking the wrong
parent would result in an empty diff, and consequently an error message
like this:

   nothing to commit, working tree clean
   The previous cherry-pick is now empty, possibly due to conflict
   resolution.
   If you wish to commit it anyway, use:

       git commit --allow-empty

   Otherwise, please use 'git cherry-pick --skip'

I'm not sure if this error is easier or harder to understand than the
one you get today when omitting -m, but we could probably improve it by
mentioning the -m option if the cherry-picked commit was a merge.

I'd be interested in example scenarios where both sides of the merge
have non-empty diffs. Won't this only happen for evil merges?

> If I were simplifying this, I would probably
> 
>  (1) disallow cherry-picking a merge (and suggest redoing the same
>      merge, possibly after rebasing the copy of the merged history
>      to an appropriate base as needed), and

This seems unnecessarily restrictive to me. Cherry-picking merge commits
using -m1 is useful, it's an important part of our release workflow at
my day job.

>  (2) allowing reverting a merge only wrt the first parent,

Interesting, that's what I'm considering doing in lazygit (except for
both revert and cherry-pick), but I kind of didn't expect much support
for that idea. :-)

-Stefan
