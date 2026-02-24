Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBC36BCCB
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925359; cv=none; b=bArNP1miUjx5AEcrpDzSlf9s8fX3jJUvoFZQjNprJsWs2TWcWdAootYmPZF8HNJOMbk1kdf0hh0k3wqTTrIziwWwRgOzv0TIjhHzkS9m1nJSab/HVJ4B/OCRxRIR1M1s/rnwO0CX1WdRtLDzkaxtzlv26f4lhcoAi7Vl/ZLJvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925359; c=relaxed/simple;
	bh=LT92uf3zOWGrZTB4TbBO/q4hgo+iMELCyJtEerD1k7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcUlKJBFbbwgHv4/4RzAV5P80iUbfmlfKQG6oRF9fYXtcAfOsJ6imq7toG2u1IwkTTV9/kMUp0nhn609uhEGxGRXcF47fsW8ofdyiVQhFt/mi9uIF+tDY4hCTIBViDalekugNZicKsBRHbk/vn1RVzg2IIxnZX4riyACtEpwDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=l2smupyd; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="l2smupyd"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771925355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2/eM0WxK6QahgCDjkVbyE5/mTEAujIFNDcPxdWVsEc=;
	b=l2smupydVCug+WgAjiyuuRnF8hfEEQ0HRdZDuwCFTFsX0Z1LHEtOUF/Q0GdnSkNql6PkVd
	yfg04uvpCERfuad9NUuL8qvsJNmAH+pp3rLTo9DB1orqAqkE7J7tVD43xrVYfiN6N2i/Xn
	uBzCVZNQY2XCI0Vpqj8HVpDakWbpcwGYUPTMqYyOqZFnvWryQ55QONOoXB7DzgxfdsYkXi
	wEzxlD6U/f3U/RPqhs67/lLJFk3lslG60Y83fY9CQd62+qCjt/92A6+8ojcoc0RbnW0qSh
	OgxEK1Jh+vJ4GGN0/uGhXGK9o+1GjGfcJYV8w5D/7swOTXfxRlZZac0GuTUFgQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] format-patch: add ability to use alt cover format
Date: Tue, 24 Feb 2026 10:29:01 +0100
Message-ID: <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
In-Reply-To: <cover.1771925291.git.mroik@delayed.space>
References: <20260224040400.751247-1-mroik@delayed.space> <cover.1771925291.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5776; i=mroik@delayed.space; h=from:subject:message-id; bh=LT92uf3zOWGrZTB4TbBO/q4hgo+iMELCyJtEerD1k7g=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnW9Sk6F7a2EJHWmzX9sdzLWo0KSL2S7WdUqQV Hk13VCtVi2JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ1vUgAKCRBIeX6hnBm+ 0SPiD/4v4kXEbztwMYPeiyF9VPUcAs4SGE1y0fCb6/uVXg88WYnfcZnPiMsV4Y6lo+dOuYyDTOO Je7mvw4JLueXngqgAZ1piTo4WXcwxDgyzppfN56IR1p/jHr97oD2oTAlX8JOkJ3pbQ9UZO5PtH2 aoGJeZo3VyApz/lZJyeP7A+cK1084KwHor3P6w9xTxx7fG5QgpzYtW5/zTgnnRbHA37WPUBGdJ/ 78VeF/vIg6ZEz2tI1NuAcDTAXuck/SoYTiOb4VFdC0j8ajCIiLRPUgjBp3F13HP/OCJ51K3Gqm3 bspMx6eS0mZmHKrzQcBtrP9qziMjvZk3NJhabaGSYAOIegT3L+fQLrP4+4aXU6m1RdcDbVIKzU6 HiZgV7gsJSxuXS40RsKT2nyLAFWZUinRcJo5+5fhtkp6aQC23EFTc/1tpKkosCy3pyjUtDPM7+m OAnEmUAb3hCkRYZ65NalvM8dlZkAgYP6JkiclYuXiC0fT36Szc/a23rShPIbs7yLk+i72nRn6hI zIS0tTlvi6FlwxAc7RUoD2pBVv1V1VDFkRwEUcG8ciYxWYGf0iYyxhTj9IYTcF3SK8P+ENc4b1x IabiFCAxmaDZEXVusTKquhDkSn78J3oTZHMJuobtfxyp89O4pIXPfTah0YYA7CKUnf7oQgiEOd+ Wp8+Q7EMU
 m7J3Vw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

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
 builtin/log.c | 65 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c1cd3999a7..5e99660d7c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1324,13 +1324,32 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 	}
 }
 
+static void generate_commit_list_cover(FILE *cover_file,const char *format,
+				       struct commit **list, int n)
+{
+	struct strbuf commit_line = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+
+	strbuf_init(&commit_line, 0);
+	for (int i = n - 1; i >= 0; i--) {
+		strbuf_addf(&commit_line, "[%0*d/%d] ", decimal_width(n), n - i, n);
+		repo_format_commit_message(the_repository, list[i], format, &commit_line, &ctx);
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
@@ -1342,6 +1361,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	struct commit *head = list[0];
 	char *to_free = NULL;
 
+	assert(format);
+
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
 
@@ -1377,18 +1398,22 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
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
@@ -1906,6 +1931,7 @@ int cmd_format_patch(int argc,
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = -1;
+	char *cover_letter_fmt = NULL;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	int zero_commit = 0;
@@ -1952,6 +1978,8 @@ int cmd_format_patch(int argc,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
+		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
+			    N_("format spec used for the commit list in the cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
@@ -2289,13 +2317,14 @@ int cmd_format_patch(int argc,
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
@@ -2375,12 +2404,16 @@ int cmd_format_patch(int argc,
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
2.53.0.3.g6a0c7aecfd

