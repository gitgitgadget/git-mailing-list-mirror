Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B053E49E
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665130; cv=none; b=QwqXeBsrh9woty0T2ahPTox11pgVsyqfA6JlMZP+ByXoAI6fOr9fhX96GXJSSmS+RNXBE7wCtZHHQq/sZOzVm6UFN75cLE9lDF0sD5yC9yb4xkoqiK/hPkHxVdITtjJHLMazQp34TmNXsG/3DIN63rEm+E2+0SAOhI0W+aonKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665130; c=relaxed/simple;
	bh=Q9norb/bciQhOYybtQkA6DU+m6qbDo5c73z3i3AELzI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFZZ+jK66vhvMjZP4/ZkIAys0AgZ2+KOmW/PhUVZy9k/edULcat9MzBq9Vdf4YGi1/DnKP3qMAR/FyeXJDtUcnlw7iJZAwkrj+N2Gxv/HLU6+/HXKHBhl7fsB+Lz9/YOWxO5u17ElXv0dcuRO72uAmfynp14PtLCPJu6e0IQbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ycyc+8s0; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ycyc+8s0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728665126; x=1728924326;
	bh=7ZRy58b61JclDQ7ZYR0uW/QEmZdBLItkQoWDDPWKmfQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ycyc+8s0HbNHDxBwXBPNXi0xKgtJxKb7x8k5fBbeHeUlGVw7TuAdAFZ1Bj8megsH+
	 exntaRe8T8yHCUgXp8TY3jsbcHyHfjXYWmhLjaX1DeJF9A5nkvzliaIwrcZqR8nu3H
	 /+vDkX6/Oaoe7XAJ23/BNNRiSrKVZDp4i0xEj1sXL1Jm5veq67h28fLFVB1vBXhzMi
	 eX+wvxIe1Uf0bVw1p55Os/87bpKnmsSXh1/k4H45Zip5aOZgeg98pnPWitQJUdQrh7
	 7ccHKjqxQWQ5BQHZop3L7VFUv93dkMd7PYsPoCmbYkybJ1kSbyrVg31UkHmOV9udyr
	 XEiVG7h3LToWA==
Date: Fri, 11 Oct 2024 16:45:22 +0000
To: Rebecca Turner <rbt@fastmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: `git worktree list` when bare repository is named `.git`
Message-ID: <D4T4N4E0BR32.14QK0OEESB5CH@pm.me>
In-Reply-To: <517c8829-f98f-4fed-af4d-b84182fb253e@app.fastmail.com>
References: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me> <444a412d-bf4c-4bbe-8250-18d8bc86fd21@app.fastmail.com> <D4SQFBEB1HYZ.QDOLCYY80DIZ@pm.me> <517c8829-f98f-4fed-af4d-b84182fb253e@app.fastmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: fa6511cd0e2cc314eaeb5683a3a5d6533e4e76a4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Oct 11, 2024 at 11:19 AM CDT, Rebecca Turner wrote:
> Ah, I should give some context here. I'm using worktrees with the layout =
you
> describe later in your email:
>
>     my-repo/
>       .git/      <- bare git directory
>       main/      <- worktree for main branch
>       feature1/  <- worktree for feature work
>       ...
>
> I'm writing a tool to manage these layouts for you. I want to provide two
> features:
>
> 1. The ability to add a new worktree in a slightly more magical manner; i=
n
>    particular, I want to be able to do `git my-tool add feature2` and add=
 a new
>    worktree in the same directory as all the other worktrees.

If your repository is already set up in the layout you describe, you can
just execute `git worktree add` (I have this aliased to `g w add`, I'm a
lazy typer haha) in the `my-repo` directory.

>    For a non-bare main worktree, that directory is the parent of the main
>    worktree.

I would *not* do this, you may just want to not support this case. I
imagine most folks have a common directory for all their repositories,
and polluting the parent directory with worktrees sounds like a bad idea.

>
>    For a bare main worktree named `.git`, it's the path of the main
>    worktree. (Nothing in the `git worktree list` output indicates this is=
 the
>    case!)
>
>    For other bare worktrees, it's the parent of the main worktree.

Note that you can use `rev-parse` to get the actual directory:

    git rev-parse --absolute-git-dir
    ~/sources/bare-repo/.git

> 2. The ability to convert an existing repository in this layout.
>
>    This requires separating the `$GIT_DIR` from the worktree and then
>    reassociating them, in order to convert the non-bare main worktree int=
o a
>    bare main worktree and a second linked worktree. (In particular, I'd l=
ike to
>    avoid the cost of copying all the files in a large checkout.)

To convert an existing repository to this layout, all you should have to
do is:
- Add `bare =3D true` to the `[core]` section of the `.git/config` file
- Remove everything except the `.git` directory
- Create a new worktree for the default branch
- Profit!

>> When I was first doing research on this, I found a ton of articles with
>> all kinds of different ways to do it. Some folks put their worktrees in
>> the same directory as the actual repository (intermixed with their
>> code), some polluted the parent directory, some created a detached
>> commit that removed all files from the default working tree and then
>> created the worktrees, some used a bare repository but then just created
>> the worktrees in the same directory, etc. I finally came across an
>> article that showed the `.bare` method above and I thought that was the
>> cleanest method. However, after using it for a while, I realized that
>> I could just move `.bare` to `.git` and it would work just fine (and
>> I could remove an extra file). I've been using that method ever since.
>
> Yes, exactly! My frustration with this technique is how difficult it is t=
o use.
> I have existing checkouts I'd like to convert to worktree repositories, a=
nd
> `git clone --bare` doesn't create remote-tracking branches, so it's stran=
gely
> difficult to set up repositories like this. I'm hoping to ease some of th=
is
> with my new tool.

I've created a helper script[1] that allows me to clone a bare repository
to use with worktrees. In case you don't know, any script in your PATH
that starts with `git-` can be called as `git <script-name>`. I then
have a git alias for this script and so I can run the following to set
everything up:

    git cloneb https://github.com/git/git

The script also allows setting up an upstream remote at the same time
in case you've forked the repository.

    git cloneb --remote=3Dhttps://github.com/git/git https://github.com/<us=
er>/git

[1]: https://github.com/calebdw/dotfiles/blob/master/scripts/git-clone-bare=
-for-worktrees

Best,

