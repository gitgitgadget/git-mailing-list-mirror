Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958A3A1CE9
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781344763; cv=none; b=tt8rwMv0NTdGLOMtc9GS0wR0K0v/+bduT6LfV96+myzpyJVWjnINLi9kHcq5NCLX8azFula5TsxZzqmv3Xz1eg2YZxXRmgfJ/5l+sphR6NZkdFeiGGHdsN8MrMn1S8dtcqm5UBal5PckdzekV/j797vo8apK8iNaw4ldHbEn0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781344763; c=relaxed/simple;
	bh=IF4dxDfghO40oaflc/DCtW96p/ScwFSy7/rw9rKgru8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLDqrOxMgCB2cKAAaExJtwTy7WHv7M6G73TuAN7GoUk46cmL5uaqHXhtQ6YCLSfBPgHYDbSapwGj/XO/GfQJAPGqz2NLUynoGmK3qKDLtFG43L/YWQI2rbWtlR1DlIHX6Hwg57dBpZV8jXl7mQ9M+8Nj1MZq7Ajuo7W+Y21j/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gcsKr05wFzRnlX;
	Sat, 13 Jun 2026 11:59:11 +0200 (CEST)
Message-ID: <355d4f1a-147c-47e3-ab09-06810d7910c0@kdbg.org>
Date: Sat, 13 Jun 2026 11:59:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] commit: preserve commit hash on a no-op amend
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.06.26 um 11:16 schrieb Harald Nordgren via GitGitGadget:
> git commit --amend --no-edit rewrote the commit and moved the branch tip
> even when nothing changed, because the committer date was reset to "now".
> Reuse the existing committer date so a no-op amend keeps the commit hash and
> leaves the branch untouched.

`git commit --amend --no-edit` is a way to set the committer timestamp
to the current time without changing other aspects of the commit. This
takes away this ability, doesn't it?

Is this keyed to --no-edit? Why is this mode special? Wouldn't it be an
identical case when the commit message is passed to the editor, but
comes back unchanged?

An invocation of `git commit` asks to "please make a new commit". But in
the suggested mode, no new commit is created. Shouldn't this then be
regarded as failure?

What happens with the current branch? Is it left unchanged (no ref
update occurs) or is it changed (a ref update occurs, but it happens to
be a no-op)? And does this then generate a reflog entry?

The updated documentation says about signed commits (note: I am totally
clueless about commit signing procedures):

> A commit that is being signed (`-S`, or `commit.gpgsign`)
> is always rewritten, since its signature cannot reproduce the original.

But if the commit doesn't change in any way, why should the signature be
invalidated, rewritten, or updated?

-- Hannes

