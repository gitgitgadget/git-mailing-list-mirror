Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643051CD15
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184697; cv=none; b=oYbl5pBXba3pVhTErFfW7FreeIXzU3XxMuPNRYytNS5oqysTX6ZVeOCks7hyb0BoLicyNvRDi0ZWc135M3d5pZky1plfmflIJqLiEezcEQM5gvTGF8nHdZLEv/N1xeLrF+PpU+S6m6Uil1uAKnVFd11DDsIIve86qUJe8+B5nDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184697; c=relaxed/simple;
	bh=Mdtl5igiQft5jjp8WbyQjeQV6AORPGtP2zQo0pfhL1c=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HBWrwQ9CwGGq8/ttZCn6friPxc5/DKzjJ8g88VHCGOqvRagHiSdn4Y1HwSoOfr6F1A/VghV6YYCsJemLkDZGHsKDXrCp66E33fTnDW8v7wlg4jniQveckHWFT4tA0kPtEqbp/bYWRuzSuS0jHNg2OUa3q6uqqJbn0ZoIf60Vf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5AQJIAqC3242379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 19:18:10 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        <git@vger.kernel.org>
References: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com> <94d81164-5af5-471e-a403-f2d544796d18@app.fastmail.com> <014801dc5ae9$543c73c0$fcb55b40$@nexbridge.com> <328687ed-7fe6-47a2-a76e-7c38932d3914@app.fastmail.com> 
In-Reply-To: 
Subject: RE: [BUG] Test Failure 2.52.0, t8020.16,19
Date: Wed, 26 Nov 2025 14:18:04 -0500
Organization: Nexbridge Inc.
Message-ID: <038001dc5f09$674bfd90$35e3f8b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFDHHm2se7imlkNauYXEvAe+CtXBwNzej23ATvoHHYBJe/kubYI+0RQgAAyqjA=
X-Antivirus: Norton (VPS 251126-4, 11/26/2025), Outbound message
X-Antivirus-Status: Clean

On November 26, 2025 11:16 AM, I wrote:
>On November 21, 2025 8:36 AM, Kristoffer Haugsbakk wrote:
>>On Fri, Nov 21, 2025, at 14:18, rsbecker@nexbridge.com wrote:
>>> On November 19, 2025 11:25 AM, Kristoffer Haugsbakk wrote:
>>>>On Wed, Nov 19, 2025, at 16:50, rsbecker@nexbridge.com wrote:
>>>>> The following two failures appeared on NonStop for the actual
>>>>> release. I
>>> did
>>>>> not see them in -rc0 or after (doesn't mean they didn't happen
>>>>> after
>>> rc0).
>>>>> To my eyes, this looks like a real issue not just on NonStop. It is
>>>>> 100% reproducible and is not transient. The build is with OpenSSL
>>>>> 3.4, but
>>> that
>>>>> should not matter.
>>>>>
>>>>> expecting success of 8020.16 'cross merge boundaries in blaming':
>>>>>         git checkout HEAD^0 &&
>>>>>         git rm -rf . &&
>>>>>         test_commit m1 &&
>>>>>         git checkout HEAD^ &&
>>>>>         git rm -rf . &&
>>>>>         test_commit m2 &&
>>>>>         git merge m1 &&
>>>>>         check_last_modified <<-\EOF
>>>>>         m2 m2.t
>>>>>         m1 m1.t
>>>>>         EOF
>>>>>[snip]
>>>>
>>>>Also reported here
>>>>https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-
>>>>defa3a051087@mit.edu/
>>>
>>> As a packager for NonStop, my team and I are trying to determine
>>> whether
>>> 2.52.0
>>> can actually be shipped. The concern is, is this a defect in the test
>>> code or underlying git merge code, and if the latter, how big an
>>> impact. If we hold off, how long will it take for a fix
>>> (approximately). I do not know the merge code, so...
>>
>>See the email from Jeff King on that thread
>>https://lore.kernel.org/git/20251120081611.GC1283645@coredump.intra.pef
>>f.n
>>et/
>>
>>By the way your email client reflows lines so aggressively that it
>>breaks lines in the middle of URLs.
>
>I tried the suggestion from Jeff King, but there are no problematic casts
that I can
>see.
>One possible issue here is the use of & with enums vs. ints, like
>
>if (data.commit->object.flags & BOUNDARY) {
>
>If flags is an in and BOUNDARY causes a sign extension, this might be an
issue on a
>big-endian platform, particularly if 0x8000000 is used as the value or if a
sign
>extension is expected.
>
>The SANITIZE option ends up causing -f to be supplied to c99, which is gcc
specific.

Not the issue with BOUNDARY. I am considering a potential compiler issue but
need to see whether this is try or not. There have been issues in the
distant past with unsigned flag:28 (bigger than 16 bits) on 32-bit builds,
which mine must be for now. I doubt this is the issue, but I need to verify
one way or another based on what is expected for t8020.16 or 19. I can use
gdb to verify one of the casts or calculations but  I'm sorry but I cannot
follow what the code is doing well enough to know for certain. Is there a
specific line with results I can verify/dispute in builtin/last-modified.c
that will show an issue, please? A little help would be appreciated. My team
has decided that 2.52.0 is potentially problematic on NonStop ia64 and x86
because of this problem.

