Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700A25753
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585073; cv=none; b=gelVFg5vd7PopbfZ9n7wUlXoLAZjQO87seoyo1lwIwuOyr5482AZneCKLXQdpxxJB8DYz8mNVD2U9JN+22YX9p3hIliP+w6vH+xbAUA6WFKdtZ5UdPU+p0SPznJ5lxrxHYu5yMRgTllRqfi6uLceXoDxwGRDU4pxzdh6oOpJT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585073; c=relaxed/simple;
	bh=FJ5EcK3l3fVl5XEw1yKa9fa8Jgv6N81FZH9qslHkQ+8=;
	h=Received:Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=ipHB6kdVUbLWg1pQJ2Cnd+FyK59k806OWnX17/MMLsCmiWO+4fvcIgLpv6SeGmvKHeGOJ0O5bRHwkuFuZeenm63A3ZHRNm3ToCqzfKTCLtbgopg5pj/PMqmhWu6kJ+9HRt917PHb7NFFDpkklbF5EdTpRbEDeauOjxrqKuyItP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ixRztQJG; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ixRztQJG"
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5408:0:640:72fa:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTP id C0178614AF;
	Thu, 18 Jan 2024 16:30:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uUNkA9AfteA0-tlanCcmd;
	Thu, 18 Jan 2024 16:30:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705584656; bh=FJ5EcK3l3fVl5XEw1yKa9fa8Jgv6N81FZH9qslHkQ+8=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=ixRztQJG91cx0QQ1lRUYHTr4IcHZMUanaEH1uEf8xRw4D6XHM3nxZi8CfaEt5Tep+
	 lFqYzWHGq90o/oapaBv0uC0Jun2B3Pu/WQILXbkZxr16qQwGtmlcolKJTutqmlcekY
	 QCe56LiwksHskAfWgaW5MxvHHoPPJZjfNv3OHB8c=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2c996cb7f83466a4ded11f4f581748c82d24b3c3.camel@yandex.ru>
Subject: Re: How to execute a command on git am/rebase/cherry pick --abort ?
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Date: Thu, 18 Jan 2024 16:30:56 +0300
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
>=20
> Patrick

Oh, this is amazing, thank you! No, I didn't know about it, will use!
