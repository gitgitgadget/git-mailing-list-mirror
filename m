Received: from bsmtp3.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD5277026
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430742; cv=none; b=BWSVMHu57xWkDXiHS1pVT4lg//Xd4nrcOAKU4wRbDpU9VmR4vwfft9CAua7TKYOYAmk2nlwf+clMufrYYMNQETqXaQTivO1+WLA7IRzfdvn5gbcv8MaR0W4uDDmb1IpdvM867SoKB8ZyTRzkG3Ek1ZDnbw5Ksn+iRwyn2RPUdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430742; c=relaxed/simple;
	bh=zNw7fBGZi6KjJ5+UCxZVuaSL/PzxyKIyD6onUJ28gUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eym8Jn1su7A/gHmbfCv/aI6CQVbnTBfcd4w2QDNRztdEOSE37wwQFdMDh/g60D9efUv6PjthzLQsXEgDuxLiZXouUQEK68sJfIaIwWaUjx3uYQzQBTQnr07LTBS7lM//R2PImyha5PIzjThEPQC2gMQ/hSdgyiztU9ci5oyhJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gMFTl0R5xzRnly;
	Fri, 22 May 2026 08:18:50 +0200 (CEST)
Message-ID: <273103d7-c816-4cde-9e89-b630c37b0749@kdbg.org>
Date: Fri, 22 May 2026 08:18:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] branch: add --forked <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
 <f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.05.26 um 00:40 schrieb Harald Nordgren via GitGitGadget:
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index c0afddc424..3a421f6663 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -24,6 +24,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
>  git branch (-c|-C) [<old-branch>] <new-branch>
>  git branch (-d|-D) [-r] <branch-name>...
>  git branch --edit-description [<branch-name>]
> +git branch --forked <branch>...

I would have preferred that this option is another filter of --list
mode, not its own mode of operation. Consequently, each --forked option
would take only a single argument (which can contain globs), and can be
given multiple times.

>  
>  DESCRIPTION
>  -----------
> @@ -199,6 +200,12 @@ This option is only applicable in non-verbose mode.
>  	Print the name of the current branch. In detached `HEAD` state,
>  	nothing is printed.
>  
> +`--forked`::
> +	List local branches whose configured upstream matches any
> +	of the given _<branch>_ arguments. Each argument is either
> +	a ref (e.g. `origin/master`, `master`) or a shell-style
> +	glob (e.g. `'origin/*'`). Multiple arguments are unioned.

So this could perhaps read:

`--forked`::
	List only branches whose configured upstream matches
	_<branch>_. The argument can contain a shell-style glob
	 (e.g. `'origin/*'`). The option can be repeated to
	widen the filter.

Note that there is no reason to say "local branches". ("... are unioned"
sounds strange, so this is may attempt to express the same in a
different way.)

The icing on the cake would now be that

    git branch --merged origin/main --forked origin/*

provides the list of branches forked from origin that have already been
integrated.

-- Hannes

