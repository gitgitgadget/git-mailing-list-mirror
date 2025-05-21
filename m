Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762391E98F8
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870164; cv=none; b=YEOh2IL240wFXRqewJM2ChMpHcV9Ko7CztKZrRV/dzvBjYJEcjByQclRB23zIdXLapr0zgSwAqXzZVmSjGeJNGJ4Ws0R8xQ1xkEtwqExr9641KhPHZ1luJYOczcOqsV/6ZxKmN+i/gQVGY1JC57snILOSKrCqZobOal9i77dqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870164; c=relaxed/simple;
	bh=UiZJqYMVUUH9Qsv+CGBhfcs6RTuhrv+SwwLSb323JnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5BMsNMDrKrzS9x1zc9PrTVKgSF8G81gGwIqF8qtjQcKovgyuA67AmLsWJ/CR/Y51u04WIGuuz5fqMkJc0FbZXvnJ3cBJUO9KJcR/jVDVZPApDs2a/bp5me+EJjkfXHlY5ktzeSwXmbwOXdMNkQv5y8mWW3jDPeKUfV1lxnvrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0EvE/ej; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0EvE/ej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870163; x=1779406163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UiZJqYMVUUH9Qsv+CGBhfcs6RTuhrv+SwwLSb323JnY=;
  b=a0EvE/ejC+NOuevpgivroD4rx2lEdVd15ofF1JzFoO6iru4YJcbGMjvz
   jH3Ahl89E2/6GWYTD4sJlK1CsAMzlZP+8u6sSFcRRmJOKmpGNDQCElFj/
   Gi6GewQ9Y3/G3vph0zxdTQRSMXYemdNtZah3oZZHz900wL3g8HSjtEKW1
   SqJm6qF6jsjCdzT4m0ydMLixzmhonPKerPGhXWexfunUaGzeWYsc9QCpw
   g+3JDTlHkrq92h4wBuFqd+0qQuszBr10YIHQtRviYgzhh/C9mKziGMUN2
   ciclH1fHUEhr9g+Jk43iq0VG9shOjOyb9GZgsVJam1EV1W65vqSQ8oQX2
   g==;
X-CSE-ConnectionGUID: lC/DQJPaQkiBnZe3yxw3Kw==
X-CSE-MsgGUID: gazRODj6QwWIRXY8OvwIdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75271675"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="75271675"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:22 -0700
X-CSE-ConnectionGUID: y712KWwNS7iJkQ7zLit5Yg==
X-CSE-MsgGUID: RENn2XetRZ6Z1EKJ4bf5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140072359"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 0/3] diff: add pathspec support to --no-index
Date: Wed, 21 May 2025 16:29:14 -0700
Message-ID: <20250521232917.2333291-1-jacob.e.keller@intel.com>
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

This version uses only one set of pathspecs and instead uses some logic to
skip past the root of each directory tree being scanned. This avoids needing
to parse pathspecs multiple times, and is overall a simpler approach.

I also opted to add a match_leading_pathspec() instead of exposing the
match_pathspec_with_flags(), since I didn't how DO_MATCH_EXCLUDES wasn't
exposed. It felt messy.

I tried a couple of different methods for skipping past the leading portion
of a path, including skip_prefix. Ultimately just the index to skip to
seemed like the simplest solution. I like that it means we only need a
single pathspec array now, and that we no longer have to worry about
changing prefix_path_gently.

Changes since v3:
* Drop the patch modifying prefix_path(_gently).
* Instead of exposing the do_match_pathspec flags, create a
  match_leading_pathspec() variant that sets both flags when is_dir is true.
* Use some simple logic to skip past the starting portions of each path
  before calling match_leading_pathspec
* Re-write the commit message for the final patch
* Add a couple more test cases
* Simplify existing test cases to use --name-status
* Drop remaining TODOs

Jacob Keller (3):
  pathspec: add match_leading_pathspec variant
  pathspec: add flag to indicate operation without repository
  diff --no-index: support limiting by pathspec

 pathspec.h                  | 11 +++++
 builtin/diff.c              |  2 +-
 diff-no-index.c             | 89 ++++++++++++++++++++++++++++++-------
 dir.c                       | 19 ++++++--
 pathspec.c                  |  6 ++-
 Documentation/git-diff.adoc | 10 +++--
 t/t4053-diff-no-index.sh    | 75 +++++++++++++++++++++++++++++++
 7 files changed, 187 insertions(+), 25 deletions(-)

-- 
2.48.1.397.gec9d649cc640

