Received: from lucy.dinwoodie.org (unknown [81.2.116.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569671386DA
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.116.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341140; cv=none; b=Kgfw6S+0V0nofe3/dG6S3xCsVnU36GJg2c9q03x7AP/ikfK2f94Do0U9V2cnWqkNgNh9U8huE1QlvQDnte8G/JgQ3AiZaYA1Uu1F+j5ButLOV4O0b1VQgnCgWhKhqIhC0rpD+g5M75TA66Cz2ymmbAWoLmuJIniO4VttM3M98bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341140; c=relaxed/simple;
	bh=7b7cBVcLcCkfHrzRZlYxMbhxFbsvhMX6bkuQpffATM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6lREZIz/uy554ZXDELr0+N+z+tTxJ7yfCf/iCJoy3aMNzUQ7JyS5T5Fj1wjreGFDKGhGUYa4QWHvs7BF2QBNW52H33U1UOQngsjiU5o7CFwl8QEVP/uetungfuilA9boDiUHtu1BKO6Puj7XvKnKIja/Q+Etu1TMqU8bJMxPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; arc=none smtp.client-ip=81.2.116.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Received: by lucy.dinwoodie.org (Postfix, from userid 1001)
	id 4F160462F94; Sat, 16 Aug 2025 11:37:04 +0100 (BST)
From: Adam Dinwoodie <adam@dinwoodie.org>
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	"D . Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH] t/t1517: mark tests that fail with GIT_TEST_INSTALLED
Date: Sat, 16 Aug 2025 11:36:53 +0100
Message-ID: <20250816103656.1693607-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The changes added by 39fc408562 (t/t1517: automate `git subcmd -h` tests
outside a repository, 2025-08-08) to automatically loop over all "main"
Git commands will, when run against an installed build using
GIT_TEST_INSTALLED rather than the build in the build directory, include
some extra git-gui commands that are installed by `make install`.  These
fail the test, so record them as such.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 t/t1517-outside-repo.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 1c69d52c76..61fdd0170c 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -111,8 +111,9 @@ for cmd in $(git --list-cmds=main)
 do
 	cmd=${cmd%.*} # strip .sh, .perl, etc.
 	case "$cmd" in
-	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
+	archimport | citool | cvsexportcommit | cvsimport | cvsserver | daemon | \
 	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
+	gui | gui--askpass | \
 	http-backend | http-fetch | http-push | init-db | \
 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
 	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
-- 
2.49.0

