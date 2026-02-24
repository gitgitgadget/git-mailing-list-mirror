Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40F18AE3
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905869; cv=none; b=O5I+C81fqq0m5vVvo1LLDRqcB12vhWLxMQpqZ5VJOvE2+3JgEnTMelqg64+qbXZos+xZ005mrnBuTEYACRAvMFMYaSCb3UoVJ8GYFPagByH0yyD4Y21GvAA+wkKN6XWCVDpSnQ+Z1Sjq5eH6/zzxKPLrd1+yGqjClQ5W2qZHrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905869; c=relaxed/simple;
	bh=oWBr9BfbCMYLeua25pIDXyuVKv55esashwECFbV2IvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw1gRz2OIau4sKnoS41qcLpsQv1uEacRcuLo+DafygaMDeT4OQiRbJ521MFqOeqAMQdAWEEEKOD8VbbXrrbQpWXdSCX8Tkm+5zTf7kH9LBAzD1/WbJa09jEjMAII6+n8xB6Odm9OJ5wHe5QoRcSr156vKGbvT41dS4t0BUeTu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=CCIFJrW3; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="CCIFJrW3"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771905866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYnd6bwVl7ZAo+T2pLPyA9fDKlx0/qFnzHG47bokzE0=;
	b=CCIFJrW3WdVdq9OjvLxaDdZeXTnMuOW6qa/x/smcuY+8GQh64aDlZhaW3darMeHt4lG+S2
	FpFsSbTEzxaRc0EQbK67G8wewbfoGLh1ssl5LTrw1F97N5SfCEzRKQslafbaH1eb9cn0vL
	VPi+EZdYTBvQGL6P6Y/raEpYXoAyMU1Q5mZNoZVdvFH5fcKawu/TdYtZx28pyed2JVXqbz
	QFRz6gAef2vnctI2ShlJzHUs5dyIrGwO7dzMVe7ptXs2dkxtqK4ezuOq05M8uMzKAOm5DP
	LT0Vj0WM33n1buUta9BDic++sOO5gWqr/q4GH55uDYUVacFWYiRGSXQ5iYyw/w==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] format-patch: add ability to use alt cover format
Date: Tue, 24 Feb 2026 05:03:57 +0100
Message-ID: <20260224040400.751247-3-mroik@delayed.space>
In-Reply-To: <20260220230633.132213-1-mroik@delayed.space>
References: <20260220230633.132213-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5867; i=mroik@delayed.space; h=from:subject; bh=oWBr9BfbCMYLeua25pIDXyuVKv55esashwECFbV2IvU=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnSLdQnFPqZzknYnY8O9i65P/DflnpV4ReWIf9 4S8Hl8xzAmJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ0i3QAKCRBIeX6hnBm+ 0RZVEACiBlpYYpNEceeOfS6/x7h7B4kdVWOvuXfFlyjK9Sx1Ouyl9ZasW/1m8T5HIkNjUfZOSYo rRF2NzX6J1d6M8dI00aiWDdsG3Wyz2oDuyq6WmR5BFfQlS1hj4CSGeMyjjzrSK3BBtzTFWQ3Xks cpW5oezCz6jZlkYyhEcwStkae7/euzqbejkDEprD+Z7eAR5xBL69HPvtb1dDC4RwNsY9DdRuJS6 kPq5Tf+3z8yWdjKbsvQaCOU9C3ez//az+seUHJBPh6wjkolCUP9z4MugTV42Hxz9Rgye83RJiEJ 6n4Iu/gwIngfckqywZM+nhZciQhqpmAD9EzEA9a1XeT3biD2cBQ7K1VJuy7tYhY3CBej1cj15xf GHthZ687+O9zv1zTvM04+Pjyw2CEaL8l+8Tsx/lLurpGep1tduyk1Lk/j7bGdlOKAXERaMRO2qz UtTBySmlJi1mEnrdBdzHLlRK3etzE/eVU25BxWuETG/0JNsVzjzgIZubsXgAj4O7TDIACMXFAtd 1NnyyBMn04r2hP+8EMTQtV+rLrHkkJapjEBfYCxEdHA+9ITboaAu1nbLmO54p5W1Jv4uFwcOOwG ijhxUI4cSeqp0fA4AZzhJmmIbusrRUSE9prBp4Qq1C+xcWTc8ji9wnLxkG2wwW+jF3yh5dvq+7Y ceB1/A2XtF105+A==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Often when sending patch series there's a need to clarify to the
reviewer what's the purpose of said series, since it might be difficult
to understand it from reading the commits messages one by one.

"git format-patch" provides the useful "--cover-letter" flag to declare
if we want it to generate a template for us to use. By default it will
generate a "git shortlog" of the changes, which developers find less
useful than they'd like, mainly because the shortlog groups commits by
author, and gives no obvious chronological order.

