Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0FEBE
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109959; cv=none; b=AkNdUt1bdMwYRRcpRMp3Pmu413HsHa9jBukIezIjO6McX7+zBbzDx3e0xAKGUVSpGgxi7aQYK/M/WKJc3AAq4jnGeXlasipvm3845Ln+avyrc81Oz1VIs/qgUiQrohP51NjUlAqd6ezUfly+WL0iLjnkrpodkwHI1uY3U0VkX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109959; c=relaxed/simple;
	bh=6vZSZaiIaj9o/GqifFJWkTxZOjZQ5LXfGMcgUpuBL/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXkHkiw1JEIYMazuU7MEULLELOqGp1BGiD6NEA3vYDcYfrs78HJJp4/UDuLOaYQYxj0ASzMrByN4Py9vfr95Fv0KHbPNlQHUNqZH9iXEDMYwZw2K2BthvxEu4NPkuy9lGcFxq7x0fmDsXGUbIZK877vJTDO2r9KrIrWhvELCZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QDlH5+0H; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QDlH5+0H"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F302119E6D;
	Fri, 26 Apr 2024 01:39:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6vZSZaiIaj9o/GqifFJWkTxZOjZQ5LXfGMcgUp
	uBL/g=; b=QDlH5+0Hq7VQiQzKjiFvFVdT4gbuG/+yfe4K9P4lxEw6sbwhc4/v7D
	8hK2burPTuJ5dipiLuX34oXUv+GJIgg8gTcDH8G98vJH5ooAxQ+9scyzlV6vCmmq
	DHC6OxS0bUflSpzoLwnltYzJjqFI7zzj1cMAcgyOoMcQUKJ/E5c7Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EB85719E6C;
	Fri, 26 Apr 2024 01:39:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83FA519E6B;
	Fri, 26 Apr 2024 01:39:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Thomas via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Thomas <thomasqueirozb@gmail.com>
Subject: Re: [PATCH] completion: fix zsh parsing $GIT_PS1_SHOWUPSTREAM
In-Reply-To: <Zir-eeK0CZxVLhcR@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 26 Apr 2024 01:08:09 +0000")
References: <pull.1710.git.git.1714071592035.gitgitgadget@gmail.com>
	<Zir-eeK0CZxVLhcR@tapette.crustytoothpaste.net>
Date: Thu, 25 Apr 2024 22:39:10 -0700
Message-ID: <xmqqr0esbs3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4FC8A514-038F-11EF-884C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I wonder if it might actually be better to adjust the shell options when
> we call into __git_ps1.  We could write this like so:
>
> 	[ -z "${ZSH_VERSION-}" ] || setopt localoptions shwordsplit
>
> That will turn on shell word splitting for just that function (and the
> functions it calls), so the existing code will work fine and we won't
> tamper with the user's preferred shell options.

Nice.  I did

    $ git grep -e 'for [a-z0-9_]* in ' contrib/completion/

and wondered why other hits were OK.  The completion one seems to
have "emulate" all over the place to hide zsh-ness from functions it
borrows from git-completion.bash, but git-prompt side seems to lack
necessary "compatibility" stuff.

> My concern is that changing the way we write the code here might result
> in someone unintentionally changing it back because it's less intuitive.
> By specifically asking zsh to use shell word splitting, we get
> consistent behaviour between bash and zsh, which is really what we want
> anyway.

Very well said.

> I use the above syntax (minus the shell check) in my zsh prompt and can
> confirm it works as expected.

Thanks.

By the way, I notice that the title of the patch talks about
"completion", but this is about a prompt.  It needs to be updated in
a future iteration.

