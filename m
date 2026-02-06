Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B562459C9
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354308; cv=none; b=XHK0yAQCKs6yzJH6EihaqyJ7yQMWVTUH8gjKxHUNzxwKdaDw+vl/pR9K7QQRPKRRn9ScMNTl3e/ebGYTHO5ojJ5x4TEWKIzjSwUaqj3H54mmigMpaBHmsbq87MNphVSXdCHamUxZc9rsbi6IgziMluBCrLcdQFVnWmvV2dmwQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354308; c=relaxed/simple;
	bh=nRNRWsQNg/DvxMZbdWn6yi+xN6xnz8GJiIKnz1nPr2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2W+FI//9HZ5b+Q4Ar4Y5ZQE4Jl/v+C81db/tig7msDrZ3Sz2Wa0+Im71Ke0n8gVwi1zA00MgNrAFkrC9QxFNOPIXJn15AIPbqQGxKuaZpeVPLEkIkZMIFVTbeIKS5p8p1342Hk1/0f0Zfof3SsiHU6tuVMJC/BT8gtWicidIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HhMHiKsJ; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HhMHiKsJ"
Received: from [192.168.43.16] (unknown [37.168.1.79])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8EB60B00548;
	Fri,  6 Feb 2026 06:05:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770354306;
	bh=nRNRWsQNg/DvxMZbdWn6yi+xN6xnz8GJiIKnz1nPr2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HhMHiKsJCtVOGjyOdKSW6ureTWGFChMCwPZ5pWkx3U3Gx/mvO0028Pf22uplc2rma
	 THzEHPFn1s9d3Nm6RQ3duBYugNVfThBAuQnR4hmjuaUMMjl4EtY0+zt0EXW4bPHIWB
	 L69t3WM0UEvH3Aw0M3O5FZp+w/qhliWDEedlqBpjuxsnsY9tDtx4SwQ10VOGu+aIKl
	 Q9WMlwCCesiRO2DW8Gn8h34zaBy6xGnPJVWCCSkYYCdlaYIeGuEQ+qOH0f60u+oio+
	 1UK+ceOYUOGm+pDASEB2alt6X23ZxVcsy6fP9HWOZpmkyS4BR2+XIDNS80pg3LI/zY
	 43uerttsPnNkg==
Message-ID: <5861406e-0ac7-4b96-9bde-cd3860ad5c4d@free.fr>
Date: Fri, 6 Feb 2026 06:04:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] config-batch: add 'set' v1 command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/02/2026 à 15:20, Derrick Stolee via GitGitGadget a écrit :
> From: Derrick Stolee <stolee@gmail.com>
> 
> This new command is intended for single-value assignments to a specific
> chosen scope. More complicated versions of the 'git config set' command
> will be incorporated into future commands.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-config-batch.adoc | 24 ++++++++
>  builtin/config-batch.c              | 71 ++++++++++++++++++++++
>  config.c                            | 27 +++++++++
>  config.h                            |  3 +
>  t/t1312-config-batch.sh             | 94 ++++++++++++++++++++++++++++-
>  5 files changed, 217 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
> index 3c9a3bb763..feec85c4ef 100644
> --- a/Documentation/git-config-batch.adoc
> +++ b/Documentation/git-config-batch.adoc
> @@ -111,6 +111,30 @@ get 1 missing <key> [<value-pattern>|<value>]
>  where `<value-pattern>` or `<value>` is only supplied if provided in
>  the command.
>  
> +`set` version 1::
> +	The `set` command writes a single key-value pair to a config

Please use direct imperative form.

> +	file. It specifies which file by a `<scope>` parameter from
> +	among `system`, `global`, `local`, and `worktree`. The `<key>`
> +	is the next positional argument. The remaining data in the line
> +	is provided as the `<value>` to assign the config.
> ++
> +------------
> +set 1 <scope> <key> <value>
> +------------
> ++
> +These uses will match the behavior of `git config --set --<scope> <key>

This "--<scope>" form is new in the synopsis grammar. Would we just cite
all alternatives or use a "normal" placeholder _<scope>_ ?

> +<value>`. Note that replacing all values with the `--all` option or
> +matching specific value patterns are not supported by this command.
> ++
> +The response of these commands will include a `success` message if the
> +value is written as expected or `failed` if an unexpected failure
> +occurs:
> ++
> +------------
> +set 1 success <scope> <key> <value>
> +set 1 failed <scope> <key> <value>
> +------------
> +

Please use synopsis style block for these too.

>  NUL-Terminated Format
>  ~~~~~~~~~~~~~~~~~~~~~
>  
