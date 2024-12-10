Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17314230D19
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820160; cv=none; b=fWnSDvwf3hrd8o2D/7Ot+U7lTGwyNRB1mdhB8WnLxWXRG71bB0/eDdEc3Rry5c699WgRtE1bjR7KyAmWcVCFfYNeQpjtUidC92FWt4LdozDnwc7/vZqp1ei8PYjjZZeDmSFDGmh3oM0Hrhyvxy4zu2WBuL4m8g00+7gyfdcaBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820160; c=relaxed/simple;
	bh=Ly+5uBdBtFlZfcgu9fgF2XIaSHEH8uRw89T+ogQ+2Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ga8kQ0HW9XMWZXIWu6i0C5nbQTyFQLVmFosB1jHpNM7T6AwNR8xVZKCxriajbQCssXMEc5TlItMJo7HQnxM9Lb1DUnOcLuNvfDiwLvBwXmCpXwX7h0q/Fet4R2HZELhIEvxGl8gcFCXB7vnKj9e262n22JZYYE6AOCUcTWd4W2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Y6rmm1MH2z7QWtc
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 09:02:16 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Y6rmR3746zRnmF;
	Tue, 10 Dec 2024 09:01:58 +0100 (CET)
Message-ID: <a337ef76-096b-4995-ac06-d1be3b34750d@kdbg.org>
Date: Tue, 10 Dec 2024 09:01:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Document HOME environment variable
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
 Alejandro Barreto <alejandro.barreto@ni.com>,
 M Hickford via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1834.git.1733771894867.gitgitgadget@gmail.com>
 <xmqqwmg8mnab.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqwmg8mnab.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 10.12.24 um 00:47 schrieb Junio C Hamano:
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Alejandro Barreto <alejandro.barreto@ni.com>
>> +System
>> +~~~~~~~~~~~~~~~~~~
>> +`HOME`::
>> +	Specifies the path to the user's home directory. On Windows, if
>> +	unset, Git will set a process environment variable equal to:
>> +	`$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
>> +	otherwise `$USERPROFILE` if `$USERPROFILE` exists.

Makes sense and matches the implementation in compat/mingw.c. GfW uses
the same method with with additional checks for existence of the
$HOMEDRIVE$HOMEPATH combination.

> I wondered what the reaction by the readers on non-Windows would be,
> but hopefully they would read this to mean that HOME will not be
> mucked with, even if they leave it unset (or they take it granted
> that HOME is set somewhere while they log in and they do not have to
> worry about it), so it may be OK.

Since all Windows specific text is in a single sentence, I think it is
difficult to misread. I would leave away the colon, though.

> Just out of curiousity, is Git the only thing that uses $HOME on
> Windows?  Or among may other programs on Windows that use $HOME, is
> the way Git gives a fall-back value out of these three variables
> unusual and deserves documentation?

No Windows native program uses $HOME. Only POSIX-derived tools would
consider doing so. So, I would answer your question: yes, Git is the
"only" one insisting in HOME being set. We are free to choose how we set
it, and the way we do it makes the most sense for Git's purpose. It is
certainly useful to document how we do it.

-- Hannes

