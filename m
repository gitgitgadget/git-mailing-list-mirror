Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764BD2EFD83
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195855; cv=none; b=dUikZY8E3EJn2ObRVyiTa2X+iWTM0DhOCoLyJXMPC3Ywhjo/xUwtGez2fb1G9N1bcigUzjf+evnr/gZZO8/fDZLNxcaiDHfuCoYHya07occd/yU456GvOv3iWoJhm9cP6ci5rvdAK1UYaOvA+V10hfxfvoCRKXLQgL/YJgAs5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195855; c=relaxed/simple;
	bh=+WbwS/CZfC2OmmlZmliwPp9LKMzimzjkwcTEd23kczQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LXhXUqakebn2yb2TVRMjQ38nLKitKWvuxS2Ihc+oVgwaq4vCLDF65mFJyP5DDpMJ6tGPkIkUmJJuemEHzpimlMbDwvsu22iolPMjKRVflpuNhpmMwvb43xHvh5b/OMuMfYdOa/7NumVz6TV0saTIIR3PD39buw98Tg4Zk1BqZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMGRmK5R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMGRmK5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195853; x=1781731853;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=+WbwS/CZfC2OmmlZmliwPp9LKMzimzjkwcTEd23kczQ=;
  b=bMGRmK5R+FQzVoiyfQpJ8RSV+FCdC+d+Sx7Q0x6OqrmCnJDStVDmodyu
   pXjpJ/PfKAdg5klmOPKGjucsh4C4HkjUVnnNyhxLpuc+jsvLzWXU5fdJ7
   WHz6Gt3Sq7PxEu6srPUZFbBUR23g932dgyj1aBb0pBHWmQuf7YXi0jjg6
   CAfcXgV+Xq1bSc3whoIUBWEKOj97eUGP7L58gNIctJYgWOZ84oge+CLxs
   nF1l1MN+yhojHZWejyYkqoeaZM/jRIfmm7r26iJ5p7pHa9DVaoooudrkE
   cbfjBAHwPWLJvKWB3qahyI/5joQ7LatM9evgzwgFT8+fLW9beLt95+hEn
   w==;
X-CSE-ConnectionGUID: Bk2fJw14Sb6F9VUvPaE0qA==
X-CSE-MsgGUID: PrtTNotbS7K6A4vmynOYNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56195371"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="56195371"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:52 -0700
X-CSE-ConnectionGUID: U/sjXnhpSGm+246IwopnyA==
X-CSE-MsgGUID: 8Qik4n3pQ1mJ7BzgbzgWrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153856671"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 0/6] submodule: improve remote lookup logic
Date: Tue, 17 Jun 2025 14:30:40 -0700
Message-Id: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDeUWgC/43NQQ6CMBCF4auQWTumBYrBFfcwLLAdYLRQ0lqiI
 dzdyglcfm/xvw0CeaYA12wDTysHdnNCfspAj908ELJJhlzkSlRS4OOJId4nZ6IlHMku5DEGwug
 tklKm0MWl7rseUmHx1PP7qN/a5JHDy/nPcbbK3/pfd5UosDKy1FKJkmrZDFPH9qzdBO2+71/G7
 qBMxgAAAA==
X-Change-ID: 20250610-jk-submodule-helper-use-url-e55d3c379faf
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

This series improves the git submodule remote lookup logic implemented in
submodule--helper.

A few cleanups are done first:

* Both the branch_release() function and remote_clear() functions do not
  completely free all memory pointed to by their associated structures. In
  addition, branch_release() potentially dereferences branch->merge even
  when its NULL. Fix these inconsistencies to ensure that the remote logic
  works for a submodule repository pointer.

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
Changes in v2:
- Remove repo_get_default_remote() entirely. The extra checks it does are
  really only necessary if you're doing manual configuration lookup. This
  avoids the confusion of similarly named functions and is less code.
- Fix leaks in branch_release() and remote_clear().
- Add a forward declaration of struct repository.
- Verified tests pass with leak sanitizer now.
- Link to v1: https://lore.kernel.org/r/20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com

---
Jacob Keller (6):
      remote: fix tear down of struct branch and struct remote
      dir: move starts_with_dot(_dot)_slash to dir.h
      remote: remove the_repository from some functions
      submodule--helper: improve logic for fallback remote name
      submodule: move get_default_remote_submodule()
      submodule: look up remotes by URL first

 dir.h                       |  23 +++++++++
 remote.h                    |   6 ++-
 builtin/submodule--helper.c | 106 ++++++++++++++++------------------------
 remote.c                    | 114 +++++++++++++++++++++++++++++---------------
 submodule-config.c          |  12 -----
 t/t7406-submodule-update.sh |  61 ++++++++++++++++++++++++
 6 files changed, 206 insertions(+), 116 deletions(-)
---
base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
change-id: 20250610-jk-submodule-helper-use-url-e55d3c379faf

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

