Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCE15DBB7
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777998; cv=none; b=RS2L4od2qzo4spA33wfXgwsvKrzwVLb1W+I+n4/1WS68uw31x8I/87BbugpD9rmDGmsWM6CZ1RVx2Mk5PBkCfYWHQ8xE91XDHW8IFjvhb9V6f0FUzFlPJrOkNK2x4HQmq7yQiINT+j9towHs/qhHpOkGmMUqwxQ8BzJgjavY6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777998; c=relaxed/simple;
	bh=MrDMolBGo1uMx+hHhmcob4UeWuvibYYOyCalJTcrBIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtvyMgeHBn9fhhIJmd06FL0DXLydXc0SlKIyDjlnCbqo+mbZbXceMqo43LmEkmz7kZ/5C1O/V/KvGhoCdUUwjKyDA89QjXXyWDL3NzKwmH7Dj/4Qt0z/stnraWrnAR1n+hOEbHC933I3vyYTJ4I3WlHwibaudsjaD/yPD/EOixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=UIjaS5nB; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="UIjaS5nB"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 17B681A1F620;
	Wed, 10 Apr 2024 21:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712777993; bh=MrDMolBGo1uMx+hHhmcob4UeWuvibYYOyCalJTcrBIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UIjaS5nBizk4gsVPM1tM7Gvb7hlXpAikn/zsv5R7BGnOQm0if/fZ0dUm+d3beqNx3
	 p/eQ+/eeglK3myo0O+WvbrNB7AvCm2MM1RU47sEqou5hTmRZLqNmENU/bCQrh0cDPp
	 ETtjuZxUlikyOwscHZSYichwRVeM720sV9j2cqDY=
Message-ID: <0c9ad7f2-55e8-4763-8201-f29f15a39616@schinagl.nl>
Date: Wed, 10 Apr 2024 21:39:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
 <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
 <d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
 <2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
 <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com> <xmqqzfu3dcl1.fsf@gitster.g>
 <116dd27e-2e30-4915-a131-6c71c999fccd@schinagl.nl>
 <xmqqzfu1upty.fsf@gitster.g>
 <bb0dc4a7-e598-45f5-b707-e22de0890f26@schinagl.nl>
 <xmqqle5lrp46.fsf@gitster.g>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqle5lrp46.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10-04-2024 21:31, Junio C Hamano wrote:
> Olliver Schinagl <oliver@schinagl.nl> writes:
> 
>> See, the hook is named 'post-checkout' and thus, it runs after
>> checkout has been performed. So we are now on the 'broken' commit we
>> do not want to test, git should have skipped this already, and not
>> checked it out.
> 
> You are not the only user of this feature (by the way, do not call
> this a "hook".  It should be per "git bisect" session)

Yep, it is stored as part of the bisect session when invoked via as a CLI.

> and others may need to actually inspect their working tree state before being
> able to say "nah, I do not want to test this version, please give me
> another one" by exiting with 125.

So your use of 'You' and 'others' is a bit confusing, if it's me, the 
person, and 'others' the script itself. But yes, I fully agree with what 
you are saying I think. Just 'please give me a nother one' could be done 
in the script itself, or via exit 125 of course (where I totally get 
that doing the 125 routine is much better).


> That is why post-checkout is more
> useful in general.  Contrasted with that, a check that happens
> before the checkout is useful only in a much narrower "I can tell by
> looking only at the commit object name" use case, which I would not
> be interested in seeing.

So that leaves me in the same lack of understanding :p

If we run something post checkout, `bisect_checkout()` has run, and git 
bisect (the application) is (almost) done. The directory has been 
'checked out' (as `bisect_checkout()` of course does `git checkout` 
(unless `no_checkout` is used) The tree is of course in a bisect session.

So if a script runs, and does the 'please give me a nother commit' 
thing, how would that work within `builtin/bisect.c` (or in `bisect.c`). 
This is the part that would puzzle me. The command returns with 125, 
then what? How can git 'go on and give you a nother one'. afaik the only 
return codes from `bisect_next()` etc are BISECT_OK and BISECT_FAIL?

Olliver

> 
> Thanks.
> 
> 
