Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7033F36D
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481338; cv=none; b=QmrtnH1Ytwq1n33yV7MropUrZrp2UgxVVKjGdOBWjOw/sZDsmeSaa+NeSTmCEKkjBAO/vyIs8JANn8MJmYL37DOUWqSrGmc6zvQCtfW01QHN8D2S8ec6axZGWjAIyIoYJi1Ar9UMkFt8UbYJdpEkCWWD3A33eEvIGn6RZMAUxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481338; c=relaxed/simple;
	bh=PVg2dCnH3klRCrSTtm5QKuKlmW66WkAV1KRA8vMMCMs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sMCOG+v66jFsFQ4mipCcWMSRhkL0A/0AAxfG8OsW4c3EsyBxnD/Cv90i15vqNfjsQEBgq99oJnlm5qS4UbVoedOHsSNyNrFBJK49Iq9CNvr61nQtFgXAtVou+panpjt6YbPsGZLcvExG1DBWllOR/qd6UEOlbZi6Jaxjr209nC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=G0zAKdPf; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="G0zAKdPf"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 4DA0860905;
	Fri, 31 Jul 2026 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1785481330; bh=PVg2dCnH3klRCrSTtm5QKuKlmW66WkAV1KRA8vMMCMs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=G0zAKdPfhix7Dn0DLmYtIGfzB6qZhsW7bDuAeCFQxm5uJCaNdvyNlOrEuGjQN4VK0
	 dqhYiQxInB2IN9oRPNfsGuYyxzrTldF+WHMWn+61XpDe6dxXkB7ieBXdDwAzSuJIXH
	 H3T8+06ve3YRh6tvLkVgPcGa5jAX3BYNBrAfIi1c=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 03:02:10 -0400
Message-Id: <DKCKB3HW6VJA.19CQLPOHR6WTI@lfurio.us>
Subject: Re: What's cooking in git.git (Jul 2026, #12)
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 <phillip.wood@dunelm.org.uk>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
 <CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>
In-Reply-To: <CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>

On Thu Jul 30, 2026 at 2:11 AM EDT, Harald Nordgren wrote:
>> Without "--reedit-message", it will happily discard "amend!" and
>> "squash!" commit messages even though the user creating them is a strong
>> signal that they intended to use them to reword the commit.
>> "--reedit-message" is a rather verbose option name which does not make
>> sense to me as we're creating a new commit with a new message so we're
>> not re-editing anything. I've commented elsewhere that I strongly
>> dislike reusing the rebase squash message template for this command
>> where we can squash fixups into multiple different commits at the same
>> time.

I also agree with these points, but given that they were already brought
up and dismissed before, I felt it wasn't my place to try to dictate
high-level design.

I may be misunderstanding your current concern with the first sentence
Phillip, but this was (at least in part) one of the recent things
addressed in this feature [1] [2].  If we go with the assumption that the
default behavior is to squash all the changes, but abandon all context
outside that provided by the first commit, then accepting amend!
messages for that first commit seems to drive the behavior closer to
what you describe.

> Should we always do "--reedit-message" then, i.e. remove the option
> and have it as the default? Do we need a "--no-edit" switch then
> instead? Maybe not, user will then always have the editor opened and
> they can save and quit if they don't care.

A script running 'git history squash' may have a harder time with this,
though something like 'git -c core.editor=3D/bin/true history squash' is
at least _some_ workaround.

It would seem consistent with other git commands to offer both an --edit
and --no-edit option.  If --edit is the default, it may make sense to
offer the option anyway, for the sake of some potential future where
there exists a config 'history.editSquashMsg' (for example).  '--edit'
would then override a configured value of 'false'.  Of course, the
precedent is --reedit-message so far in 'git history'.

1: https://lore.kernel.org/git/DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us/
2: https://lore.kernel.org/git/pull.2337.v9.git.git.1784128573.gitgitgadget=
@gmail.com/
