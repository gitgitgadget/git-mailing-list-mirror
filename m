Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1192206AF
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923738; cv=none; b=WDgYeN/y+GW8SdA3b9TAVLsbea6LDkDXfp296L8p2Uz7ZI0+uN/C2BKgiJ6FfXnPyqLQgDr8q5CyzQ1q+p02BR8UdU4K3SzbZ8UzixUOOhX3kcq0SutgwTxcUamRUSzNEJXw0I9ctEwNiT7ef6PeCKjNVUbuACI10lvc/lgh3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923738; c=relaxed/simple;
	bh=KeRf3UVPga0wm/RcLH5S7B18Ds5UOOzwX6qhR8dtA48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcBztqVRIFLsDxrSSpypDqlgt+YKdUxgJ7t8/CT20qcwM5mWjvyt6s0Gsx2ejUpqxzICZ4xIRDmKYZkh/94hWFdaOC5sb9c5uYbw0I82fQR18vPrM6/qHFPs/fCb69rAf6mhRGV+S4NzS4JXyqLu4mhJ2DduUh1IVRTa6cISNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YZgAlMet; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YZgAlMet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752923729; x=1753528529; i=l.s.r@web.de;
	bh=zrAPEMrwF/jnWsq2fMAG+4b15W5h05iA8Y5bY7wNBrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YZgAlMetfpM9257hP341mw1A/Z+taCRJ3J4WTEMOVdMOoJtOBl40cnYhzEHrFG3T
	 7QvCy8dIgZ9yffuV+vc/2qgIvWrGJETyBAeSzVnPolXmpW+XdLvGOH8NULGtWRfx/
	 o9yBJ1HsYzqN1IEphmjLpyIoO9SsJKp1D9ylx8FnEY+9uJlM6yU4C0byAF2PW1LiH
	 U6gQMAQ2ncYwPPneKwb7QqWGUcEm/q4Nc+CYHeOXGWQIDXMbQyDEfUkf6pKuBaL1I
	 mNxBSuNJsdoKwrN9E5EdUwiTqQzq5lD0QTHuQBJXf+iV/F1jYp+CgVZY1DAjY4nGc
	 yGC5FTLQOj/pxs9+Fw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mty5u-1utdxF0ork-0131Ba; Sat, 19
 Jul 2025 13:15:29 +0200
Message-ID: <37f34e15-f44f-4b8a-b684-bda27a977775@web.de>
Date: Sat, 19 Jul 2025 13:15:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
 <20250716050540.GB1396022@coredump.intra.peff.net>
 <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
 <20250719065558.GD705356@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250719065558.GD705356@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qHDRfwiOnzg2vW4asta0eSsxvMwPC2DKQbzsEcpwu/J8OpkEreV
 WZzbBGNbssp59gwek74okRHXxP4uDfeHTiqmQQPEUtwQrHNbJ2XN94lt5z33LtwOelKNIxM
 wrL8DWY3aA3nnX9uYqCZZXZjyln+KJJ6Dn0nueu0ljCeichf2nAGtqMv9xQu/1Yi13CBbTp
 p/QW2IpxaKZMAdxGYI7vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UPRvHgXPiJw=;qgrx+kRJhsoUwdhhfaQoA4gw70Y
 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
 8HQRvculMYa8s1aT7pO9ij7wPC

On 7/19/25 8:55 AM, Jeff King wrote:
> On Wed, Jul 16, 2025 at 11:39:49AM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> On 7/16/25 7:05 AM, Jeff King wrote:
>>> On Tue, Jul 15, 2025 at 04:51:07PM +0200, Ren=C3=A9 Scharfe wrote:
>>>
>>>> pop_most_recent_commit() calls commit_list_insert_by_date(), which an=
d
>>>> is itself called in a loop, which can lead to quadratic complexity.
>>>> Replace the commit_list with a prio_queue to ensure logarithmic worst
>>>> case complexity and convert all three users.
>>>
>>> I guess I'm cc'd because of my frequent complains about the quadratic
>>> nature of our commit lists? :)
>>
>> And because you introduced prio_queue.
>=20
> I think that was Junio, but I think I can be counted as a cheerleader
> for the topic. :)

Ah, sorry.  You did make it stable, though, which allows using it for
backward-compatible history traversal.
>>> I actually have a series turning rev_info.commits into a prio_queue
>>> which I need to polish up (mostly just writing commit messages; I've
>>> been running with it for almost 2 years without trouble). Ironically i=
t
>>> does not touch this spot, as these commit lists are formed on their ow=
n.
>>
>> That is not a coincidence.  I had a look at that series and tried to
>> reach its goals while keeping rev_info.commits a commit_list.  Why?
>> Mostly being vaguely uncomfortable with prio_queue' memory overhead,
>> lack of type safety and dual use as a stack.  I still used it, but only
>> as local variable, not in the central struct rev_info.
>=20
> Hmm, I would have thought prio_queue had less memory overhead. You're
> spending one pointer per entry in a packed array, versus list nodes. But
> it's true that it doesn't shrink as items are removed (though that is
> something we _could_ implement).

If we just count the net data then a commit_list item has two pointers
and a prio_queue_entry has a pointer and an ID for stability.  That's a
tie.  ALLOC_GROW overallocates by ca. 50%, so that's 25% more on
average for the prio_queue.  No idea what overhead malloc() needs per
allocation, but I guess it's enough to tilt the scale back against
commit_lists.

However, a prio_queue without a comparison function acts as a FIFO
stack, but needs double the amount of memory than a pointer array
without the stability ID would, for the same behavior.

I don't think lack of shrinking causes much of an issue.  I did stumble
over at least one place where using a prio_queue in FIFO mode made the
code slightly but measurably slower than using a commit_list, though,
which could be rectified by using a raw array of pointers.

Ren=C3=A9

