Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92EB3290DC
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977086; cv=none; b=KjfBHY25cTVhec8hJToXNalpjIR4QxuemorCgJl90bcYRUmJCal7AFoRC4GF63EH8l5AMOq2vnQ1DZNFiBYTo0iEy1xYxX2TBtd8CFpAYxy9ZOhtf1K3d6r/RRku6m620BZgcJkzzAjHmDcJqAT3Qt3VcFj/4pth3rI0+2L4V0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977086; c=relaxed/simple;
	bh=7bX064J3CTy53nYyo0raEihqkcvXF5MmdkQyJJGhZ50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kj1Gxk/CFnB3qbggNxIeyJnlYYztcmNnhEjrS1EYLfjhbY9LFtI70VppvEzE4PH1Mg6cDakNPVYyObn7D7Oik8mUUm0zLvK17inVNiAMJDEc1deaQLQhf8MCFRUpKUIVXTJk/3sCy6IXFT8yxW8dGDFNEqrKYho+jmQyHcor8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=pLJNnAIJ; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="pLJNnAIJ"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 3CA71B00563;
	Tue, 31 Mar 2026 19:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1774977082;
	bh=7bX064J3CTy53nYyo0raEihqkcvXF5MmdkQyJJGhZ50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLJNnAIJziKjIxKdBCd/FdaGkT/Q+g7O+GgkZYm+G4C09iXsqEeHyzMBbiLEv7L7y
	 Wr8eihosHqRqiJ7u3cfIvh9qPvQchqR4ECTDo4OxI/Tm7yHk/HQ8nuUZWoir1Cd3G+
	 3Ek773FbJq4YYL5Icfzls8/OTpRK6pVR/6I94h5/8GsNSb5tQHfIXcGATLx7dYyEu7
	 ovICneItqWPkzZ9tPHf5BgbJbS0HjnPdWvVaU/6iKGU6j54MpZafwW6W/0tAci0uc7
	 6yLbDLHBHzIeITmqcnlNXXV+Zj7Nxrt1IRqrPEMcnJ5ygOn8Gr+T/YOVtlA6C3qyn8
	 GzJFTaSjZQQrg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: karthik.188@gmail.com, christian.couder@gmail.com, ps@pks.im,
 gitster@pobox.com, toon@iotcl.com,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Subject:
 Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to --batch-command
Date: Tue, 31 Mar 2026 19:11:13 +0200
Message-ID: <2060629.PYKUYFuaPT@piment-oiseau>
In-Reply-To: <20260329082808.12609-2-siddharthasthana31@gmail.com>
References:
 <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-2-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 29 March 2026 10:28:08 CEST Siddharth Asthana wrote:
> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
> but this option needs to be set when the process is created. This means
> we cannot change this option mid-operation.
> 
> At GitLab, Gitaly caches git-cat-file processes and it would be useful
> if --batch-command supported toggling mailmap dynamically with existing
> processes.
> 
> Add a `mailmap` subcommand to --batch-command that takes a single
> argument: `yes` to enable mailmap and `no` to disable it. When enabled,
> mailmap data is loaded from disk on first use and kept in memory so that
> toggling back on does not require reloading.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
> CI: https://gitlab.com/gitlab-org/git/-/pipelines/2416081861
> 
>  Documentation/git-cat-file.adoc |  7 +++++
>  builtin/cat-file.c              | 30 ++++++++++++++++++---
>  t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-
file.adoc
> index c139f55a16..af32e929a8 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -174,6 +174,13 @@ flush::
>  	since the beginning or since the last flush was issued. When `--
buffer`
>  	is used, no output will come until a `flush` is issued. When `--
buffer`
>  	is not used, commands are flushed each time without issuing `flush`.
> +
> +mailmap <yes|no>::

`yes` and `no` are keywords, and you want to express an alternative, do it 
like this: `mailmap (yes|no)::`.

> +	Enable or disable mailmap for subsequent `contents` and `info`
> +	commands. When `yes` is given, mailmap data is loaded from disk on
> +	first use and kept in memory; passing `yes` again does not reload 
it.
> +	When `no` is given, mailmap is disabled but the data stays in memory
> +	so that a later `mailmap yes` does not need to reload it from disk.
>  --
>  +
> 

Instead of detailing the alternatives in the same chapter, you could break it 
into a sub-list:

Enable or disalbe mailmap for subsequent `contents` and `info` commands. 
Possible values are:
`yes`;;
mailmap data is loaded from disk on first use and kept in memory; passing 
`yes` again does not reload it.
`no`;;
mailmap is disabled but the data stays in memory so that a later `mailmap yes` 
does not need to reload it from disk.

Thanks


