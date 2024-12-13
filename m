Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493018F2FB
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121413; cv=none; b=d6UPw2KJ7OkeipKxft/kKN5vWt8TXUPhfJeZ+CXavj/7DB/sOkqzLzHAHXweVVXv3dWJX5jE4wlhuA8Hu45mhcZ5/Qsv9RfDLxlOLeSLvpc3YnQbbLdqrQX+LlyLVVWTpx7EKb6LpEdGeh5RDf29JpbL9pubgGp7zCQZfFTACwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121413; c=relaxed/simple;
	bh=i8E/lGhpaGUjDrDqL7WGAcojgEh3WB2frai91XMdz+w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jady0QwhyqSBkYDO+/fVX666HV1fxy5aDr78qgOlEYaJOe+B6dLWMbeg683144vy+B1NKEakEptA11CvNIJIprTRU35H88CLbQ6XHMzumtyWRs9NWXVjNJIUOzbUpJ4XkMmJlFRt+SjSHXeDWjLvgPLXyd8P07gW2L18eWJHmac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6kZlNU0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6kZlNU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EBFC4CED0
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734121413;
	bh=i8E/lGhpaGUjDrDqL7WGAcojgEh3WB2frai91XMdz+w=;
	h=Date:From:To:Subject:From;
	b=W6kZlNU0ZtFbPCfu5Esnt0J9gWDbe7WEvICQ+XjPz43cu/j+uUpB2y7SpIuhpLgrT
	 lMQH9iVQra1gs0eQ5nWqerp7HD6l9YgK8In36a2H8hjHTJ7wy1TcA8N3tyqV51p6xA
	 oDK71KCRSsFDRQ0EPcBp+OnFKD9kxkG86PrJiuDbsu9G/GmwoaDbXA238Q1lEN/zpU
	 fyEAzawiphvd7ptYZKWr0PGHO1EFM8FkIdU7vEa4K774CkyPgd1su9CZ6Nrf8Aj3XP
	 vyonPzXolBihspv7gk3+rhnY3UYfw/jK5NRaKc6y/6fO/8fWF9t18BINfASM0c/yhU
	 SJO7Zk+BT86HQ==
Date: Fri, 13 Dec 2024 21:23:29 +0100
From: Carlos Maiolino <cem@kernel.org>
To: git@vger.kernel.org
Subject: [Bug report] signingKey beying bypassed
Message-ID: <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have reasons to believe git isn't honoring the configured signingKey config
on the .gitconfig.

the git-tag manpage states:

"
CONFIGURATION
	By default, git tag in sign-with-default mode (-s) will use your committer
	identity (of the form Your Name <your@email.address>) to find a key. If you
	want to use a different default key, you can specify it in the repository
	configuration as follows:

           [user]
               signingKey = <gpg-key-id>
"


I do have my $HOME/.gitconfig configured to always sign tags with a specific key
per above documentation, and I just take it for granted.
Today I had two smartcards connected, and when signing a tag, git-tag used the
wrong key to sign the tag, instead of the specified in the .gitconfig.

I believe this might be a bug or some expected behavior that doesn't match the
manpage. Or perhaps I misinterpreted the manpage?


- What did you expect to happen? (Expected behavior)

git-tag to sign a tag with the .gitconfig specified key or issue a warning it
couldn't use it.

- What happened instead? (Actual behavior)

A tag has been signed with a key different than the one specified in the
.gitconfig


I can reproduce it on any git repository in my machine, even a fresh just
initiate repo.

[System Info]
git version:
git version 2.47.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.9.1
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1.zlib-ng
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash

No Enabled Hooks


Thanks
Carlos

P.S. I'm not subscribed to the list, so, please Cc me on any reply.
