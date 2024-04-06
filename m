Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72D4CB38
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712431086; cv=none; b=TjvzY97BvPyxcsLRgUlO85Yh00rb2NExGoPSOdegPlwCl0gviieEbCi5YKJBak4AMTSrdoOjWUZfA0ne5lz+3Jbo/NBCDtP2xbdk5J8tul4XZiQ7AuRrwqs6p/eIT45JzZnAHG60Bd023U/FXIDirfGZRPJgl7ovpVEPyJlVVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712431086; c=relaxed/simple;
	bh=PrCMU3vkJmYzn6nRMWhmHTE5y7b8glGxe6b9ZwL5zAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIUT1wcb44HQHQPu/NR1XCjR4xqk+hqlTdZLOBiX3717T8wNizTkj4/ydzPLnuGEKSHnutPXLroeZIFIfVmcdQ5ej9BjmEHS4LPzEaYKBJz6Z5fqx35L+Bma1O/Sbzi3dcx7xnaqRJa5hhjb7hfya38Fvc7V77fsitmn9ZeFi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=pskh8Vi0; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="pskh8Vi0"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id ACC351A181A3;
	Sat,  6 Apr 2024 21:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712431079; bh=PrCMU3vkJmYzn6nRMWhmHTE5y7b8glGxe6b9ZwL5zAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pskh8Vi0dvJZQ0WpcDtO8M5TmH1txU6MZe82zY2JSBKzX1rG7jzx6PHE2vL8IQoMb
	 TtyMe27eul86cyHEMr4POIU3B57vIfbCBS5NECuRZEjBIMjFCN8fgG54ztmFqJuof6
	 FXKPtayowKCUyc/hQPbBwp3FJjOfHA3YTJBvRSiY=
Message-ID: <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
Date: Sat, 6 Apr 2024 21:17:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Phillip,

On 06-04-2024 15:50, Phillip Wood wrote:
> Hi Olliver
> 
> On 06/04/2024 11:06, Olliver Schinagl wrote:
>> On 06-04-2024 03:08, Junio C Hamano wrote:
>>> Olliver Schinagl <oliver@schinagl.nl> writes:
>>>
>>>> Hey all,
>>>>
>>>> I've also got my work on a branch in my repo, if that helps to look at
>>>> things, https://gitlab.com/olliver/git/-/tree/skip_bisect
>>>>
>>>> Also included is a script to be used as an example. I opted to use
>>>> `git show`, which is nice because it works both on commits, but also
>>>> on notes.
>>>>
>>>> Anyway, any thoughts on the bellow before I send the full series?
>>>>
>>>> Olliver
>>>
>>> I would not write get_skip_when() before studying the same file to
>>> see if there already is a helper to read the whole file used in the
>>> vicinity (like strbuf_read_file(), perhaps).
>>
>> Fair enough. I'm a little worried about optimization vs readability. I 
>> think it makes it mre clear what the code does in its current form; 
>> but I'll investigate. Bisecting shouldn't be a computational often 
>> happening thing, so I'm not to worried about performance. But I'm not 
>> too familiar with the git code base, so I don't know either :p
> 
> If you search builtin/bisect.c you'll see some existing callers of 
> strbuf_read_file() that read other files like BISECT_START. Those 
> callers should give you an idea of how to use it.

Yeah, I found after Junio's hint :) What threw me off, as I wrote 
earlier, get_terms(). I wonder now, why is get_terms() implemented as it 
is, and should it not use the same functions? Or is it because terms is 
a multi-line file, whereas the others are all single line (I didn't 
look, though I see addline functions for the strbuf functions. Should 
this be refactored?

> 
>>>
>>> I do not have enough concentration to follow changes to
>>> bisect_auto_next() is reasonable.  Especially I do not know why
>>> "bisect-skip_when" wants to exist and what it is trying to do,
>>> besides the fact that its name looks horrible ;-).
>>>
>> naming things, sure. I can look into this absolutly :)
> 
> For me it's not just the name but the whole hook thing - do we really 
> need that rather than just the command line option?

So with the name, I started to think some more about it, and after 
playing with some names, I settled on 'bisect-post-checkout'. Things 
then sort of fell more into place. It is still a hook/commandline 
option, but it's a much smaller change (since we don't have any special 
code to check the exit code anymore) as we can (obviously) run `git 
bisect skip` instead of `exit 125` as well of course. The `exit 125` 
thinking came from `git bisect run` and maybe a suggestion on the ML 
earlier (I don't quite recall).

> 
> The other thing I wondered about is the exit code handling for the 
> "--skip-when" script. In Junio's example in an earlier message he used a 
> successful exit to mean "skip this commit" and an unsuccessful exit to 
> mean "test this commit". To me that matches the name of the option - we 
> skip when the script given to "--skip-when" is successful. Copying the 
> mechanism used by "git bisect run" seems a bit cumbersome as we only 
> need to know whether to skip or not, we don't need a special way of 
> distinguishing "skip this commit" from "this commit is good" and "this 
> commit is bad"

So as I explained above, I think just offering a 'post-checkout' step, 
and let the user decide what to do there, makes things even simpler and 
more flexible.

I've just pushed my latest changes to 
https://gitlab.com/olliver/git/-/commit/4361a5deb0c5ee4c113c25b57752af61b74aabf3 
and will start working on some tests before offering it for review again.

Thank you!

Olliver
> 
> Best Wishes
> 
> Phillip
> 
>> But in short, bisect_auto_next was returning just after checkout It 
>> seemed. So after checkout, running the script seemed sensible. But I 
>> look at it as a normal git user. So you checkout, test your commit, 
>> skip to the next one if applicable.
>>
>>
>> I'll think of your two comments, and see if I can address them as you 
>> regain your concentration :p
>>
>> But seeing that these are your main concerns, I'm more confident I'm 
>> not completly on the wrong path here.
>>
>> Olliver
>>
