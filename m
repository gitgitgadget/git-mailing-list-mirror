Received: from mail-01.sigsum.org (mail-01.sigsum.org [91.223.231.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C070801
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.223.231.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180136; cv=none; b=RSy5ZXce0KMYRb5W0afg8buq1jkHYjW7MyPfUdhjfgIDqMY1wzHf4GEcLI5qU7CpAfo79uiPFhjzOEbzRTt2YRSLXDM6YQDp6vKicbYP9FTac1FBXbrQXdM3JNvO021IEF9HAhV+hdA/qstMkiwaf43T2s769wEk2BeRdlepAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180136; c=relaxed/simple;
	bh=n2qalRdmBPJ/IOG1ZgqfwsFPDA2doIQoU4usACF8D4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b2mCVWxgrJoH191KbN7K82fmUqVnxJ4XN62l5/TUuJyetbkTrV2TOEaJSfvGsJaFrKcIlPY/59qPdoe08zo2ew18k0VdFwe9jigeXT+CDZRxhc2XpZKqU3VJ4KgAtabTWfA+pDAnetBH3mOHBvnZDmrDldRt4s0glWoURY4E+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se; spf=pass smtp.mailfrom=glasklarteknik.se; dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b=DKiynEuy; arc=none smtp.client-ip=91.223.231.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glasklarteknik.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b="DKiynEuy"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2E1DC0895;
	Thu, 21 Nov 2024 10:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glasklarteknik.se;
	s=dkim; t=1732180122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWGPa3xc8ftsAw5Ix5PZYogkwGuHD058q5eBo7vRzx0=;
	b=DKiynEuyEapuSICLk2AgEYAkmCCgwPQw161FsIroJfhacI2nXi++a0p8GV/np3xJARZXZx
	yEbB0zAlUF/BNTmroGfvPpv59iu4UihuAs+Xm21A72edzkXgd0GjfIj2VYwfzcXUnn9a+N
	N62tpHf1biO52mVfgIRmCelXlyJxfWFoT247FZawU72TzTYvt3wwukHj00/5kWjr+BezXk
	s+1N3S0fTLHfpUP2pivKrsakrCbCfsLzDGhwWE4+Vu2aQjRL8hiZF9AUV1tDFkZW8mVVtT
	wgCGNxteNrHUKXI5IgZJUWyTbaOp+aSk45vNqpX4Wt9rG+JDWClecxznKkD+Gg==
From: =?utf-8?Q?Niels_M=C3=B6ller?= <nisse@glasklarteknik.se>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Unexpected effect of log.showSignature on tformat:%H.
In-Reply-To: <Zz0NsaM-KFRXzBp6@tapette.crustytoothpaste.net> (brian m.
	carlson's message of "Tue, 19 Nov 2024 22:14:09 +0000")
References: <87cyirtweq.fsf@localhost>
	<Zz0NsaM-KFRXzBp6@tapette.crustytoothpaste.net>
Date: Thu, 21 Nov 2024 10:08:37 +0100
Message-ID: <874j41t0mi.fsf@localhost>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> git show is a porcelain, and it can be affected by options, such as
> `log.showSignature`.  If you want predictable behaviour, you need a
> plumbing command, whose behaviour isn't affected by configuration in
> this way.  The equivalent to what you've requested is this:
>
>     git rev-list --no-commit-header -1 -s --format='tformat:%H' SOME_COMMIT
>
> I've confirmed that works correctly even if `log.showSignature` is set.

Thanks! It seems the way to understand this is that git show can display
a bunch of different things, depending on configuration, and --tformat
affects only one of potentially many output lines.

So git rev-list solves this problem. My script (which creates a file
archive, in a reproducible fashion, from a list if git repos and (signed)
tags) uses a few more git commands:

  git clone
  git ls-files
  git -c gpg.ssh.allowedSignersFile=... tag --verify
  git submodule

Of these, it appears only ls-files is listed as a "plumbing" command. I
wonder if I still need to stick to GIT_CONFIG_GLOBAL=/dev/null to avoid
surprises for the clone, tag and submodule commands?

Any advice appreciated.

Regards,
/Niels
