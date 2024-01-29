Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F31534F9
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538940; cv=none; b=a0DpJsoZL1I5QxQbvtUnUUTamXsl21liwss8U8uxWlZ92WJweB05ITes856O1dmYBTtC5Q6ZAcedSvnB/QVDuBvhT+XkbNYlYUNH84ZVkm94PMuZAYBueUaioX26f3iQGR2hpWobaJitAJO9UjYJkKWDxRRA55aJphuP3Kxc0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538940; c=relaxed/simple;
	bh=mPIZZ4vaVOObfS83Em/HaxwXroY3Y4Lmhn6Nkb9iW34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmaDjj17WTQEP4ulsFaEqMiebHmOATCmozwmg7gsoGS+3Vmpqom8wX4LwQm+c/WIUbGhw9kSCz6L6G7+c7DvgXqTbTA9xe+zMb599Wu3sxHYJEb8TlupALhovJz9uOz06izH+IPKnwA+Tlh3rPZzxOhCSXDJgacVlPeRJWHC9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=T5Fufqwy; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="T5Fufqwy"
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5e15:0:640:5b6e:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTP id E676F615E5;
	Mon, 29 Jan 2024 17:35:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id RZZTNNIOc4Y0-ShrclGan;
	Mon, 29 Jan 2024 17:35:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706538927; bh=mPIZZ4vaVOObfS83Em/HaxwXroY3Y4Lmhn6Nkb9iW34=;
	h=In-Reply-To:Cc:References:To:From:Date:Subject:Message-ID;
	b=T5Fufqwy7KI3JPl+wZMCgeW6DZemS+/ESjtFqOaCWRJTV969AkqpwbIVRjmZf9jN6
	 kjKLW+Dmphz5z0mjcY9GIQs918kljdxIwFp8rzhz3tgIZ2Fr0yYwbLjZ1SGwPGjRfO
	 N3IM2suMNgo0UFfwzdFaGhlnEa17kC96Wgt+QNps=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4dd609ae2a33f3729291ff26b40632c8eb5decae.camel@yandex.ru>
Subject: Re: How to execute a command on git am/rebase/cherry pick --abort ?
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Date: Mon, 29 Jan 2024 17:35:27 +0300
In-Reply-To: <Zaknu0nwBucHVJPP@tanuki>
References: <d66ef46827fc7391bd74ece943afa2c5245896d6.camel@yandex.ru>
	 <Zaknu0nwBucHVJPP@tanuki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 14:29 +0100, Patrick Steinhardt wrote:
> On Thu, Jan 18, 2024 at 03:53:21PM +0300, Konstantin Kharlamov wrote:
> > (please keep me CC'ed, I'm not subscribed)
> >=20
> > Hello!
> >=20
> > There's a well-known problem of git not fully checking out changes
> > while doing e.g. `git checkout` and similar commands when you have
> > submodules. So e.g. if HEAD changes a submodule commit and you do
> > an
> > interactive rebase to HEAD~2, you may be lucky to find a submodule
> > commit change in `git diff` (because if you don't get lucky, you
> > won't
> > notice that and commit the change to the unrelated HEAD~2).
> >=20
> > As a workaround I have a `git submodule update` inside `post-
> > checkout`
> > hook.
> >=20
> > Now, the problem is I still often finding myself having the wrong
> > submodule ID, and I tracked down that problem to commands such as
> > `am/rebase/cherry-pick --abort` also not updating the submodule,
> > nor
> > executing `post-checkout`.
> >=20
> > I looked through `man githooks` but couldn't find any way to
> > execute a
> > `git submodule update` during these aborts.
> >=20
> > Any ideas how to fix these?
>=20
> Are you aware of the `submodule.recurse` config? If set, it should
> cause
> git-checkout(1) and many other commands to recurse into submodules
> and
> update them accordingly. This should both make your post-checkout
> hook
> obsolete and should also work with git-cherry-pick(1) et al.

It doesn't seem to work =E2=98=B9 I've set it, and now supposed my top comm=
it
changes submodule. So I do a `git rebase -i HEAD~2` and "reword" the
previous commit. After "reword"ing is done, git returns me back to HEAD
commit and when I execute `git diff` I see the submodule ID changed =E2=98=
=B9
