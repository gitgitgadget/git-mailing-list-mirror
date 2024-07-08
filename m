Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A83C08A
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441855; cv=none; b=RMs8meOhbJ9Od8AgOqbI3nojNzXo5Bl+Ta68f4X6bqeiKFMzbBeZKDpjLkR+cvVDJYX6928EwyC6C62Lb2NmrV0SXCsuqYr543cHw+qJybSuJyUebD4v6vfREJjlWO1qPzLxt7YTuGiS6dYvz1c9O/BOCVLYorgqDq/o2WhMLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441855; c=relaxed/simple;
	bh=0snH2StlnKeBYBEZXsdRVnGyFMYEqfZwyAAaHYOo7D4=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rSJgFvbHspVx88eRvBy8MfyNXt1j11XfNKYJmjilKDhR16C8yYAWGReBRtY8XgscbiRWqihAzOJ/E5e7fBI1FZYCtusphHGT2+mZIHgdECKg3RgM7/NAKUeBw3fhn12X1X4AbYdS87cAo3hFlxLE3q7Jy3Fs4le5f+0rxg2T19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 468CUmmu3175252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 12:30:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'ellie'" <el@horse64.org>, <git@vger.kernel.org>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org> <0be201dab933$17c02530$47406f90$@nexbridge.com> <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org> <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com> <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org> <d3b3c9bb-fa2a-422d-99a7-4add5f98326e@horse64.org> <0a7401dad0d6$10d27e20$32777a60$@nexbridge.com> <15bb8955-8ef6-4d83-b10c-e8593f65790c@horse64.org>
In-Reply-To: <15bb8955-8ef6-4d83-b10c-e8593f65790c@horse64.org>
Subject: RE: With big repos and slower connections, git clone can be hard to work with
Date: Mon, 8 Jul 2024 08:30:41 -0400
Organization: Nexbridge Inc.
Message-ID: <000001dad132$a9339170$fb9ab450$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ8D86lVlMiQEsTuxPOCK2qhFj8vwLR+fypAySGZOIBTladAgHDwEecAnFSq6EC9vQ7iAIhfiTNsCWwyiA=
Content-Language: en-ca

