Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418081459F6
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455809; cv=none; b=qVqB2bQwMP4s4d+/32nia+pAe13UXhn+CJuoyrb6Ls5lPm9Vz9YhRlVttjWYmtWNx7PD7FYg/l/1/4LcQ4khqzSG6/enJE6y52S7KJEuxqCQSFZoOqXadAahCSPRR611rEQwcydHzIt1+jgLhJgRU2VB3BN0IHHlDqAUNnle870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455809; c=relaxed/simple;
	bh=l2OgbDxdRkNwX9puSaSotwWTSFG6f1REBIkhAGt7R4k=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFkJIYVob6Y2IrP80cT3vKXqLVnlxJpEELpHBW3P9y59Rm0n9x6gJ5UhfKdf7JR8rkLDd/wbr1oM8yPsG4WO6qESLu6iIyoOagfs7jBlo8lVoUb/4rZFe9rV1gBHJhwZIZOdasa/53gdDVjJmsV/hSa/NNf0ngqyqWaR0beQDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 468GNNWT3228273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 16:23:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'ellie'" <el@horse64.org>, <git@vger.kernel.org>
References: <20240708143239.vq47dg7mgh33hykf@carbon> <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org> <001301dad14b$f8f0e460$ead2ad20$@nexbridge.com> <47799635-7832-4c89-b4d3-e992d49ad40c@horse64.org>
In-Reply-To: <47799635-7832-4c89-b4d3-e992d49ad40c@horse64.org>
Subject: RE: With big repos and slower connections, git clone can be hard to work with
Date: Mon, 8 Jul 2024 12:23:17 -0400
Organization: Nexbridge Inc.
Message-ID: <001a01dad153$271c2e60$75548b20$@nexbridge.com>
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
Thread-Index: AQIOcuJNQOiJMkQZvscuPTyr1NeGYwK0gGVSAXyLYmMBl/NYr7FXcptg
Content-Language: en-ca

On Monday, July 8, 2024 11:49 AM, ellie wrote:
>On 7/8/24 5:31 PM, rsbecker@nexbridge.com wrote:
>> On Monday, July 8, 2024 11:15 AM, ellie wrote:
>>> On 7/8/24 4:32 PM, Konstantin Khomoutov wrote:
>>>> On Mon, Jul 08, 2024 at 04:28:25AM +0200, ellie wrote:
>>>>
>>>> [...]
>>>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>>>>> CANCEL (err 8)
>>>> [...]
>>>>> It seems extremely unlikely to me to be possibly an ISP issue, for
>>>>> which I already listed the reasons. An additional one is HTTPS
>>>>> downloads from github outside of git, e.g. from zip archives, for
>>>>> way larger files work fine as well.
>>>> [...]
>>>>
>>>> What if you explicitly disable HTTP/2 when cloning?
>>>>
>>>>     git -c http.version=3DHTTP/1.1 clone ...
>>>>
>>>> should probably do this.
>>>>
>>>
>>> Thanks for the idea! I tested it:
>>>
>>> $  git -c http.version=3DHTTP/1.1 clone
>>> https://github.com/maliit/keyboard
>>> maliit-keyboard
>>> Cloning into 'maliit-keyboard'...
>>> remote: Enumerating objects: 23243, done.
>>> remote: Counting objects: 100% (464/464), done.
>>> remote: Compressing objects: 100% (207/207), done.
>>> error: RPC failed; curl 18 transfer closed with outstanding read =
data
>>> remaining
>>> error: 5361 bytes of body are still expected
>>> fetch-pack: unexpected disconnect while reading sideband packet
>>> fatal: early EOF
>>> fatal: fetch-pack: invalid index-pack output
>>>
>>> Sadly, it seems like the error is only slightly different. It was
>>> still worth a try. I contacted GitHub support a while ago but it got
>>> stuck. If there were resume available such hiccups wouldn't matter, =
I
>>> hope that explains why I suggested that feature.
>>
>> I don't really understand what "it got stuck" means. Is that a =
colloquialism? What
>got stuck? That case at GitHub?
>>
>> Have you tried git config --global http.postBuffer 524288000
>>
>> It might help. The feature being requesting, even if possible, will =
probably not
>happen quickly, unless someone has a solid and simple design for this. =
That is why
>we are trying to figure out the root cause of your situation, which is =
not clear to me
>as to what exactly is failing (possibly a buffer size issue, if this is =
consistently failing).
>My experience, as I said before, on these symptoms, is a proxy (even a =
local one)
>that is in the way. If you have your linux instance on a VM, the =
hypervisor may not
>be configured correctly. Lack of further evidence (all we really have =
is the curl RPC
>failure) makes diagnosing this very difficult.
>>
>
>Thanks for your response, I appreciate it. I don't know what the hold =
up is for them,
>but I'm probably too unimportant, which I understand. I'm not an =
enterprise user,
>and >99% of others have faster connections than me which is perhaps why =
they
>dodge this config(?) issue.
>
>And thanks for your suggestion, but sadly it seems to have no effect:
>
>$ git config --global http.postBuffer 524288000 $ git -c =
http.version=3DHTTP/1.1
>clone https://github.com/maliit/keyboard
>maliit-keyboard
>Cloning into 'maliit-keyboard'...
>remote: Enumerating objects: 23243, done.
>remote: Counting objects: 100% (464/464), done.
>remote: Compressing objects: 100% (207/207), done.
>error: RPC failed; curl 18 transfer closed with outstanding read data =
remaining
>error: 2444 bytes of body are still expected
>fetch-pack: unexpected disconnect while reading sideband packet
>fatal: early EOF
>fatal: fetch-pack: invalid index-pack output
>
>I'm doubtful this is solvable without either some resume or a fix from =
Github's end.
>But I can use SSH clone so this isn't urgent.
>
>Resume just seemed like an idea that would also help others, and it's =
what makes
>many other internet services work much better for me.

I do not know which pack file is having the issue - it may be the first =
one. Try running with the following environment variables =
GIT_TRACE=3Dtrue and GIT_PACKET_TRACE=3Dtrue. This will not correct the =
problem but might give additional helpful information. git uses libcurl =
to perform https transfers - which appears to be where the error is =
coming from. It is my opinion, given the issue is very likely in curl, =
that a restart capability will not help at all - at least not until we =
find the actual root cause (still mostly an unknown, although this error =
is widely discussed online in other non-git places). The failure appears =
to be transferring a single pack file (139824442 bytes) size may be an =
issue, but restarting in the middle of a pack file may not solve the =
problem (discussed in other threads) as the file is potentially built on =
demand (as I understand it from GitHub) and may not be the same on the =
next clone attempt. What we probably will find is that a restart will be =
stuck in the same spot and not move forward because the failure is not =
at a file boundary.

In addition to this, GitHub may have limits on the size of files that =
can be transferred, which you might be hitting (unlikely but possible). =
Check your plan options. I tried on a light plan, so this is unlikely =
but I want to exclude it.


