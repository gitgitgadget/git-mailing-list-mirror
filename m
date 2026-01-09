Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80833D4F6
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994233; cv=none; b=kG18dmoOm957oSwL07f9O8FjGfw+MrlsBkAqZM3aWSGubBpGYOFokDz56V1PnTD0FI1PtPOiEXgzxMdQjk+P6tJvSgGPVpBsvZ548yIctw7WG+4uMd7SUGMfjOPGnrmvPlBtl/WZcEcQDfnihj8Gc7Elu7amzVuzzmfQ8e5y+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994233; c=relaxed/simple;
	bh=6ZArj0gqACONUt7YC/3DJvOunVDIstmcWzBypvlSsWo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmNc2UuDc5Gp5GzZMgX0s5XoGCH/RLSY7XHPksh3beRWJp2wVez/aM2R+8GzZAWG2zrNas55unzCXeGADS8euaq7fnW58rgoCma5Rfk5wL/Hlo7mA5TNfxLf+wRbXDno6aV2C/rYBnf2BShDZy5BbCR7U565azeeXEnqM+De3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hdqz1ZrE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hdqz1ZrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994222; x=1768599022; i=l.s.r@web.de;
	bh=XDtqUbbIyFECs1X41LfcYf0wbYn3SaSBpJ9v+gu0C2k=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hdqz1ZrEhrpUlMbLrH1+j/dm82WvGdIpkGPv9GMYgbKfhn28uSVb9te0Y5Z/wHUI
	 94LPtDCKJuqcy6MEnrw6B7CQWxlHAImnrR/QLgiesz3/rTHPoqE6Tdx8lmrMXq4sj
	 5d//Zp7FTWo8CVBtuXWy6rCLm0Vnxqf8I/TQMG8IhqgEV1NzOFMkkRynL4YQDaifh
	 0hlBiQH4X0zumGnrM3DRatuhcava4dX/D0VSjP1vl1MVe8RHvuQp346il5c1P0H5A
	 YPMUlOE6C48f/vmryRsYcmLY7RlGyLaEW/lu7f5jsIQypE+Ox89d+Aqh29KAHc3/z
	 PrivMsw53BhNRDLVEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mft7j-1wJyPH0f85-00qdAv for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:22
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 01/10] environment: move access to core.maxTreeDepth into repo settings
Date: Fri,  9 Jan 2026 22:30:12 +0100
Message-ID: <20260109213021.2546-2-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bA74xYTYbr6kuq415Ld3lzcEh0bW8Ny4BluVSRB04WYnX3DhvyC
 9tFrpj+vlqd+QlXL9biDqqc8ONTYXOAQq/x25kDdfbqdDgPFuofqmTUd4VimyyySGKr8a+G
 gHRQXI3ZuuzotL1HKmuSa5sNgLM0hqWpIcbSgqncKwUQMzKNgsrKOd5uAxhv6/dovVjODDG
 aZTzl4Yd6fv8RaHXOQq1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q8WgBEMl7qc=;3i3nDK7VygkwbcF1kEYzdxi8zmO
 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

The config setting core.maxTreeDepth is stored in a global variable and
populated by the function git_default_core_config.  This won't work if
we need to access multiple repositories with different values of that
setting in the same process.  Store the setting in struct repo_settings
instead and track it separately for each repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 environment.c     | 29 -----------------------------
 environment.h     |  1 -
 git-compat-util.h | 24 ++++++++++++++++++++++++
 list-objects.c    |  2 +-
 repo-settings.c   |  3 +++
 repo-settings.h   |  3 +++
 tree-diff.c       |  2 +-
 tree-walk.c       |  4 +++-
 tree.c            |  2 +-
 9 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/environment.c b/environment.c
index a770b5921d9..c6e5b65abac 100644
=2D-- a/environment.c
+++ b/environment.c
@@ -80,30 +80,6 @@ int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition() =
*/
 unsigned long pack_size_limit_cfg;
-int max_allowed_tree_depth =3D
-#ifdef _MSC_VER
-	/*
-	 * When traversing into too-deep trees, Visual C-compiled Git seems to
-	 * run into some internal stack overflow detection in the
-	 * `RtlpAllocateHeap()` function that is called from within
-	 * `git_inflate_init()`'s call tree. The following value seems to be
-	 * low enough to avoid that by letting Git exit with an error before
-	 * the stack overflow can occur.
-	 */
-	512;
-#elif defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarc=
h64__)
-	/*
-	 * Similar to Visual C, it seems that on Windows/ARM64 the clang-based
-	 * builds have a smaller stack space available. When running out of
-	 * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
-	 * Git command was run from an MSYS2 Bash, this unfortunately results
-	 * in an exit code 127. Let's prevent that by lowering the maximal
-	 * tree depth; This value seems to be low enough.
-	 */
-	1280;
-#else
-	2048;
-#endif
=20
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
@@ -569,11 +545,6 @@ static int git_default_core_config(const char *var, c=
onst char *value,
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.maxtreedepth")) {
-		max_allowed_tree_depth =3D git_config_int(var, value, ctx->kvi);
-		return 0;
-	}
-
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return platform_core_config(var, value, ctx, cb);
 }
