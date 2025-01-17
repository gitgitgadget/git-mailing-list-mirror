Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86B1F63E0
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084623; cv=none; b=rEmIv3fMFD+4l5RhwXRvNKFq0io5B73/s3AQXjI+qj1IqGvfl4drMIOuQBNRRC5diCzB+GlGoSHlbnVd7ELpwIBMklvxwKZhBEKj8MjZt3Ol3dIgeVyOgOB+cvoLc7OnoHLewWbvpLkh8xdVBBULK/jljjLHPrZRVicw9KeKFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084623; c=relaxed/simple;
	bh=n9nKRzKjKUKtx0X9LWg47ODvaQ8YqXb36dtASGdRhGU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=UngjP0eHwLH7zkrHi5sp+vhiJIcK3ogatXmimByzKGHteOX/r9PhwHOBegyqUNt25fslYZQaCTJOqOhzKhhoqma9yqLJ054J5kguzXSSo6j4WVFZPlWayjW4sM1BCRohe3pdyt0beiDip6G26VrF5NYvI+wVy7NdgKQW5sr9CRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=apbgFkfa; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="apbgFkfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1737084613; x=1737343813;
	bh=l6jtMrqovS/OncY3QzTXA+4IPhceEUc9L+4hYlZM6lU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=apbgFkfazaYtVDY2AgkHLI67SkfWeWOoL55TNSZPCdVHXB5CV9WRe8QdJYkqq1Blp
	 tOUjlDTke8WO4LqJVHuyXXb56ES1MEBOxHGBdq8AuGZ6xfvevW1O2Sea2Q/nWOfDCc
	 7P/r4Lf+Yj6WeJTQWoy+Jc7dY6rJ+UMTgIGpOQc/fPwR2ECLqfVQyIro1nMaDm5Wn3
	 iMUiXPbpw4W+k2tp+VUZQYvFN5LeQsEDt1GHU4gkwgMcIZXgbiU7CBB+mvgnuD89hT
	 Vo3VZCRV4E9XNGhLslw0Tj0TwcCCTcLLvf4iaW+Qi32wa4EjFmqJZ4U/59srNGejx5
	 8wTyMTweoyKCg==
Date: Fri, 17 Jan 2025 03:30:09 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Koakuma <koachan@protonmail.com>
Subject: [BUG] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 5cd38276eb7bced8b94923603c71606783c0794e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Compile git with clang (this doesn't seem to happen with GCC, oddly)
2. Do a `git pull` on a repository that will trigger the `unpack-objects` c=
ode

What did you expect to happen? (Expected behavior)

Pull succeeds

What happened instead? (Actual behavior)

Pull fails with this error:
remote: Enumerating objects: 7, done.
remote: Counting objects: 100% (5/5), done.
error: unpack-objects died of signal 10
fatal: unpack-objects failed

What's different between what you expected and what actually happened?

The pull process crashes with a SIGBUS.

Anything else you want to add:

re: unpack-objects, I don't know how to specifically trigger that code,
but I know that once `unpack-objects` is triggered it will reliably crash
with the error above.

According to gdb, the crash happens on this line:
#0  0x000001000019ca18 in cmd_unpack_objects (argc=3D<optimized out>, argv=
=3D0x1000063a4e0, prefix=3D<optimized out>, repo=3D<optimized out>) at buil=
tin/unpack-objects.c:653
653=09=09=09=09=09hdr->hdr_signature =3D htonl(PACK_SIGNATURE);

Overaligning the `buffer` declaration in the same file to try to get around
possible alignment issues seems to be able to prevent the crash,
but I don't know if it would be a proper fix for it.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.48.1.262.g85cc9f2d1e
cpu: sparc64
built from commit: 85cc9f2d1ee4d65cb1edb00d4f56863185a53e0f
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.10.1
OpenSSL: OpenSSL 3.3.2 3 Sep 2024
zlib: 1.3.1
uname: Linux 6.6.30-sparc64-clang+ #1 SMP Sat Oct 26 21:22:10 WIB 2024 spar=
c64
compiler info: clang: 19.1.4
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

