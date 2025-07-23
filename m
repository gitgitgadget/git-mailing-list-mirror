Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96BC1D7E4A
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301013; cv=none; b=rOj7GMf2na27cA99bdXCKMynE7266zBUeDdZNezKtN9XtpKWtWEV6DDLgKdi7EqZFpLDKDRd6NmOTHK/NKrrDTkwoAa9OqN7Qea95q7eXksZuQEDsdlJVCK9S5h1rcksRcH+D8XdY+70QemF3lFfpgQrgJgaySJrFFmSlwrrlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301013; c=relaxed/simple;
	bh=+weGiP9ZCX7w8UsXJ/WPccpGBTrnq/zSm76d0RJoqMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCgyEcJxtOUqL2t9aubUhuPm7zgK/CsM7FgFfPMz9Lpw4kwlqxPcV90AhkQi70D0ILX6LTjpUICyz3pFYLXSnI6LG31Ok4FnY5RPtdgc34MrOsvMxd40Hi8E2tI6WHOGaxTyc7EMT8Z9tcKOhGLkSr+P9xAUBh05n132h/NmsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=AmAmqWFv; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="AmAmqWFv"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:eeb4:a2dd:b58f:acf4])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 913A878035B;
	Wed, 23 Jul 2025 22:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1753301002;
	bh=+weGiP9ZCX7w8UsXJ/WPccpGBTrnq/zSm76d0RJoqMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmAmqWFv2spTi+jMZXiiFGBt0Ng42fUEByOjk/4WCgB1Qfowa/QaUN/ARv5rG8hK6
	 VFvnTtfe9tNOxKr/imJJcp6B9jXJV79fCXKB0Rc3ThhQLzC5B3Z3uWUZPy/6l5aXXT
	 Uc5D4EcMWKTM7VfoUjwSqNGEO0+1qMozQ9yGFMNWZAde3zAIezmluVqIA6ESAT26W+
	 OfARfK+2CE/WY6PX5h51LD5x1SDZHN8NzP+pdCzfR3dg1V10KMps29wEyYiJh5q6HS
	 EQ8LYDEy/OXAqM8F9i125IPX2BVjGoHtTrapTxOYKzXKOuQDosvLhwrC4gGqwP6R8T
	 A/JHSMvIzgUVA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
 jltobler@gmail.com, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
Date: Wed, 23 Jul 2025 22:03:12 +0200
Message-ID: <12708774.O9o76ZdvQC@cayenne>
In-Reply-To: <20250722002835.33428-2-lucasseikioshiro@gmail.com>
References:
 <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 22 July 2025 02:28:31 CEST Lucas Seiki Oshiro wrote:
> Currently, `git rev-parse` covers a wide range of functionality not
> directly related to parsing revisions, as its name suggests. Over time,
> many features like parsing datestrings, options, paths, and others
> were added to it because there wasn't a more appropriate command
> to place them.
> 
> Create a new Git command called `repo`. `git repo` will be the main
> command for obtaining the information about a repository (such as
> metadata and metrics), returning them in a machine readable format
> following the syntax "field<LF>value<NUL>".
> 
> Also declare a subcommand for `repo` called `info`. `git repo info`
> will bring the functionality of retrieving repository-related
> information currently returned by `rev-parse`.
> 
> Add the required tests, documentation and build changes to enable
> usage of this subcommand.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  .gitignore                  |  1 +
>  Documentation/git-repo.adoc | 38 +++++++++++++++++++++++++++++++++++++
>  Documentation/meson.build   |  1 +
>  Makefile                    |  1 +
>  builtin.h                   |  1 +
>  builtin/repo.c              | 26 +++++++++++++++++++++++++
>  command-list.txt            |  1 +
>  git.c                       |  1 +
>  meson.build                 |  1 +
>  9 files changed, 71 insertions(+)
>  create mode 100644 Documentation/git-repo.adoc
>  create mode 100644 builtin/repo.c
> 
> diff --git a/.gitignore b/.gitignore
> index 04c444404e..1803023427 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -139,6 +139,7 @@
>  /git-repack
>  /git-replace
>  /git-replay
> +/git-repo
>  /git-request-pull
>  /git-rerere
>  /git-reset
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> new file mode 100644
> index 0000000000..caee7d8aef
> --- /dev/null
> +++ b/Documentation/git-repo.adoc
> @@ -0,0 +1,38 @@
> +git-repo(1)
> +===========
> +
> +NAME
> +----
> +git-repo - Retrieve information about a repository
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git repo info [<key>...]
> +
> +DESCRIPTION
> +-----------
> +This command retrieve repository level information.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +COMMANDS
> +--------
> +info [<key>...]::

The commands and options are quoted with back-quotes with the new synopsis 
style:

`info [<key> ...]`::

Thanks

JN