Give the ability to format-patch to specify an alternative format spec
through the "--cover-letter-format" option. This option either takes
"shortlog", which is the current format, or a format spec prefixed with
"log:".

Example:
    git format-patch --cover-letter \
        --cover-letter-format="log:%s (%an)" HEAD~3

    [1/3] this is a commit summary (Mirko Faina)
    [2/3] this is another commit summary (Mirko Faina)
    ...

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 68 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c1cd3999a7..80ec79efe8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1324,13 +1324,35 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 	}
 }
 
+static void generate_commit_list_cover(FILE *cover_file, const char *format, struct commit **list, int n)
+{
+	struct strbuf commit_line = STRBUF_INIT;
+	struct rev_info rev = REV_INFO_INIT;
+
+	strbuf_init(&commit_line, 0);
+	get_commit_format(format, &rev);
+	if (commit_format_is_empty(CMIT_FMT_USERFORMAT))
+		die(_("invalid format spec"));
+
+	for (int i = n - 1; i >= 0; i--) {
+		strbuf_addf(&commit_line, "[%0*d/%d] ", decimal_width(n), n - i, n);
+		pp_commit_easy(CMIT_FMT_USERFORMAT, list[i], &commit_line);
+		fprintf(cover_file, "%s\n", commit_line.buf);
+		strbuf_reset(&commit_line);
+	}
+	fprintf(cover_file, "\n");
+
+	strbuf_release(&commit_line);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *description_file,
 			      const char *branch_name,
 			      int quiet,
-			      const struct format_config *cfg)
+			      const struct format_config *cfg,
+			      const char *format)
 {
 	const char *from;
 	struct shortlog log;
@@ -1342,6 +1364,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	struct commit *head = list[0];
 	char *to_free = NULL;
 
+	assert(format);
+
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
 
@@ -1377,18 +1401,22 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	free(pp.after_subject);
 	strbuf_release(&sb);
 
-	shortlog_init(&log);
-	log.wrap_lines = 1;
-	log.wrap = MAIL_DEFAULT_WRAP;
-	log.in1 = 2;
-	log.in2 = 4;
-	log.file = rev->diffopt.file;
-	log.groups = SHORTLOG_GROUP_AUTHOR;
-	shortlog_finish_setup(&log);
-	for (i = 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
+	if (skip_prefix(format, "log:", &format)) {
+		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
+	} else {
+		shortlog_init(&log);
+		log.wrap_lines = 1;
+		log.wrap = MAIL_DEFAULT_WRAP;
+		log.in1 = 2;
+		log.in2 = 4;
+		log.file = rev->diffopt.file;
+		log.groups = SHORTLOG_GROUP_AUTHOR;
+		shortlog_finish_setup(&log);
+		for (i = 0; i < nr; i++)
+			shortlog_add_commit(&log, list[i]);
 
-	shortlog_output(&log);
+		shortlog_output(&log);
+	}
 
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
@@ -1906,6 +1934,7 @@ int cmd_format_patch(int argc,
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = -1;
+	char *cover_letter_fmt = NULL;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	int zero_commit = 0;
@@ -1952,6 +1981,8 @@ int cmd_format_patch(int argc,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
+		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
+			    N_("format spec used for the commit list in the cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
@@ -2289,13 +2320,14 @@ int cmd_format_patch(int argc,
 		/* nothing to do */
 		goto done;
 	total = list.nr;
+
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
-			cover_letter = (total > 1);
+			cover_letter = total > 1;
 		else if ((idiff_prev.nr || rdiff_prev) && (total > 1))
-			cover_letter = (cfg.config_cover_letter != COVER_OFF);
+			cover_letter = cfg.config_cover_letter != COVER_OFF;
 		else
-			cover_letter = (cfg.config_cover_letter == COVER_ON);
+			cover_letter = cfg.config_cover_letter == COVER_ON;
 	}
 	if (!cfg.keep_subject && cfg.auto_number && (total > 1 || cover_letter))
 		cfg.numbered = 1;
@@ -2375,12 +2407,16 @@ int cmd_format_patch(int argc,
 	}
 	rev.numbered_files = just_numbers;
 	rev.patch_suffix = fmt_patch_suffix;
+
+	if (cover_letter && !cover_letter_fmt)
+		cover_letter_fmt = "shortlog";
+
 	if (cover_letter) {
 		if (cfg.thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
 				  origin, list.nr, list.items,
-				  description_file, branch_name, quiet, &cfg);
+				  description_file, branch_name, quiet, &cfg, cover_letter_fmt);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(signature, rev.diffopt.file);
 		total++;
-- 
2.53.0.4.geaa3cc5f7e

