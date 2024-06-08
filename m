Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623401A702
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717871946; cv=none; b=EgpR1bL9i/VUvC9RXbCCmF7AwumA6mUZNrLbsPNCWgs/+gT58j0zEz+ybqn5sIWsdEHIaOfideChhviPWsSw4xtN0KtOMZJ0pY4xFNeCIpdy2g9HAKgpWpHXpfTFOlVk/XZCLPzWS7i3H5lSW0HvCatTjSAjWJu4FTDtZ7gSCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717871946; c=relaxed/simple;
	bh=7LbS2FPu2RY3f+DJ5tv9Hfo45OMRUBIk6Ie6CsJObUg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=alL7W259rsgOPk+xT8DrcBIeiyLmVA1S7UACBFZfUOpuI2S/xNL9RA7mvoyDYGzNuH89y9ZsMc2KiS1tthXTUfPVpOpQAT1rxVC2tSSWkVYI4jWC8XY0+rab00MrVdztvxV+ftwwmiLyRYtlG/l3/EsEYZ4PdjV4vyE8P26nN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hyUW+LLE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hyUW+LLE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1137A38CD3;
	Sat,  8 Jun 2024 14:39:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=7LbS2FPu2RY3f+DJ5tv9Hfo45OMRUBIk6Ie6CsJObUg=; b=hyUW
	+LLEJzCvWX0vzxY4EOcDaDNMEJHpKXcTaxMSDqw5zef4Ks+zwUaoIhqP3Ii5HF2L
	cq0STZxP/QevlkSO2P4tEG8Ybn6/N8FVh5AOd9twGxs7hFfBmxw/TvNDQ031KF40
	vTne3U2J2jEl9pYfGIpVj2EoMP4QfVv+/ms/XDs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D55E338CD2;
	Sat,  8 Jun 2024 14:39:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86C6838CD1;
	Sat,  8 Jun 2024 14:39:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] worktree_git_path(): move the declaration to path.h
Date: Sat,  8 Jun 2024 11:39:01 -0700
Message-ID: <20240608183901.2084546-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-445-g1b76f06508
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 609134E8-25C6-11EF-AF13-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The definition of this function is in path.c but its declaration is
in worktree.h, which is something unexpected.  The function is
explained as "Similar to git_path()"; declaring it next to where
git_path() is declared would make more sense.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.h     | 9 +++++++++
 revision.c | 1 +
 worktree.h | 8 --------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/path.h b/path.h
index c3bc8617bd..a6f0b70692 100644
--- a/path.h
+++ b/path.h
@@ -4,6 +4,7 @@
 struct repository;
 struct strbuf;
 struct string_list;
+struct worktree;
=20
 /*
  * The result to all functions which return statically allocated memory =
may be
@@ -81,6 +82,14 @@ void strbuf_repo_git_path(struct strbuf *sb,
 const char *git_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
=20
+/*
+ * Similar to git_path() but can produce paths for a specified
+ * worktree instead of current one
+ */
+const char *worktree_git_path(const struct worktree *wt,
+			      const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
 /*
  * Return a path into the main repository's (the_repository) git directo=
ry.
  */
diff --git a/revision.c b/revision.c
index 7ddf0f151a..09024cf4aa 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,7 @@
 #include "bisect.h"
 #include "packfile.h"
 #include "worktree.h"
+#include "path.h"
 #include "read-cache.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/worktree.h b/worktree.h
index 7cc6d90e66..11279d0c8f 100644
--- a/worktree.h
+++ b/worktree.h
@@ -177,14 +177,6 @@ int other_head_refs(each_ref_fn fn, void *cb_data);
 int is_worktree_being_rebased(const struct worktree *wt, const char *tar=
get);
 int is_worktree_being_bisected(const struct worktree *wt, const char *ta=
rget);
=20
-/*
- * Similar to git_path() but can produce paths for a specified
- * worktree instead of current one
- */
-const char *worktree_git_path(const struct worktree *wt,
-			      const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-
 /*
  * Return a refname suitable for access from the current ref store.
  */
--=20
2.45.2-445-g1b76f06508

