Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7A848E
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712524290; cv=none; b=I1ITj6YCXtIXZLEJ1tUblPubReuuUUjCxHu9odu6UzTgPENCKMBlhx/vCdRPkHWrp9G15/gKRq7BEw1kmORG42+93qGWpAa48OqigBzqGwyzBNxeccRVs7MkMmCYbORtlRZ0bLVx52uwZ/xmPaG4eZtPwnkFr17leUG/rMnhRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712524290; c=relaxed/simple;
	bh=k7U6elcM/6tEeUVzkYhBt1cWJ92IdwOaqQOnxCXabjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPNTr2spv3tfupzFpaghwe3ICdQSzH2tKCSf2Q2v1SdzkCP6tAy7KUSbhoxq5eJnQYCFlG12jU05vSUm+x1sLVTSdocepH0JEYU5z1WnE87AAEjUmMddcNblXZuFeuZnHNvQXLfnyVuaaTihpb3oOWlGZXpD1yWK/+CdMLAG/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=aWm6fA1o; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="aWm6fA1o"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 099F51A19F71;
	Sun,  7 Apr 2024 23:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712524283; bh=k7U6elcM/6tEeUVzkYhBt1cWJ92IdwOaqQOnxCXabjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aWm6fA1otQlemCW7Ech6Y8XW9LrQH4HJjp+mxubxbqfJ2xwJAOgudjoL+pZkiH82o
	 sQc0MGdZjqSsZ1jxdBQ3EDZBhirHNTwOtUuJAXAnIcItK9hRcc2aaXS1+ml27MOeUv
	 hyMyZDeuH5/l8u2Owt+gELVbbJuAY//M5WYpMv7c=
Message-ID: <97e57635-48cc-4ebd-a50d-6109cba8f7e0@schinagl.nl>
Date: Sun, 7 Apr 2024 23:11:22 +0200
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
 <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
 <d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
 <2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
 <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07-04-2024 17:12, phillip.wood123@gmail.com wrote:
> On 07/04/2024 15:52, Olliver Schinagl wrote:
>> Hey Phillip,
>>
>> On 07-04-2024 16:09, phillip.wood123@gmail.com wrote:
>>> On 06/04/2024 20:17, Olliver Schinagl wrote:
>>>> Hey Phillip,
>>>>
>>>> On 06-04-2024 15:50, Phillip Wood wrote:
>>>>> Hi Olliver
>>>>>
>>>>> On 06/04/2024 11:06, Olliver Schinagl wrote:
>>>>>> On 06-04-2024 03:08, Junio C Hamano wrote:
>>>>>>> Olliver Schinagl <oliver@schinagl.nl> writes:
>>>>> If you search builtin/bisect.c you'll see some existing callers of 
>>>>> strbuf_read_file() that read other files like BISECT_START. Those 
>>>>> callers should give you an idea of how to use it.
>>>>
>>>> Yeah, I found after Junio's hint :) What threw me off, as I wrote 
>>>> earlier, get_terms(). I wonder now, why is get_terms() implemented 
>>>> as it is, and should it not use the same functions? Or is it because 
>>>> terms is a multi-line file, whereas the others are all single line 
>>>> (I didn't look, though I see addline functions for the strbuf 
>>>> functions. Should this be refactored?
>>>
>>> get_terms() wants to read the first line into `term_bad` and the 
>>> second line into `term_good` so it makes sense that it uses two calls 
>>> to `strbuf_getline()` to do that. It does not want to read the whole 
>>> file into a single buffer as we do here.
>>
>> Right, but I why not use strbuf_getline()?
> 
> Because you want the whole file, not just one line as the script name 
> could potentially contain a newline

I suppose; I'd think that there would be a strbuf function call to do 
exactly (more or less) of what was needed. But I'll let it go ;)

> 
>>>> So with the name, I started to think some more about it, and after 
>>>> playing with some names, I settled on 'bisect-post-checkout'. Things 
>>>> then sort of fell more into place. It is still a hook/commandline 
>>>> option, but it's a much smaller change (since we don't have any 
>>>> special code to check the exit code anymore) as we can (obviously) 
>>>> run `git bisect skip` instead of `exit 125` as well of course.
>>>
>>> Does that mean you will be starting "git bisect skip" from the script 
>>> run by the current "git bisect" process. I don't think calling git 
>>> recursively like that is a good idea as you'll potentially end up 
>>> with a bunch of "git bisect" processes all waiting for their post 
>>> checkout script to finish running.
>>
>> Well the process is inherently recursive, though that's up to the user 
>> depending on what they put in their script of course. I don't think 
>> git is 'waiting' is it? In that, git bisect runs the command, the 
>> command runs git bisect, git bisect stores the commit hash in the skip 
>> file and 'exists', which goes then back to the bisect job, which then 
>> continues as it normally would.
>>
>> So technically, we're not doing anything bad in git, but a user might 
>> do something bad.
> 
> If I understand correctly we're encouraging the user to run "git bisect 
> skip" from the post checkout script. Doesn't that mean we'll end up with 
> a set of processes that look like
> 
>      - git bisect start
>        - post checkout script
>              - git bisect skip
>                - post checkout script
>                  - git bisect skip
>                    ...
> 
> as the "git bisect start" is waiting for the post checkout script to 
> finish running, but that script is waiting for "git bisect skip" to 
> finish running and so on. Each of those processes takes up system 
> resources, similar to how a recursive function can exhaust the available 
> stack space by calling itself over and over again.

Hmm, you might be right. I was thinking that `git bisect skip` would put 
the hash in the file, and then exit, but of course it also goes to the 
next checkout and thus triggers the script again (potentially), we don't 
want that. We do want the hash to end up in the file, but then not 
continue, as that would be the job of git bisect.

So then I go back to my previous solution, which expects exit code 125, 
like the other case in bisect. That shouldn't cause that behavior, as 
we'd otherwise have the same problem with the other exit code 125.

Thank you,

Olliver

> 
> Best Wishes
> 
> Phillip
