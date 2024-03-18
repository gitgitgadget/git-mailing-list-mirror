Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71D54F89
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781422; cv=none; b=P7NWBXYdY9eEA3idxHUUQo699sjX37CVMabt2UyKzCFoJaLThcNuVlS3akbL4/iwYlZNcqH5V7pcbXi2QHA1cWQfn3ww7Ustk0UOWyvmVK/rqtFcDc1QgVvvvAmvWUMZ7hXfdzKpR0Nu+l2qAnY420IzQpJqtEAwoVU42urSGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781422; c=relaxed/simple;
	bh=E2PAHpRZ/ZUZGX7lnZUktTXKt0f6D3m1uMEuBGrnRD4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=T/mhLSb8ZdogOHNA01OmdpdlgxIsoq0tZa5iUqayGVUiknj8WQGv10Ar63pkdOKpHW2HSTZK8epDeHI0gO1lEDxv4E+NLyUFQphR4j6VhqxC/0alVjs2oEeoeVutzkhCHWclGd+IPStVRVA36COyHmq76I8ptJDQkMkwyW63nwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=A8od2ZR7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="A8od2ZR7"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710781410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jTcfCBQTNUOzW65XJ84nczhypIC1a43p1LqNKdKWzXA=;
	b=A8od2ZR7qQl1Bj2fwRvdrMvM7e6YJEH5CMv2Ut2SOjccsegttyueOhddqxodBn0aAQYWO3
	/almW3JLqaibB03Z0h0J1OjEoPr/ViSAexgUAhfQw1oQpN4mqQCEj1uzvf7d+Jgswjha4i
	1bBzLLsn9vxpMZnykGx8jqLFE+ym/KQSyISwR0CUri1rZl5g+bkrYbhsdVmZuZppWvI7ao
	mnNKyWy2ltIVSYZ2nxJJQh3m5CXcUiAnk+tXVNg9izQab+V2zRqjmZo4f+fHYC5oSev4vT
	eLZhXo2TmH583RSd2+AIXqD4L25lqmcuqIzlEKyP7dzz2z3M8/+cu7FPFs+J+Q==
To: git@vger.kernel.org
Subject: [PATCH 0/5] New config option for git-grep to include untracked files
Date: Mon, 18 Mar 2024 18:03:20 +0100
Message-Id: <cover.1710781235.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This patch series introduces new config option grep.includeUntracked,
which makes the untracked files also searched by default when git-grep(1)
is invoked, in addition to searching the tracked files.  This is quite
handy when someone expects git-grep(1) to mimic grep(1) even better, when
it comes to the selection of searched files.

Setting grep.includeUntracked to true in one's git configuration should
have no ill effects to various scripts, which presumably shouldn't rely
on expensive operations such as git-grep(1).

This series also performs some related cleanups and small improvements,
which are extracted into separate patches.

Dragan Simic (5):
  grep: perform some minor code and comment cleanups
  grep docs: describe --recurse-submodules further and improve
    formatting a bit
  grep docs: describe --no-index further
  grep: introduce new config option to include untracked files
  grep docs: describe new config option to include untracked files

 Documentation/config/grep.txt |  8 +++++++-
 Documentation/git-grep.txt    | 19 +++++++++++--------
 builtin/grep.c                | 24 +++++++++++-------------
 t/t7810-grep.sh               |  9 +++++++++
 4 files changed, 38 insertions(+), 22 deletions(-)

