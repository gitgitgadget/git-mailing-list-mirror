Received: from binarylane-bailey.stuart.id.au (binarylane-bailey.stuart.id.au [203.57.50.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42407C8DF
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.57.50.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709261; cv=none; b=dNTiknVhjXQEboja2zt+a9xsulH17Ryxv6B7KLijCbJTsfMzSzI1eIbOtg38XX+FnWMl0zlrj7JO0THkysHGHupHz/23qLgsgqXndqjmWbl2Dg3i5PEhk6mBLWpuJDtp3oCVCLI8vPS8zTD//YvL4NRc7+TzQeMQFwipurJ7T1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709261; c=relaxed/simple;
	bh=5ibQkI0zd7BB4y/COjUOiJqk6J8tBHI3oQ8+LxBFVqo=;
	h=From:To:Subject:Message-Id:Date; b=swyKXlkukYb9C4Pr1bzi6z2JCYVQ9WKgzh601iMn8LAVze4CsJOAtXcrleie53pMLO2exlVLHqfy+H/34rEUJVNTl14mh/tR9RZ0u70fTe6+UlbuxUXO9wpVnAdJzgPCi3CiyqTpgU9hnYEo+P4ecQ4ZzFfbdiLQrRACBMtOyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au; spf=pass smtp.mailfrom=stuart.id.au; dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b=XsX7WBF7; arc=none smtp.client-ip=203.57.50.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b="XsX7WBF7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=stuart.id.au; s=dkim; h=Date:Sender:Message-Id:Subject:To:From:Reply-To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pWZwK0p7iuTc37z6SUrhW9nYqLnJ20ocppmXiQlPyKY=; b=XsX7WBF7NxTD+C5hje69UbHh8h
	2IFB2AJdbonDmHfv0x990ZFIY1mfMUAVhtUhZpnSpyOK3xjh+Vqf86R3P1wughC2FbD7uyKVtYpTB
	PnpHqwlcZ/46BWC4s/W09bTGLcfQrhZMtPcf2/o5I4EgoodvHJGWfm9E9QAd5PzU5TYEw/hxQ3VJC
	TyOGoIUFcDar27P9RYP2Gv2p5Z2FXrr4pnVmeVZLDH/D5xVJQ6Mch+ncI2xCUx7hCh43hNxUt/+3c
	u4TmxcZIIi4NYY+KdqEN9utqPnRQXB5+j71BeXlU/OwSe/cYYJtfaBuUvxtw0Iv8UjJOQxW0CKygF
	VHCQOklg==;
Received: from russell by binarylane-bailey.stuart.id.au with local (Exim 4.96)
	(envelope-from <russell@binarylane-bailey.stuart.id.au>)
	id 1sr5iF-0007zV-2k
	for git@vger.kernel.org;
	Thu, 19 Sep 2024 11:12:03 +1000
From: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
To: git@vger.kernel.org
Subject: "git worktree repair" modifies the wrong repository
Message-Id: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
Sender: "russell,,," <russell@binarylane-bailey.stuart.id.au>
Date: Thu, 19 Sep 2024 11:12:03 +1000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

What did you do before the bug happened? (Steps to reproduce your issue)
    /tmp$ mkdir -p gb/a gb/b
    /tmp$ cd gb/a
    /tmp/gb/a$ git init r
    Initialized empty Git repository in /tmp/gb/a/r/.git/
    /tmp/gb/a$ cd r
    /tmp/gb/a/r$ touch x
    /tmp/gb/a/r$ git add x
    /tmp/gb/a/r$ git commit -am .
    [main (root-commit) 6323b04] .
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 x
    /tmp/gb/a/r$ git branch foo
    /tmp/gb/a/r$ git worktree add ../r.foo
    Preparing worktree (new branch 'r.foo')
    HEAD is now at 6323b04 .
    /tmp/gb/a/r$ -r cp ../* ../../b/.
    -bash: -r: command not found
    /tmp/gb/a/r$ cp -a ../* ../../b/.
    /tmp/gb/a/r$ cd ../../b/r
    /tmp/gb/b/r$ git worktree repair ../r.foo
    repair: gitdir incorrect: /tmp/gb/a/r/.git/worktrees/r.foo/gitdir
    repair: .git file incorrect: /tmp/gb/a/r.foo
    /tmp/gb/b/r$ cat .git/worktrees/r.foo/gitdir 
    /tmp/gb/a/r.foo/.git
    /tmp/gb/b/r$ cat ../r.foo/.git
    gitdir: /tmp/gb/a/r/.git/worktrees/r.foo
    /tmp/gb/b/r$ cat ../../a/.git/worktrees/r.foo/gitdir 
    cat: ../../a/.git/worktrees/r.foo/gitdir: No such file or directory
    /tmp/gb/b/r$ cat ../../a/r/.git/worktrees/r.foo/gitdir 
    /tmp/gb/b/r.foo/.git
    /tmp/gb/b/r$ cat ../../a/r.foo/.git
    gitdir: /tmp/gb/b/r/.git/worktrees/r.foo
    /tmp/gb/b/r$ 

What did you expect to happen? (Expected behavior)
    I expected "/tmp/gb/b/r$ git worktree repair ../r.foo" to alter the
    repositories it was run from, ie those under the directory "/tmp/gb/b".

What happened instead? (Actual behavior)
    "/tmp/gb/b/r$ git worktree repair ../r.foo" modified the repositories
    under the directory "/tmp/gb/a".

[System Info]
git version:
git version 2.39.3 (Apple Git-146)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:14:21 PDT 2024; root:xnu-10063.141.2~1/RELEASE_ARM64_T8103 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


--
Regards,
Russell Stuart
