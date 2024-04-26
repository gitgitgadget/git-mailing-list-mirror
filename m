Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867252C6B7
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714169528; cv=none; b=oKi+aV9wkubh5bIY0HnNYXys3g/aD6GtQFnrGG35Ty2C9oyd5Hy9B7cIBhbLvHzZ9FEc41Uv5cMvVX50/mWcNZaEQnHSt5PlmGz9/oyrvgeYzX840myqDbAA/H0l/PxVoionl0/3vlkghpLeIFC7uBHGbD6qyfBag5IueHWVEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714169528; c=relaxed/simple;
	bh=pHyfSixLPGmwOa8ZCreZlekakC22nDvEkJqwvW346Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHgZLSqjBbuAwoaSVpe/4E5cutrArLM5C5ZocVQlcQ9Nd7n1LPmTlbdxUGvl+Gowsx/J2nkOtUiao7TmMnR6S5L4wsQk9i4xzvf9iw/ZFZb8yusKzgLgwbE4z5zZXAN3FdoufS22oPSV9IsJS9yOOQ0Ad2pCPQ04bfuhw/f+B9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=m6qlsQXH; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m6qlsQXH"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5D0155B2D2;
	Fri, 26 Apr 2024 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714169523;
	bh=pHyfSixLPGmwOa8ZCreZlekakC22nDvEkJqwvW346Vs=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=m6qlsQXHBGscRrWUN06Y+kSZ01BeS4cR3ZTpXijje6hQ5YkGG2SzpV7ixod9yzq4n
	 4ayhFYwLrK/zIGayUP/TfogQtZT8maiaaKWBNeVmRoS/5uZa8vC7B+qaGw+qUterg/
	 I5BzyaptKNVPWgKf5uZRSQDrNIH1oQqDjUVPD36YarDLx83L25hqNAwxryPLy4fzAZ
	 78WH8lpNa/sXs2pGZdCdvsRNXZ0zog32yWSdfCnTZrThhkzwNVAIKDbYE5UTH1uvkk
	 L3S0BvgbLj66iv/XV3Fi6Jw4NSDZcq9jc/Za8B/O21i1Wh1DWgvthYJzRjYswvbTqm
	 r5iNoCSYFhYr4aT/Ha5tl4ggVoeNIEcB78ZUo2cx0RP294eVkJQ7sHgoC17IA87OFE
	 vbUNL1R2LvpMIiTqqqGkk8kvdFY71jbiZLG9wOOW/mh5aKMVKyCB62SusUFNjclZsP
	 lQ2IyrQaXXyaKKvk9ZRNbfVGUiveONYR47dF5ELtLCYriiY5Fc/
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Test fixes when running with zsh in sh mode
Date: Fri, 26 Apr 2024 22:11:52 +0000
Message-ID: <20240426221154.2194139-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zsh is a common shell on a variety of systems, primarily for interactive
use.  However, it can be used as a POSIX sh on Debian, macOS, and on other
systems where /bin/sh is not POSIX compliant or doesn't provide the
local keyword as we require from our shell.

This series fixes two test failures with zsh when run in sh mode; that
is, the mode that occurs when the shell is invoked as "sh".  sh mode
provides the most POSIX-compliant behavior and avoids a lot of
incompatibilities that the default zsh mode provides.

Additionally, as of zsh 5.9, thanks to a patch I sent, zsh also runs all
parts of a pipeline in a subshell when in sh mode, which fixes a
substantial portion of our testsuite.  POSIX specifies this behavior,
but allows shells to run any or all portions in the main shell instead
as an extension, and the default zsh and AT&T ksh behavior[0] is to run the
final element in a pipeline in the main shell, which breaks lots of our
testsuite.  This, and the fact that every default /bin/sh implementation
_does_ run all the elements in a subshell, is the reason I sent that
patch.

One of the two test failures is due to a zsh bug already fixed upstream
but not yet released, and the other is due to zsh complying with the
standard more strictly than competing shells.  With this series, we can
do this[1]:

----
#!/bin/sh

mkdir -p "$TMPDIR/shell"
ln -s /usr/bin/zsh "$TMPDIR/shell/sh"
make -j8 SHELL_PATH="$TMPDIR/shell/sh" && (cd t && make prove SHELL_PATH=$TMPDIR/shell/sh GIT_PROVE_OPTS=-j8)
----

and the testsuite passes.

Note that this series doesn't make any attempt to make zsh pass the
testsuite in any mode other than sh mode and I have not even tested such
a configuration (which I am sure is horribly broken and would probably
require invasive patches to fix).

These issues are long-standing and probably don't need to be merged down
to maint unless you really feel like it.

[0] Note that AT&T ksh does not support local, so its behavior is
    already very broken with regard to our scripts and testsuite.  Other
    ksh implementations, such as mksh and lksh (MirBSD ksh), pdksh, and
    OpenBSD's ksh/sh _do_ support local and _do_ run all elements of a
    pipeline in a subshell, so they are fully functional with our
    testsuite already.

[1] Please note that I am using user-private temporary directories and
    you should otherwise choose a different directory than `$TMPDIR`.

brian m. carlson (2):
  t4046: avoid continue in &&-chain for zsh
  vimdiff: make script and tests work with zsh

 mergetools/vimdiff       |  3 +--
 t/t4046-diff-unmerged.sh | 16 +++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

