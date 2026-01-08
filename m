Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC62DB791
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861427; cv=none; b=SUgTj46bYnd8mFCDVxajztqQIuZ2fZvQKRmF4pL+70BJaZ1dLSaUDkQloaHEe7P5YPIBtYCiQfACMiBBJYrd2RGWwhP3jH9ffScRcenXFeXk0sl5FaFJK6+YZitxwiTno+B3wCXtPftKARFA9nwxmRzqsGlEEiNy1sVGWgXfu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861427; c=relaxed/simple;
	bh=FNABs/BSEdtkhzLs49o/u7GFE98yivpPvzXyInxWolQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYcC4Oy90mq6ZIhcHdxZRJf/pkp94P0y0Ciw5BCPlJqNi2VmJRLJ+Vf6yQmxlw8Mx7f0Juq7lVaUwptfZHakcgA3MYKR9e3RAZHQKA1PszX0D/6A6w7gP+QOF003duRH5L8h0q3WlWlaVL1r85vv8oxLmN/FUrkW5YzT3RfSpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dmytX678vzRpL1;
	Thu,  8 Jan 2026 09:36:36 +0100 (CET)
Message-ID: <5860c8ec-7b34-4c47-926e-67a2c44a654e@kdbg.org>
Date: Thu, 8 Jan 2026 09:36:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ws: add new tab-between-non-ws check
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20260107013051.312291-1-adrian.ratiu@collabora.com>
 <d3f26459-d828-4d01-8c38-ce754e5cc576@kdbg.org>
 <87y0m9guns.fsf@collabora.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <87y0m9guns.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.01.26 um 19:11 schrieb Adrian Ratiu:
> On Wed, 07 Jan 2026, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 07.01.26 um 02:30 schrieb Adrian Ratiu:
>>> +	git add x &&
>>> +	git diff --cached --check &&
>>> +
>>> +	git diff --cached --color >raw &&
>>> +	test_decode_color <raw >actual &&
>>> +	! test_grep "<GREEN>1234567<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
>>
>> This must be
>>
>> 	test_grep ! "...
>>
>> Furthermore, a negative test with a very tight pattern is often not
>> desired: The test could fail if any single character does not occur
>> (which could easily happen if the test text is changed, but not this
>> pattern). In this case, it would be sufficient to test only that "BLUE"
>> does not occur.
> 
> Thanks, I'm still a bit of a noob wrt the git codebase. Will do.
> 
>>> +	test_grep "<GREEN>1234567	b<RESET>" actual &&

Reconsidering this, we have a positive test for the desired result here.
Then the negative test is redundant, I would think.

-- Hannes

