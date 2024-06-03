Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C646A4
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445146; cv=none; b=lD6cF5AjSYUIWO6a0rEixWh4P8ji8rwuX4IsjTm8F9c4UelGoYPpMK+azD82qc73Hax5JuWufgNl7u48f811KaCd1dqLQVX2zV9XQGPjKwHXwCFLiENbQdbglhIMXZUa5VTgCc1sAzmzSW54GPXtQq4HEueSFvqjD4/QY0bJvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445146; c=relaxed/simple;
	bh=QDIzSvRxjutIoen1OaEt/GBCe6U0vY55aQ1ru/UNojo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G1sfxWoQC5WxeQIR/t7s7OVUplKnkjxUpcp1tgiYR28YzNB1/g/PeCLjEAlfHjqCHj+JiwXbvEfga2c5d/OjxRPxx6taFQpgPE582wJe116RERh8hsT1G2TfQcMVgbrFF5a2eBzGN7rDFOiQUTfarLWKYXq+tDg5lDqrKCYQPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F4RmRG0W; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F4RmRG0W"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 096B934C99;
	Mon,  3 Jun 2024 16:05:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=QDIzSvRxjutIoen1OaEt/GBCe6U0vY55aQ1ru/UNojo=; b=F4Rm
	RG0W2hBLg884M4XmE+stTmMoPYaL33cjKacijDr03EO86kdyH9NRB5UUQ19u8Q+O
	3SrO7KjLu6sKXv7KkLrvTkvkwrS8gGk+I6q28RPjqzGbgAj1ZHjNhM9GuPHEmgcD
	QLwgommCfB4V8fgmNpx+V9DcLpSXd3p81i8p2bg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0260034C98;
	Mon,  3 Jun 2024 16:05:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71E9A34C96;
	Mon,  3 Jun 2024 16:05:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] Branches are branches and not heads
Date: Mon,  3 Jun 2024 13:05:36 -0700
Message-ID: <20240603200539.1473345-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-404-g9eaef5822c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A6B36468-21E4-11EF-BE7D-8F8B087618E4-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Back when Git started, we used the word "head" to mean the tip of
possibly multiple histories, and that is where the name of the
hierarchy .git/refs/heads/ came from.  But these days we call these
entities "branches" in human terms, and "head" is still used to
refer to the tip of the history each of these branches represent.

When asking "git ls-remote" or "git show-ref" to limit their output
to branches (as opposed to showing any ref), we use "--heads" for
historical reasons, but give the option a more human friendly name
"--branches", and demote "--heads" to the status of a deprecated
synonym.  This would eventually allow us to remove them at the
breaking version boundary.

Junio C Hamano (3):
  refs: call branches branches
  ls-remote: introduce --branches and deprecate --heads
  show-ref: introduce --branches and deprecate --heads

 Documentation/git-ls-remote.txt | 12 +++++++-----
 Documentation/git-show-ref.txt  | 18 ++++++++++--------
 builtin/ls-remote.c             | 25 ++++++++++++++++++++++---
 builtin/show-ref.c              | 33 ++++++++++++++++++++++++++-------
 connect.c                       |  4 ++--
 remote.h                        |  2 +-
 t/t1403-show-ref.sh             | 22 ++++++++++++++--------
 t/t5512-ls-remote.sh            | 30 +++++++++++++++++++++++++-----
 8 files changed, 107 insertions(+), 39 deletions(-)

--=20
2.45.2-404-g9eaef5822c

