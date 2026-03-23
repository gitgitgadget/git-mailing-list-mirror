Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A1282F3D
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282217; cv=none; b=XhIj7rO2fO63VEZI5jvw5Ol+wz2+NuxINVRc8oM8AhI+/hHW1iAACJY+CVXUer/K9V+G9H3Q8ajz6wUyuBObPn6wC9mn3W6RXcSJPmmfKy7avG09Wt2WwRHR+iqAQV0MdaUl5ZCi5cnKmfS2dtNAdZQtKRCedLT0B40vl1CjC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282217; c=relaxed/simple;
	bh=xJQbyPmCqTYX/xygz3OSOSZFK1NcFtCqH8ezEyrMl08=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cP34qcdXmK69qa9L18lQm2Y7KLIGZpqo48Pd1R2UQ9eiyDkKRYLh06Xj5ggwXvVI/gSs5qYEaCayy7K1MQzl7eYaiz3cvKaDv+L+gPiTggONSOMRV0Ms6AXAAmXJNBcbYZO4Xy5gH1S1JMLnjln/K1oewBwVyml9of/tgWDT9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=eQvBMBbv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="eQvBMBbv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774282212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tq3P+9T1jsTgM4NxA86t8XZtwJM4i1tjfzuy0cRtedM=;
	b=eQvBMBbvk5r1wW73RlqQOklxspB4uEDzAiiQ8/KVX+ZGvsRR1/dBRwmOEhjy1f4UcG78g7
	badOvFuwQAn7/PAZOGzACThQ0cYrIb+iSCBKeQZLelEMpWcs1jvwIEAxock3RTs77KlO7N
	KVMFYe/WXQ+4XWhIbhiDD62ZZo5JAHk=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/3] Add option --ref to git-replay(1)
Date: Mon, 23 Mar 2026 17:09:49 +0100
Message-Id: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAwAf4X02SYwAqi/Ynwoo9Mas5FuGgnh3
 y36eJfcrZBZhTOcqxWU35IlRYPmUIG/U7wxymQMrnZ93boWS0oRlecnLUg6SlHSxUTAjo5N6MJ
 p6P0A1s8m5fN7X65/zq/xwb7sQ9i2L3ESnu99AAAA
X-Change-ID: 20260323-toon-replay-arbitrary-ref-5a81f5f976c7
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In a previous RFC[1] I suggested to implement subcommands into
git-replay(1). While it would be arguable nice to have subcommands for
the different modes, because git-replay(1) is a plumbing commands, it's
fine to keep a status quo.

This series takes one thing for that RFC though: adding option --ref.
This new option is useful if you want to have full control over which
ref is being updated, and not want to rely on the refs that are using
in the <revision-range> or as the value for --advance and --revert.

In the leadup to the final change (the last commit), some
documentational consistency is added in first two commits.

These changes answer the needs expressed in[2].

This series is based on Siddharth's series[3] to add '--revert' to
git-replay(1) (sa/replay-revert @ ba5c0d03d3).

[1]: https://lore.kernel.org/git/20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com/
[2]: https://lore.kernel.org/git/CAHTeOx-SMLh_idKhGczPKzZNOKy04uYXmUhL8Z79yRuNpmE4eA@mail.gmail.com/
[3]: https://lore.kernel.org/git/20260313054035.26605-1-siddharthasthana31@gmail.com/

---
Toon Claes (3):
      t3650: use option with value consistenly with equal sign
      builtin/replay: improve documentation on options
      replay: allow to specify a ref with option --ref

 Documentation/git-replay.adoc |  22 ++++++-
 builtin/replay.c              |  39 ++++++++-----
 replay.c                      |  29 +++++++---
 replay.h                      |   7 +++
 t/t3650-replay-basics.sh      | 131 +++++++++++++++++++++++++++++++-----------
 5 files changed, 171 insertions(+), 57 deletions(-)



---
base-commit: ba5c0d03d39a8b1798c8f988bdc95f9a08f10fac
change-id: 20260323-toon-replay-arbitrary-ref-5a81f5f976c7

