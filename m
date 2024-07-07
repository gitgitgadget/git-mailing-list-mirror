Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18E1CFA8
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720358765; cv=none; b=AOQfv3F8EbUt1dwVmSIKUFpK9zQaTALBopBsAeSySfMD3s2oYbHjitKNr9LOa9j2jqVs6qd55qZAcQQv+QpDnzT2EBoVqHYpBENQZooPmvS9NF71kIf5OlNMnDcCr2uUo+nbnlP8mqXWo/j7DlkXFs/yPtRd+kEYxd1/taimKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720358765; c=relaxed/simple;
	bh=bw3SIAXYYw/eDn52lwXYocrMQmPl8iDgxpMxdEzq2sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfxDdiaQcn4vKBhtyVU4WcMMXOsXlmSwVzt5mB09xu66EBoFxTjxhPKjHH2Al+AZUuQqDH1kB/V3pGNjUEBhPQYcS6U248dRlA8C2ftkm5I4LpIwEJc0i00FGNKwwSmp1sER59FImjciIq2Bp2/HYoEVQhFDDfYgJESDFTRbM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WH7Kq6hn0z5tmH
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 15:25:35 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4WH7Kg2r1DzRnmK;
	Sun,  7 Jul 2024 15:25:26 +0200 (CEST)
Message-ID: <028ae5d6-b587-4ffe-b837-38f2c13992ae@kdbg.org>
Date: Sun, 7 Jul 2024 15:25:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 brianmlyles <brianmlyles@gmail.com>, git@vger.kernel.org,
 Sean Allred <allred.sean@gmail.com>
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
 <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
 <m034onpng4.fsf@epic96565.epic.com>
 <CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
 <752d41f9-6ce3-4c31-a0a2-4960c7dc1b2b@kdbg.org> <xmqqtth2petz.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqtth2petz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.07.24 um 20:15 schrieb Junio C Hamano:
> There may be two classes of comments CLI "git commit" users would be
> seeing, ones coming from the "git commit" itself that describe what
> CLI "git commit" does (e.g., "lines starting with '#' are ignored",
> "absolutely empty message buffer aborts the command"), and others
> coming from project specific template and other mechanisms that
> describe what the project expects (e.g., "please keep your lines
> shorter than 72 columns").
> 
> I agree that it makes perfect sense not to show the former at all to
> the end-user in git-gui UI, especially if git-gui does not ignore
> lines starting with '#' or abort commit with an empty message.
> 
> I am not sure if it is safe to strip the latter out of user's view,
> though.

I see your point. These two kinds of comments have different topics
(usage of the tool being used vs. project conventions concerning the
commit message itself).

It is easy to clean only MERGE_MSG to solve the annoyance caused by the
list of conflicted files. We could have this a first step, and then we
can consider later whether cleaning other sources is worth it. But it
would not help OP, where the comments come from the commit message template.

-- Hannes

