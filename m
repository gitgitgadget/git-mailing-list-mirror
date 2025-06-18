Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC01C2324
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288114; cv=none; b=TXChhkwzFluzKtsvgb+LnAbA2HaOhsoBjF4QXB5kIibfNFXkqjk9qJTOy5D/RidI0o5b+M7cahVMg78uBgivungW972NtcVzKml3vGwQI1H7p2vWjpfynqsft4NmR7MSAVVsa2g3tcCzvNlwZeCIy2aIXJbeF89Rasb+rYZT344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288114; c=relaxed/simple;
	bh=U72z7Yj53+dNR6yscfK7U7BIkFWdUSQ3Vb5PGwYInsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g/8PMQ7+qVhSHKA/CI/9vt6oUofNVXev4jbyhi4OHWVGywdtW60TncSaq1hJGF++/fxBns6+Zmwvh20CKCg7FWhKcXBo1gU+3Ka6WVaGVYy5SQDSSXBgorFMhrXEyfTSosFLcSjsgj9/w/4JiDvUQwyHWG1LIvD3UYkuBHwS0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beqKeujO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beqKeujO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288112; x=1781824112;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=U72z7Yj53+dNR6yscfK7U7BIkFWdUSQ3Vb5PGwYInsY=;
  b=beqKeujOktGDeVQRnXfmConUEwcRM9qqUajXwj1W/YkBLqHGTMM9h/DJ
   6B0e9tFYvsqSZQoMFl+BMWzhRCCIO3/ZkUBFC5BRnOs8Fu4xsI5VMZguv
   tVcrSyel0xZ18D/W6zY/CSYnSNR6Guet70ntN8dxRGwvXB1nJb7PCGTt9
   lqQcrm1WfbW2/NWhP4tiI5GxOD4GRQwRISPDVfvTTThPHID8I6AAlLWN2
   u1qZIaFfw+W9HqXjt8kGgum0Uc4TV+dqOHIqlBgRMUvU6omgVuC+MgT5B
   qhruKDhAVbr0XOAf/L14xjbOCGXfKIaNNMXNfzXfwhOvuQbhC38jwCopJ
   g==;
X-CSE-ConnectionGUID: ZKP9wHFoSECz6yp0sOT5Sw==
X-CSE-MsgGUID: 5cLCa4SqRVq+m+OBIqMRlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="69966799"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="69966799"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:31 -0700
X-CSE-ConnectionGUID: 9/Vbxl+0Smu9P0jYmm+oIw==
X-CSE-MsgGUID: fZi/6yNxSYeKuF6U2msIIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="156048560"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 0/7] submodule: improve remote lookup logic
Date: Wed, 18 Jun 2025 16:08:14 -0700
Message-Id: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5GU2gC/43NvQ6DIBiF4VsxzP0aEJHYqffRdFD4VFr8CRTSx
 njvRSenpuN7hucsxKMz6MklW4jDaLyZxhT8lBHV12OHYHRqktNc0JJReDzBh2aYdLAIPdoZHQS
 PEJwFFEJzxWXV1i1JwuywNe9dv91T98a/JvfZzyLb1v/cyIBCqVmhmKAFVuzaDbWxZzUNZHNjf
 rTkbytPFi1U01DKmZT6aK3r+gUkia7pEgEAAA==
X-Change-ID: 20250610-jk-submodule-helper-use-url-e55d3c379faf
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

This series improves the git submodule remote lookup logic implemented in
submodule--helper.

A few cleanups are done first:

* Remove the branch->merge_name array and replace it by directly using
  branch->merge[i]->src immediately. This is simpler and easier to reason
  about. While cleaning this up, also fix the issues with branch_release()
  not tearing down everything properly.

* remote_clear() failed to release the remote->push and remote->fetch
  refspec data. Fix this.

* The starts_with_dot(_dot)_slash helper functions are moved to dir.h for
  re-use, as these are used both within submodule--helper.c and
  submodule-config.c

* Several remote.c helper functions are refactored to take repository
  pointers, enabling use with a submodule repository pointer.

Next, the submodule--helper.c logic replaces the repo_get_default_remote()
function with a repo_default_remote() function in remote.c, which is based
on the more robust configuration reading logic. This helper uses similar
logic but also allows returning the only valid remote in the case where a
repository has exactly one remote. This way we do not fall back to "origin"
if a user has renamed the remote without adding another.

This improved logic is a good first step, but won't handle cases where
there are multiple remotes, with none of them being named "origin".

For the final improvement, notice that the parent project already stores
the URL for the submodule in its .git/config or .gitmodules file. This URL
is what we use to set the remote in the first place when cloning.

Add a repo_remote_from_url() helper which will iterate through the remotes
and find the first remote with that URL. Use this in
get_default_remote_submodule() to first try and find a remote by its URL.
If unsuccessful, we still keep the original fallback logic, in the off
chance that the user has changed the URL from within the submodule.

This method is more robust as it is less likely that the user has manually
changed the submodule URL within the submodule but not also within the
.git/config.

With this change, all commands which need the submodule remote will first
look up by URL before trying to use the fallback logic, and should now be
able to find a suitable remote regardless of now they are renamed.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v3:
- Completely remove branch->merge_name, making the resulting logic much
  easier to understand.
- Link to v2: https://lore.kernel.org/r/20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com

Changes in v2:
- Remove repo_get_default_remote() entirely. The extra checks it does are
  really only necessary if you're doing manual configuration lookup. This
  avoids the confusion of similarly named functions and is less code.
- Fix leaks in branch_release() and remote_clear().
- Add a forward declaration of struct repository.
- Verified tests pass with leak sanitizer now.
- Link to v1: https://lore.kernel.org/r/20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com

---
Jacob Keller (7):
      remote: remove branch->merge_name and fix branch_release()
      remote: fix tear down of struct remote
      dir: move starts_with_dot(_dot)_slash to dir.h
      remote: remove the_repository from some functions
      submodule--helper: improve logic for fallback remote name
      submodule: move get_default_remote_submodule()
      submodule: look up remotes by URL first

 dir.h                       |  23 +++++++
 remote.h                    |   8 ++-
 branch.c                    |   4 +-
 builtin/pull.c              |   2 +-
 builtin/submodule--helper.c | 106 ++++++++++++--------------------
 remote.c                    | 147 ++++++++++++++++++++++++++++----------------
 submodule-config.c          |  12 ----
 t/t7406-submodule-update.sh |  61 ++++++++++++++++++
 8 files changed, 229 insertions(+), 134 deletions(-)
---
base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
change-id: 20250610-jk-submodule-helper-use-url-e55d3c379faf

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

