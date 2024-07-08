Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89613A27B
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482930; cv=none; b=dqbRZ6XnQiXAMs4RrJ0UGc8Hg8lArDX7y1vo6sN8WM1UOnAGao7xuj5kk475v2RfqVIO3+/KV+MR0Bx0LDcPMRvF8WHgrfrRrmcmd/5Stm3i/7kqY9EcIaZ0egMxzISMiy9nxolxcGzb+NNhtDiyNDfsRKm7YLnpep035QA4sB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482930; c=relaxed/simple;
	bh=CFmbvWJTUSoJFIYNux23HJG9AKK7X+PXUJs2ExHP0Bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtSZ+5HrEWSG4H34UnTb0NGzOySaAV0Q5sfKQ2ErhtVhobYKprZe+nIOuNBrwnpFEFOyxuZ7vUPXHoq7XplB6YRHO/xA4CeSn9eX0mr1c8WNZ1Hl6fDkH0fOctUlC8HCMgDzfKJn7ND/sMZZcoqVqBjhJUn/BcXHc8gCPALSMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xV3IMo1+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xV3IMo1+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AD712E230;
	Mon,  8 Jul 2024 19:55:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CFmbvWJTUSoJFIYNux23HJG9AKK7X+PXUJs2Ex
	HP0Bo=; b=xV3IMo1+Jd6GS2zc/Ji/b1B9QbAhr+7JTLAtmdah3hLmUENcXrKVX9
	NrFLd/O93JZIoEvCVTe0oWXZax04cwpPS/Mw9wtuMCH1wdmTvc5b80RPETNdgpk5
	0DykJUnrwmXR/SYPcQ8jm5zhgbpnmT1d1bli2Y+XBUAYa5r27/9h8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90FE52E22F;
	Mon,  8 Jul 2024 19:55:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E302F2E22E;
	Mon,  8 Jul 2024 19:55:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is
 actually used
In-Reply-To: <Zox48sVp-PybvLxi@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 8 Jul 2024 23:40:34 +0000")
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<xmqqed83g1e6.fsf@gitster.g>
	<Zox48sVp-PybvLxi@tapette.crustytoothpaste.net>
Date: Mon, 08 Jul 2024 16:55:25 -0700
Message-ID: <xmqqr0c3h21e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8C8875BC-3D85-11EF-8717-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> The "look on the %PATH%" strategy does not make any sense as an
>> implementation for getting GIT_SHELL_PATH, which answers "what is
>> the shell this instanciation of Git was built to work with?", at
>> least to me.  Maybe I am missing some knowledge on limitations on
>> Windows and Git for Windows why it is done that way.
>
> Well, it may be that that's the approach that Git for Windows takes to
> look up the shell.  (I don't know for certain.)

> If that _is_ what it does, then that's absolutely the value we
> want because we want to use whatever shell Git for Windows uses.
> I will say it's a risky approach because it could well also find a
> Cygwin or MINGW shell (or, if it were called bash, WSL), but we
> really want whatever Git for Windows does here.

Yeah, absolutely it is risky unless it is doing the "we are
relocatable, so where is the 'sh' _we_ installed?", which is what I
would expect GIT_SHELL_PATH to be.

> That's because external users who rely on Git for Windows to furnish a
> POSIX shell will want to know the path, and this variable is the best
> way to do that (and the reason I added it).

If Git for Windows furnishes programs other than POSIX shell, paths
to which external users would also want to learn, what happens?
GIT_PERL_PATH, GIT_WISH_PATH, etc.?  Locate them on PATH themselves
shouldn't be rocket science (and instead of locating, just spawning
them themselves would be even easier, I would presume).

Thanks.

