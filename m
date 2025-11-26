Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C43161BB
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137413; cv=none; b=fUL93X53HkLp7MfiiSzd4aYSHmFcD1T/oyHrKM28p+k3tS5+SLb9LFM5fxRmeAqOtNh9ujLYgV/zkyvQF1jwqZrJiamvxW9mVjT1ZZvdTPo2ujvGWQ2ncboo4nszmKFLuLhKL/5Ike2G5J+iSVfvYEGITVXlwJWyoFOCrbNb8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137413; c=relaxed/simple;
	bh=PFmihR9b7KQkp6vsb+zjDIeZ69tpYXiBuynSjhKXigU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=px0W1VgzYqyU188eygrfvdI42ts9/kpgtx+5HU5b8npczjiEMmW6E0yDnstFqA+Jyk0r0pAyYLyvhZm0lom+AMn9VYMO07OXJqvYzYT4pT7WkXjUegiLYT6ljV58QOyTNeW/wAUvYnYsfJ+OKZ0XX5sMibxnnBPBw4CzQ4KvySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=HNQ2gM8r; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="HNQ2gM8r"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764137408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFPJtD58GJgZiWF80YZak1lifdFOFBRMzwCi5udHUIc=;
	b=HNQ2gM8rw/mQ/lTPzLMtYsuoeLfipU8QkGDqQ3lzNLynLY9X2gAWR4JrnHqrfbOLX7heaO
	NpSZ3ANINNduFC/FjEERcAFeOPpDmK7Z/RSRokyuSpvgCUIQchUrES0XlAvV4InR4YHwk7
	MJ/vBPp+xxK/Ub7wvGZXGzl0wDzP8WQ=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Nov 2025 07:09:44 +0100
Subject: [PATCH 2/3] last-modified: document option --max-depth
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-toon-last-modified-zzzz-v1-2-608350df0caa@iotcl.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Option --max-depth is supported by git-last-modified(1), because it was
added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
max-depth parameter, 2025-08-07).

This option is useful for everyday use of the git-last-modified(1)
command, so document it's existence in the man page and `-h` output.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc |  9 ++++++++-
 builtin/last-modified.c              | 12 +++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index cd4a5040b0..8409daebe9 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -9,7 +9,8 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
 SYNOPSIS
 --------
 [synopsis]
-git last-modified [--recursive] [--show-trees] [-z] [<revision-range>] [[--] <path>...]
+git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]
+	[<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -32,6 +33,12 @@ OPTIONS
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
+`--max-depth=<depth>`::
+	For each pathspec given on the command line, descend at most `<depth>`
+	levels of directories. A negative value means no limit.
+	Setting a positive value implies `--recursive`.
+	Cannot be combined with wildcards in the pathspec.
+
 `-z`::
 	Terminate each line with a _NUL_ rather than a newline.
 
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 9206bbdc1d..ccb7ff66d4 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -25,6 +25,7 @@
 
 #define LAST_MODIFIED_INIT { \
 	.line_termination = '\n', \
+	.max_depth = -1, \
 }
 
 struct last_modified_entry {
@@ -60,6 +61,7 @@ struct last_modified {
 	bool recursive;
 	bool show_trees;
 	int line_termination;
+	int max_depth;
 
 	const char **all_paths;
 	size_t all_paths_nr;
@@ -487,6 +489,12 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
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
@@ -515,7 +523,7 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	struct last_modified lm = LAST_MODIFIED_INIT;
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees] [-z] "
+		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z] "
 		   "[<revision-range>] [[--] <path>...]"),
 		NULL
 	};
@@ -525,6 +533,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			 N_("recurse into subtrees")),
 		OPT_BOOL('t', "show-trees", &lm.show_trees,
 			 N_("show tree entries when recursing into subtrees")),
+		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
+			N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
 		OPT_SET_INT('z', NULL, &lm.line_termination,
 			N_("lines are separated with NUL character"), '\0'),
 		OPT_END()

-- 
2.51.2

