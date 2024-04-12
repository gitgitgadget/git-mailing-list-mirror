Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818534C6E
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958845; cv=none; b=AUSSIJSM42a2xkL3Qp1HH134dA6jkLdAMxryo6DepkY6nyO313AOjRdwRdQZyU0yhVze7GHut+yN7sdzH1WmetMef0g8ijsvohmjRds6+yOTbY3OVPGmWPJcf4Yq/Pm0mHHzJ3wuiAxy5hCMQx5KtaB96xIeiUA1yMP+8pYMZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958845; c=relaxed/simple;
	bh=lyKf6dgPSaAFqqt9sIue4fPhIKzq56JJkDcPOYhm4bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iT9hrXqrDfQTXsU01ilWoRzIOAGDasqrrOq9tWy6yBt2pwRZaEou9wAq/W/LpWazKKVYxeF23jhwXnipGDqvcowMMDOe2FRL5hC406jY4mQJPuATaW2hZ2kZZKaOP8J3pFvdAnJW4Lbi5YyqswNtD6LZIpqMjvtBqFubYaSeeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4VGVh928Y4z5vZh
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 23:54:01 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4VGVh06ctrzRnmF;
	Fri, 12 Apr 2024 23:53:51 +0200 (CEST)
Message-ID: <ee644475-8387-4dbf-a4b9-0d301bd7cf5b@kdbg.org>
Date: Fri, 12 Apr 2024 23:53:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Clones from local repositories do not work correctly under
 Windows
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: "L. E. Segovia" <amy@amyspark.me>, git@vger.kernel.org
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
 <2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
 <e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>
 <01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org> <xmqqil0mmqpx.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqil0mmqpx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.04.24 um 19:32 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> alternate: C:/Temp/repoorig/.git/objects
>> alternate: /c/Temp/repoorig/.git/objects
>>
>> This is the MSYS2/Cygwin absolute path with a "drive letter".
>> Unfortunately, this kind of path is unintelligible for Git for Windows.
>> It expects absolute paths to begin with drive letter-colon or a
>> double-slash or double-backslash. For this reason, it reports "unable to
>> normalize alternate object path".
>>
>> The conclusion is: Do not use two different flavors of Git on a
>> repository that is set up with a link to an alternate repository.
> 
> I do not complain to the conclusion, and I do not use Windows, but
> it makes me wonder if there is a way to spell that full path that
> can be understood by both implementations.  The two implementations
> are not incompatible in the actual object contents and refnames and
> other things in .git/ directory, are they?
> 
> In short, does MSYS2/Cygwin understand paths in "C:/Temp/..." style,
> and if so, writing that out, even though it may not what it
> considers the native format, would make the world a happier place.

Yes, MSYS2 should understand C:/Temp. This can be achieved easily by
doing the clone with Git for Windows. A small complication is, though,
that the actual contents of the .git/objects/info/alternates is
constructed from the literal command line arguments. In my test I used

   git clone -s C:\Temp\repoorig repoclone

which writes

   C:\Temp\repoorig/.git/objects

to the file. The path we see in the output of count-objects -v is
obviously a normalized version. Users will have to say

   git clone -s C:/Temp/repoorig repoclone

to get the more widely understood version into the file.

-- Hannes

