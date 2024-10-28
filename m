Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47EE1311AC
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078099; cv=none; b=GlsAoZJ540Tnyag2cGATT7u8/y5ui1G6gnQU5w5BN33thl7D1MiPw1u7DgGVfCKqz8SROQMD9YnCozm4gV7/cXAGtggIjoDHyt1yClFfPizl2SvIuuwd8JsVnUHikyb0ICBKHl9KQ+IBCF5+4uDuuavaTg9RW7xedGRnvx/T1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078099; c=relaxed/simple;
	bh=jVQW+EiSzFTDYN2H4qaUj+ekIqzN4UjsHOppKNT+zDQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4I6O5t+PBjuXZCuhx0ghn1OsoUh1wYoC5HrrWknP9I1IVtLW9j7VSp1mOJFVjOTwPVX2IUrXCQFAEAoNfdFUltm6TX/tRcwdFuIXp+CBB90Z7V+koWM9rtmBjVE6Xk2V3M30ii5EUpMsR9Zmnh1ZHQdI+n5gXAerpgy6ZOS+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lJKxKHYw; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lJKxKHYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730078094; x=1730337294;
	bh=jVQW+EiSzFTDYN2H4qaUj+ekIqzN4UjsHOppKNT+zDQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lJKxKHYwxrvUbY8YeI980KO8lA22v/jn/8DFoKrzfUuoEmCy8XajJLmFAlqE14cy1
	 RJkZJlJfu1gyqz4DLytpDjyh9TPWm46+O9UYAS4Tq5M95guiFd7/0WBmLLl3AMnes5
	 dtf1oJd4c+uwS0Xj6KBTVx2X1ZNlsyyXRYAszH0BxnXLJxnrakgtPUjcNjjoT1V/o2
	 RHG3NI4fxuQ7bRm3bn/kFc1royvi5tu30zMODU05I6U2rzMMXuUbl8UrWWwWlWzPmu
	 1eDSei7Xl8nxD6hnna3wOjHkLgNi3S+y6lgGRgCoT3hmXYWjo5eGqfVAbqiMtthrd9
	 /Ln+49p++dW0A==
Date: Mon, 28 Oct 2024 01:14:51 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/2] worktree: add `relativeWorktrees` extension
Message-ID: <D571HWYAD4MM.28JAS7D0Y6OI3@pm.me>
In-Reply-To: <Zx7YxLPItxvFJK62@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me> <20241025-wt_relative_options-v1-2-c3005df76bf9@pm.me> <Zx7YxLPItxvFJK62@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 87d23ec12674d9b44e8d1e42ff7e661c923450c7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Oct 27, 2024 at 7:20 PM CDT, Taylor Blau wrote:
> On Fri, Oct 25, 2024 at 10:29:47PM +0000, Caleb White wrote:
>> A new extension, `relativeWorktrees`, is added to indicate that at least
>> one worktree in the repository has been linked with relative paths. This
>> extension is automatically set when a worktree is created or repaired
>> using the `--relative-paths` option, or when the
>> `worktree.useRelativePaths` config is set to `true`.
>
> This approach feels like a very heavy hammer. I wonder if writing
> worktrees with relative paths by default was too aggressive of a step,
> and if we should instead make the new behavior opt-in rather than
> opt-out.

The v4 series of the original round added the cli options and updated
the relative worktrees to be opt-in. This patch keeps the git default
behavior of writing worktrees with absolute paths, and users can opt-in
via the `--relative-paths` cli option or the `worktree.useRelativePaths`
config.

> Saying that new worktrees are written with relative paths, and that
> creating a worktree with a new version of Git breaks reading the
> repository on older versions feels very unsatisfying to me.
>
>> The `relativeWorktrees` extension ensures older Git versions do not
>> attempt to automatically prune worktrees with relative paths, as they
>> would not not recognize the paths as being valid.
>
> This is the piece of information that I was missing in the earlier round
> when I merged that down. I think we need to take a step back and think
> about how to make this change safely in a way that doesn't break
> compatibility with older versions of Git.

Adding the extension was the direction suggested by Junio in the
previous round. Git did not account for the possibility of the linking
files containing relative paths, so there's really no way to make this
change without breaking compatibility with older versions of Git. Git
had to be taught how to handle files that could contain either absolute
or relative paths.

Best,
Caleb