On Sunday, July 7, 2024 10:28 PM, ellie wrote:
>I was intending to suggest that depending on the largest object in the =
repository,
>resume may remain a concern for lower end users. My apologies for being =
unclear.
>
>As for my concrete problem, I can only guess what's happening, maybe =
github's
>HTTPS proxy too eagerly discarding slow connections:
>
>$ git clone https://github.com/maliit/keyboard maliit-keyboard Cloning =
into 'maliit-
>keyboard'...
>remote: Enumerating objects: 23243, done.
>remote: Counting objects: 100% (464/464), done.
>remote: Compressing objects: 100% (207/207), done.
>error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>CANCEL (err 8)
>error: 2507 bytes of body are still expected
>fetch-pack: unexpected disconnect while reading sideband packet
>fatal: early EOF
>fatal: fetch-pack: invalid index-pack output
>
>A deepen seems to fail for this repo since one deepen step already gets =
killed off. Git
>HTTPS clones from any other hoster I tried, including gitlab.com, work =
fine, as do git
>SSH clones from github.com.
>
>Sorry for the long tangent. Basically, my point was just that resume =
still seems like a
>good idea even with deepen existing.
>
>Regards,
>
>Ellie
>
>On 7/8/24 3:27 AM, rsbecker@nexbridge.com wrote:
>> On Sunday, July 7, 2024 7:42 PM, ellie wrote:
>>> I have now encountered a repository where even --deepen=3D1 is bound =
to
>>> be failing because it pulls in something fairly large that takes a
>>> few minutes. (Possibly, the server proxy has a faulty timeout =
setting
>>> that punishes slow connections, but for connections unreliable on =
the
>>> client side the problem would be the same.)
>>>
>>> So this workaround sadly doesn't seem to cover all cases of resume.
>>>
>>> Regards,
>>>
>>> Ellie
>>>
>>> On 6/8/24 2:46 AM, ellie wrote:
>>>> The deepening worked perfectly, thank you so much! I hope a resume
>>>> will still be considered however, if even just to help out =
newcomers.
>>>>
>>>> Regards,
>>>>
>>>> Ellie
>>>>
>>>> On 6/8/24 2:35 AM, rsbecker@nexbridge.com wrote:
>>>>> On Friday, June 7, 2024 8:03 PM, ellie wrote:
>>>>>> Subject: Re: With big repos and slower connections, git clone can
>>>>>> be hard to work with
>>>>>>
>>>>>> Thanks, this is very helpful as an emergency workaround!
>>>>>>
>>>>>> Nevertheless, I usually want the entire history, especially since
>>>>>> I wouldn't mind waiting half an hour. But without resume, I've
>>>>>> encountered it regularly that it just won't complete even if I
>>>>>> give it the time, while way longer downloads in the browser =
would.
>>>>>> The key problem here seems to be the lack of any resume.
>>>>>>
>>>>>> I hope this helps to understand why I made the suggestion.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Ellie
>>>>>>
>>>>>> On 6/8/24 1:33 AM, rsbecker@nexbridge.com wrote:
>>>>>>> On Friday, June 7, 2024 7:28 PM, ellie wrote:
>>>>>>>> I'm terribly sorry if this is the wrong place, but I'd like to
>>>>>>>> suggest a potential issue with "git clone".
>>>>>>>>
>>>>>>>> The problem is that any sort of interruption or connection
>>>>>>>> issue, no matter how brief, causes the clone to stop and leave =
nothing
>behind:
>>>>>>>>
>>>>>>>> $ git clone https://github.com/Nheko-Reborn/nheko
>>>>>>>> Cloning into 'nheko'...
>>>>>>>> remote: Enumerating objects: 43991, done.
>>>>>>>> remote: Counting objects: 100% (6535/6535), done.
>>>>>>>> remote: Compressing objects: 100% (1449/1449), done.
>>>>>>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed =
cleanly:
>>>>>>>> CANCEL (err 8)
>>>>>>>> error: 2771 bytes of body are still expected
>>>>>>>> fetch-pack: unexpected disconnect while reading sideband packet
>>>>>>>> fatal: early EOF
>>>>>>>> fatal: fetch-pack: invalid index-pack output $ cd nheko
>>>>>>>> bash: cd: nheko: No such file or director
>>>>>>>>
>>>>>>>> In my experience, this can be really impactful with 1. big
>>>>>>>> repositories and 2.
>>>>>>>> unreliable internet - which I would argue isn't unheard of! =
E.g.
>>>>>>>> a developer may work via mobile connection on a business trip.
>>>>>>>> The result can even be that a repository is uncloneable for =
some users!
>>>>>>>>
>>>>>>>> This has left me in the absurd situation where I was able to
>>>>>>>> download a tarball via HTTPS from the git hoster just fine, =
even
>>>>>>>> way larger binary release items, thanks to the browser's HTTPS
>>>>>>>> resume. And yet a simple git clone of the same project failed =
repeatedly.
>>>>>>>>
>>>>>>>> My deepest apologies if I missed an option to fix or address =
this.
>>>>>>>> But summed up, please consider making git clone recover from =
hiccups.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>
>>>>>>>> Ellie
>>>>>>>>
>>>>>>>> PS: I've seen git hosters have apparent proxy bugs, like timing
>>>>>>>> out slower git clone connections from the server side even if
>>>>>>>> the transfer is ongoing. A git auto-resume would reduce the
>>>>>>>> impact of that, too.
>>>>>>>
>>>>>>> I suggest that you look into two git topics: --depth, which
>>>>>>> controls how much
>>>>>> history is obtained in a clone, and sparse-checkout, which
>>>>>> describes the part of the repository you will retrieve. You can
>>>>>> prune the contents of the repository so that clone is faster, if
>>>>>> you do not need all of the history, or all of the files. This is
>>>>>> typically done in complex large repositories, particularly those
>>>>>> used for production support as release repositories.
>>>>>
>>>>> Consider doing the clone with --depth=3D1 then using git fetch
>>>>> --depth=3Dn as the resume. There are other options that =
effectively
>>>>> give you a resume, including --deepen=3Dn.
>>>>>
>>>>> Build automation, like Jenkins, uses this to speed up the =
clone/checkout.
>>
>> Can you please provide more details on this? It is difficult to =
understand your issue
>without knowing what situation is failing? What size file? Is this a =
large single pack
>file? Can you reproduce this with a script we can try?
>>

First, for this mailing list, please put your replies at the bottom.

Second, the full clone takes under 5 seconds on my system and does not =
experience any error that you are seeing. I suggest that your ISP may be =
throttling your account. I have seen this happen on some ISPs under SSH =
but few under HTTPS. It is likely a firewall or as you said, a proxy =
setting. GitHub has no proxy.

My suggestion is that this is more of a communication issue instead of =
than a large repo issue. 133Mb is a relatively small a repository and =
clones quickly. This might be something to take up on the GitHub support =
forums rather that for git - since it seems like something in the path =
outside of git is not working correctly. None of the files in this =
repository, including pack-files is larger than 100 blocks, so there is =
not much point with a mid-pack restart.

