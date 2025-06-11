Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634525695
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603148; cv=none; b=LXPt7t9MAnCO6C3uiwvbkpgGlqw5OwHQKqgs05eT+mmIE78sLr2D6ZME8MQFVHSnVhSHiV4986u2eVncD5sKJFdgwDmTacJdzpTjz/N9PnZhSYFrBvPjufB4ofehVhFUuPS+2PLWA2/hDBvqX79kakB4EzGHD6vjH0NxzR5zx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603148; c=relaxed/simple;
	bh=cB+UPsPwmBC4LN83zeUlnroPAwooVxR79cR1bWTtTTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UG4glNxLXe5UqDmxg+Tey5hHlC9KOEHN+poL/aSNC18dgujOHbGWTEWEQKedqhF4tiV9/o/SvTRX6097N4S1YAIAau0tbMzztIe0hie7ZxXccdXVVOLrsGBoWIBZJB2nd/GHaNpEKW44G7plhnYcW+WllQJjnFA58c6hOfqjyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLsU/Txe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLsU/Txe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749603147; x=1781139147;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=cB+UPsPwmBC4LN83zeUlnroPAwooVxR79cR1bWTtTTA=;
  b=RLsU/Txe2hwNgF7+fTrXEi07XZZ67e1oQIzeyX/Gmm9d3vyVDDwzp61x
   wMrHbsvOm+GdrBKBl4DpneQV4VkCFZnwM64stFBd8pIzLqDyFIwkW3Ciw
   IYfRejPRAGrzsTCvo0/VU9S52YWYQwNM5Uf9wa8kwG8aO150DTJ29CjNQ
   91HOjUTia/dOfNSCepldo1aFgmnBGSEIKSC2rCvyOvVy064dhtk8YAY1r
   FRduyiQn3iFa5f/V4em3dQrOloTYw/XEBvokIImr+1wkaQpfdSgKtredt
   f2Tt+f/JTbYVbaPS3h5ud1d5a9912HUiR0K88LWfSwo/W+Z8xMKmB5cAs
   Q==;
X-CSE-ConnectionGUID: oPaRn4/BTNGKgvsKFBymwQ==
X-CSE-MsgGUID: oK7N0v80R0eJcqQjqPTF2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62012575"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62012575"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:26 -0700
X-CSE-ConnectionGUID: xJk0uhDHREGTWHvA9+GUbQ==
X-CSE-MsgGUID: 9y+onrxhQzCwGcymvPAJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="170199734"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/6] submodule: improve remote lookup logic
Date: Tue, 10 Jun 2025 17:52:14 -0700
Message-Id: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD7TSGgC/x3MQQqDMBAF0KvIrDsQlVTsVUoX1vzo2FRlhpSCe
 PeGLt/mHWRQgdGtOkjxEZNtLagvFY3zsE5gCcXUuMa7a+14ebHl53sLOYFnpB3K2cBZE8P70I5
 t18chUhl2RZTvf78/zvMHU5XeRG0AAAA=
X-Change-ID: 20250610-jk-submodule-helper-use-url-e55d3c379faf
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

This series improves the git submodule remote lookup logic implemented in
submodule--helper.

A few cleanups are done first:

* The starts_with_dot(_dot)_slash helper functions are moved to dir.h for
  re-use, as these are used both within submodule--helper.c and
  submodule-config.c

* Several remote.c helper functions are refactored to take repository
  pointers, enabling use with a submodule repository pointer.

* The branch_release logic is fixed so that it won't dereference
  branch->merge if it was never setup. This appeared to trigger in some
  cases if a submodule repository was passed into the read_config()
  function.

Next, the submodule--helper.c logic in repo_get_default_remote() is
refactored to remote.c helper functions. A new repo_default_remote() helper
function is added which will try to find a default remote. This helper
first tries to look up the remote from the checked out branch, then falls
back to the only remote (if there is exactly one remote) before finally
falling back to "origin".

This improved logic is a good first step, but won't handle cases where
there are multiple remotes, and when remotes have been renamed.

For the final improvement, notice that the parent project already stores
the URL for the submodule in its .git/config or .gitmodules file. This URL
is what we use to set the remote in the first place when cloning.

Add a repo_remote_from_url() helper which will iterate through the remotes
and find the first remote with that URL. Use this in
repo_get_default_remote() to first try and find a remote by its URL. If
unsuccessful, we still keep the original fallback logic, in the off chance
that the user has changed the URL from within the submodule.

This method is more robust as it is less likely that the user has manually
changed the submodule URL within the submodule but not also within the
.git/config.

With this change, all commands which need the submodule remote will first
look up by URL before trying to use the fallback logic, and should now be
able to find a suitable remote regardless of now they are renamed.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Jacob Keller (6):
      dir: move starts_with_dot(_dot)_slash to dir.h
      remote: remove the_repository from some functions
      remote: check branch->merge before access in branch_release
      submodule--helper: improve logic for fallback remote name
      submodule: move get_default_remote_submodule()
      submodule: look up remotes by URL first

 dir.h                       |  23 ++++++++++
 remote.h                    |   3 ++
 builtin/submodule--helper.c | 101 ++++++++++++++++++++++--------------------
 remote.c                    | 104 ++++++++++++++++++++++++++++----------------
 submodule-config.c          |  12 -----
 t/t7406-submodule-update.sh |  61 ++++++++++++++++++++++++++
 6 files changed, 207 insertions(+), 97 deletions(-)
---
base-commit: 4c0e625c091d4c648cec7319bafaed3cc81658e5
change-id: 20250610-jk-submodule-helper-use-url-e55d3c379faf

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

