Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022F28F4
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740299160; cv=none; b=u7rlz1o8tARO4jRockcgS/uCOrN1LS1huTZ5e+oDrx4wbux44tzsDbvB3qeWFZ/LAbNwWoCN9XnR4+36BIzQNl0yMrkG0UPDGxJh5IBpvJrtntnO8b3cb45GppY+1BAFek0wpPYaNiNXyH+q93m1MXLANIHSnkoxx4FkyfoBVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740299160; c=relaxed/simple;
	bh=UO07SwiH3sxHD3FUAdxX9bblIaX6f6Veb17CnmLxboo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYeUh9f9PQf48zY7Syy6FxufSzJfb03RGN+Xwwzqb2tSLAGWMrxIouHXuqmqm+TEiWVkwiHJ+eYE5MJM5s2SqewEOr9pvM9iUJaaB9H7rpeC0973FbfHBwMFO+a6OZlYX/zv67CjDdtuahiFds/82CYXI5D577EptRxo234Tbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HCPvdPlG; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HCPvdPlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740299155; x=1740903955; i=l.s.r@web.de;
	bh=23HJXL7l02vGN7+A6+YGTvwysjgZHqf9PoTQ3xoy/1s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HCPvdPlGyWxp6rRj09cIcufkSFB0X3qjoVcKopa7d5p6Rf9+aBzBk2PsZ7Xvn6c/
	 Y8ogr9ZMTtL4y45gxFu/Np67sLtiD8TdGZMjWzYYCd6OqDtQpRcYL6RkE+sQLcSdB
	 c48K7OSYUfDlPTmDWA9X2iNuPUb2jDG8lCgqHhYn+WypN6BJMKuy3TWTwyP/iT3wu
	 qHBYzpkBXSfnUSAC+RPhg4xJBoLnlpjBonn7w+He5CP+CbnY+p6cA7f9pie+Jn1RG
	 QiVnaYIRVCG5AJ7mCJSYjrA7tIYyl7pPxlCxdd4F6sRyPgCn6Oto23aFYqFFRjAnx
	 0P78mZH3A88Wn9ppfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.28.180]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2gkf-1tkjbI09j5-001xkb; Sun, 23
 Feb 2025 09:25:55 +0100
