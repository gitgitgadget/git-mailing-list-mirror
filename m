Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25721ADA4
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157184; cv=none; b=Tp0IJPwDn3sbx5J8QNRehnHsWUUpBEa4Q/99jX8zhbQg4mWOXhoG6sGXeeOISiBJ9LOqT+LB/9kPRgArXbJ7puZi5t5aO/XFdEgzZbk3eXWYOoMHKKhYIm5r/j5ZlvhS5r6Iam/B0rCbjgyrd4dbQV6Jp84UTWJvfu+c4K2roPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157184; c=relaxed/simple;
	bh=LexJd0wf3INQlurLxDipxL3kajrJqGVAOx62HhBHMng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHW+V19KJbAx6b3/BCfSLVjy6qimdczE0ZxGAa0scKTJPyEZe6qRklmIOB7iV99drEptooOjCrb4dqNjYb9Dn+hV3QqjdUToY+2McbblbPgcHCY1ZOxbIBAr3dMp5LFMw5C81bTssMuZZV/ElMWd6eefjGNuj9rwo/wjcR1O2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=i8D24WMu; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="i8D24WMu"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772157175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKviKD+6YO1XAWGqitNcMtLQ6phcwElZbSR/0CeGnVo=;
	b=i8D24WMuGZTXO1M3muCJWKkwfDgqDom9dszwIuT4xHZEhfK730nJSBv2Aip1s0sZ5GjZ2m
	bQUErfjIL25H5XKttjTpsxwXPlkfxKLxR75nBLT+QL9Ku3nqiX8gXQCcDjizrg1Th8IFtF
	wpnLf7gomUdnpRLvpXCSt/ZNY3bsd5Ov8l6+1K4rHQPvia1Io1durgTYslDcBUMzYCrmcI
	lc9029bG4GwCthLc3sXE9n5iK2d6QVMSUm2M/DV7TTCG1CH8vzNKnJXw+VAv8MMYc3nmWe
	kku/iTLu6wlOP0iGZ4TAUM5dQujtbeiZ5beFk/bfZc+M0y+W63ti13qRIslleA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] format-patch: add ability to use alt cover format
Date: Fri, 27 Feb 2026 02:52:38 +0100
Message-ID: <190817fe6ac5199c6df95558a7dee4be3d2fffdd.1772156996.git.mroik@delayed.space>
In-Reply-To: <cover.1772156996.git.mroik@delayed.space>
References: <cover.1771925291.git.mroik@delayed.space> <cover.1772156996.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7410; i=mroik@delayed.space; h=from:subject:message-id; bh=LexJd0wf3INQlurLxDipxL3kajrJqGVAOx62HhBHMng=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpoPiZceBTxeWsz01UFGzEST7G/y06IxFx87qWR UQTdPPKMAWJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaD4mQAKCRBIeX6hnBm+ 0UFTD/9nSLI3s8rGk8SRy6IvMoCvNL1CgnytUmigT70R36Sf6Uc/8JZ2sLyw1OwnjsK3F8HZq8N jZgbGDq/H30nc+WwSLUmG3Ms6sVwTH1MUWS286jAnl+1dnK4G4nRlWfDMc1/4QIzWQ/80Ly+MFX 8jl2hhibxgDizgxgWL6B6cjuuqs48m8952StyTysuNywZVDsa2EQySphsWVHp0Pg8ermdmEUp0k uA8EO7Sxcj6S1+oxKjOsVa8gdFfvH1mg4iHMcKctxNbbt+cNOtm8B4aBXyupHT2viNr7ZWrdY6O UjVH35v3ByYwa/Yfj84HGRD/wetLXPad9tmmNL2hk/aDsds3plRSG52EgRQK+P6xRD2M1HD6vXl 2DpeJJ4Oztj92q0195KWFI5nqK11yhxuayG08zG2aTtFDCyVOe0Zo12uqGAh+wnPSFhEZdfYKAo oznNTcw3H5u5pnaZGHQqpoKb6ZzaCAFQEqR6DTiLWrFKN8jny7ht8XInUXFh3MxLj4L/DB7Q0HU RkllbR8EL+PEo1TPu0GqWgy7kbpl5BUMuViwKbhLxjdsSekCOSzpi+n/3/FduXy3PiGAgW8/5p2 hmKhw4mypCKiLzQ/Tu71Rx268SfMzuqrVzp0QfKS1BqTZNFyW5RcEqqWj+UXowz9dcCTjDMo9CA +OAmNJb3U
 uAooUQ==
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
 builtin/log.c           | 40 +++++++++++++++++++++++++++++++---
 t/t4014-format-patch.sh | 48 +++++++++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh   |  1 +
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0d12272031..46c8e33773 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1343,13 +1343,36 @@ static void generate_shortlog_cover_letter(struct shortlog *log,
 	shortlog_output(log);
 }
 
