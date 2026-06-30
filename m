Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517D379EF7
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811405; cv=none; b=OfDACR8/Q4Z16kqfu/QugRe5Xs3CdaLrwQfrecYC6EJRrMUW7+7KDPVa6I1sPBnt/FmWCdf4wY1tiE+7XSIN9zj32OBz8UQUk/f1a2cF09eLaci4v6z+rIOVyQRq68e0R6/j8s5bhttVoMgVwFlanElSp55gb5TX4OCh6P8fHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811405; c=relaxed/simple;
	bh=+OIdqb9mg9IxSsK4/KWvBQ/fyQUUSDwwUy1ICHE634Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qECqxkXUT1WSjJi67FwKDbeIRxrJraGRwSJOZ6SztsdOdLa7y25jb1xq8mw3OYwkca/CK+SEihw0poFGQl/+EJUnJnVwnAiHVkF+t902jBvBcsrF8TEIxupIcHSK67XHV5Gd2jHjT7sb9B9cdwdx9N+xDr5YORi2nYxjyl4RAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=l6/NkOMN; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="l6/NkOMN"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 0C0C060431;
	Tue, 30 Jun 2026 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1782811403; bh=+OIdqb9mg9IxSsK4/KWvBQ/fyQUUSDwwUy1ICHE634Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=l6/NkOMNvPRjPhXyszBNsp1650D/aWEuYloVqtXDYPed4z9otzcysySreOmH1biP4
	 2Drho+BRhtPMCJKmfuUjMtkleyZW2k1HKitubeQlT1nPTJZ0pPc/IK8n1y7skjYRi1
	 JuqjlKxbt2z7w7AHNks/cJWDrn972I09GEC25l5Q=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 05:23:22 -0400
Message-Id: <DJM9WBO3EI9M.5ASUW8SQ6BP2@lfurio.us>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
Cc: <phillip.wood@dunelm.org.uk>, "Patrick Steinhardt" <ps@pks.im>, "Harald
 Nordgren via GitGitGadget" <gitgitgadget@gmail.com>, <git@vger.kernel.org>
To: "Harald Nordgren" <haraldnordgren@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
 <DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
 <CAHwyqnVBEOm+FwD+i9Aa7edTvdnDPJom1zubcXgoExZnp--vWQ@mail.gmail.com>
In-Reply-To: <CAHwyqnVBEOm+FwD+i9Aa7edTvdnDPJom1zubcXgoExZnp--vWQ@mail.gmail.com>

On Tue Jun 30, 2026 at 3:19 AM EDT, Harald Nordgren wrote:
>> This is probably a larger question, since (according to the man page) it
>> affects the other 'git history' commands as well.  When I run
>> 'git history ...' and discover that I made a mistake after inspecting
>> the results, is there a fool-proof way to undo the change and return to
>> the previous state?  My first thought was to run 'git reset --hard ...',
>> but the default behavior of --update-refs (moving other branches) can
>> make this more complicated.
>
> This is a larger question: But I would love to have a reflog that is
> more human-centered. When e.g. rebasing a series with N commits, it's
> very tricky in the reflog to find what was the state before that.
>
> I feel like branch switching is given too much space in the reflog,
> since it's not a destructive action, I don't care about it.

I share these headaches to an extent.  When dealing with the first
problem (seeing an atomic entry in the reflog), I usually look at the
branch's own reflog instead of HEAD's

But my question is about doing a comprehensive reset from a botched
operation.  If any history operation updates branch refs besides the
current one.  I don't think there's an obvious way to see which other
ones were affected, and a naive 'git reset --hard my-branch@{1}' leaves
them pointed at unwanted commits.  Is this right?

tangent:  I'm pretty sure that git-status relies on checkout / branch
switching reflog entries in order to know which tag your detached HEAD
started from, eg: when it says something like

    HEAD detached from v2.55.0-rc2
    nothing to commit, working tree clean

>
> And when handling multiple commits in on go (squashing, rebasing), I
> would love to see a visual hierarchy (with indentation for sub-steps)
> instead of treating each action as equally important when it isn't.

Sounds compelling!
