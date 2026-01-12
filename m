Received: from mxout1-he-de.apache.org (mxout1-he-de.apache.org [95.216.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C544199EAD
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.194.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261089; cv=none; b=pB3k2yuC1FAkh6m0Wa/+JfYmSHEk5mDXS47xkMqlcPmngtVTJvvsK3T86pexGbnXtw02r64WqUD9ZjhpeMfsQ+MFII0D6pW6SmchNK63d3Mkb2Pls2GVB0IoxjdmcDL2WmnxmJfllxcwSIDyTmpgkcn9UcbVAFxD2H3s50xGd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261089; c=relaxed/simple;
	bh=StWRfVMTAKGnOt5a1zLojD9emdhrEz9HsR2POW3CiBw=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=MfvUWESh14w2fm1cD7Qy0gvN+0Db7FcZB2OFbu8pyHHYqVDUHVFH0+sgpcOocYZ1QCZ/LSwe0EmEJXF1HZmW8u23/WkIvbyjo/ojyleglQN4Ex/ghf8ntYRFPfji8gpdQQhiLEDL+KNyS+PQ5TOr9vFlkCqjwM9SbetLghiGEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apache.org; spf=pass smtp.mailfrom=apache.org; dkim=pass (2048-bit key) header.d=apache.org header.i=@apache.org header.b=NhCPY61U; arc=none smtp.client-ip=95.216.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apache.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apache.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apache.org header.i=@apache.org header.b="NhCPY61U"
Received: from mail.apache.org (mailgw-he-de.apache.org [IPv6:2a01:4f8:c2c:d4aa::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mxout1-he-de.apache.org (ASF Mail Server at mxout1-he-de.apache.org) with ESMTPS id 4B269655C2
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 23:27:32 +0000 (UTC)
Received: (qmail 132187 invoked by uid 116); 12 Jan 2026 23:27:32 -0000
Received: from mailrelay1-he-de.apache.org (HELO mailrelay1-he-de.apache.org) (116.203.21.61)
 by apache.org (qpsmtpd/0.94) with ESMTP; Mon, 12 Jan 2026 23:27:31 +0000
Authentication-Results: apache.org; auth=none
Received: from [IPv6:2001:569:bef2:d200:63e1:9891:d2d4:fc0] (unknown [IPv6:2001:569:bef2:d200:63e1:9891:d2d4:fc0])
	by mailrelay1-he-de.apache.org (ASF Mail Server at mailrelay1-he-de.apache.org) with ESMTPSA id 0A2EE42698;
	Mon, 12 Jan 2026 23:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apache.org; s=mail;
	t=1768260451; bh=YgIHm7QZLzRXHPFhU2Yx1VR3B/oBUlJVAvrIjP3aEnA=;
	h=To:Cc:From:Subject:Date:From;
	b=NhCPY61U1mVVpCbVjmrexrLZrNWpeZjKZbGg5e0ocS9wMgI5a3WvMuMKYi4ECONJm
	 TavCEgtqVVzHX4X7ggZwpQXVMd2AmL3MxbHd4r36tkEaCRltLTGC9n4vZps8Pg9Hn7
	 Unzq4ccsEDm/4ls3jY2HQ6tVVoapTmhepQmBriNBKOqLNK5qT97A9H6ofgiE/9IHFm
	 eZ9gfLHrZdC5GvSsXq9wXx1/Nfb+HDzCz9LYYZH8r5XUFGHbcUmyp6d/4AaF9BuAwJ
	 0NqcvlMYFqr5Y4QiGjPU/cb2LDYBDXfIAq/YlG09k6oPYUADS0/7ozPl1z4Gr0dWVX
	 xhzFLbqYXLUPw==
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Chris Darroch <chrisd8088@github.com>
From: Chris Darroch <chrisd@apache.org>
Openpgp: preference=signencrypt
Subject: pre-push hooks and stdout regression
Message-ID: <ab578804-891e-edcc-12a6-8b1030d1bacb@apache.org>
Date: Mon, 12 Jan 2026 15:21:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.7.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello --

   I'm one of the current maintainers of the Git LFS project, and we
happened to notice that a recent change in Git's "master" branch has
introduced a regression in our test suite.

   Specifically, with commit 3e2836a742d8b2b2da25ca06e9d0ac3a539bd966
("transport: convert pre-push to hook API") from the "ar/run-command-hook"
merged last week, it appears that when a pre-push hook such as our
git-lfs-pre-push program runs, messages it writes to its standard output
are now delivered to the user's standard error stream instead of
their standard output stream.

   I suspect this is because the pick_next_hook() function in hook.c
sets the stdout_to_stderr flag for its "cb" child_process argument,
and that function is now used to run the pre-push hook.

   Arguably, the Git LFS pre-push hook program should write its
progress meter messages to stderr, but since at least 2017 it appears
we have used stdout for this purpose:

https://github.com/git-lfs/git-lfs/commit/d665f7d725150761fe3b196da2c2d4448f7d2c61
https://github.com/git-lfs/git-lfs/pull/2732

   We can certainly work around this change in the Git LFS test suite,
since our progress messages are still output by Git, just to stderr
instead of stdout.

   However, I think there remains the larger concern that users who
depend on the existing Git pre-push behaviour in some way may also
encounter regressions, perhaps because they expect (as our test suite
does) to see certain messages either output or not output to stderr
during a Git push operation.

   Please do let me know your thoughts on this subject!  If the
consensus is that the new behaviour is correct, we'll adjust our test
suite to match it, but I'll wait to hear the outcome of any discussion
before making that change.

   Thank you again and all the best,

Chris.

-- 
GPG Key ID: 088335A9
GPG Key Fingerprint: 86CD 3297 7493 75BC F820  6715 F54F E648 0883 35A9

