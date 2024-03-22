Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF2C67750
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144753; cv=none; b=gByXEwcqDArATSpQbjaj24El1FhaCSO9sbwYnrCrRmsMnZ3Ud6H5a6+Jj63uvYZaJE2tvxVggFdB5DsOwg/PQ73oO8RfA0tyKqPsO4hVSdWxiJtwd9n1IVJMTU23Qk706oacQOowbE91axij+Qxuqm2SXGdWpTUVUvt5sNOPaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144753; c=relaxed/simple;
	bh=+4FeGT0nY3M3zO5+DwetCEB53gtWv6VDRe9GIdLg31Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1EyUS95a4oTiveTqlqOJOCTa4ARTUe2ssPKq4xQmE4DdCNl5+5zP9DJGkg7GyyQOo4aJDxfK3iieDRXw583u/oYoNKMbK5BqbqwOr+ggrulFMJ8nWs6VeGqd83ufV7JeMeaY+lOap3QnzubUXTDE4MYsFmRsk+IYMKkPILvkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=EM/msO0k; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="EM/msO0k"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 3257B19FD408;
	Fri, 22 Mar 2024 22:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711144749; bh=+4FeGT0nY3M3zO5+DwetCEB53gtWv6VDRe9GIdLg31Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EM/msO0kPm4dLVTmvzXHKv7LNMXz6Nz6DnEh6glzfuXRjw7K331nm3EYfy7jJ0o0a
	 gAL2niqB23MruQxhcbbQRVRH52bRQyinBg2PSaKH4QVt1gaka0F1ElOOejcpiKDFpN
	 0WKstJ05R9b8GzBiS328bcFKLXeF9+BqRJAUpBzc=
Message-ID: <71f2d0e3-d3e5-4d6a-96d5-863a47b3ffc4@schinagl.nl>
Date: Fri, 22 Mar 2024 22:59:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
Content-Language: nl, en-US
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
 <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02-03-2024 19:02, Karthik Nayak wrote:
> On Sat, Mar 2, 2024 at 6:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> This patch series adds the diff.wordDiff config option. This mimics the
>>> '--word-diff' option of `git-diff(1)`.
>>
>> Is it even be sensible to introduce this configuration variable in
>> the first place?  What would this do to users who set this variable
>> and use third-party or their own scripts that run "git diff" under
>> the hood?
> 
> This is definitely a good question to ask. I'm primarily not a user of this
> option, and this patch series was more of to start this discussion, based
> on the request. I'm comfortable dropping the patch series too if it doesn't
> make much sense.

As a human user, I would very much like to see this feature :) It helps 
much to visually distinct things, but `git diff` sits way to deep in my 
muscle memory to remember my alias. Also, we have a configuration system 
to set configuration options for many things.

I wonder though, how many other configuration options we already have, 
that potentially break 'random scripts' because the user has set it ...

> 
>>
>> The usual answer is "these tools should be using the low-level
>> plumbing commands like diff-files, diff-index, and diff-tree", so I
>> am not worried about it too much myself, and the above is purely the
>> devil's advocate comment.
>>
>> Having said that, running
>>
>>          $ git grep -e 'git diff '
>>
>> in the collection of scripts I use [*] to work on this project, I am
>> reminded that I may have to be a bit more conservative than I
>> currently am about the risk of breaking scripts with the changes
>> like the one being proposed.
>>
>> The proposed feature also may break those who use the git-prompt and
>> diff-highlight available in conrib/, even though I am not sure how
>> badly they would break, because I only looked at the lines given by
>> this command:
>>
>>          $ git grep -e 'git diff ' -- \*.sh ':!t/'
>>
>> and didn't check how the output from 'git diff' is used.
>>
>>
>> [Footnote]
>>
>>   * They can be seen in the 'todo' branch, if anybody is interested.
> 
> Having said that, wouldn't this cause a problem only if the config is set up?
> Meaning the user must explicitly set `diff.wordDiff` for their scripts
> to potentially
> break. In that sense, is it a breaking feature?
