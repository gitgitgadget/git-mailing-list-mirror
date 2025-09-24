Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD426D4DD
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703672; cv=none; b=EWYwUikGwgGm+9Odj3YvNR23RgPNTxJIauM73FPkv2BtpFBjbXdTJTan/nzNez7ZRm3zEVsojVu4qxZQ6wargfLPAay/nP0mgwWE0XP1ZJ6oMiss7Ss42h0gK55ljxy8JjvZP6ppf5mWCb7E4V5Q6Cnwgqjk1SbLCOoFzRItGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703672; c=relaxed/simple;
	bh=i1EuYvuBEnD0oLT9NS2wA0rC1t+5fRnCIR5w7s8SNsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUAWMLPSYghxTQWeBys3fOOP/R2WSVCXXI7H69Bh4AjrAQbFrPDH7MGA5p7UdYBQXVx/q1n0+GIgjlrZ8u1fijBIo5TjCT22jSio1Ig3n+BSSMAUQu0aqZ9tLNEKyL3tJCRmrb+v07Tjh12QJYMExGWySWFp/FoZmnYRrJCfgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cWr8C6GYnzRpKs;
	Wed, 24 Sep 2025 10:47:39 +0200 (CEST)
Message-ID: <0a14a93e-7da2-43e1-9d71-c58a69c7a4af@kdbg.org>
Date: Wed, 24 Sep 2025 10:47:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
To: Junio C Hamano <gitster@pobox.com>, Mathias Rav <m@git.strova.dk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
 <xmqqldm4onma.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqldm4onma.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.09.25 um 23:38 schrieb Junio C Hamano:
> "Mathias Rav" <m@git.strova.dk> writes:
> 
>> In `git rebase -i` with the fixup command, the -C flag controls whether
>> the commit message is taken from the previous or current commit,
>> but currently the author name, email and date are always taken from the
>> previous commit.
> 
> As the name of the command says, you are fixing up the previous one,
> so I do not find it a problem if the credit for writing the
> resulting combined commit stays with the author of the previous one.
> The authorship information both covers the contents recorded in the
> commit's tree, as well as the commit message.
> 
> Granted, many commits of this project that is a one-liner change
> often have 50 lines of explanation in the commit log message, but
> still I think it is sensible to give more authorship credit to the
> author of the contents the tree of the final commit than to the
> author of the log message of the final commit.
> 
>> Change the behavior so that fixup with -C takes both message and author
>> from the current commit, instead of taking the author from the previous.
> 
> I am somewhat negative to this change.  I am perfectly fine to have
> a separate "I may have started from that previous one, but that was
> so broken that I essentially dismantled the original and replaced
> with the new one.  It is better to attribute the credit to whoever
> did this last one that is replacing" command.  But the "fixup"
> command people have been familiar with would be different, I would
> think.
The common situation where the proposed change is handy isn't where a
previous commit is fixed up.

Sometimes, a previous commit is a fixup for a later one, for example, a
change slipped into in earlier commit that should go into a later commit
and has been split off into its own commit. Many times it would be
sufficient to reorder the commits and be done. However, sometimes (and
not even infrequently), reordering the commits introduces conflicts that
do not happen if the order remains. Here, we want the proposed feature.

Since your argument hinges on the word and meaning of "fixup" (which I
can buy somewhat), we could extend "squash" with an option that
specifies which commit supplies the date and authorship metadata.

-- Hannes

