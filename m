Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF53D1CA9
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945667; cv=none; b=PsJt6FTB5H/9ae6D5RwPHHdSci9DUmlzkX2sm39GqnDE4XB2Pt76/N4wVx8OGi7t/cmSuzEulfvCFrCoDoWa/gR4MHdeN8oNpfpbrBxNiYOs/7kByVLCEGSNvuf2EWov+UabGMoQLBRzdgiM0djABt5XjhzV+XgLu55ps/GvmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945667; c=relaxed/simple;
	bh=yvlq1XT3bTDywAbM0rxUVTV/FMzDjzTs6lhE4kHQy4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/v0LOMtqHhheeDg8o34HzLUGy7qUEF2HzFIpobAOxLmLSaPRCW+APvOB5S7pbK5369kJlxYPgRmINQ0Op85e0fQmb8x0uOY3zYY3KcyWtskgR5o7KTnRZYApJaIgP5878G4VSQWN+nn8sTID64MYe6iW4Y4Ek3wyeOox0Jz9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=vQyOTxXm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="vQyOTxXm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768945662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qT6pBYinhNPkxdFY1+ItK6k/2JiApvxkcbZdm6wgCI=;
	b=vQyOTxXmowSoGWa43BKvtHxa7yL8jqZs9L0XxkR6Sgq+Q7d0ou4k0F7fh/1uZo8FUJLk+l
	nNTLpmmqq3bGpLXB07QvBCY7VeuR+dJUPT+sS24QmzhCUJrodTokIQiB2Hwbci3zrspJ+S
	6E/bI9DxjUmiUc1ClnqdyZO8qG8DxrY=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 20 Jan 2026 22:47:10 +0100
Subject: [PATCH v3 3/4] last-modified: document option '--max-depth'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-toon-last-modified-zzzz-v3-3-9bffd4968b0e@iotcl.com>
References: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
In-Reply-To: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Option --max-depth is supported by git-last-modified(1), because it was
added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
max-depth parameter, 2025-08-07).

This option is useful for everyday use of the git-last-modified(1)
command, so document it's existence in the man page.

To have it also appear in the help output of `git last-modified -h`,
move the handling of '--max-depth' to parse_options() in
builtin/last-modified.c itself. This prepares for the change in default
behavior in the next commit.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc |  8 +++++++-
 builtin/last-modified.c              | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 3760fd33a1..6f9b119bb6 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -9,7 +9,7 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
 SYNOPSIS
 --------
 [synopsis]
-git last-modified [--recursive] [--show-trees] [-z]
+git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]
 		  [<revision-range>] [[--] <pathspec>...]
 
 DESCRIPTION
@@ -33,6 +33,12 @@ OPTIONS
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
+`--max-depth=<depth>`::
+	For each pathspec given on the command line, traverse at most `<depth>`
+	levels into subtrees. A negative value means no limit.
+	The default is 0, which shows all paths matching the pathspec
+	without descending into subtrees.
+
 `-z`::
 	Terminate each line with a _NUL_ character rather than a newline.
 
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 4060abfad3..28fc77a0f8 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -56,6 +56,7 @@ struct last_modified {
 	bool recursive;
 	bool show_trees;
 	bool nul_termination;
+	int max_depth;
 
 	const char **all_paths;
 	size_t all_paths_nr;
@@ -483,6 +484,12 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	lm->rev.diffopt.flags.recursive = lm->recursive;
 	lm->rev.diffopt.flags.tree_in_recursive = lm->show_trees;
 
+	if (lm->max_depth >= 0) {
+		lm->rev.diffopt.flags.recursive = 1;
+		lm->rev.diffopt.max_depth = lm->max_depth;
+		lm->rev.diffopt.max_depth_valid = 1;
+	}
+
 	argc = setup_revisions(argc, argv, &lm->rev, NULL);
 	if (argc > 1) {
 		error(_("unknown last-modified argument: %s"), argv[1]);
@@ -511,7 +518,7 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	struct last_modified lm = { 0 };
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees] [-z]\n"
+		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]\n"
 		   "                  [<revision-range>] [[--] <pathspec>...]"),
 		NULL
 	};
@@ -521,11 +528,19 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			 N_("recurse into subtrees")),
 		OPT_BOOL('t', "show-trees", &lm.show_trees,
 			 N_("show tree entries when recursing into subtrees")),
+		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
+			      N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
 		OPT_BOOL('z', NULL, &lm.nul_termination,
 			 N_("lines are separated with NUL character")),
 		OPT_END()
 	};
 
+	/*
+	 * Set the default of a max-depth to "unset". This will change in a
+	 * subsequent commit.
+	 */
+	lm.max_depth = -1;
+
 	argc = parse_options(argc, argv, prefix, last_modified_options,
 			     last_modified_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |

-- 
2.52.0

