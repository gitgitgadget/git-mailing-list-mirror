Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351227FD4B
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733521; cv=none; b=ndUrMO3wB34MDeghtBTdr/0oYCoWvDKQM3q7jLyjYEr1twGwq4G+Z9/JZIc27S0dxMURlN5ods2ttjsUsaby4BW/OEVMFtVMI2DE4aidbBiWLwVH/d639H4sVl+L1IjlfALM8vTtwnyTsNdQn5SfAurVUfdLevatGzlOSL7K25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733521; c=relaxed/simple;
	bh=MTm7e32BNNc1rMCM10gkF+KOpgZe2HcGamZPYI3K5RI=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/U83DKLzFnXG6bzKNtmi3PC08YbG63rDR89mGrOIZ2ROu65BiQFmZRtHPVCBsOwt4NJxNTLNR0C0eY+0m49hGRlVP07MxvgtWrJXJdJPwMvvdzvJTP0zLlUiafbRL7qf4v7ksPwwrvxTOAIrQ1NCGn/HwhOV9UgtfvLmJ2dcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5ALDwZPf2203570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 13:58:35 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        <git@vger.kernel.org>
References: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com> <94d81164-5af5-471e-a403-f2d544796d18@app.fastmail.com> <014801dc5ae9$543c73c0$fcb55b40$@nexbridge.com> <328687ed-7fe6-47a2-a76e-7c38932d3914@app.fastmail.com>
In-Reply-To: <328687ed-7fe6-47a2-a76e-7c38932d3914@app.fastmail.com>
Subject: RE: [BUG] Test Failure 2.52.0, t8020.16,19
Date: Fri, 21 Nov 2025 08:58:30 -0500
Organization: Nexbridge Inc.
Message-ID: <014901dc5aee$ee435a60$caca0f20$@nexbridge.com>
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
Thread-Index: AQFDHHm2se7imlkNauYXEvAe+CtXBwNzej23ATvoHHYBJe/kubYA+dwA
X-Antivirus: Norton (VPS 251121-4, 11/21/2025), Outbound message
X-Antivirus-Status: Clean

On November 21, 2025 8:36 AM, Kristoffer Haugsbakk wrote:
>On Fri, Nov 21, 2025, at 14:18, rsbecker@nexbridge.com wrote:
>> On November 19, 2025 11:25 AM, Kristoffer Haugsbakk wrote:
>>>On Wed, Nov 19, 2025, at 16:50, rsbecker@nexbridge.com wrote:
>>>> The following two failures appeared on NonStop for the actual
>>>> release. I
>> did
>>>> not see them in -rc0 or after (doesn't mean they didn't happen after
>> rc0).
>>>> To my eyes, this looks like a real issue not just on NonStop. It is
>>>> 100% reproducible and is not transient. The build is with OpenSSL
>>>> 3.4, but
>> that
>>>> should not matter.
>>>>
>>>> expecting success of 8020.16 'cross merge boundaries in blaming':
>>>>         git checkout HEAD^0 &&
>>>>         git rm -rf . &&
>>>>         test_commit m1 &&
>>>>         git checkout HEAD^ &&
>>>>         git rm -rf . &&
>>>>         test_commit m2 &&
>>>>         git merge m1 &&
>>>>         check_last_modified <<-\EOF
>>>>         m2 m2.t
>>>>         m1 m1.t
>>>>         EOF
>>>>[snip]
>>>
>>>Also reported here
>>>https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-
>>>defa3a051087@mit.edu/
>>
>> As a packager for NonStop, my team and I are trying to determine
>> whether
>> 2.52.0
>> can actually be shipped. The concern is, is this a defect in the test
>> code or underlying git merge code, and if the latter, how big an
>> impact. If we hold off, how long will it take for a fix
>> (approximately). I do not know the merge code, so...
>
>See the email from Jeff King on that thread
>https://lore.kernel.org/git/20251120081611.GC1283645@coredump.intra.peff.n
>et/
>
>By the way your email client reflows lines so aggressively that it breaks
lines in the
>middle of URLs.

Yes, I'm using Outlook, which does not like bottom-tracked replies at all. I
have to manually do everything and it breaks rational likes. Blame you know
whom.

In any event, "make SANITIZE=address,undefined" generates bad CFLAGS, so I
cannot compile that way.

