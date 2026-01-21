Received: from mx1.hexon-is.nl (mx1.hexon-is.nl [82.148.219.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44A48A2C7
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.148.219.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001307; cv=none; b=Gwf1ADzBgYvq1iQPuFYyV9/AnnQWlKrIx/ioTBMZvmQQ6pzuC9ND5esYHZvibT5bL9VH67NDOmSmS1uuAmlvfqXiyFlhUQUcxIkth+qgaIVuacAukHsr8tfG5PBl7lgRkySdvE3AYVLaAhpaPQT3JUwhSoROq2sQmzrRNJNqRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001307; c=relaxed/simple;
	bh=Q1umRYl/bUyQQIjFVUXD2KoYyh6TQeMytLUeAubnQag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G5jH672R8+yG4fF5L26sNlpZGfo7eFkHsMdOL16b8XQvN88uTxMx7E+tx8rYZClHWlvhc2K08WrORdiTBFVw/MrMRx5agnJOcUW2VAaRyw0h8FndogCOWpAICjWGUZFVRwFbH81W75Q24sBZJdnaDVwOjm3Mieg80OBQ2L617rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexon.nl; spf=pass smtp.mailfrom=hexon.nl; dkim=pass (1024-bit key) header.d=hexon.nl header.i=@hexon.nl header.b=WDPwQq+i; arc=none smtp.client-ip=82.148.219.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexon.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexon.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hexon.nl header.i=@hexon.nl header.b="WDPwQq+i"
Received: from [10.0.1.108] (gw.hexon-nijmegen.nl [89.255.9.179])
	(authenticated bits=0)
	by mx1.hexon-is.nl (8.15.2/8.15.2/Debian-18) with ESMTPSA id 60LCUY0L3799047
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2026 13:30:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hexon.nl; s=default;
	t=1768998634; bh=Q1umRYl/bUyQQIjFVUXD2KoYyh6TQeMytLUeAubnQag=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WDPwQq+iC3209FOW1hO0Jj004xGbFRWmT2xnBF4Bxjcs2+5vAQ8hUuOs3kPoymeyU
	 JJ5954SGWFgiuVwPrGsfehkBkaflyS5o5pvHuPbGXJQyiTRoZ29rg1CPMooJwsV3SD
	 Mv1KMepT/zJ6xZeiMNXzw+Vf4A0Kwawce3Qd13l4=
Message-ID: <5a81da1c-1cf7-4966-8be5-67139878a3e0@hexon.nl>
Date: Wed, 21 Jan 2026 13:30:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: git-stash fails for new file not staged for commit
To: Claas Augner <claas.augner@lsp.net>, git@vger.kernel.org
References: <f139a5e1-242a-e23b-6eda-b8b49423d70b@lsp.net>
Content-Language: en-US
From: Jille Timmermans <jille@hexon.nl>
In-Reply-To: <f139a5e1-242a-e23b-6eda-b8b49423d70b@lsp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Hexon-MailScanner-ID: 60LCUY0L3799047
X-Hexon-MailScanner: Found to be clean
X-Hexon-MailScanner-From: jille@hexon.nl
X-Hexon-MailScanner-Watermark: 1769603435.31784@yUvFyrnOKnrcDNyP2fzjJg

On 24-06-2021 17:42, Claas Augner wrote:
> > What did you do before the bug happened?
>
> I tried to stash a new file that I added with `git add --intent-to-add`:
>
> ```
> $ touch foo
> $ git add --intent-to-add foo
> $ git stash
> ```
>
>
> > What did you expect to happen?
>
> The file should have been stashed.
>
>
> > What happened instead?
>
> The stash failed with the following error message:
>
> ```
> error: Entry 'foo' not uptodate. Cannot merge.
> Cannot save the current worktree state
> ```
>
>
> > What's different between what you expected and what actually happened?
>
> Instead of stashing the file, the stash fails with an error message.
>
>
> > Anything else you want to add:
>
> Background: https://github.com/okonet/lint-staged/issues/990
>
>
> [System Info]
> git version:
> git version 2.32.0
This bug is still present with git version 2.52.0.
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28 23:40:43 
> UTC 2020 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /usr/bin/zsh
>
>
> [Enabled Hooks]
> applypatch-msg
> pre-applypatch
> post-applypatch
> pre-commit
> prepare-commit-msg
> commit-msg
> post-commit
> pre-rebase
> post-checkout
> post-merge
> pre-push
> pre-receive
> update
> post-receive
> post-update
> push-to-checkout
> pre-auto-gc
> post-rewrite
> sendemail-validate
>
> -------------------------------------------
> LSP.net GmbH
> Prinzregentenstr. 40
> 10715 Berlin / Germany
> T +49 30 20896331
> Web: https://www.LSP.net
> Blog: https://blog.LSP.net
>
