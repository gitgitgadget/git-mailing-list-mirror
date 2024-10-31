Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEF28E8
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730353088; cv=none; b=HwiGBXXpeCaz8yP8mMxFHQQjh+olR2eP+PhnoJY/KVwGUm1t8sPSCPN9Mz6IGxlOne4+5iyPCqY/0N5qlTe49wSIpy/QCmyHieX8+htKSurXCza9c5IuQZmFBmMEpu6el9XgmreBGSoCoyGADsEM70EtYUeZX+3O3jIr3E5EBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730353088; c=relaxed/simple;
	bh=8qWrXSx/UgrUxZIxv9/V3ZTd4HaKrQSh8HPpUsJnmL0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkuNbBsR6bnM8A4f0MUEBlriiAU+ci+5YaN+ua3lpvG2vpSv2Ii9JAPrF6mSaofeGhFm8GmKo2No2CLDWJ0EQCCu/Em0/Bz3lmlAhif5QslXqgO9O9RHtLSw4ulrvVCBD8GzXXwIyR6Pg66ZfzbUeh5vXsJZ7rRXac/d/434ftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fsv4fuqN; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fsv4fuqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730353084; x=1730612284;
	bh=EAi/gW/dkk71IyiFoq3mKI/n/HW9MhDbiui3jgoip5Q=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fsv4fuqNW8R1IVKOeL0m2vmZKgbdktSJU3uX3CkCDoSaZ/EunOsN966mOCtnQ9ygs
	 qvR/ldPojxfK7NlpZjRAjZvFC6TNwHAprgg/owrNoCDIkSWKDZNhXshMATT1U/+feG
	 Vb+A7dBo+vWEPwVCFpCYePxUZahOAc75SazwExpBBadeqVJd2sUadoBmR3p9coQvHk
	 ORUjylyyEdGizq/2eTNfHmctcYuGAcvVR02WoBw3/rVnyh0RXe18ngbZK+wvxegi3Z
	 NfqCHjVpu84Gput1wqAcFBVRnkzFav2LYKFdAikH1PHhCT02XWfHWEWuPrlLUQKZn0
	 Ai7bE5I+IMeRg==
Date: Thu, 31 Oct 2024 05:38:00 +0000
To: Michael Orlitzky <michael@orlitzky.com>, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Subject: Re: safe.directory warnings for root-owned repositories
Message-ID: <D59QZ1P3KSNB.ZXDHUA5HGC97@pm.me>
In-Reply-To: <ZyMGKHTnZDQ5JVuo@mertle>
References: <ZyMGKHTnZDQ5JVuo@mertle>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 66dd1e2925b8daf6182dc6a933ab9fc95ce84bfe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Oct 30, 2024 at 11:23 PM CDT, Michael Orlitzky wrote:
> If I create a new repository as root,
>
>   $ sudo git init
>   Initialized empty Git repository in /home/mjo/tmp/.git/
>
>   $ ls -alh
>   total 12K
>   drwxr-xr-x  3 mjo  mjo  4.0K 2024-10-31 00:09 .
>   drwxr-x--- 17 mjo  mjo  4.0K 2024-10-31 00:07 ..
>   drwxr-xr-x  6 root root 4.0K 2024-10-31 00:09 .git
>
> and attempt to do anything in it, I get a safe.directory warning:
>
>   $ git status
>   fatal: detected dubious ownership in repository at '/home/mjo/tmp'
>   ...
>
> Does that make sense? In terms of ownership, root:root is as safe as
> it gets.
>
> I'm aware that safe.directory is only scratching the surface of these
> "doing things in a directory that someone else can write to" exploits,
> but within the limited scope of this one feature, root ownership does
> not strike me as particularly dubious.

The dubious ownership check simply reports that the directory is owned by
someone other than the user running the command, with no special handling
for the root user. While the error might not make the most sense in this
context, I'm not sure that it's worth special-casing the root user
(really the user with id =3D 0 as it might not be named `root`) in the
implementation.

Why would you initialize a repository as `root` in the first place?

Best,
Caleb

