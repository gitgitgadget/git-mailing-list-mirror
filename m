Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59711FDD
	for <git@vger.kernel.org>; Tue, 21 May 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304819; cv=none; b=nHLiU6pq57V/bIa4HkjVzzTPHERwsMJv5aFo2rduvkvPwmNzFpTUdrboePK5T5oMJ/4lOwS+8e4y8o8JJihxKW0X8wQABPcHMjUBP26OzRLZAh5BE/mFq54T3XIBaPrjzh9GKve/uNkSUjZYUEy1yaIbrRRZqSMvw3tP2cd8Qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304819; c=relaxed/simple;
	bh=gIl/ETLTWfD+BxrYKFMUWZkPeMTo4lJgFOhZVCbYIoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WevKcEPSDhGDb0Fnw/WT5qIKUEmHQgqcOw+AKYt82ahsNPHnhq8RoTKiklNY7PILznI+5MF9JcaOYFpE/AhXdEJ0vRcj/LlhkgbjRt3tesyEDNTFtux9DWQ1KJHXpXXl2iJaeBx61cE2Gz79yCDfYXnhhSdMfW+l+g7HDgebxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZqjC6Rvg; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZqjC6Rvg"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D4E6C2F660;
	Tue, 21 May 2024 11:20:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gIl/ETLTWfD+BxrYKFMUWZkPeMTo4lJgFOhZVC
	bYIoU=; b=ZqjC6RvgthaUkaE1LoBqtGHiGSEsWB8F3cOgGs453KAgehz6jCjuX2
	Bsfm/JpM/hNM9VdhI3vY2LS1TiMXkegxnSWbUDWGfTe+fJ1elT39aMqF+ePwmLKn
	Ius4iI1eBxqUS/n4LR9Zq7pmUvgUyniRspow1zwhTbuPCHgXiX5c0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CE29F2F65F;
	Tue, 21 May 2024 11:20:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D1E972F65E;
	Tue, 21 May 2024 11:20:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Ondrej Pohorelsky <opohorel@redhat.com>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: git-daemon doesn't work as expected in v2.45.1 and friends
In-Reply-To: <20240521-evasive-mindful-stoat-c58b31@meerkat> (Konstantin
	Ryabitsev's message of "Tue, 21 May 2024 09:27:03 -0400")
References: <CA+B51BGonS2DDTBQ2RsipW4Cyg5pRv0U71RAN9M1pcPjACtJ4A@mail.gmail.com>
	<20240521-evasive-mindful-stoat-c58b31@meerkat>
Date: Tue, 21 May 2024 08:20:10 -0700
Message-ID: <xmqq5xv7chud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9DE31554-1785-11EF-ADC6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Mon, May 20, 2024 at 10:21:23AM GMT, Ondrej Pohorelsky wrote:
>> Is there a way to make git-daemon hosted repositories safe to clone,
>> without specifying safe.directory in git config? AFAIK this is widely
>> used feature of Git not only by the end users, but also quite a lot of
>> tests rely on it.
>
> I would say more -- this is very broken and needs to be rolled back. Running
> git-daemon as a different user is the recommended setup for read-only
> deployments.

Is this from f4aa8c8b (fetch/clone: detect dubious ownership of
local repositories, 2024-04-10) where the commit sprinkled a
"protection" meant only for "local clone" to more generic code paths
that are also used by "git daemon" serving a remote clients?  It may
be that the commit was a bit too aggressive and had a blast radius
that is much larger than intended?

I think that 1204e1a8 (builtin/clone: refuse local clones of unsafe
repositories, 2024-04-15), which is a very pointed fix to ensure we
do not "hardlink copy" local repository owned by others for
security, was a good use of die_upon_dubious_ownership() call,
though.

Reverting f4aa8c8b may not be easy to do mechanically, as it
introduces the die_upon_dubious_ownership(), but 1204e1a8 uses an
identical copy of the same function introduced by 8c9c051b (setup.c:
introduce `die_upon_dubious_ownership()`, 2024-04-15), and reverting
f4aa8c8b mechanically out of the merged result in v2.45.1 would
likely to remove the function that is still in use, which would need
to be retained.

