Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18852DB7BD
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862915; cv=none; b=CD8e8xDt5SX6kQSLUTiBjuyENY2HstJSrCEAWij8mbRbEQpD5PGuoKLwGXlUcJV7XErN9T07Qc+sgjTNcpDWSxs5SU5xD8YBcKTcCfd78rWNYbU9Ug4X/cwMfHaz/CL8TFoDEuYhiowZLW7uF54V4wAT8v2RnOk8fKAbt3SR82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862915; c=relaxed/simple;
	bh=YOAYuSAwbBGKqReVLNy9zllSX1bHDY06w/1j9bF6m5M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cpLk7nq2yj9O2Mz2h/oyG+1uEWVOD69G/UqC9B9x42ArPjw9Z6MmM73Qvad9hGNrgAW1Kjitz224K0iIxMpkvPd2XSn+7KFIT8MMrrhz7Eq2J5a4zkSWk/Ivs77HS+McOJXPz68jEvTlNkt8eSUO1PJhPE3hACW1CKzyvmRxcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dmzRT0CL7z7QWpR
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 10:01:41 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dmzRB6hG2zRqpj;
	Thu,  8 Jan 2026 10:01:26 +0100 (CET)
Message-ID: <dcd87fc4-6514-4146-9e44-1276bd739d2f@kdbg.org>
Date: Thu, 8 Jan 2026 10:01:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ws: add new tab-between-non-ws check
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20260107013051.312291-1-adrian.ratiu@collabora.com>
 <d3f26459-d828-4d01-8c38-ce754e5cc576@kdbg.org>
In-Reply-To: <d3f26459-d828-4d01-8c38-ce754e5cc576@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.01.26 um 18:33 schrieb Johannes Sixt:
> Am 07.01.26 um 02:30 schrieb Adrian Ratiu:
>> The check is a bit complex because we want to detect places where
>> a SP was intended (HT can expand to more than one display column),
>> so we need to count both the display columns (col) and the string
>> character columns (i) to determine if a HT looks identical to a SP
>> or can cause confusion.
>>
>> Highlighting support for tools like git diff/show/log is added, as
>> well as git apply --whitespace=fix capability.
>>
>> The middle section of the line used to be assumed non-highlighted,
>> which is obviously not true anymore, so we split its logic into a
>> separate function named emit_middle_section().
>>
>> The new check is enabled for Documentation/**/*.adoc, where these
>> kinds of mistakes were seen in practice. It can also be enabled in
>> other locations where it can be useful, by adding to the relevant
>> attributes file.

This makes me wonder how useful this check is. Yes, I has happened that
I didn't spot at TAB that should have been a SP, but perhaps a handful
of times in my career. Compare this to the many times that the other
kinds of whitespace errors happened.

Applying the rule to all documentation files is questionable: I can't
format a table with TAB characters between columns reliably, because if
a column happens to be 7 characters wide, the TAB at the 8th position
would be diagnosed, but I certainly do *not* want it to be replaced by a
SP. Yet, I might want legitimate cases outside tables to be diagnosed, so...

Maybe I'm too much of a devil's advocate here...

-- Hannes

