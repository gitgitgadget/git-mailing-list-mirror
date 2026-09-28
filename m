Received: from outbound.st.icloud.com (st-2003j-snip4-11.eps.apple.com [57.103.77.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADEE4BB815
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602723; cv=none; b=fzHy4DnY8iPawp0VWr68oGpyN1aJ7HA3lv1NdWIIpmupK6j1NQ8xQ/zhRRQ1Yo4maKt7JuMBtp5kfOnZFMP0oF57qcgrEO+juO6Vyrhl2O0jWdsJbmXZr+S986w1/HRHeRROrn9p/sIhr1vz8YfGl97JXRj/1vF9dn8/FjvASDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602723; c=relaxed/simple;
	bh=96mEwdb2157OtTp/pTfmtK/1gHTkw8ZXxD7ToHyC/Nc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:To:Date; b=pDOO96Qqhy5P+S9np3TvxACToeHTV/kkK3g3XeZAOuO17BC74DEkRcvuaossnthnWJrE4dSfkmLkUrDsBsDto41+3fV2hoil0wpWxHfQzm7yTLvwmCQC5hI1if3I/HVqcwanUP7cw9VCzyHL/GwdmUtomawzQpnmLozGDEEVz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=SB5eeelN; arc=none smtp.client-ip=57.103.77.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="SB5eeelN"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id 8FEA51800A98
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:38:37 +0000 (UTC)
X-ICL-RepId: 01a0e83d-2906-700c-923d-f47cb8d29e05
X-ICL-Out-Info: HUtFAUMEWwJACUgDTUQeDx5WFlZNRAJCTUwWWANYHFxQXBwOAFUKQAJQGUYBQytbE1UXRgkZCF0dGR5XUF4IXh9MHB0OWAYSAlpFAk1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDgRUB10FXVZQAlpLXxldRQ9VAikANApAAEAPXgNJFExyWgFGCjR8PB5ZAlICRg5IBV11XQMwUBtfAkIPHBNWFQ1NQxJCFQQRUAFYHlY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1790602720; x=1793194720; bh=96mEwdb2157OtTp/pTfmtK/1gHTkw8ZXxD7ToHyC/Nc=; h=From:Content-Type:Mime-Version:Subject:Message-Id:To:Date:x-icloud-hme; b=SB5eeelNpizjE/c+9TYDzIBofMIcCe5X+dj2FG3vkZGRCAV+yERWXDn/kSoiGag1IN6QrbgPjR7Jvso7AR2noAX2frBNdTB7ZKiBPXw++QQxu+6+WzuKjnMP/87XiWnodjt57Cb0GMR+4Y+axelK/EYr/J8TKF9RIwNu8kDgTQbPbO7oWVvflz8SVs01CLrJClNuGXuEJ91GBGkvzlN4D+UDyf+J7VQI5n5rbyIknYdaQ/EODo6qZN8EkSUGimrt+I1VFgOGLDYo22X6OqhVi8bqz6GXtLN9qU5zms6EwwOlPSCOAgwp8Rh87/5zXn5jhkUphnmcDF6g2Ttskboeng==
From: jumps_dollies_9s@icloud.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: "git -C other_repo" returns wrong GIT_DIR and GIT_COMMON_DIR when run
 via alias in worktree
Message-Id: <85B2D383-8519-4A76-8DED-459067060B61@icloud.com>
To: git@vger.kernel.org
Date: Mon, 28 Sep 2026 11:08:22 -0230

Hello,
I=E2=80=99ve discovered an interesting and likely very niche bug. When =
using "git -C other_repo =E2=80=A6=E2=80=9D from the worktree, the =
values of GIT_DIR and GIT_COMMON_DIR reflect those of the worktree, not =
the other repo, but only when run via an alias. If run directly, then =
GIT_DIR and GIT_COMMON_DIR reflect the expected values for the other =
repo.

This has knock-on effects, notably when using =E2=80=9Cgit -C =
submodule_path restore=E2=80=9D in an alias, it copies the contents of =
the parent repository.

Using =E2=80=9Cgit -C other_repo =E2=80=A6=E2=80=9D from the original =
clone returns the correct values for GIT_DIR and GIT_COMMON_DIR. This =
occurs only with worktrees.

I=E2=80=99ve collected a reproduction into a single script
https://gist.github.com/MayaBarriaultRT/76d864f005bcff2fccb02444c48a3343

I=E2=80=99ve reproduced this with Git v2.52.0 on AlmaLinux 9.7, v2.54.0 =
on macOS 26.4, and v2.55.0 built from source using ubuntu:26.04 Docker =
image.

Maya Barriault=
