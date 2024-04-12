Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620914D2B1
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943719; cv=none; b=J1mYsFP7Wdd6rIoh7+cr+oH7YKg+Z+FNgPBHcusd0r6Z8lCdWf1BA5M5tmqoXlUnaYD07CDCPXL1OWMbSUz98U27U5QJWA72Qq7ZEiuWNoeobQaPY2SW43c7EBgkFTs2Ykm8r0t+XyNa9i44UEYGFYSOyoz4MuZdUJgiB/gCVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943719; c=relaxed/simple;
	bh=GbRvfoHwu9Eh4hx2ZTGWTuXRUg6E99C2aioMSbagMjY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Js9WynGWCFT4bcBO980MaGx2XIj7J9YDnW/wfWmjimjFMQB5wBjTev2RtI8PXf1tRl2HQj2Gj4sAuuzlMIqDsR9eaiiLtt/5EnULkpRhtl/mJTKeewKijSqsL7neeBVkMNibV3AJJ+9348BGbLeEsIrFaK3l6lWc09woxbQsK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43CHfmIN498125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 17:41:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Johannes Sixt'" <j6t@kdbg.org>
Cc: "'L. E. Segovia'" <amy@amyspark.me>, <git@vger.kernel.org>
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>	<2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>	<e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>	<01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org> <xmqqil0mmqpx.fsf@gitster.g>
In-Reply-To: <xmqqil0mmqpx.fsf@gitster.g>
Subject: RE: [BUG] Clones from local repositories do not work correctly under Windows
Date: Fri, 12 Apr 2024 13:41:43 -0400
Organization: Nexbridge Inc.
Message-ID: <02b801da8d00$b2c5b9f0$18512dd0$@nexbridge.com>
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
Thread-Index: AQIexDfdOFOIpsIe/2oTJHhmBsmNgAKLJmfsAWQx2MUB8WA43gGCLP4MsKFgeSA=
Content-Language: en-ca

On Friday, April 12, 2024 1:33 PM, Junio C Hamano wrote:
>Johannes Sixt <j6t@kdbg.org> writes:
>
>> alternate: C:/Temp/repoorig/.git/objects
>> alternate: /c/Temp/repoorig/.git/objects
>>
>> This is the MSYS2/Cygwin absolute path with a "drive letter".
>> Unfortunately, this kind of path is unintelligible for Git for Windows.
>> It expects absolute paths to begin with drive letter-colon or a
>> double-slash or double-backslash. For this reason, it reports "unable
>> to normalize alternate object path".
>>
>> The conclusion is: Do not use two different flavors of Git on a
>> repository that is set up with a link to an alternate repository.
>
>I do not complain to the conclusion, and I do not use Windows, but it makes
me
>wonder if there is a way to spell that full path that can be understood by
both
>implementations.  The two implementations are not incompatible in the
actual
>object contents and refnames and other things in .git/ directory, are they?
>
>In short, does MSYS2/Cygwin understand paths in "C:/Temp/..." style, and if
so,
>writing that out, even though it may not what it considers the native
format, would
>make the world a happier place.

I'm my environment (<2 month old Cygwin update), the path would be
/cygdrive/c/temp... I have not had issues using that style with git. Cygwin
itself does not understand C:\Temp (resolves to C:temp), but does understand
C:/Temp in bash and various utilities. It also understands (and expects) ~
to mean /home/user (C:\Cygwin64\home\user) in the Cygwin space, not relative
to C:\Users\user for resolving .gitconfig.

