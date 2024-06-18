Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C018E756
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754287; cv=none; b=D4uVjZkZPkcsonaCEjlS+fLTjqYZLG+RRoewA7NbIKbxkSdTFEF1fj1iK5bqLKhMPQVHiLsqPI6zbAH5XdR6cNQ2pVgn+Uj1CxY5w5hPPGd6k5tW7JnuHb1Si3oVualOp2XFShEzSrmL0l9a46kyOejMO9lWPbsfhpo1+4Q2LHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754287; c=relaxed/simple;
	bh=/LAzRk4xxIuiKwhdFwE96XzRhE+YoeSGqqphbALagF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGaGnyJKcj56Tq9S7eUC9gfLTwomZe7w85V+Gm9dl5w9lICMKppxokg6EqTWosbYiPgIg2GywupFmClibmTEVOgOe6yY1IHLMiu335uooptlTxJK0nvARtC4UQ6A13ACMr+hdbH0hGe8NZs0oANuWudUVv59SLr47NHqAI5RYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U4Iqw7Xk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U4Iqw7Xk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 990191F5F3;
	Tue, 18 Jun 2024 19:44:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=/LAzRk4xxIuiKwhdFwE96XzRh
	E+YoeSGqqphbALagF4=; b=U4Iqw7Xkv2Nq9toM/Zz7Qvc/AlLcoH6x+ouFQ/nv4
	bfN5cfVeFmkXWn+Muta5dlWMAiPxGl8dNg7bxievkbfduSzITxF6puD/1gLrGLCT
	UjVFeHio+eB8dV3Ab8XBYq7FNHId+he9ksvTshPS2SWlRqCxjLYRUxHs0uwo7qKw
	Zc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 929FD1F5F2;
	Tue, 18 Jun 2024 19:44:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7CAB1F5EE;
	Tue, 18 Jun 2024 19:44:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] .gitignore: introduce GITIGNORE_FILE CPP macro
Date: Tue, 18 Jun 2024 16:44:32 -0700
Message-ID: <20240618234436.4107855-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-711-gd2c001ca14
In-Reply-To: <20240618234436.4107855-1-gitster@pobox.com>
References: <20240618233303.GA188880@coredump.intra.peff.net>
 <20240618234436.4107855-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 BBC0AF5C-2DCC-11EF-88AF-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

GITATTRIBUTES_FILE and GITMODULES_FILE have their own CPP macros
that resolve to their string literals to help compilers catch typos.
Add one for ".gitignore" as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/read-tree.c | 3 ++-
 dir.c               | 4 ++--
 environment.h       | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index a8cf8504b8..bc12f5bd16 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -6,6 +6,7 @@
=20
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -65,7 +66,7 @@ static int exclude_per_directory_cb(const struct option=
 *opt, const char *arg,
=20
 	if (!opts->update)
 		die("--exclude-per-directory is meaningless unless -u");
-	if (strcmp(arg, ".gitignore"))
+	if (strcmp(arg, GITIGNORE_FILE))
 		die("--exclude-per-directory argument must be .gitignore");
 	return 0;
 }
diff --git a/dir.c b/dir.c
index 45be4ad261..ec875e3878 100644
--- a/dir.c
+++ b/dir.c
@@ -2888,7 +2888,7 @@ static void new_untracked_cache(struct index_state =
*istate, int flags)
 {
 	struct untracked_cache *uc =3D xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, 100);
-	uc->exclude_per_dir =3D ".gitignore";
+	uc->exclude_per_dir =3D GITIGNORE_FILE;
 	uc->dir_flags =3D flags >=3D 0 ? flags : new_untracked_cache_flags(ista=
te);
 	set_untracked_ident(uc);
 	istate->untracked =3D uc;
@@ -3428,7 +3428,7 @@ static GIT_PATH_FUNC(git_path_info_exclude, "info/e=
xclude")
=20
 void setup_standard_excludes(struct dir_struct *dir)
 {
-	dir->exclude_per_dir =3D ".gitignore";
+	dir->exclude_per_dir =3D GITIGNORE_FILE;
=20
 	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
 	if (!excludes_file)
diff --git a/environment.h b/environment.h
index e9f01d4d11..39c3c24a3f 100644
--- a/environment.h
+++ b/environment.h
@@ -43,6 +43,7 @@ const char *getenv_safe(struct strvec *argv, const char=
 *name);
 #define GITMODULES_FILE ".gitmodules"
 #define GITMODULES_INDEX ":.gitmodules"
 #define GITMODULES_HEAD "HEAD:.gitmodules"
+#define GITIGNORE_FILE ".gitignore"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
--=20
2.45.2-711-gd2c001ca14

