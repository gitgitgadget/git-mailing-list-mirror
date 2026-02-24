Received: from mail.runxiyu.org (runxiyu.org [155.138.132.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFD1A38F9
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.138.132.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771907619; cv=none; b=kwvP+bK+xS97pLJqRYKfPmw9Q3Z5G5OklZG1ENtKXrC5Qe8SwxQUkw3kxyeC11bRgEESQp7L08A9f1dU3ABhkvuBD/cL1apOOX/KPgImyWjA1qhOfXmbaZ8rRJjUWeKw3IxhZe+6u0ZHa4R/3gEKflaVxgztqtP1XaqYzSExHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771907619; c=relaxed/simple;
	bh=4JbroQE4bjBVC9sxLiqAeABq9tnECEvRRkG9h9POiZA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NnOmtA5kp4LJAB2HyqwKV2OXvlc6CupLLl2YmYsGVUX13obOq6mAtwb7tnggT+CTkQEuFyBt+qlYuhKpSRPFflOO5yMOJFRK+R3ZcXo7E8hJaVKr8M0kFTnZBW6k9+f8vL37Qx6KzCocDkDD7hi+UFNBa4V9OSL7jTjVRhRrz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=runxiyu.org; spf=pass smtp.mailfrom=runxiyu.org; dkim=pass (2048-bit key) header.d=runxiyu.org header.i=@runxiyu.org header.b=Od7I6z9w; arc=none smtp.client-ip=155.138.132.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=runxiyu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runxiyu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runxiyu.org header.i=@runxiyu.org header.b="Od7I6z9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=runxiyu.org; s=mail;
	t=1771907617; bh=4JbroQE4bjBVC9sxLiqAeABq9tnECEvRRkG9h9POiZA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Od7I6z9wytQJwbB0eDegEs/rY/q0VzPsg611A+TDqtvwk4lmGTWzyjgjFkp1ESDcr
	 S4mcK/5/OX3F6IDX5plAcqjdSjS8Jk9MTZCFuOOEO+claFBWnZtkUjqnORmXDQGICS
	 qo2pe9dPRn55koHCoxeca7eS7Aizi3X4aUxdvxF9ab/1exJnBlPn+0DFfj5WOtYwHu
	 MWpZKpERgSItFoHzzDz8XJrzhnPcN1vrwVEU93RGQL9MHAtMrIPWbpMy1D3tplWH3+
	 sMwE0PS5d5RbChXJtWS0IHctz/1cWxvpOjZG3Z33rJTaR01GO/boNZZr1DoygIaAm6
	 p5/KW5TKmg4pg==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 12:33:34 +0800
Message-Id: <DGMWTSG72GEI.1TA0INKB1UHB6@runxiyu.org>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH git] t5516: test updateInstead with worktree and unborn
 bare HEAD
From: "Runxi Yu" <me@runxiyu.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Runxi Yu" <me@runxiyu.org>
X-Mailer: aerc 0.21.0
References: <20260223141236.22476-1-me@runxiyu.org>
 <xmqq1pibnuej.fsf@gitster.g>
In-Reply-To: <xmqq1pibnuej.fsf@gitster.g>

On Tue Feb 24, 2026 at 3:15 AM CST, Junio C Hamano wrote:
> Did it ever worked before?  When did it regress?

Not that I know of. Unfortunately it's a bit difficult to build older
versions, but the same logic was present in this commit and in main:

> commit 9fdf4f1db422cc259e4a3ce0023a255102c6fa3b
> Author: Anders Kaseorg <andersk@MIT.EDU>
> Date:   Wed Dec 1 14:15:46 2021 -0800
>=20
>     receive-pack: protect current branch for bare repository worktree
>    =20
>     A bare repository won=E2=80=99t have a working tree at "..", but it m=
ay still
>     have separate working trees created with git worktree. We should prot=
ect
>     the current branch of such working trees from being updated or delete=
d,
>     according to receive.denyCurrentBranch.
>    =20
>     Signed-off-by: Anders Kaseorg <andersk@mit.edu>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

update finds the destination linked worktree correctly
update_worktree sets GIT_DIR
push_to_deploy decides whether to diff against HEAD or the empty tree by ca=
lling head_has_history
but head_has_history uses the bare repo's HEAD rather than the destination =
worktree

head_has_history used get_oid before vs repo_get_oid now, but they still
both seem to use the bare repo instead of the worktree's HEAD.

So if the bare repo's own HEAD is unborn, in both current main and
9fdf4f1db42, we would be incorrectly choosing the empty tree for the
'has staged changes' check's base, and report failure, even though the
linked worktree is clean



Well, by regression test, I don't mean that this was a previous
regression; I just mean that, this was a way to reproduce this bug that
sounds reasonable and could serve as a future regression test.