diff --git a/environment.h b/environment.h
index 51898c99cd1..9efe0b30fb3 100644
=2D-- a/environment.h
+++ b/environment.h
@@ -156,7 +156,6 @@ extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
-extern int max_allowed_tree_depth;
=20
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/git-compat-util.h b/git-compat-util.h
index b0673d1a450..bebcf9f698c 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -578,6 +578,30 @@ static inline bool strip_suffix(const char *str, cons=
t char *suffix,
 #define DEFAULT_PACKED_GIT_LIMIT \
 	((1024L * 1024L) * (size_t)(sizeof(void*) >=3D 8 ? (32 * 1024L * 1024L) =
: 256))
=20
+#ifdef _MSC_VER
+  /*
+   * When traversing into too-deep trees, Visual C-compiled Git seems to
+   * run into some internal stack overflow detection in the
+   * `RtlpAllocateHeap()` function that is called from within
+   * `git_inflate_init()`'s call tree. The following value seems to be
+   * low enough to avoid that by letting Git exit with an error before
+   * the stack overflow can occur.
+   */
+#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 512
+#elif defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarc=
h64__)
+  /*
+   * Similar to Visual C, it seems that on Windows/ARM64 the clang-based
+   * builds have a smaller stack space available. When running out of
+   * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
+   * Git command was run from an MSYS2 Bash, this unfortunately results
+   * in an exit code 127. Let's prevent that by lowering the maximal
+   * tree depth; This value seems to be low enough.
+   */
+#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 1280
+#else
+#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 2048
+#endif
+
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
=20
diff --git a/list-objects.c b/list-objects.c
index 42c17d95739..1279676ddca 100644
=2D-- a/list-objects.c
+++ b/list-objects.c
@@ -167,7 +167,7 @@ static void process_tree(struct traversal_context *ctx=
,
 	    !revs->include_check_obj(&tree->object, revs->include_check_data))
 		return;
=20
-	if (ctx->depth > max_allowed_tree_depth)
+	if (ctx->depth > revs->repo->settings.max_allowed_tree_depth)
 		die("exceeded maximum allowed tree depth");
=20
 	failed_parse =3D parse_tree_gently(tree, 1);
diff --git a/repo-settings.c b/repo-settings.c
index 195c24e9c07..208e09ff17f 100644
=2D-- a/repo-settings.c
+++ b/repo-settings.c
@@ -100,6 +100,9 @@ void prepare_repo_settings(struct repository *r)
 	 */
 	if (!repo_config_get_int(r, "index.version", &value))
 		r->settings.index_version =3D value;
+	repo_cfg_int(r, "core.maxtreedepth",
+		     &r->settings.max_allowed_tree_depth,
+		     DEFAULT_MAX_ALLOWED_TREE_DEPTH);
=20
 	if (!repo_config_get_string_tmp(r, "core.untrackedcache", &strval)) {
 		int v =3D git_parse_maybe_bool(strval);
diff --git a/repo-settings.h b/repo-settings.h
index d4778855614..cad9c3f0cc1 100644
=2D-- a/repo-settings.h
+++ b/repo-settings.h
@@ -67,6 +67,8 @@ struct repo_settings {
 	size_t packed_git_limit;
 	unsigned long big_file_threshold;
=20
+	int max_allowed_tree_depth;
+
 	char *hooks_path;
 };
 #define REPO_SETTINGS_INIT { \
@@ -78,6 +80,7 @@ struct repo_settings {
 	.delta_base_cache_limit =3D DEFAULT_DELTA_BASE_CACHE_LIMIT, \
 	.packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE, \
 	.packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT, \
+	.max_allowed_tree_depth =3D DEFAULT_MAX_ALLOWED_TREE_DEPTH, \
 }
=20
 void prepare_repo_settings(struct repository *r);
diff --git a/tree-diff.c b/tree-diff.c
index 5988148b602..631ea868124 100644
=2D-- a/tree-diff.c
+++ b/tree-diff.c
@@ -439,7 +439,7 @@ static void ll_diff_tree_paths(
 	void *ttree, **tptree;
 	int i;
=20
-	if (depth > max_allowed_tree_depth)
+	if (depth > opt->repo->settings.max_allowed_tree_depth)
 		die("exceeded maximum allowed tree depth");
=20
 	FAST_ARRAY_ALLOC(tp, nparent);
diff --git a/tree-walk.c b/tree-walk.c
index e449a1320e5..7e1b956f278 100644
=2D-- a/tree-walk.c
+++ b/tree-walk.c
@@ -12,6 +12,7 @@
 #include "pathspec.h"
 #include "json-writer.h"
 #include "environment.h"
+#include "read-cache-ll.h"
=20
 static int decode_tree_entry(struct tree_desc *desc, const char *buf, uns=
igned long size, struct strbuf *err)
 {
@@ -441,8 +442,9 @@ int traverse_trees(struct index_state *istate,
 	struct strbuf base =3D STRBUF_INIT;
 	int interesting =3D 1;
 	char *traverse_path;
+	struct repository *r =3D istate ? istate->repo : the_repository;
=20
-	if (traverse_trees_cur_depth > max_allowed_tree_depth)
+	if (traverse_trees_cur_depth > r->settings.max_allowed_tree_depth)
 		return error("exceeded maximum allowed tree depth");
=20
 	traverse_trees_count++;
diff --git a/tree.c b/tree.c
index 1ef743d90f4..2a677234d60 100644
=2D-- a/tree.c
+++ b/tree.c
@@ -25,7 +25,7 @@ int read_tree_at(struct repository *r,
 	int len, oldlen =3D base->len;
 	enum interesting retval =3D entry_not_interesting;
=20
-	if (depth > max_allowed_tree_depth)
+	if (depth > r->settings.max_allowed_tree_depth)
 		return error("exceeded maximum allowed tree depth");
=20
 	if (parse_tree(tree))
=2D-=20
2.52.0

