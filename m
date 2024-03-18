Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E954BFA
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781422; cv=none; b=b1vR5cjm1KsZBu9wXgTLhpRuK85vQOBWCxs2428kWAOWCJdmYOURp5dKfvWnllbHBS/cpAsT67vN4Qfc6UgnjvdeItDGNLLje5OoTashCuSsEV+ag8rimIVMXIcO5jYSee/qx8YLkwjEnTgwIKXLmjVDnpnk9+uh8fFXBlrKaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781422; c=relaxed/simple;
	bh=HafAkm914n1i3Ie3fCVRteaSBieutfMot2DB381B7n4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDYoVkOz1v9mUGR6isqLItq6LsLXHzTHiS+ENgA7his+wWSUbtu88TZ7tNHDw9tuycs3ngrwetdvUwZcsdAjYg5CbxFBWVA7pNJPEhnS6JCqA4oOYwm5JI8Le4a2t7RAn+5KcaZ41y1KxgB/AIzx5KQaLOyvE7hCxDVme+XO4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=cUTDsnvi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cUTDsnvi"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710781411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1X3Hbgd+yE4oHYkBr0Ro8GXeDlXlZR9qhEb3EV/TRk=;
	b=cUTDsnviIye8bGe5wNefalN8fZdCJr9YbKcQ2leU5VVJltS3Heq8QlQI/YDx4G1hG86LdQ
	uKK4ARARGa/FbHcvKJXxl2IPUup6d1WNE6DbINgeTAHWyByJoKfRQoIC3CrNRrAadYBXU/
	RN/KzvXtY/qguitZ7ks48TqPPKK/P+XkoPNmlr3JtzgUz4pXMm815uCJfcT4x0ivf2GDYy
	FuMmwhf4mDCoWPb7T+2cUmCl9akSERqqyG9zoxDKOy1asMTnIbAv6OHQkfvWKF7Tw2YXAH
	h+dS8Rj9cpz/vwgU8M/UskqNWMi7Rqz3oz2bztiouAnZL/i6cKT2rHITdRE8xg==
To: git@vger.kernel.org
Subject: [PATCH 1/5] grep: perform some minor code and comment cleanups
Date: Mon, 18 Mar 2024 18:03:21 +0100
Message-Id: <96b81f3573d3f29bb97e77d623be0d53cf8085b0.1710781235.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710781235.git.dsimic@manjaro.org>
References: <cover.1710781235.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move some variable definitions around, and reflow one comment block, to
make the code a bit neater after spotting those slightly unpolished areas.
There are no functional changes to the source code.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 builtin/grep.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 982bcfc4b1df..af89c8b5cb19 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -623,13 +623,13 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
 		     int check_attr)
 {
-	struct repository *repo = opt->repo;
-	int hit = 0;
+	int hit = 0, name_base_len = 0;
+	int old_baselen = base->len;
 	enum interesting match = entry_not_interesting;
+	struct repository *repo = opt->repo;
 	struct name_entry entry;
-	int old_baselen = base->len;
 	struct strbuf name = STRBUF_INIT;
-	int name_base_len = 0;
+
 	if (repo->submodule_prefix) {
 		strbuf_addstr(&name, repo->submodule_prefix);
 		name_base_len = name.len;
@@ -890,19 +890,15 @@ static int pattern_callback(const struct option *opt, const char *arg,
 
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
-	int hit = 0;
+	int hit = 0, seen_dashdash = 0, use_index = 1;
 	int cached = 0, untracked = 0, opt_exclude = -1;
-	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
+	int i, dummy, allow_revs;
 	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
 	struct object_array list = OBJECT_ARRAY_INIT;
 	struct pathspec pathspec;
 	struct string_list path_list = STRING_LIST_INIT_DUP;
-	int i;
-	int dummy;
-	int use_index = 1;
-	int allow_revs;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -1059,9 +1055,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		recurse_submodules = 0;
 
 	/*
-	 * skip a -- separator; we know it cannot be
-	 * separating revisions from pathnames if
-	 * we haven't even had any patterns yet
+	 * skip a -- separator; we know it cannot be separating revisions
+	 * from pathnames if we haven't even had any patterns yet
 	 */
 	if (argc > 0 && !opt.pattern_list && !strcmp(argv[0], "--")) {
 		argv++;
