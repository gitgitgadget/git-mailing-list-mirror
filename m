Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79B36D501
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974899; cv=none; b=KQo81yv9aonpDzXVS4DDb6EW/VU5bNqvsqvQ6WCc/Ghra8ry6JuKI1P9hDq2BSv/7ptdRWpeJsqDPJr3k9GKgONFLpNP1hSm+hVYWlp70Ruji/SqxORVPNJBxF7f2xlXxO7DFat/03E/KEYBHQ11GSOGUbhne9/rmzj+mIs52l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974899; c=relaxed/simple;
	bh=LM3BpNx7fe1AehHFpuM9VJb7LwT3KD9JAhx/zvn2OA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=dLKyaw4lDdVLT5Hx/2Z9YGRysi3vYHQ1ua+sGoCghr2LxtfIaytt7IozYaeboDnoxBliwkERcvVizsSjiA+Hl4kyc2EftpMF+wPSgH+yKTPUtKEtVi0hhEtFh93Q0ciNttQwsaWzsfooVADDZzAIMUnCWn18Qy8MhBcyFOocW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dFKZ10T2Gz7QsGq
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 10:01:29 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dFKYr2RFFzRnmN;
	Mon, 24 Nov 2025 10:01:20 +0100 (CET)
Message-ID: <9aa7cfdb-fc50-4ceb-936c-2ed441c462a3@kdbg.org>
Date: Mon, 24 Nov 2025 10:01:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filter smudge for secret restoration: no disk access?
To: Kache Hit <kache.hit@gmail.com>
References: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.11.25 um 08:39 schrieb Kache Hit:
> I was working on a git redaction script that restores working copy
> secrets when applied via `.gitattributes` clean/smudge filters, but
> encountered `smudge` not having access to the "working file" on disk.
> 
> I see it's documented as intended in
> https://git-scm.com/docs/gitattributes:
> 
>> Note that "%f" is the name of the path that is being worked on.
>> Depending on the version that is being filtered, the corresponding
>> file on disk may not exist, or may have different contents. So, smudge
>> and clean commands should not try to access the file on disk, but only
>> act as filters on the content provided to them on standard input.
> 
> Any chance there's a way around this or some alternative? Python
> implementation below for reference.
> 
> And also for my understanding, why _shouldn't_ smudge access disk?

A smudge filter must read its stdin and write the result to stdout. The
presence of %f in the configuration does not change this.

The filter can inspect the file name it receives via the %f token (note:
the *name* of the file, not the file itself) to draw additional hints
how to process the data, but it still has to read stdin and write to stdout.

-- Hannes

