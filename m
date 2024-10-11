Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A52F26
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625033; cv=none; b=E1K+sKKaYOrcyqTC1uUv9r/vtrGJ2r70Ls+voj77ufJKIVcPIezXcBE4atIf+Fl08mHouk4cSHb8Bmy9Gf07ZW/pj3ds59VdiC2Ys4tpbK0Yg6lYfm72oaKdibj6/nQbEbxbK4iaqnY3Vh7FzjDGyEIrFmPS0njtvPCNPOzHgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625033; c=relaxed/simple;
	bh=k54EkNFU+WGVmTSEp8vbpTbKT5W8roU3GCjTTX0Xyus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEPdKNeO6Iq097SXuXqDeXkkqwp9y3DaBNg2A7NtZBOHgY1+m4h58Id3g/nWem/Urx/45nlN2ruoXc+bul/7MjBMYOGS332RJ3nlz+aS30JikH1YNTA4OQJUrHnXDrBHo7EkzWTKQVwALaZeycKa3844PWNgCniFhpHph47n9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=q5G/Lp+Q; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="q5G/Lp+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728625022; x=1728884222;
	bh=y6K1oHSuxp8/ySSG7KUTpX+1+7/F/tFw+pTbjAT35xE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=q5G/Lp+QFFG4Mf31ee9AmYCth/R/VWc9SXlDTqV49pNB5pYvPLk4QlIDiwXpz46oc
	 1dkTrAS0w1TcTqB6yyKWdcAxdVKIQMXl35IHtxnNZt+hlAnDV+CGVjXb9VmlBXPUZK
	 zj0PdhcLNMH6Vfefa208MNjUB0mOLUc5WAkxw1GHjmo300qg+b5SeMBSmtkjQM16oH
	 ILM3WDlRz/c664X6cb+cCLwleMnCfg+/CqwN5YKNm5MIM3rs6OGEBQ89djhvQcGf9g
	 yu5IH7tFBgZ+aEei9gmnH2S45+0GRgxfqgcyTeqYPRfXcg3O5eZADALDTm6aD+ORHM
	 1jPQDSiiJNrwA==
Date: Fri, 11 Oct 2024 05:36:57 +0000
To: Rebecca Turner <rbt@fastmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: `git worktree list` when bare repository is named `.git`
Message-ID: <D4SQFBEB1HYZ.QDOLCYY80DIZ@pm.me>
In-Reply-To: <444a412d-bf4c-4bbe-8250-18d8bc86fd21@app.fastmail.com>
References: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me> <444a412d-bf4c-4bbe-8250-18d8bc86fd21@app.fastmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 8b1e615fb6551d2c22e5d3b3ffa5d6b4579135ef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Oct 10, 2024 at 11:59 PM CDT, Rebecca Turner wrote:
> Perhaps your example got scrambled, but I can't quite reproduce it:
>
> $ mkdir -p repo/.bare
> $ cd repo/.bare
> $ git init --bare
> Initialized empty Git repository in /private/tmp/repo/.bare/
> $ git worktree list
> /private/tmp/repo/.bare  (bare)
> $ cd ..
> $ git worktree list
> fatal: not a git repository (or any of the parent directories): .git
> $ echo 'gitdir: .bare' >.git
> $ git worktree list
> /private/tmp/repo/.bare  (bare)

> It seems like the $GIT_DIR is shown in the worktree list here, and when I=
 add
> a `.git` file pointing to `.bare` manually, that doesn't get listed. (Whi=
ch I
> suppose makes sense, because it's not a `git-worktree(1)` worktree, but s=
till
> seems a little bit odd?)

Ah, I was mistaken. It will show the actual path if the gitdir points
to a separate directory.

> I understood this note to be talking about paths _within_ the `$GIT_DIR` =
or
> `$GIT_COMMON_DIR` itself; I see no reason why `git worktree list` wouldn'=
t list
> a bare repository _consistently_ as either the `$GIT_DIR` or the parent o=
f the
> `$GIT_DIR`.
>
> What I'd like to do is get the path of the worktree so that I can move it=
. `git
> worktree list` gives me this information _except_ for bare repositories i=
n
> directories named `.git`. I'm happy to have a special case for this, but =
I'd
> like to understand the principle here.

Why would you move the `.git` directory? If you're trying to move the
repository, then wouldn't you just move the directory that contains the
`.git` directory?

I think the main reason why the `.git` path is trimmed is because it
doesn't make sense to show it in non-bare repositories. No one wants to
see the `.git` path in a normal repository.

    # global git
    git worktree list
    ~/sources/git  3f20f8dd05 [wt_relative_paths]

    # locally modified git
    ./git worktree list
    ~/sources/git/.git  3f20f8dd05 [wt_relative_paths]

I would rather not have the `.git` show even in bare repositories,
if a user has moved the bare repository to `.git`, then that would
indicate that the *intent* is for the parent directory to essentially
act as the repository (and be moved as a cohesive unit if moving).

> Maybe I'm just not supposed to name a bare repository `.git`? The
> `gitrepository-layout(5)` page does seem to imply this is mutually exclus=
ive
> with bare repositories:
>
>> A Git repository comes in two different flavours:
>>
>> =E2=80=A2    a .git directory at the root of the working tree;
>>
>> =E2=80=A2    a <project>.git directory that is a bare repository (i.e. w=
ithout its
>>      own working tree), that is typically used for exchanging histories =
with
>>      others by pushing into it and fetching from it.

There's nothing wrong with naming a bare repository `.git`. I've been
doing it for a while now and it works just fine.

I've become a big fan of using bare repositories with worktrees,
particularly in high-trafficked repositories where I'm constantly
switching between branches.

When I was first doing research on this, I found a ton of articles with
all kinds of different ways to do it. Some folks put their worktrees in
the same directory as the actual repository (intermixed with their
code), some polluted the parent directory, some created a detached
commit that removed all files from the default working tree and then
created the worktrees, some used a bare repository but then just created
the worktrees in the same directory, etc. I finally came across an
article that showed the `.bare` method above and I thought that was the
cleanest method. However, after using it for a while, I realized that
I could just move `.bare` to `.git` and it would work just fine (and
I could remove an extra file). I've been using that method ever since.

Best,

