Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C459B4E
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612871; cv=none; b=HpzZit3trEcrZqOsitfkZJZKLAllTTHd2BfAcFE4oBHzH8a1wDOcen3r7S61k9bb5lIkVIHmIqi3WsW8TzWzVXkr6JjRPosyEdDIMppXVCf8XkTXd5wzlEoPr7f6vB8iO2O9ThTsyi0/Ycolps7droEjuXQE+Oe3dwpg6fg3/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612871; c=relaxed/simple;
	bh=OK6CzeI9iJSv6PzO3RH43YD+JlWlB2tQM7wLQ2Yf4LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5Spa6+sNu+qAeBdCa8hM4ecTfDlhgm1Ty4DcqKzH1sXRxqSxrWNQrKvuK71N2powK2mvhJFE43P2WSPm4mJbtuwRiDtD0P2DiZtxcD+uNt01ks7000G8nOyXLF12J2mIGaG4LuA77llWeTsIjIwMQ9PSEYSm/SDLY/cTf3M4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=TEMh627R; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="TEMh627R"
Received: from [10.2.12.77] (unknown [10.2.12.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 1DBCC1A06D5F;
	Thu, 28 Mar 2024 09:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711612864; bh=OK6CzeI9iJSv6PzO3RH43YD+JlWlB2tQM7wLQ2Yf4LQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TEMh627RLrmiL4KvWB5hkwvORG010xfyRz6UvazCh2eNqy0hrFAvv7o0v6sSnqhsh
	 J9ikvOX36CVDXmPT8/Y4TcVzoZh+oX9InJ9WiwamWSf/NGE7cLCDBiYKBDDCXFH+gL
	 npD/gc577LYgHApQwwtu759YPFgtdh3aidnyyp+g=
Message-ID: <e94be8ec-87aa-4703-b6bf-b37dd4919752@schinagl.nl>
Date: Thu, 28 Mar 2024 09:01:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow git bisect to auto-skip
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
 <xmqqwmptzyny.fsf@gitster.g>
 <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
 <xmqqle68x008.fsf@gitster.g>
 <e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de>
 <CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
 <xmqq8r27sclp.fsf@gitster.g>
 <7556a3de-a6a6-4284-8c36-3635ae43c653@schinagl.nl>
 <xmqqfrwb1nr8.fsf@gitster.g>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqfrwb1nr8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27-03-2024 20:24, Junio C Hamano wrote:
> Olliver Schinagl <oliver@schinagl.nl> writes:
>
>> Anyway, want I was thinking of, based a key somewhere in the message
>> body (GIT_BISECT_SKIP=1 for example), mark the commit in the list to
>> be skipped, as `git bisect skip` would. This so the skipped commit
>> actualyl ends up on the list of skipped commits
>> (`refs/bisect/skip-*`).
> I think it is very unlikely that we'd adopt any hardcoded scheme
> that allows only one supported way of marking commits as not to be
> tested.  Certainly not the kind that the committer is forced to know
> the commit must be skipped during a bisection session before
> creating the commit.

My goal is to make things work as automagically as possible, without 
special tooling or scripts. This to make the barrier for entry as low as 
possible. E.g. if someone says 'could you please bisect this for me', 
things should just work.

Having said that, I also realize that the use-cases where a commit 
message would be enough are limited. There's only a very rare cases 
where it is known before hand a commit will break bisect.

The `GIT_BISECT_SKIP=1` would obviously be configurable, so it could be 
set on a per-repo level, with a sane default, and probably wiser to use 
`git commit --skip-bisect` to make use of said flag.


Having said all that, right now, I'm just exploring how things work, how 
easy it would be, how logical it would be. So for thank you for bearing 
with me :)

>    So I am not sure how much good it will do to
> know that commit_list->item is a commit object on the list, or
> calling repo_get_commit_buffer() on it would give the contents of
> the commit object.
>
> Knowing that commit_list->item->object.oid is the object name of
> such a commit, and calling oid_to_hex() on such an object name
> stringifies it, should be sufficient to write a new code that calls
> out to a script specified via "git bisect --skip-when=<script>"

I had learned about `oid_to_hex()` already, and I am charmed by that 
idea for sure. So much in that I'll look into this first. In the end, 
both solutions could even be used as they are in nearly the same spot 
I'd think.


Four things I lack right now. The first one I hope to have figured out 
before your reply (but don't shy the reply).

1) What is the best way to parse the skip-when argument. I see 
`bisect_start()` does arg parsing, but trying to see what 'the git way' 
is to get the argument of the new flag.

2) Where to store the argument. `bisect_terms` is passed around 
everywhere to hold the good and bad states, but with bisect doesn't pass 
much of anything else around. Though `bisect_run` isn't storing 
`command` either, and you do mention so I'll delve into that and see how 
that maps into the `run_command()` API.

3) Using the `run_command()` API implies to do the check 'on checkout'; 
which was my first idea as well, but a) where does this happen? I have 
not found this yet, though `bisect_run` might be more revealing here,

3) Using this approach, can I still do a 'regular' `git bisect skip` in 
that the skip gets recorded (in refs/bisect/skip-*)? I think it would be 
nice to see what was skipped.


Thanks,

Olliver

> using the run_command() API to decide if the commit object should be
> skipped, and if you do want GIT_BISECT_SKIP=1 in the log message,
> your script given via --skip-when may be a single-liner:
>
>      #!/bin/sh
>      # usage: this-script $commit_object_name
>      # expected to exit with 0 when the commit should not be tested
>      git cat-file commit "$1" | sed -e '1,/^$/d' | grep GIT_BISECT_SKIP=1
>
> Thanks.


