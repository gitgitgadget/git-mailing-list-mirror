Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9E14A62B
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083848; cv=none; b=KUE+lWyiu2qXa9kIRzI2mFNGSEU3tNudvOIeejwgAihQQsN1NjWiYfmKfOgw/AcvaQDAdVEOJas84JoN8xJ9XD12C3y6bZUnHHe2m37ZinV+vxWorHzJ/3nR5BU1B8h1qfkuUITpLIocjtEFMkok/7HfFFqXqGznnjwBH2ReFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083848; c=relaxed/simple;
	bh=D7KeavaQfEWtspWatoBjoYQxOK6bFNAPh94BYhDTTus=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=obJ7WhX3DbOL6B8CYwdYaqmylWa4ABjdiVUmUiItikOQVAD+ZV+UJIJRWuHVGxVtQt6Z6lAUlqTC1b3soQbpQ4dtlccVvV07ViCAOLqJRb9uoDCvamzoyQQamLAxrIhh2y1ifXJFOlc45bv4Aa2A56D9l1NvBZN8+qPMb3ULmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=SmYWXaXh; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="SmYWXaXh"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id B6E4060743;
	Fri,  3 Jul 2026 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1783083845; bh=D7KeavaQfEWtspWatoBjoYQxOK6bFNAPh94BYhDTTus=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=SmYWXaXhZGF/LDMCeOGK37NB2EaNLLrPT+5IQtmMdvElI6s9v0BdpxQLUlfy0FERy
	 +B6NMLXRK5tKlM+dCtbMy+4R9I8gxX/CdpA8xdvNuaw3af7SOy96b8Kh2G71nigTl2
	 Pd17WavVOPstOKmvvAdiMuvh46feJmnBuI5GLp0s=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 09:04:05 -0400
Message-Id: <DJOYGY682OLT.1TPZHGTA5EMQQ@lfurio.us>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: Unexpected recursion in 'git rm'
Cc: <git@vger.kernel.org>
To: =?utf-8?q?=D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=B9_=D0=9F=D0=BB=D0=B8?= =?utf-8?q?=D1=81=D0=BA=D0=B8=D0=BD?= <eugene.pliskin@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <323134122.20260702104910@gmail.com>
 <DJOQR6XMG7QZ.2UH68XH0N1D7W@lfurio.us>
 <1978773121.20260703123754@gmail.com>
In-Reply-To: <1978773121.20260703123754@gmail.com>

On Fri Jul 3, 2026 at 5:37 AM EDT, =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=
=B9 =D0=9F=D0=BB=D0=B8=D1=81=D0=BA=D0=B8=D0=BD wrote:
>> Hi - I threw a quick test repo together, but did not see the result you =
describe.  Could you produce a script or series of commands to reproduce th=
e problem?
> Hi. Thank you for your reply.=20
> I was advised meantime that indeed this behaviour is expected:
>
> This is expected behaviour, as the argument to git-rm(1) is a pathspec,
> and "*" matches directory separators by default, see also gitglossary(7)
> under "pathspec":

Yup, I see that now, and that was the difference maker in my test.  I
had json files in the directory I was working, as well as at nested
paths.  My (non-windows) shell globbed to pass just the upper files.

To address Patrick's question in <akdzSHrJ4DfdUWoS@pks.im>:

> Could you maybe clarify which part of git-rm(1) made you think that this
> wouldn't happen?

I'll say that I _don't_ think the man page is unclear in this regard
(having given it a look just now).  To me, this is just one of the
aspects of git that is integrated with its unix counterpart well enough
(git-rm vs. rm) that you can forget the finer details like this fairly
easily.

And since the command is so straightforward, I couldn't tell you the
last time I pulled up git-rm(1) as a reference.
