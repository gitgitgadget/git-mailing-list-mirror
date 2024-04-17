Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E528DBF
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324775; cv=none; b=VGmlZF1XADdyjxgyDg1RL7OveYhNXJqtsStqE7U5t2BYOsdxEPuXErr0tFdu3HolquyTOmuKLsf/6Ck1daMzpSH9zsb8UYCbZWm2Bb23ixGzoOkFf56KH9BEvdASxwrvipwzb2QECMHVh5elEA3TFQzu37ktv4DaGu3mFcFPq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324775; c=relaxed/simple;
	bh=bvaYWdwuM/w+1aEFlz+dzfoSkBx8smO9xCdgtuHOkIo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RUsFbptRFQ9rlGf+fIKVOHEAsF5QQtOwX+xtqBcN7jV6AZ2q/EgfY4LO7nL5t41Ek/tsQemx98iwJrnINPtT/qpr0/h9HtuIENl43yME893BZw+l0ifZnUsFI+hs7/vlKwPomFY5ljEn4rrh6C271v7ImO9LC6AeTnYG0O41Xrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vZmDEHIv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vZmDEHIv"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713324769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AQ6dNgSoq7JxqzcXTZzjB5z0bhbHpaJli5GqLW0ifA0=;
	b=vZmDEHIvxwOEaUXawFN0PuDNstLYJJSj0O4XFXlNmh+fN5+B+ALzPyR+B18tBFSZeVdvWi
	qCVKaPAs5N4nM1O9qDOUFGoonYPLAy4MBuE07QHyIHzf4d5obSA0km/YCiCJPM2lOrLyB/
	IQ/anKuqjtEbKMdXeX3MHoe70oTaclJPqqFGlOA+Np86Qe03X9NQ6uCBNe7H0FMcJ1F0cx
	O8ILQprwXTncWPsNNzB6FHUBVzbXVO2RzMDRx+iGB0FKn4N33yd4MOu94PaCUhKQ2UqW6/
	nZ88pYkojWdfa8iM92Pj+cqNUyR7GMEoZG5uUSKMShW6v37in/x9mVWY2f26Hg==
To: git@vger.kernel.org
Subject: [PATCH 0/4] format-patch: fix an option coexistence bug and add new --resend option
Date: Wed, 17 Apr 2024 05:32:40 +0200
Message-Id: <cover.1713324598.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series fixes a bug that allows --rfc and -k options to be specified
together when running "git format-patch".  This bug was introduced about
eight months ago, but it has remained undetected, presumably because of
lacking test coverage.  While fixing this bug, also add a test that covers
this mutual exclusion, for future coverage.

This series also adds --resend as the new option for "git format-patch"
that adds "RESEND" as a (sub)suffix to the patch subject prefix, which
eventually produces "[PATCH RESEND]" as the default patch subject prefix.
This subject prefix is commonly used on mailing lists to denote patches
resent after they had attracted no attention for a while.

Dragan Simic (4):
  format-patch docs: avoid use of parentheses to improve readability
  format-patch: fix a bug in option exclusivity and add a test to t4014
  format-patch: new --resend option for adding "RESEND" to patch
    subjects
  t4014: add tests to cover --resend option and its exclusivity

 Documentation/git-format-patch.txt |  9 +++++--
 builtin/log.c                      | 16 +++++++++---
 t/t4014-format-patch.sh            | 41 ++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 5 deletions(-)

