Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8913446D1;
	Fri, 31 May 2024 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177631; cv=none; b=eXZ+ApkFIhtduEl8iOfChAdp+biOFwDqjnWHwkwtskvIpCVDCu0f1TnXBC2G8cG3/zrZUbIsRuIPvF/WPJHx7TC6A5oJiC0Xclr+v/K2eQRly4GUtb5oVkxpSyVZ7oqJWRsfMoeFWdtbVNol8HF7CcmJ7ZbYVYhxluxgHxq7kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177631; c=relaxed/simple;
	bh=STC3o5gSi5OYdaCbqle4ia4Q1b9nBiy9V/4qY2XoH7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MK30IuoUYmB/yHB0ReWQjDYRsRsUbTtQvZob+rcVTShFeAml6KA0wjBQncwPdjjMvvhi3vVP0GB7RvhKENtQu4RB43piIKv63BS28aP4h9Y49ezaI7LtHECFWAwNqYi0kl4t9nQLhAWmEEEbIRFnK8QP4e+fiRbxyaj87120xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MXuQMnSL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MXuQMnSL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6DDD1C0C3;
	Fri, 31 May 2024 13:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	TC3o5gSi5OYdaCbqle4ia4Q1b9nBiy9V/4qY2XoH7M=; b=MXuQMnSLptlc3AmPK
	5rSgyqaYqinEqyly+ynTyiXjBmuy3pTk0CPHt744m/lstqLqxy7eMWZL+fDWbfCN
	u0YrdZkdslCI6NOMCIElQPQWcylAwjGxuwCix2QyH5XDl7YVkZpqasY7+HmICljs
	cWgZuNdcaum3QRMJDXiB7etm2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACC321C0C2;
	Fri, 31 May 2024 13:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1BEA1C0C1;
	Fri, 31 May 2024 13:47:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.45.2 and friends to unbreak "git lfs" and others
Date: Fri, 31 May 2024 10:47:06 -0700
Message-ID: <xmqqr0dheuw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCD82AAA-1F75-11EF-A55A-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

The latest maintenance release Git v2.45.2 and its siblings
(v2.39.5, v2.40.3, v2.41.2, v2.42.3, v2.43.5, and v2.44.2) are now
available at the usual places.  They are to revert overly strict
checks, which were "added while at it to help enhance security, even
though these changes alone would not solve any known security
problems", in the recent security updates that addressed four CVEs.

They unfortunately broke valid setups of "git lfs" and "git annex"
(among other unknown things), so we are first reverting them, with
an intention to later reassess the situation and rebuild
replacements that are much less aggressive and more precise, if
needed.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.45.2'
and other tags:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.45.2 Release Notes
=========================

In preparing security fixes for four CVEs, we made overly aggressive
"defense in depth" changes that broke legitimate use cases like 'git
lfs' and 'git annex.'  This release is to revert these misguided, if
well-intentioned, changes that were shipped in 2.45.1 and were not
direct security fixes.

Jeff King (5):
      send-email: drop FakeTerm hack
      send-email: avoid creating more than one Term::ReadLine object
      ci: drop mention of BREW_INSTALL_PACKAGES variable
      ci: avoid bare "gcc" for osx-gcc job
      ci: stop installing "gcc-13" for osx-gcc

Johannes Schindelin (6):
      hook: plug a new memory leak
      init: use the correct path of the templates directory again
      Revert "core.hooksPath: add some protection while cloning"
      tests: verify that `clone -c core.hooksPath=/dev/null` works again
      clone: drop the protections where hooks aren't run
      Revert "Add a helper function to compare file contents"

Junio C Hamano (1):
      Revert "fsck: warn about symlink pointing inside a gitdir"

----------------------------------------------------------------

Changes since v2.45.1 are as follows:

Jeff King (5):
      send-email: drop FakeTerm hack
      send-email: avoid creating more than one Term::ReadLine object
      ci: drop mention of BREW_INSTALL_PACKAGES variable
      ci: avoid bare "gcc" for osx-gcc job
      ci: stop installing "gcc-13" for osx-gcc

Johannes Schindelin (6):
      hook: plug a new memory leak
      init: use the correct path of the templates directory again
      Revert "core.hooksPath: add some protection while cloning"
      tests: verify that `clone -c core.hooksPath=/dev/null` works again
      clone: drop the protections where hooks aren't run
      Revert "Add a helper function to compare file contents"

Junio C Hamano (2):
      Revert "fsck: warn about symlink pointing inside a gitdir"
      Git 2.39.5