Message-ID: <a5be80b2-bcc0-400d-8f83-f537a71d83a4@web.de>
Date: Sun, 23 Feb 2025 09:25:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit: avoid parent list buildup in
 clear_commit_marks_many()
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>
 <Z6xIPowXnL-awm6g@pks.im> <69909785-7f7a-4164-bdcb-bed61d006cc8@web.de>
 <Z7LYI4tqGZzZ2Vaw@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Z7LYI4tqGZzZ2Vaw@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f4EIlJepM7M96ZfrQwgn5fcT2ocuKjCLTVq5BOm1CwRA4y5XqTk
 72e8JwyfiPDvKggXCKc6MNrHFANFvMrNVjycMesx4n2x45I4gfAjypyv8gDtG8djR4bH7m5
 7Z+bxhn1TDNZxFr67i8jjx1QVm238hxW9oo94EymqkK+62SoxTSfz/rWnq9W1CbR64CEbaz
 JBBUljaYhZ6mvBOf65OuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ccy722oZLaA=;Stk/jGGhRaaithgeZjhTYywpp+U
 kMFq1pp4R5W1lcw6s/5BOSBXIxRi9xOZwNqaAHXPEA+8A0bdYs22Zb+sDiAZ14fZbr/84ia3o
 cbY7Ari2bJevRB1KQmb00wOh3H6c+U9Ho3WzbxWwYbimeKEhLF41M1pjQNrF2rGCts39p0Bgx
 sNM884i2jSoDm0kLFvVQV7ZpfWbdM1Bw8bsEE/lbQcXar0SunAM6LZ0LCa1V9wRjXBdpaKLs9
 V9xlrnLi8wUEZAT32aTK2bS4zqi1XqxfeU7OWC9rXXDiM/B3H8b7SUVpMiw8PDNvwd/J/CuX7
 Be9Y/MM2Lp0CK+/Mt7rt+f/mXPpJW3XSj4sZosHGfQAPKzkN6XzyFO+33A5SzLxMbSA3eySAP
 MYk7WRVHOiav+Z9wnLxdFpcos/IzgBExZyQ3WXtkqgRCWlZrzrXLLOg0AFY9jAxExSXSTMFJ1
 CrorbzfaDkM0zWdhT5fUYMQhE9ixtFWitB3kHEYtiL7llxaq8xHmXCiJcvZAX6i2FuApRFWxO
 2qX2UiwA+c2Rp3WfF/m87oh4XMYYiR7zTiY8tj+ceQXA4mI5qmFKzDrAoR15W+kE3ICwJ443F
 e9PuaPT9MO1m9qECP0yzFp/p7P3KCNCvsmzT0CqjTOBKlFTD0KUnCh2ad4x+s73tnFyfpQZYG
 cdQuKbc/JgzsjFAuvsgXIsfdpq3g6TEmYlnk36laWc7zkL6E637PAazKLXyC/RqbBQUn0HCfY
 5GIVCn6Jx52EHV2ZimwqlRNPGMlwJC120lYgxtSO+iRHW9S8bg73Y6ZobJEzb6FUWa9S/T/M9
 YzdXr/4XRbTVsDvSsnICILryymCzjtAaCDAx4hXQVpOgJ+AGzLVA9vyExLHMr5G2YCY+vqAD6
 AG64TETvQXSQvc7ea1r+wMIDYol5O1e//dEZlpNhw3OtMaxl5Dn/NjDTK/25kSQP67Z9HxdW2
 1U02Es1HwnHq9YHBPBALwrFpt1roQ/dDQdqWuzdhym66K3FvvBImOAok8f70dNiIFJl3tjHqx
 uyHh17r372fgbf43sukgwj3/ROlgzGX5fnm/fpHsP+7niqmgU8oC/tVBe6ieAxenaSz8bpR5F
 4cvyHGD+fIZtyiXkwJLs7udkJbdoH4tBqKVLv28JAKwqPM6Pp9RYUPmJcvoKWGyWBqpejGFZP
 oYwgf7mRiUhwqVbbwZGqHyLitzposXb810VXext/LRec0XhexgkEMQXlDMAJKCi6soQ/XVW/h
 rNYdDw765A/idsAnbe9nolHTQKE9dM1O32vY7aY2mcrZUC5rGd3g1EDD3bZ5+Ya36gBYda5xQ
 fHeDYCSn2iTK6E1IWEpyK1OCmWYPf5jwiVI130MXduLKLAQkbvFb9ivdspYw6VGSchalBz5KV
 PynJfKNOKXNAAYRuw+DZnGZtRDS3t7/kvwxcecQHn2aRiXI0fb0uzs8rIZ

Am 17.02.25 um 07:33 schrieb Patrick Steinhardt:
> On Thu, Feb 13, 2025 at 10:38:51PM +0100, Ren=C3=A9 Scharfe wrote:
>> Am 12.02.25 um 08:05 schrieb Patrick Steinhardt:
>>
>> Well, the maximum list length for clear_commit_marks_many() calls with
>> nr > 1 in the test suite goes from 12 in t6600 to 4 with the patch.  No=
t
>> that exciting.  The question to me is: Why pile up parents in the list
>> when we can clean them earlier with no downside?  Or is there any?
>
> If it really is without downsides then yes, it's a nice improvement. I
> was mostly wondering whether you're fixing something where the old way
> of doing things performs _significantly_ worse and where the change
> could lead to a user-visible improvement. Like, requiring us to store
> orders of magnitudes less commits at the same time.

You could construct pathological cases, e.g., cleaning lots of disjoint
histories, but I don't expect any dramatic impact to real usage of the
function.  It's just a small improvement.

Ren=C3=A9

