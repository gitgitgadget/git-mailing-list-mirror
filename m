Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0A208A9
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428647; cv=none; b=cSgg5lilsLpjgBJMA7gM/s6MqwCOBkmfm9ou4/qCeM8Uh0rjGvVssBoUxvXpG04FaWzkR7QALMvlx20plYDyPS1Yxoy0OR7/n80twItfPKfWmgM0P1rNeMPFOmcDn6YEumrQAtdr9EJcpb0SRZTICXOqQk+VIf/FKG6Vl+tFZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428647; c=relaxed/simple;
	bh=I72J74hAUmwZrkHAcp2kYSakVu4Yj/v1dzs/Ru06swU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4ZhQyCX32GloV7QnXLP0ImhP/W05iyvNcqxooMelOAJUyRzZ75mSBgM5y1yEVKE3YPwMI/8RW7TzpLpY5HHIAWv1Fvt6X/1G8TAGQPBKOpesttT5EIyZbVmzr8pycJ+38iAyu3egJIr/r7Fg5nO2vzfaBaKCVeZrbQ99iuM1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=FAxSw8mZ; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="FAxSw8mZ"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:f89b:5f6f:dbed:efce])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9523113F880;
	Sat,  1 Feb 2025 17:50:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1738428642;
	bh=I72J74hAUmwZrkHAcp2kYSakVu4Yj/v1dzs/Ru06swU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAxSw8mZEicR0cPN55PJxA2N27Vp2yXMiZGBBQSYwLR17ZzX9lIVCdhsi5EzXc1g5
	 L98CnkKXZni49EKthvJOQtCHlYqwf0GhMlHrimv2dJBbeZXjQ3oWpF/R7p7RPcoZ4J
	 GvFp7Mj5W+61DR2Zeys+Ez+bJ9xGkHCKPOnK3arXka6aXPMLM4XhAvUXNNBK1r//8n
	 SPckU1GEGxkNo5En1ah2uPY2V78fMbUnrqUFmkgFrhbgSnNb1UcN4JNXdwx4U212ih
	 lpob/8Ikbx2aDjkXQLuj4pCR91Hszr6R3iC9dCjxX6lEFwrXyAiUQw0mkjctKi1paM
	 zv7MKlfns/7Pw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
 Toon Claes <toon@iotcl.com>
Subject:
 Re: [PATCH v4 6/6] builtin/clone: teach git-clone(1) the --revision= option
Date: Sat, 01 Feb 2025 17:50:36 +0100
Message-ID: <2974411.e9J7NaK4W3@cayenne>
In-Reply-To: <20250131-toon-clone-refs-v4-6-2a4ff851498f@iotcl.com>
References:
 <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
 <20250131-toon-clone-refs-v4-6-2a4ff851498f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 31 January 2025 16:30:34 UTC+1 Toon Claes wrote:
> The git-clone(1) command has the option `--branch` that allows the user
> to select the branch they want HEAD to point to. In a non-bare
> repository this also checks out that branch.
> 
> Option `--branch` also accepts a tag. When a tag name is provided, the
> commit this tag points to is checked out and HEAD is detached. Thus
> `--branch` can be used to clone a repository and check out a ref kept
> under `refs/heads` or `refs/tags`. But some other refs might be in use
> as well. For example Git forges might use refs like `refs/pull/<id>` and
> `refs/merge-requests/<id>` to track pull/merge requests. These refs
> cannot be selected upon git-clone(1).
> 
> Add option `--revision` to git-clone(1). This option accepts a fully
> qualified reference, or a hexadecimal commit ID. This enables the user
> to clone and check out any revision they want. `--revision` can be used
> in conjunction with `--depth` to do a minimal clone that only contains
> the blob and tree for a single revision. This can be useful for
> automated tests running in CI systems.
> 
> Using option `--branch` and `--single-branch` together is a similar
> scenario, but serves a different purpose. Using these two options, a
> singlet remote tracking branch is created and the fetch refspec is set
> up so git-fetch(1) will receive updates on that branch from the remote.
> This allows the user work on that single branch.
> 
> Option `--revision` on contrary detaches HEAD, creates no tracking
> branches, and writes no fetch refspec.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-clone.txt |  10 ++++
>  builtin/clone.c             |  59 +++++++++++++++++----
>  parse-options.h             |   9 ++++
>  t/meson.build               |   1 +
>  t/t5621-clone-revision.sh   | 123
> ++++++++++++++++++++++++++++++++++++++++++++ 5 files changed, 193
> insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index
> 
99a9222e63429b3447deb3e7c08962d4ec60a295..6c882b6fc56c2595059124cd0ecdaf825e3
> 10160 100644 --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -221,6 +221,16 @@ objects from the source repository into a pack in the
> cloned repository. `--branch` can also take tags and detaches the `HEAD` at
> that commit in the resulting repository.
> 
> +`--revision` _<rev>_::

You can use the backticks for full synopsis style: `--revision <rev>`

> +	Create a new repository, and fetch the history leading to the given
> +	revision _<rev>_ (and nothing else), without making any remote-
tracking
> +	branch, and without making any local branch, and point `HEAD` to
> +	_<rev>_. When creating a non-bare repository, the revision is 
checked
> +	out on a detached `HEAD`. The argument can be a ref name
> +	(e.g. `refs/heads/main` or `refs/tags/v1.0`) that peels down to a
> +	commit, or a hexadecimal object name.
> +	This option is incompatible with `--branch` and `--mirror`.
> +
>  `-u` _<upload-pack>_::
>  `--upload-pack` _<upload-pack>_::
>  	When given, and the repository to clone from is accessed
> diff --git a/builtin/clone.c b/builtin/clone.c
> index