+static void generate_commit_list_cover(FILE *cover_file,const char *format,
+				       struct commit **list, int n)
+{
+	struct strbuf commit_line = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+	struct rev_info rev = REV_INFO_INIT;
+
+	strbuf_init(&commit_line, 0);
+	rev.total = n;
+	ctx.rev = &rev;
+	for (int i = n - 1; i >= 0; i--) {
+		rev.nr = n - i;
+		repo_format_commit_message(the_repository, list[i], format,
+				&commit_line, &ctx);
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
 	const char *committer;
 	struct shortlog log;
@@ -1396,7 +1419,12 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	free(pp.after_subject);
 	strbuf_release(&sb);
 
-	generate_shortlog_cover_letter(&log, rev, list, nr);
+	if (skip_prefix(format, "log:", &format))
+		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
+	else if (!strcmp(format, "shortlog"))
+		generate_shortlog_cover_letter(&log, rev, list, nr);
+	else
+		die(_("'%s' is not a valid format string"), format);
 
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
@@ -1914,6 +1942,7 @@ int cmd_format_patch(int argc,
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = -1;
+	const char *cover_letter_fmt = NULL;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	int zero_commit = 0;
@@ -1960,6 +1989,8 @@ int cmd_format_patch(int argc,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
+		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
+			    N_("format spec used for the commit list in the cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
@@ -2297,6 +2328,7 @@ int cmd_format_patch(int argc,
 		/* nothing to do */
 		goto done;
 	total = list.nr;
+
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
@@ -2383,12 +2415,14 @@ int cmd_format_patch(int argc,
 	}
 	rev.numbered_files = just_numbers;
 	rev.patch_suffix = fmt_patch_suffix;
+
 	if (cover_letter) {
 		if (cfg.thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
 				  origin, list.nr, list.items,
-				  description_file, branch_name, quiet, &cfg);
+				  description_file, branch_name, quiet, &cfg,
+				  cover_letter_fmt);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(signature, rev.diffopt.file);
 		total++;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 21d6d0cd9e..458da80721 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -380,6 +380,54 @@ test_expect_success 'filename limit applies only to basename' '
 	done
 '
 
+test_expect_success 'cover letter with subject, author and count' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --cover-letter \
+	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
+	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
+test_expected_success 'cover letter with author and count' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --cover-letter \
+	--cover-letter-format="log:[%(count)/%(total)] %an" -o patches HEAD~1 &&
+	grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
+test_expect_success 'cover letter shortlog' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --cover-letter --cover-letter-format=shortlog \
+	-o patches HEAD~1 &&
+	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
+test_expect_success 'cover letter no format' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --cover-letter -o patches HEAD~1 &&
+	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
 test_expect_success 'reroll count' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 964e1f1569..4f760a7468 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2774,6 +2774,7 @@ test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
 	--cover-letter Z
+	--cover-letter-format=Z
 	EOF
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
-- 
2.53.0.4.g55f3102ead

