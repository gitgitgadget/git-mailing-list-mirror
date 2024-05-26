Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9B8F5B
	for <git@vger.kernel.org>; Sun, 26 May 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716718053; cv=none; b=HLj+MUqXjPqgr7C0VyF2y04JU7ynrqVdCBlVB+YNNKrdUtCcFhMB37kJjTwOM1IeAk02EnJqs34pkDuVixEPBf1O9BzXjFqnhweXOf4FuBSvIEiV18sr3rtokv1Ywq3Al6hAHyqpJwxq6Ut1ZBPytLJ35Gn2CPJD5tH1BQEMq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716718053; c=relaxed/simple;
	bh=Itj5P5/k8JDmzKeGViMBYawGTtjtK7ZzXcckJje/CDI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=EOVdJyLEejlm9zaPu0rTtGwJ3OB66KhW63xwh2EvyYVohTVegqKG0GyENTqCsqTWc3cztkAkaGcrKKSadEDNjb8OimzL2I19AOR9Hf2Q1+2fSCvRtI/+vl8sGmqcV8SEg8cTExGEGQYhinuBOUwoO6T8oJ3ZFysvishxu5OYmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=J628I8+k; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J628I8+k"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VnDwT1qjrz9sTl
	for <git@vger.kernel.org>; Sun, 26 May 2024 12:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1716718041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QJ/3Y58lcMtgMF1QvTSr0UDbgSFm1jGqIpk/AtPOqh8=;
	b=J628I8+k7BjCkL61Zfut2Cl2KaJbyKVErCOTFL3Qmj0tkqBPgLylyqF3Ws+8AHimp66KTm
	NlSV/RRSZJqczekm0SYiCD9JqOC/15DaWHG8WPb7LcP5rly8i0m+PQc1yb3VAGQXj7IyaF
	tIzhFYsyy4CMbyd2wDg/bWmuS+dz1SvtB+szg1A2RYHQLnNJl51Y0hLIqbWqclfijU19w4
	0cWNSMhsgx39175wzrQRy9Jyc+XyuByz8qreKR98vJ/m4ql1Jn9OPQX1AzlkQAY2E5fCea
	kYdZXEnYFWepdV++7YSs2h72hqahJDPrjaeeqcZuvLfTz2T8heJTlGMj8OnFDQ==
Message-ID: <73554ec7-4080-494f-8e2b-3e70acb48f93@mailbox.org>
Date: Sun, 26 May 2024 12:07:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: =?UTF-8?Q?Florian_Mei=C3=9Fner?= <aspiring_sociopath@mailbox.org>
To: git@vger.kernel.org
Subject: [BUG] git instaweb hanging on very large workdirs with
 `status.showUntrackedFiles no`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k81h9xrjhpqjrdpnqyy3srt3465dnytt
X-MBO-RS-ID: 3d6ea3fa0095d46e834

# What did you do before the bug happened? (Steps to reproduce your issue)

I manage my dotfiles with a bare repo, an alias and `git config 
status.showUntrackedFiles no` (see 
https://news.ycombinator.com/item?id=11071754).

# What did you expect to happen? (Expected behavior)

Git instaweb just showing the commits and tree, optimally without 
untracked files (respecting status.showUntrackedFiles).

# What happened instead? (Actual behavior)

When I try to run `git instaweb` on that repo, the website doesn't load 
but the git-instaweb process goes to 100% CPU (single-core) and stays 
there. From looking at `lsof` I conclude that instaweb somehow tries to 
look at every file in my workdir, taking forever (as my home folder) is 
very big. This renders gitweb/instaweb unusable for this type of repo.

# What's different between what you expected and what actually happened?

Gitweb loading instantly vs. taking minutes / not loading at all.

# Anything else you want to add:

I glanced over `man gitweb.conf` but couldn't find any useful parameters.

`git config --list` (redacted):
```
user.email=…
user.name=…
init.defaultbranch=development
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
core.editor=nano
maintenance.repo=…
push.autosetupremote=true
includeif.gitdir:/run/media/…/.path=config.no_compress
core.repositoryformatversion=0
core.filemode=true
core.bare=true
status.showuntrackedfiles=no
remote.origin.url=git@…
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.development.remote=origin
branch.development.merge=refs/heads/development
```

[System Info]
git version:
git version 2.45.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.10-2-MANJARO #1 SMP PREEMPT_DYNAMIC Thu May 23 19:12:51 
UTC 2024 x86_64
compiler info: gnuc: 14.1
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


