Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34036113
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671145; cv=none; b=B/d64c5gCIu60TGisZWZCnYxZ58gm5S7neFGflofq0FfcYnlxU5orrxHnYGpqBMxhu5gsevgpP+Pytam7Pp1KyDZRhgVUZRPpkzeJOcIjUGKzMpk4buiL045Q9vH045VPrSV602gha8P2kUqedwytREq+HTJj/S0wgakcG7vPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671145; c=relaxed/simple;
	bh=c7z6tQr6fb8eC13BkuV5Hx3zifbt/oBVqHFDiJjdwlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEWEeMU3kUa9WJK8+G1nqrI1EB0zXQxB4lXXJyWlvMVfDVZ0NFBrpF2ZAIUWaBJ1Ia+mstPwXYzjiCj1ubEt8O96BJQuFbdgUZ1Q7FxUuZF1gdwZEQluiLq8FOGgC69t4e4h5AaaU2ypKli69u3YnMS0sbdmHvBzZMWuT/ErRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dwdM7g/l; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dwdM7g/l"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A0CE91D5870;
	Sun, 11 Feb 2024 12:05:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c7z6tQr6fb8eC13BkuV5Hx3zifbt/oBVqHFDiJ
	jdwlA=; b=dwdM7g/lq0ii7yJSM8aguRxeykesFTcyVcfelpDLS4JqMRpbcjYv8h
	fbxuVzCTMCz8g8KTv25DFWJFjooQBay84kWQga0+JHdvg9DQ7Y4CqTcjovD1QnQt
	mYrxSpvP8f3nsK9DMBtn2jKhzSCpMEIbKtglv8p/9fZurAIceynyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97D991D586F;
	Sun, 11 Feb 2024 12:05:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE7F91D586E;
	Sun, 11 Feb 2024 12:05:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  git@vger.kernel.org,  Jonathan Nieder
 <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
In-Reply-To: <4073b764-ab6a-4b4b-a8a3-2e898620b2f5@gmail.com> (Phillip Wood's
	message of "Sun, 11 Feb 2024 11:11:52 +0000")
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
	<20240205141335.762947-1-vegard.nossum@oracle.com>
	<ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
	<xmqqy1bymru0.fsf@gitster.g>
	<b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
	<xmqqcytal01i.fsf@gitster.g>
	<4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
	<xmqq8r3wcjq2.fsf@gitster.g>
	<ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
	<eaf511ff-f9e0-47ac-ae2e-3de0efa928dd@gmail.com>
	<xmqqv86yoot3.fsf@gitster.g>
	<4073b764-ab6a-4b4b-a8a3-2e898620b2f5@gmail.com>
Date: Sun, 11 Feb 2024 09:05:40 -0800
Message-ID: <xmqq8r3r9biz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C99F75A4-C8FF-11EE-AB9A-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 08/02/2024 17:20, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> I think that typically for small suggestions like that we just add a
>>> Helped-by: trailer but feel free to add my SOB if you want.
>> Thanks, both.  Here is what I assembled from the pieces.
>> ----- >8 --------- >8 --------- >8 --------- >8 -----
>> From: Vegard Nossum <vegard.nossum@oracle.com>
>> Date: Fri, 2 Feb 2024 10:18:50 +0100
>> Subject: [PATCH] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec' commands
>> Running "git cherry-pick" as an x-command in the rebase plan loses
>> the original authorship information.
>
> It might be worth explaining why this happens
>
> This is because rebase sets the GIT_CHERRY_PICK_HELP environment
> variable to customize the advice given to users when there are
> conflicts which causes the sequencer to remove CHERRY_PICK_HEAD.

True.  I'd prefer to see the original submitter assemble the pieces
and come up with the final version, rather than me doing so.

Thanks.
