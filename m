Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BD14A614
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464888; cv=none; b=HOX+azHMp2NH//NPqxgK8Jn5tLPiTfxY6vVzA04UkhgRnO3EC9iBxTUX4VlqkhF0RuWZVn3lLUMm3YaicA8fC1nr3v6d9FZYq1qO5A3wFnKCbOl3XGLCse+hqF0g5+3MN0pIXgCk7MWBcpTU1x1RvFkCtTL8qYfL2ow86/DN9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464888; c=relaxed/simple;
	bh=QjJzEXiGGY5hB0pCYaVJV6B1bCfCaBK1fZJOYEx0HE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bboq1bMP+xiKM4n/owfamxS1LW66FmPuTzm9Why0G5KnXLjr1SNw4R2Hp+a8+AHtULvbpw/GqSn4ergneQk30qZzyvYd8mTE29zQTbhJ1GaRZqO7cwnoVcRXygqZMxNSH4Er6XS0nxwZ4tg4uYcmJ+0LkoML0hn4DCnomuo/GEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N5XH3szQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N5XH3szQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA108358FF;
	Mon,  8 Jul 2024 14:54:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QjJzEXiGGY5h
	B0pCYaVJV6B1bCfCaBK1fZJOYEx0HE8=; b=N5XH3szQ3cdq5h/3KMM8AqjYFFkh
	JweXRecZjUEstLhs2P0Kdl1S2oR8pjbQMa2rarjvkKWGbc1rOvzAHc4TrMOKNX0U
	MfIjEw8iJocX8kJz5YxDylGrOfKP+5WAK2+1ukdFRacof8ct55FLqs6bmtCeMwV6
	yZ92MbCOgQOLLRA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B34EC358FE;
	Mon,  8 Jul 2024 14:54:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41794358FD;
	Mon,  8 Jul 2024 14:54:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is
 actually used
In-Reply-To: <pull.1760.git.1720443778074.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 08 Jul 2024 13:02:57
	+0000")
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 11:54:41 -0700
Message-ID: <xmqqed83g1e6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 89ABC13E-3D5B-11EF-B53C-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> On Windows, Unix-like paths like `/bin/sh` make very little sense. In
> the best case, they simply don't work, in the worst case they are
> misinterpreted as absolute paths that are relative to the drive
> associated with the current directory.
>
> To that end, Git does not actually use the path `/bin/sh` that is
> recorded e.g. in Unix shell scripts' hash-bang lines. Instead, as of
> 776297548e (Do not use SHELL_PATH from build system in prepare_shell_cm=
d
> on Windows, 2012-04-17), it re-interprets `/bin/sh` as "look up `sh` on
> the `PATH` and use the result instead".

This asks for a few na=C3=AFve questions.

If there is a fixed path the "git" binary was compiled for, which
can be referenced with a single variable GIT_SHELL_PATH, even though
on non-POSIX systems it won't be like /bin/sh, wouldn't there be a
path like "C:\Program Files\Git for Windows\bin\sh" (I do not do
Windows, so you may be installing somewhere completely different)
and wouldn't such a path work regardless of which drive is
associated with the current directory?

I would actually understand that, with relocatable build where
everything is relative to the installed directory, a single
GIT_SHELL_PATH that is defined at the compile-time may not make much
sense, and when you need to interpret a shell script, you may need
to recompute the actual path, relative to the installation
directory.

But I wonder why the replacement shell that is spawned is searched
for in PATH, not where you installed it (which of course would be
different from /bin/sh).  In other words, when running script that
calls for "#!/bin/sh", looking for "sh" on PATH might be a workable
hack, and it might even yield the same result, especially if you
prepend the path you installed git and bash as part of your
installation package to the user's PATH, but wouldn't it make more
sense to compute it just like how "git --exec-path" is recomputed
with the relocatable build?

The "look on the %PATH%" strategy does not make any sense as an
implementation for getting GIT_SHELL_PATH, which answers "what is
the shell this instanciation of Git was built to work with?", at
least to me.  Maybe I am missing some knowledge on limitations on
Windows and Git for Windows why it is done that way.

Thanks.


