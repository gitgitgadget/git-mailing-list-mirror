Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867A3FFAAD
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538972; cv=none; b=kXoJSa7NsBbFtWbuUdmd+MUW+QfQT0GCobUp0mpOu6WZA5U4V+ACr0C+Lt1P9lRRnjSSbQDnoIwvn/8HRU1T+Yq1aUg55SJCeSOI7EbdIgA18LuK462YNb5TutBHJFhoNeDSFgC0ho8Oby/YvyEOht6I6URFhxoqIZLQ8sAhIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538972; c=relaxed/simple;
	bh=tB2zjlfCuSl69E2PDY2W1tD3tuRiPrKIPwQ4QEjzjXM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ABF6CfUNfSk7iKypG/v3ESzE8F+Nq6FhN0OraDaG5Q9HuZZbWLJ3JFQDXhLxBTcGCYdIXycgWxeBw4J3V2V1ScT1hk43Rx8EzId8YTQNWOzCxBIPzF7wIEoKNPbAxdUGY4eJuTML3TaYk7Tjiwhcx5iomJeMQ5COXkeIz5Fosyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=BFq9hage; arc=none smtp.client-ip=217.11.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="BFq9hage"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774538575;
	bh=Efn+dvBojZuHrY25o7BSBPBm/SP6PoBDRnlLzslA73w=;
	h=From:To:Subject:Date;
	b=BFq9hageoNyFmsJeHKVxzmwWXDw0FH0mjGZqwiWHhfTJ5x4wvQCqgoA/q8+xxQwrq
	 ZOUgjeXXxgf+CY7WnKijpsJ+4jo2m4dMxNZzdyzwjRVnQMTVekqhZ4wFGH4gKKqqt0
	 B4xd8fh14OM2HSu6zETFYJCBOk9MhA+/ucjgARV7RVGPd2eOU5wiwiKbWviHYseooz
	 tpux2VqX6cUysOyPcU+L32p9X6SWSJ5pRHKQtB9h1lO12y7H3W4L1we+tvFGRkhRdj
	 qxRdz0FQCVbMRU5jY+bRBo2Li+XYxpM3N20/88pzqjFGuZqB5ntKd4wETY5Nlocg86
	 P8jT7GmWBMIQQ==
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [PATCH 0/6] ISOC23: quell warnings on discarding const
Date: Thu, 26 Mar 2026 16:22:46 +0100
Message-ID: <cover.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi there

Fedora 44 beta (gcc-16.0.1, glibc-2.43) brought some fun new warnings
when building git. In essence, we're not always explicit about
const-ness or lack thereof of certain pointers. Before, strchr()'s
signature which turns const arguments into non-const return values
covered this up. With ISOC23, strchr() and friends return const
pointers.

This little series takes a middle-ground: no new data types (no new
const versions of non-const data types) but more explicit casts.

Michael J Gruber (6):
  do not discard const: the simple cases
  do not discard const: make git-compat-util ISOC23-like
  do not discard const: adjust to non-const data types
  do not discard const: declare const where we stay const
  do not discard const: keep signature
  do not discard const: the ugly truth

 builtin/config.c       | 2 +-
 builtin/receive-pack.c | 6 +++---
 builtin/rev-parse.c    | 8 ++++----
 convert.c              | 3 ++-
 git-compat-util.h      | 2 +-
 http-push.c            | 2 +-
 http.c                 | 2 +-
 pager.c                | 2 +-
 pseudo-merge.c         | 2 +-
 range-diff.c           | 2 +-
 refs/files-backend.c   | 2 +-
 remote.c               | 2 +-
 revision.c             | 8 ++++----
 run-command.c          | 2 +-
 scalar.c               | 2 +-
 send-pack.c            | 6 +++---
 submodule.c            | 2 +-
 transport-helper.c     | 2 +-
 18 files changed, 29 insertions(+), 28 deletions(-)

-- 
2.53.0.1195.g771ffcb452

