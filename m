Received: from lucy.dinwoodie.org (unknown [81.2.116.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FB27280C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.116.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589608; cv=none; b=mrcJjn9n9hOLiHYRELBeiVkFl6Fv9Y3GH9pEnIVT2rJTNhw9eT2E/Ll2mITFTuRzWd4Xl/O117lI64axt5tdfQcfFCTRUodxRXGJxE3f9Dw/fVDgcOc2r6FZFmsNyKBmW7Jdjo6LouNI8xmDeL+1NGc5cm5+h58Cg5dGfesaLEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589608; c=relaxed/simple;
	bh=wetxdZ+HziCfD/ikQ2PsqXDSAQElUM36ucykbBpqgu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgkye9K43BEz6roBwj9DPCPbiISoxY/rGA2xYzd6VSN1+rTtsX5IFsque2TcfcrNgrYau1hf2lFiTdwTqrMU/3WNyfJqlugMCoO1I8IeQ5/O6S6TaYhjFSqkg7EeFRQMq7Q4ROJXV2Rjaakq3In2S3wSYMIwLAgZP8GHPHN/0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; arc=none smtp.client-ip=81.2.116.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Received: by lucy.dinwoodie.org (Postfix, from userid 1001)
	id 9354F466B39; Tue, 19 Aug 2025 08:46:34 +0100 (BST)
From: Adam Dinwoodie <adam@dinwoodie.org>
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	"D . Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v2] t/t1517: mark tests that fail with GIT_TEST_INSTALLED
Date: Tue, 19 Aug 2025 08:43:29 +0100
Message-ID: <20250819074631.3303-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250816103656.1693607-1-adam@dinwoodie.org>
References: <20250816103656.1693607-1-adam@dinwoodie.org>
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
some extra git-gui commands that are installed by `make install`, or
credential helpers that might be installed manually from the contrib
directories.  These fail the test, so record them as such.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

This re-roll adds a few more commands to those marked as known failures,
notably credential helpers I see installed in various builds for the
Nixpkgs packaging of Git.

 t/t1517-outside-repo.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 1c69d52c76..c824c1a25c 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -111,8 +111,11 @@ for cmd in $(git --list-cmds=main)
 do
 	cmd=${cmd%.*} # strip .sh, .perl, etc.
 	case "$cmd" in
-	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
+	archimport | citool | credential-netrc | credential-libsecret | \
+	credential-osxkeychain | cvsexportcommit | cvsimport | cvsserver | \
+	daemon | \
 	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
+	gui | gui--askpass | \
 	http-backend | http-fetch | http-push | init-db | \
 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
 	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
-- 
2.49.0

