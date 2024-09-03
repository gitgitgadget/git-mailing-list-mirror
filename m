Received: from hu-is-mx-01.gaijin.team (hu-is-mx-01.gaijin.team [213.163.39.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C318734B
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.163.39.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384626; cv=none; b=KXyr//jTH2d9GiNC1O9rKWjvQs5sg0LN4shlMr/u2ETR0jAoBvKKkaJPkwOJOzZhz9dvXBlgBEX86kNFSsipqy8XMHDpUIpveHoxIe4uGXiXaGPptMRUO/VTop98AI+xT21yil44etxbOlS2BvNSMhYhtPtfcl/AUsvL9SRkdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384626; c=relaxed/simple;
	bh=N3a6zA0t3PgCOxVH8ZRl/4l49ha3YVXx9LIHPKSBQl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpjIdvFIcHtpnTjr9wZ7WD5gg5HhsZ4NE0Gp6uItXkOEE9QVlRGBJH5TgDUz9g2h+nSNzxzquMkLv/YX05ck6WpxA02noV+pxeXolwIMZzTg2lCRzdi9pMOxtn02Z60NDIR+8LXYkpm8NFXKfHI9wqAQ702zl0wdmV4OczT1POk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team; spf=pass smtp.mailfrom=gaijin.team; dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b=P67H5vvR; arc=none smtp.client-ip=213.163.39.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaijin.team
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b="P67H5vvR"
Message-ID: <8a8a7f75-6a2f-4fd9-b3cf-df61129a355a@gaijin.team>
DKIM-Filter: OpenDKIM Filter v2.11.0 hu-is-mx-01.gaijin.team 04C2D41E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaijin.team; s=mail;
	t=1725384617; bh=xR+TFcsKjz/tSDOwv0EM61UZCJmsD2yWFCVDWCOz6Ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P67H5vvR242Wp/gmx9TIQU0+6BeB0vT6/U1eXnULZO8Ft64AzqsArLroXPfrkoKjI
	 Q4OjqaY2myr7Azxw6as27sN/JXIfvwUFBC1KngBpZbqXPujtklFhxN5amZqe+FC0Z/
	 dsFwEReW8Il5Ua95JiiTdQ3jZ/973h8IlTaK4sdE=
Date: Tue, 3 Sep 2024 20:30:16 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Committing crimes with NTFS-3G
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org> <xmqq1q26t1pa.fsf@gitster.g>
 <20240903155818.GA9437@tb-raspi4>
Content-Language: en-US
From: Roman Sandu <r.sandu@gaijin.team>
In-Reply-To: <20240903155818.GA9437@tb-raspi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

.gitattributes is this 
https://github.com/GaijinEntertainment/DagorEngine/blob/main/.gitattributes
`core.autocrlf` is unset.

core.filemode is false.

`git ls-files --debug` is extremely useful and I am a tiny bit salty 
that no one suggested it before I spent time learning how to parse the 
index file in C =)
But alas, nothing new, see my previous messages (hopefully they are 
visible to you, I am kind of new to mailing lists).

`git ls-files --eol` says that worktree uses crlf (which is expected, I 
checked out the repo under windows), while the index uses lf. Can that 
be the reason for Linux git thinking that the index is always out of 
date? Various dev tools work perfectly fine with crlf'd files on Linux.

On 9/3/24 18:58, Torsten Bögershausen wrote:
> On Fri, Aug 30, 2024 at 09:28:17AM -0700, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Am 29.08.24 um 22:43 schrieb Roman Sandu:
>>>> To diagnose the problem, I ran git status with GIT_TRACE_PERFORMANCE
>>>> enabled, and what I see is that the "refresh index" region is taking up
>>>> 99% of the time.
>>>
>>> Of course. The stat information that Git on Linux caches in the index is
>>> vastly different from that that Git for Windows caches. So every time
>>> you switch OS, all files appear modified to Git.
>>>
>>> I suggest that you don't switch OS on a whim and take the 8 seconds
>>> delay once when you have to.
>>
>> I somehow got an impression that the hit is not just that we need to
>> adjust cached lstat information in the index file once to the new
>> filesystem implementation after an OS switch, but every time (as if
>> we are forced to be extra careful and rehash every time until the
>> things improve, somewhat like how we handle the racy-Git situation).
>> Timestamps given by these OSes are not consistent and the clock
>> appears to have rewound, or something?
>>
>> Timestamps of files in the working tree ordinarily should match
>> timestamps in the cached lstat information of these paths in the
>> index, and timestamp of the index file itself should be newer than
>> any of the above, or the recy-Git prevention code may tell us to
>> play safe.
>>
>> I do not do Windows and/or NTFS, but I have to wonder if the smudge
>> filters (including the EOL conversion) play a role in this situation
>> as the working tree is getting switched between LF-native and
>> CRLF-native systems.  May there be situations where the system must
>> spend time only to realize that there is nothing it needs to do to
>> canonicalize the file contents and there is no modifications between
>> the HEAD commit, the index, and the working tree files, or something
>> silly like that?
> 
> Now, that make me wonder:
> What are the settings for core.autocrlf ?
> Is there a .gitattributes file ?
> According to my experience there should be one, when working cross-platform.
> A version with the single line
> * text=auto
> works for many projects, and may be fine-tuned to what you need.
> 
> The questin about core.filemode has been raised elsewhere, it should
> be false for this repo (but probably is).
> 
> Now back to the lstat() question:
> There is a
> git ls-files --debug
> 
> which may give more insight about what is going on.
> 
> And back to the line-endings:
> does
> git ls-files --eol
> give any hints, may be ?
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 

