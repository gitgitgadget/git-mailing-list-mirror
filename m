Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBC4EB55
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883385; cv=none; b=Is7HeyuwKF4QUE5PW/g5bhP3YKMuB5T4aTQvoaXDrItZ3ZozXVPtHwmf1OScXxFpkTk2xy3ysg3VDZjQzUu+QVf+jRIal+25FUmt7zOn7TlRskc4M9UVjH6drLfIdO6gq8JglLlNLwNxE4ncqd3yG+UaqHH5qBofckMMxEvySo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883385; c=relaxed/simple;
	bh=dZwgmfb4oix2J/ljrZqjsTcxgATmPguxXSEby8apV/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiZS3072a3SkPkYp61cvS1YudvRNP51iEJL9vLpG/jQFbCj6/XnjBjayBOHTK7RIKgDgYRHF/+JQF4dTIQzuZ6TR/tSTWZf0y1mTtlQG2eS1fkJNFgNspF/0vInFICUte9++GL76GbjDuCgBVBLQ0I3CkyDvPpR+tSnvGV3wWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=WYS3yKdd; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="WYS3yKdd"
Message-ID: <29901b21-83bd-4746-b08a-c428eed27604@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710883378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7zLp9L5S+ikwe+VRUz+9QdUjonRjC6qEGkwyKmPz74=;
	b=WYS3yKdd/S4tvOm8xYb0lT5r7EhtlzlTlsEfWx39p/di3B2mWOuoZ5n2lMTMH5VguFAeQM
	0LZTGfe3JV3WYtasrV1ChUyKX7yp7+kxXV4ANCMX3n2zSLNaezYG9G05ZnHzXjWBry1PqQ
	VIcNQuaxVKR7XF/CFQ7xAfqrnGuHE5ARAAQsQcI0tW96O6+kbXE4O0cM3uTAqHKNiemeBM
	xGF5yVoVxZ15hK80TzQjii8TNo37BsyQtYiFmLfIIJ/C9DMh+D4j0uxjCRyxvNgGhsMcAS
	ZZ0SbMz9Fz+qbe/ED9PEMemcRJVE0UdhLohhVUSgjkCH5J7ScHPW3uz5Lg0I1A==
Date: Tue, 19 Mar 2024 22:22:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
Content-Language: en-US
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 rsbecker@nexbridge.com
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 19/3/24 21:55, Eric Sunshine wrote:
> On Tue, Mar 19, 2024 at 2:38 PM Ignacio Encinas <ignacio@iencinas.com> wrote:
>> It was pointed out that it wasn't particularly obvious what it was meant by
>>
>>   "If the current hostname matches the pattern, the include condition is met."
>>
>> which is definitely true. Despite this, to my knowledge, there isn't a
>> way to precisely define what we mean by "hostname" other than saying
>> that we mean whatever is returned by gethostname(2).
>>
>> I still think the documentation isn't great, but I don't see a way to
>> improve it further.
> 
> Peff provided the answer when he suggested[1] implementing `git config
> --show-hostname-for-includes`.
> 
> [1]: https://lore.kernel.org/git/20240318081722.GA602575@coredump.intra.peff.net/
 
Sorry if it sounded like I disregarded the opinion. I did see it and
liked the idea, but I guessed something like that would face a lot of
resistance. My bad.

>> 1:  cf175154109e ! 2:  dec622c38916 config: learn the "hostname:" includeIf condition
>>     @@ Documentation/config.txt: As for the naming of this keyword, it is for forwards
>>      +`hostname`::
>>      +  The data that follows the keyword `hostname:` is taken to be a
>>      +  pattern with standard globbing wildcards. If the current
>>     -+  hostname matches the pattern, the include condition is met.
>>     ++  hostname (output of gethostname(2)) matches the
>>     ++  pattern, the include condition is met.
> 
> This is still unnecessarily user-hostile, especially to users who are
> not programmers, but also to programmers who don't want to waste time
> writing a little test program to determine what gethostname(2) returns
> on each platform they use. That's not a great situation.
> 
> Peff felt that adding `git config --show-hostname-for-includes` was
> probably overkill, but I'd argue that it is necessary to enable users
> to deterministically figure out the value to use in their
> configuration rather than having to grope around in the dark via
> guesswork and trial-and-error to figure out exactly what works.
> 
> And the option name doesn't necessarily have to be so verbose; a
> shorter name, such as `git config --show-hostname` may be good enough.
> Implementing this option would also obviate the need to implement
> `test-tool xgethostname` (though, I agree with Junio that `test-tool
> gethostname` would have been a better, less implementation-revealing
> name).

Lets find this a good "home" then [1]. Thanks!

[1] https://lore.kernel.org/git/CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com/
