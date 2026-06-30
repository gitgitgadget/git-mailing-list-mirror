Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1F233957
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788499; cv=none; b=qSwwTr0Ll6Md9HGcU4wQr1Ea41l9gecWyGXrCGpYZ5sEP7SWVnJEkB85f1Qg4Hx2zzJ7dR4iLU0Gbaarq2yJFGki2aGDqFJlsWM5KWUHe9FZHmpX5h1hfKwNnH/OePSNLcyNjbWv4+SmQ5ActqzOUkDC+cIURmLtfFyKi0+ylkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788499; c=relaxed/simple;
	bh=IVZPolw7aSoDg7pvw6zn/Hd3OeajRnws1PEfvBtNaNE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=jCvgIJznKz/ffwJ7OhDd+txjbLmywgAGHGou3NiYMZs1rJmVdtSo1Ur9ZqUdpGIgpT4HYzNe1IoAZp1C3CbcWi38X8nPteaysicu+ytD6QUpXyvRMLDbHWtVXkaRAhsW+FyVsAn4iwJnIJSq2UtAb1h20QzMfogWiAASAcw+5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=DxZBg8TW; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="DxZBg8TW"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 12EF76074E;
	Tue, 30 Jun 2026 02:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1782788106; bh=IVZPolw7aSoDg7pvw6zn/Hd3OeajRnws1PEfvBtNaNE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=DxZBg8TWSI6QqJn63CHxJB8YUyjMjaI8OkW0NCipA46RSPoiuM1RclKvmkmM9loke
	 y9EgkM8CrR04XLUZr1cv3GDUver+tk1aHWCazVIRWTmP4u7qBSCY+XkwBKNjLWJEWe
	 zhHM9p62hSJgjkhiVO7T+KIFbcY+KgF1ijG8d4to=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 22:55:05 -0400
Message-Id: <DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
Cc: "Patrick Steinhardt" <ps@pks.im>, "Harald Nordgren via GitGitGadget"
 <gitgitgadget@gmail.com>, <git@vger.kernel.org>
To: <phillip.wood@dunelm.org.uk>, "Harald Nordgren"
 <haraldnordgren@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
In-Reply-To: <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>

Hi!

I haven't experimented much with the new 'git history' commands, but
this discussion caught my eye and wanted to chime in.  (aka: please
forgive my stupid questions)

Note: I have built and am testing with v6 of this topic.

On Mon Jun 29, 2026 at 3:48 PM EDT, Phillip Wood wrote:
> On 29/06/2026 19:03, Harald Nordgren wrote:
>>> So instead of
>>>
>>>       # This is the combination of 4 commits
>>>       # This is the first commit message
>>>       Base subject
>>>
>>>       Base body
>>>
>>>       # This is the second commit message
>>>       # Another subject
>>>
>>>       # Another body
>>>
>>>       # This is the third commit message
>>>       # fixup! Base subject
>>>
>>>       # This is the fourth commit message
>>>       # amend! Another subject
>>>       A better subject
>>>
>>>       A better body
>>>
>>> We'd have
>>>
>>>       # This is the combination of 4 commits
>>>       # 123 Base subject
>>>       # 456 Another subject
>>>       # 789 fixup! Base subject
>>>       # abc amend! Another subject
>>>
>>>       Base Subject
>>>
>>>       Base Body
>>>
>>>       Another subject
>>>
>>>       Another Body
>>=20
>> I think this makes it a lot harder to read. If every commit body was
>> always just a single paragraph it could make sense, but it's generally
>> not. Look at the commits in this series, with no delimiter of where
>> one commit message ends and the next one starts, it would be very
>> confusing.
>
> You've trimmed the line where I said
>
>  >> Possibly with a comment before each message saying where it came
>  >> from.
>
> So I'm not against adding a comment before each message, but I do think=
=20
> we should omit any messages that would be commented out completely. If=20
> you look at the rebase example above you can see there is a mass of=20
> comments between the two pieces of text that make up the new message.=20
> That makes it hard to see what is actually going to be included in the=20
> new message.

I agree with this idea as well.  And letting fixup! messages completely
fall out makes more sense here than I want to say in git rebase.  The
commented list of commits at the top is a nice compromise for the todo
list you would have seen had you run 'git rebase -i' instead, and a
glance at the list would confirm that the fixup!s you thought you
included _actually are_ in the squash range.

I assume the same treatment would _not_ be completely given to squash!
messages, since there is at least some expectation that they carry an
additional remark that the author might want to reword into the base
commit?

>
> Thanks
> Phillip

Given the above, and how 'git rebase' usually works, I'm suprised that
--reedit-message isn't the default behavior.  This may be my bias
towards rebase showing...  Perhaps the typical use of this command is to
just work fast, and expect a follow up 'git history reword' if needed -
when the original just needs a little extra context?

This is probably a larger question, since (according to the man page) it
affects the other 'git history' commands as well.  When I run
'git history ...' and discover that I made a mistake after inspecting
the results, is there a fool-proof way to undo the change and return to
the previous state?  My first thought was to run 'git reset --hard ...',
but the default behavior of --update-refs (moving other branches) can
make this more complicated.

Thanks
