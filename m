Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284A22A4F1
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720624; cv=none; b=cXBjg5fS5KYXdXI1UjZKCqkPNbWbpggbNFkiifVm2ffYUqllgeMk2vXft5P7qjxCxOiOpnGJ84B7/uVMfT0TGVZjdsxKoI6jSzjuSTV476rpwtiuJViHH2PaBpcHMhtT/7ilRdfrCeFhIH+dB9hzyTrNd5RLTo90Mng/5sK/MzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720624; c=relaxed/simple;
	bh=LfvLd6THqQVQHJ5W0jXIzAzGfARWYIc2WBs7D88SyvA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oRL5VTTaptmrWU+M2ZislIuaUnUjUoMOqrNxjFbuuhl2VU3TzvzGD2IxYPBKUvisZGNVwfoEpfVWGBKmXOJMD+zSmHZJvEIVoULww0ccLn5iBsPVzneDA47tjBAmkOsJGJRglu+lV/lQ/9fxFN49VlbHi43z6vHRYShRqd0dlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0K5qFcX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0K5qFcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720623; x=1782256623;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=LfvLd6THqQVQHJ5W0jXIzAzGfARWYIc2WBs7D88SyvA=;
  b=m0K5qFcX8ki+fUCr/jNhW9JSWOwQsEK3Br7dCiuxKWXHSBa3nP7qjHJg
   I9T3LyVusS+tantKXX+4A1s5HgJcsdDRQQmxP+Tf40y0SbnQTlKrWnxbc
   22oYhQ0Yh5rFBmLP7fhQU9v1Ix1gfgnvk1ABqqUNGwSXRCUY8Bg+uJXAM
   6rkMAMNo02BwPkYX8Th58Yiv7COW+lGNXHz0a4Z5a6FaiLlTKRLpl1Ytn
   w7IWspt6BzsXxXegLfVLwxzl6ZPqqaiiF5Q2jgm0VU9svaZXSimD2vUCa
   mgR+2upgDIbpv1iO4SvYPm+eQYHakGSDCSgR0TNmRgiWuUq7AKCsmDllr
   g==;
X-CSE-ConnectionGUID: 4ywCUUt3S6uv9KPLyv9R3w==
X-CSE-MsgGUID: e9hEHWP6QbChEJNQdXM7/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53084549"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53084549"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:41 -0700
X-CSE-ConnectionGUID: PHiBeuV0ShOEELgMsQyTtg==
X-CSE-MsgGUID: jHHvYmugRnSmDN4o/X08Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151888457"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:41 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 0/7] submodule: improve remote lookup logic
Date: Mon, 23 Jun 2025 16:11:28 -0700
Message-Id: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACDfWWgC/43OTQ6CMBCG4auQrh0zbYGKK+9hXEA7QJW/tEI0h
 LtbWKkL4/KdxfPNzDw5S54do5k5mqy3fRci3kVM13lXEVgTmgkUCaYc4XoDPxZtb8aGoKZmIAe
 jJxhdA5QkRmqpsjIvWRAGR6V9bPr5Erq2/t675zY28fX6nztxQEgNjzVPMKaMn6o2t81e9y1b3
 Um8W+q3JYKFsS4KRMmVMt+WfLcOvy0ZLKVTLEWqMqE+/lqW5QWx/BOhXgEAAA==
X-Change-ID: 20250610-jk-submodule-helper-use-url-e55d3c379faf
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
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
Changes in v4:
- Fix branch_has_merge_config to use branch->set_merge
- FREE_AND_NULL branch->merge in merge_clear()
- Link to v3: https://lore.kernel.org/r/20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com

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
 builtin/submodule--helper.c | 106 ++++++++++++-------------------
 remote.c                    | 149 ++++++++++++++++++++++++++++----------------
 submodule-config.c          |  12 ----
 t/t7406-submodule-update.sh |  61 ++++++++++++++++++
 8 files changed, 230 insertions(+), 135 deletions(-)
---
base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
change-id: 20250610-jk-submodule-helper-use-url-e55d3c379faf

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

