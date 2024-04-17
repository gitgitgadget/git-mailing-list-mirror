Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818CD3FB81
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324775; cv=none; b=HrfJ/pndlm0VMdhr5cZgAUABJtMjSaQE9qnhtT8c3+b0zxJ25wYTsIwGJEjT4sOcOr2ngk8AW+u1tRoG4lpSH+OquhO5dtl+HCccgnhR3C5E06eJG8u/hcim/sZEQbE3z5vDvBByufECVN4UipeBGq0ENWhGjiuHb7/2NH4OxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324775; c=relaxed/simple;
	bh=D+ZTaGu/OSlj1pHzfZWhw/icIF9JPEY61yeCrTRsoZ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rfc5tNNgmlqIb2Xhd8aiOCeuNgivX+T6ophcs6ttExQUTTGChSXl/kzPoqPpuyY+3rqb6ZZTlCLwI9luGQbmq9XQsfN/VPM2F1Myph19s+97xIh3jaH7vBma8TOPSrMFtinJGgzE1e6kqaTZVkxZIqxHQHec4mRXMkXPpWQNs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DNYi/1m8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DNYi/1m8"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713324770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKq06gosPMYZP92hXh8eMP6Hi6XBf9aru8sCn+QYz3M=;
	b=DNYi/1m8osen45I5km6LRKUZ2Uj1mvpQOnVPLQlKVAjwaEcaG6bcC1yZ4GO3zld6nMl91R
	0d/8ZX5WW60LCuL6mP3udiZcwLLSF6JYH1jY1XTacCIsmymXDJNWQAoO4+PEUIgXOwTRBf
	q6J4NMY6Gzi7DRPWVHmZSyvdpXYMGZko3ZPWSAEOsOY2aT0mTKjZhpgSpNpBtTR3wWot88
	/UF672Pvn3sr6Zv3xBaewpOV/rYjxtjyy5n5mpCoI3bFJU23RWNYAOnXfBBf0RkzwOlcZq
	UvpH/zKM92qLECvJD3wI4SowUUJSWIGSB0kpvLFvVqXASKg9ZpExvZW08xS61w==
To: git@vger.kernel.org
Subject: [PATCH 3/4] format-patch: new --resend option for adding "RESEND" to patch subjects
Date: Wed, 17 Apr 2024 05:32:43 +0200
Message-Id: <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <cover.1713324598.git.dsimic@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add --resend as the new command-line option for "git format-patch" that adds
"RESEND" as a (sub)suffix to the patch subject prefix, eventually producing
"[PATCH RESEND]" as the default patch subject prefix.

"[PATCH RESEND]" is a patch subject prefix commonly used on mailing lists
for patches resent to a mailing list after they had attracted no attention
for some time, usually for a couple of weeks.  As such, this subject prefix
deserves adding --resend as a new shorthand option to "git format-patch".

Of course, add the description of the new --resend command-line option to
the documentation for "git format-patch".

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/git-format-patch.txt |  5 +++++
 builtin/log.c                      | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index a5019ab46926..8e63b62620ed 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -243,6 +243,11 @@ the patches (with a value of e.g. "PATCH my-project").
 	default.  RFC means "Request For Comments"; use this when sending
 	an experimental patch for discussion rather than application.
 
+--resend::
+	Appends "RESEND" to the subject prefix, producing "PATCH RESEND"
+	by default.  Use this when sending again a patch that had resulted
+	in attracting no discussion for a while.
+
 -v <n>::
 --reroll-count=<n>::
 	Mark the series as the <n>-th iteration of the topic. The
diff --git a/builtin/log.c b/builtin/log.c
index e5a238f1cf2c..28f31659bcde 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1908,7 +1908,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff_title = STRBUF_INIT;
 	struct strbuf sprefix = STRBUF_INIT;
 	int creation_factor = -1;
-	int rfc = 0;
+	int rfc = 0, resend = 0;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1933,6 +1933,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
 		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
+		OPT_BOOL(0, "resend", &resend, N_("use [PATCH RESEND] instead of [PATCH]")),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
@@ -2055,6 +2056,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_insertstr(&sprefix, 0, "RFC ");
 		subject_prefix = 1;
 	}
+	if (resend) {
+		strbuf_addstr(&sprefix, " RESEND");
+		subject_prefix = 1;
+	}
 
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
@@ -2111,7 +2116,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (numbered && keep_subject)
 		die(_("options '%s' and '%s' cannot be used together"), "-n", "-k");
 	if (keep_subject && subject_prefix)
-		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefix/--rfc", "-k");
+		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefix/--rfc/--resend", "-k");
+	if (rfc && resend)
+		die(_("options '%s' and '%s' cannot be used together"), "--rfc", "--resend");
 	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
