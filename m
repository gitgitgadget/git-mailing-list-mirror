Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4971946C4
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621009; cv=none; b=anKhrQ0rHF/6eKgSGFe3qMWoDRL7xU4zai48gFjp6yQ0RnwdH08D0NdBPuU/3MxtNyqRfsINPHsaiwCiFjBSa4cONBNy9n3bvlUyedoOOlPkHANMzZRZ6zJTJJU1/5yB9seNWATtt4Ib3aWY0mRMOse3doZTCB6S20WMbH5R1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621009; c=relaxed/simple;
	bh=uTdPQmpUjHXspQtQj70ngZRcrAd6kaetL7HrChgRP3o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ErgPxGAh9FJH5gSlAGdt0BU0TZiJ2ydkJsUSyAnbmIq43Wsxl2QZ88VVk5G6UzBTIl+8mnDfl/aqBDYhH06woih32tbkpDsQKB9RKW0YZD2tWweif/9Rgokr3ndLy46I3mwOr/ZJhsMhnyxXJP8ZD7wWrcuP64pPbXhMFaTBtEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=M8ENSVmL; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="M8ENSVmL"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D0F1F7BE
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718621006;
	bh=uTdPQmpUjHXspQtQj70ngZRcrAd6kaetL7HrChgRP3o=;
	h=From:To:Subject:Date:From;
	b=M8ENSVmLyDXOjqGR7mOgvlKGqmpAOGZKKOH9RXUoNZ9z8VKO//c9TMoJTV9EDCw9y
	 kKSSFDdSYVzdxTlAWPemg8CMYD4iFmjSnf99cYoAGLDx2y4bsPT7mOCt5+9mEAgInp
	 usMeFOYMKLQSCuOG5Rs5USmYYbSjm1Tdz5IKkgh0=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 0/2] cat-file related doc and test
Date: Mon, 17 Jun 2024 10:43:24 +0000
Message-ID: <20240617104326.3522535-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was working on reducing syscalls required for cat-file --batch
(and readers) in a different patch, but noticed a bug in my
yet-to-be-published patch wasn't detected in our test suite,
only via 3rd-party Perl code.

Then I noticed Git.pm documentation was wrong..., so fixes
are in reverse order.

Eric Wong (2):
  Git.pm: use array in command_bidi_pipe example
  t9700: ensure cat-file info isn't buffered by default

 perl/Git.pm     |  4 ++--
 t/t9700/test.pl | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)
