Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFD305076
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208830; cv=none; b=Mg6ra5ZrQiObznhYIbAqmm0wkgHPYORGm/UsTJUz2QmQb68pZtNTJD0bbf5WI/bpJs/A9LGSPDjh+xBY6OszoE3sWJxOY02GxfkN8i/aEKzMptW3eeAcHNFThyAFgNwIJs5vZX+/Mgljd4tIsydYLa/gMj7X7oEufE/tyMO+qYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208830; c=relaxed/simple;
	bh=1jmvoQEk8ILvHhoVdV3mdHnwN3sTM39nLO6+0Q4O/6M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=inYt/XJm7uzx89IQPjHynREY9GGDnmkaN7UnnIYJz5QjnBnKz9ez1WU1oMyD4z3NkeUj0WWTEvZBeQSkmxrS/HgZ9RKebx8BkulKjxa/JVZE6Bs6d+/a7ZchePTEAnR1paiDmfRlzzNtbdry6Fsgj6Sq71R72p9qJY+j882jEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58IFKKiV1082290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:20:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>	<20250918022912.GA1135133@coredump.intra.peff.net>	<01c601dc284b$24496400$6cdc2c00$@nexbridge.com>	<aMuankGhjxXNKErO@pks.im>	<20250918063152.GA1168297@coredump.intra.peff.net>	<aMwCcw-6l1x85Wz-@pks.im> <xmqqbjn7akca.fsf@gitster.g>
In-Reply-To: <xmqqbjn7akca.fsf@gitster.g>
Subject: RE: [Change] Git build issue on NonStop
Date: Thu, 18 Sep 2025 11:20:15 -0400
Organization: Nexbridge Inc.
Message-ID: <020001dc28af$bfec1420$3fc43c60$@nexbridge.com>
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
Thread-Index: AQGqevxo+KmTuwcnT1oackIBbO80YQIfRj6EARK0NvwBapoNmgJuD0nGAL7RSkwB5awH4bSu8CRQ
X-Antivirus: Norton (VPS 250918-4, 9/18/2025), Outbound message
X-Antivirus-Status: Clean

On September 18, 2025 10:48 AM, Junio C Hamano wrote:
>Patrick Steinhardt <ps@pks.im> writes:
>
>> One thing I missed: `uintmax_t` doesn't work on 32 bit systems:
>>
>>     ::error file=clar.c,line=879::clar.c:879:8: cast from pointer to
integer of different
>size [-Werror=pointer-to-int-cast]
>>       879 |        (uintmax_t)p1, (uintmax_t)p2);
>>           |        ^
>>
>> I'm inclined to just use "%p" instead and accept that this has
>> platform-dependent behaviour. Means we'll have to drop the test for
>> this, but that's the lesser evil from my point of view.
>
>As long as %p works everywhere and with stable output, that is the most
>appropriate solution, I would think.  After all, this is used only for
"oops, the test
>expects these two pointers are pointing at the same address, but they
differ; they
>point at these places...".
>
>To test such a test, wouldn't it be sufficient to perform "does it give a
bit of output
>or not?" check in isolation?

Surprisingly, this actually works on NonStop x86 in both memory models
despite
warnings to the contrary in their man page.. Thanks :)

