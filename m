Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9B7F7C7
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366125; cv=none; b=qwflnKZDmKa7N0/frWofPFZftGL2RjCExk9ZjQJgRxdF5lvNx9mQBl7VAaeD0h22eE2rjYKwFvCVxwiCAEBfODGacyou2hEy8L30HHVsYgAMmg0r3iTw569hRt3S2+9ib7eULFVXAehQyWOPnMoP/rMIdFyIHiba8njjmcWx6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366125; c=relaxed/simple;
	bh=JUf1Ka6o9VgkoMMahgfc7uKSItiMd7OAy+A+/i8+5k4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHZk4AcosWQ8MlBo+xSfdr2JAgK75dRAxgdLG5lOc9BJKqEJ6Fy59p/yXS9rM+BLKfeH00qc5rIidAq9cA72dILw5oQENAR7MlyM/glb0YrATOnQb+5PJVu4O5jOSGs9n/xMootNbtThzlD8oc9HXvcEf9s6u+63HJH/HaYKwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=tMLk0MLn; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="tMLk0MLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716366115; x=1716625315;
	bh=A2UjfNyZdeymMGpfW9f+YoFCClD3WOaIERN6B4pANt0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tMLk0MLnJnHSbMb4xzoTS/dg/p236eEO1k7WrI+1Vvl0ZVh+7wSIunTdbzYBpUbYZ
	 XvBFI/PlETrCImpIGVns2/f+LYqK2acf6fee6kf7soJ3RMH5LK9dYlGx2imfua2U8x
	 FrVfQhOUWsiDBxqSo5to21D9pIln39g/izkhutMyujY9uFPlyq1rML9iPVUtArZ0/k
	 1S5nCiGwsmWKDdqUCPXlWJ4MjZHQtM2T8NF87bLjTeCcrnGSFiZPH6ItN88eY7+exZ
	 NFnKqn7qO00dLIa9p2THheIZ4QI9FOQWrwdo0IOfgEPmXL/MvTGhztJfVngSSApVBp
	 4t8smIQwbzkGg==
Date: Wed, 22 May 2024 08:21:50 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git init BUG when gitconfig has includeIf
Message-ID: <D1G108TQBWK4.2XW34J29NCAHG@protonmail.com>
In-Reply-To: <Zk2ndVx4gMTV8ZUf@tanuki>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com> <xmqqbk4zazqd.fsf@gitster.g> <D1FH40J6URHF.186U29CMRJ0N3@protonmail.com> <Zk2ndVx4gMTV8ZUf@tanuki>
Feedback-ID: 1233518:user:proton
X-Pm-Message-ID: 38dc1c00417507b0ecb6531e7cd216023e2a7112
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed May 22, 2024 at 11:06 AM EEST, Patrick Steinhardt wrote:
> On Tue, May 21, 2024 at 04:46:23PM +0000, Heghedus Razvan wrote:
> > On Tue May 21, 2024 at 7:36 PM EEST, Junio C Hamano wrote:
> > > Heghedus Razvan <heghedus.razvan@protonmail.com> writes:
> > >
> > > > Yesterday I stumble upon a bug when doing git init. I didn't
> > > > find any references to it, so I don't know if is a known problem
> > > > or not.
> > > >
> > > > Steps to reproduce:
> > > > # git init .
> > > > BUG: refs.c:2123: reference backend is unknown
> > >
> > > Patrick, this looks similar to an earlier one during "git clone"
> > > that was discussed at
> > >
> > > https://lore.kernel.org/git/72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kern=
el-space.org/
> > >
> > > that was fixed with 199f44cb (builtin/clone: allow remote helpers to
> > > detect repo, 2024-02-27)?  The fix was about "git clone", but the
> > > crux of the fix went to setup.c:initialize_repository_version()
> > > which is also called by setup.c:init_db() that is the workhorse of
> > > "git init", so it may already have been fixed (I didn't try).
> >=20
> > I guess I forgot to mention, but I tested the current master 4365c6fcf9
> > and the issue is still present.
>
> I cannot reproduce the issue as-is, neither on Git v2.44 nor on the
> current master branch. So clearly, there must be something special to
> your setup. The following testcase and variants of it do not reproduce:
>
>     test_expect_success 'init with includeIf.onbranch condition' '
>         git config -f ./config foo.bar baz &&
>         include=3D$(test-tool path-utils absolute_path config) &&
>         test_when_finished "rm -rf repo" &&
>         git -c includeIf.onbranch:main.path=3D"$(<include)" init repo
>     '
>
> Now digging into the code, the condition gets evaluated in
> `include_by_branch()`. The call to `refs_resolve_ref_unsafe()` is
> guarded by `the_repository->gitdir`, which is `NULL` the first time it
> is called by git-init(1). It does get called a second time, but at that
> point we already initialized the refdb and configured the ref storage
> format as expected.
>
> Aha! Seems like this only happens when re-initializing an already
> existent repository, that's what's missing. In that case we do already
> have `the_repository->gitdir` set even though we did not yet set up the
> ref storage format. I'll investigate and send a patch.
>
> Can you confirm that this is what you see, or do you also see this when
> creating an entirely new repository?

Hi Patrick,

Thanks for looking into this. It seems that the issue happens only when
the folder for the repo exists.

Eg:
$ mkdir new_folder
$ cd new_folder
$ git init .=20

or
$ mkdir new_folder
$ git init new_folder

But directly running `git init new_folder` when there is no `new_folder`
works fine.

FYI, I just did these tests on master (4365c6fcf9).

Regards,
Razvan

>
> > > Even if it is already fixed in the current version by the same
> > > 199f44cb, we may want to follow up 0eab85b9 (t5601: exercise clones
> > > with "includeIf.*.onbranch", 2024-03-12) with an additional test to
> > > cover "git init".
>
> Agreed.
>
> Patrick


