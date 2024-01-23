Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [80.237.132.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5040C50A72
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023654; cv=none; b=YwaQ91O3ga/hdLvIWvYfXOKBZwnkku4BFKc2l6AHXHV5s8VXnXPf1Jh5pXXaEmTLxM1EtU12+y8maBp8ZLq5XfsWrwfnyO+Z9w2jj/PY6SoiLndJ4FJ/hXSLYiG1OTx+BXoSTG/taZipnCLkDky8b3x1Xf0dihDTs2gTNIQnkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023654; c=relaxed/simple;
	bh=IIwShkPKyrZr0UeDQIYlOj/kNuro4mMmUvnEuR03SWQ=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=P+eVd6n/CaeYKT3gkxQkiOgsOLgC/sbEGDKUMkjEnQPSYjH7AfDhyDA1ptEERUPH5TEe/B/s8pC6ds7Dh+O5SEYO6DdE/Dbs6aDc1g0FG94heCeJhwBWZ8JMfx90t6p9fn1m5mSSwX0XJGU0tkeevE2JM8Zlzd9hAYV8ttAkUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtuell-zuhause.de; spf=pass smtp.mailfrom=virtuell-zuhause.de; arc=none smtp.client-ip=80.237.132.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuell-zuhause.de
Received: from app01-neu.ox.hosteurope.de ([92.51.170.135]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rSIH1-00068H-81; Tue, 23 Jan 2024 16:01:11 +0100
Date: Tue, 23 Jan 2024 16:01:11 +0100 (CET)
From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1015793055.437265.1706022071164@ox.hosteurope.de>
Subject: Fatal error: commit-graph-chain.lock': File exists.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev57
X-Originating-Client: open-xchange-appsuite
X-Originating-Sender: thomas@akwgegner.de
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1706023652;e551b31e;
X-HE-SMSGID: 1rSIH1-00068H-81

Hi,

Since 2.43.0 I'm seeing the following error message when I fetch from a remote:

$LC_ALL=C git fetch --all
remote: Enumerating objects: 446, done.
remote: Counting objects: 100% (446/446), done.
remote: Compressing objects: 100% (135/135), done.
remote: Total 446 (delta 328), reused 415 (delta 311), pack-reused 0
Receiving objects: 100% (446/446), 432.84 KiB | 1.01 MiB/s, done.
Resolving deltas: 100% (328/328), completed with 29 local objects.
From EEE:XXX/YYY
 * [new branch]          bugfix/ZZZ -> origin/ZZZ
 * [new branch]          bugfix/ZZZ -> origin/bugfix/ZZZ
 + 7244c9b68...6dad36582 feature/AAA -> origin/feature/AAA  (forced update)
 + 7ce96b207...7bee890d6 feature/BBB -> origin/feature/BBB  (forced update)
 * [new branch]          feature/CCC -> origin/feature/CCC
   fd8c36a84..2ab4db03d  main                                            -> origin/main
fatal: Unable to create '/DDD/.git/objects/info/commit-graphs/commit-graph-chain.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.

Observations:
- repo and gitforge independent
- only happens when fetch.writeCommitGraph is turned on
- git gc cleans up the stale lock file
- I think this is only happening when multiple branches on the remote have changed

I do have protocol.version set to 2.

I tried replicating the issue with an example but failed so far.

Does that ring a bell somewhere? Where should I start poking?

Thanks,
Thomas

[System Info]
git Version:
git version 2.43.0
cpu: x86_64
built from commit: 564d0252ca632e0264ed670534a51d18a689ef5d
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.55-1 (2023-09-29) x86_64
Compiler Info: gnuc: 12.2
libc Info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash
