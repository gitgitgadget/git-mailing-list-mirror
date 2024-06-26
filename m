Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695F190465
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425470; cv=none; b=MOl8Xa1d3lvlzBE4NaRX4/Qy95mgTJGW7xzsrM/0mcFEzS+/OxMvPebab/ygYczFIhYlxBLNYqm3lbGsWxmORFMi9SOzvtDsnvoRjyNf9t11iU9aH02s7lvR3t9meGk0JCIvHF39WJZeVswCyE67XsprjwJG+2wg9zXhv3hAD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425470; c=relaxed/simple;
	bh=c/AVQFzVMWmteUCPdmfs9Esxwy+SWoKeFOTZFUkUQgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aHEMJvXUWP902GyJwVX6dhYRVpGS2iLUQ1luZFDS1h+rTClEsukKGTTbNCLFiz3o95gvchcALe9kzKA5sMBRorxlaTv98SbVh8+HOmIw6rl6hBbl2+KvYDGLr1knke8L59oCvs7EW037ZgUoaelLrR7pJLRV2kep+rehvFDwdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vsa4g1q8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vsa4g1q8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E82E5301D5;
	Wed, 26 Jun 2024 14:11:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c/AVQFzVMWmteUCPdmfs9Esxwy+SWoKeFOTZFU
	kUQgU=; b=Vsa4g1q8fp4TJi86j98LaCiIiZfvY4RmFoPshMp+F/+50t60HmtzGm
	R1F6da2sse8eV7X8P/NbtgD5ca1xVnjt97+b6x15+kwbjOnljxc2t8i/yYeckJdf
	hCFL8cDwMtXBdxSAwzfrVH7iHQ7YlxI9GvgPBwVBguEtvijyX/CSE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE1FF301D4;
	Wed, 26 Jun 2024 14:11:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E70E6301D3;
	Wed, 26 Jun 2024 14:11:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Florian Schmaus <flo@geekplace.eu>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
In-Reply-To: <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com> (Phillip Wood's
	message of "Wed, 26 Jun 2024 16:26:15 +0100")
References: <20240626123358.420292-1-flo@geekplace.eu>
	<20240626123358.420292-2-flo@geekplace.eu>
	<9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
	<72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
Date: Wed, 26 Jun 2024 11:11:04 -0700
Message-ID: <xmqqa5j71snb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 74B00B46-33E7-11EF-8B53-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> To expand an this a little - a couple of times I've wanted to checkout
> a bare repository that is owned by a different user. It is a pain to
> have to add a new config setting just for a one-off checkout. Being
> able to adjust the config on the command line would be very useful in
> that case.

True.  As long as it is deemed safe to honor the one-off "git -c
safe.directory=..." from the command line, for the purpose of this
"I who am running this 'git' process hereby declare that I trust
this and that repository", I think it would be the best solution
for the "git daemon" use case.

And it is much better than adding a one-off environment variable.
After all, if your "git daemon" user does not have a $HOME set in
its /etc/passwd entry, you cannot set such an environment variable
in $HOME/.profile so somewhere in your "git daemon" invocation would
have to be tweaked to have code snippet that sets and exports it
*anyway*.  You can tweak the "git" invocation to add the command
line tweak "-c safe.directory=..." at the place you would have set
and exported the variable, and using the well understood "git -c
var=val" mechanism would be more appropriate.

>> Or you could set $HOME to a suitable directory when running "git
> ...
> The advantage of this approach is that there are no changes needed to
> git, instead of setting GIT_IGNORE_INSECURE_OWNER one sets HOME to
> point to a suitable config file. I found this useful when I was
> debugging the issues with git-daemon earlier[1]

Yup, that sounds like a workable approach, if "git -c var=val"
approach turns out to be inappropriate for security purposes
for whatever reason.

Thanks.
