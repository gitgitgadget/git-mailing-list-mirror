Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E72472B1
	for <git@vger.kernel.org>; Tue, 20 May 2025 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699295; cv=none; b=NqLj2bsSwg1wT3ae5pJmjlU8jhaDeNSiLT4MO1gR7yqCEbVc7w5jnTN4nblynGjXEjRc+DyHv5p/+V9QiXgH8s4VtfpU0I9scBacAxrq06xCM6e6Xerkjqi42DwwjPpLomPHE7pFHYHQJohaLkJ93ajhrOBtoa6xbb4AKCj7E14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699295; c=relaxed/simple;
	bh=ras0SxXyWEFxbE0rZ9O1n+VdTzhwQQe4AkmSumHBhuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joRAWJD7atRATqUodhJz9cThRWqQsA03GuuVWOVQAPKQ/jjPY1gb7aSBaJLyxtY4FoLOCBxQ9dXg12yMdD+nZi4ruT4BFLu5TARu/YTAPSBRSDlbdqvVj5WatmcPzE6MCYcEQO/5RQ+PP5AkrA7CAVwpnBo3Nr5pzioivh8pGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aN47Q312; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aN47Q312"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747699293; x=1779235293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ras0SxXyWEFxbE0rZ9O1n+VdTzhwQQe4AkmSumHBhuA=;
  b=aN47Q312qxWurRNDjJUU8pXv1FtWVxiRjfeR6C0k5t+UKUZcksr7ApoW
   Vi45rKSK4apEXx0vg5HlLwDkLBD3IXWN62aXwEpjgnjFkILBx9D0SxeA1
   MO+NI3G0rDcyrq5jctUA3ENsOXGOjcwXJyj51Uq9TbdsMSw8UbM264GHv
   5TtJ6FL0c7N/m8IxYQfHG2d14kXamO2lYrNA24MR0tI36VbWMu3jeV2Wy
   7Qqbd6xXDdPE8JCWdkK08jgj/ry++cdDgIwUfDeft1iL5/UJ3haAZD/4F
   JfgUsvEdeJGdjGH17PMI15pqZdoP/jlsxA05DlGP4EDGRROhvJsueb7I0
   g==;
X-CSE-ConnectionGUID: DUI2cB+STzqUhXktG8Tf6A==
X-CSE-MsgGUID: lmGbXCUdT3Gk42jnTZQE+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72125816"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72125816"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:32 -0700
X-CSE-ConnectionGUID: 7qOavlY4Rc2NDuY6jTD6bA==
X-CSE-MsgGUID: x8z6ouECTCyeXLbm3mZ9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139559135"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 0/4] diff: add pathspec support to --no-index
Date: Mon, 19 May 2025 17:01:21 -0700
Message-ID: <20250520000125.2162144-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

This series adds support for using pathspecs to limit the comparison when
using git diff --no-index. This is similar to how you can limit what is
included with pathspecs when comparing inside a repository.

This likely still needs some reworks, and I have some open questions in the
final implementation:

 1) pathspecs must all come after the first two path arguments, you
    can't re-arrange them to come first. I'm treating them sort of like
    the treeish arguments to git diff-tree.

 2) The pathspecs are interpreted relative to the provided paths, and
    thus will always need to be specified as relative paths, and will be
    interpreted as relative to the root of the search for each path
    separately.

 3) negative pathspecs have to be fully qualified from the root, i.e.
    ':(exclude)file' will only exclude 'a/file' and not 'a/b/file'
    unless you also use '(glob)' or similar. I think this matches the
    other pathspec support, but I an not 100% sure.

  4) I'm not certain about exposing match_pathspec_with_flags as-is,
     since DO_MATCH_EXCLUDE shouldn't be passed. I got the behavior I
     expected with DO_MATCH_LEADING_PATHSPEC, but it feels a bit of a
     weird API. Perhaps match_pathspec could set both flags when is_dir
     is true? But would that break other callers?

However, this version now has documentation and some test cases. I found a
few issues with my original implementation in v2, which I've fixed.

I also an open to suggestions on better ways to handle the matching.
Currently I need a separate set of pathspecs for both paths, since I need to
make sure they get rooted appropriately. I don't know if there is a better
solution that would allow using the same pathspec structure for both
comparisons.

Jacob Keller (4):
  prefix_path: support prefixes not ending in trailing slash
  pathspec: expose match_pathspec_with_flags
  pathspec: add flag to indicate operation without repository
  diff --no-index: support limiting by pathspec

 pathspec.h                  |  13 +++++
 builtin/diff.c              |   2 +-
 diff-no-index.c             |  91 ++++++++++++++++++++++++------
 dir.c                       |  20 ++++---
 pathspec.c                  |   6 +-
 setup.c                     |   4 +-
 Documentation/git-diff.adoc |  10 +++-
 t/t0060-path-utils.sh       |  18 ++++++
 t/t4053-diff-no-index.sh    | 107 ++++++++++++++++++++++++++++++++++++
 9 files changed, 240 insertions(+), 31 deletions(-)

-- 
2.48.1.397.gec9d649cc640

