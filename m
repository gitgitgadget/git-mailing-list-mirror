Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7935F606
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837946; cv=none; b=ia+VT3jKjHyG+B0wgULk3rKEqJX+ESPhEVC/cP0sWYZ16Bokdlk7HLGhXYFQEhvEmZV2DKEWgM6avD99nh0H/6on2dJtUfhofE6/tSpZoSalA7YUv0qWX8wMFKgY2bEDWzoxQZvM9sgQDI1vaqOSs+mLDvFvMlhlh3D/SQ7mpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837946; c=relaxed/simple;
	bh=Ux+hLSwOtIBXFg1U3kgEIaD/YoPkbv0s0f7ueiFpLF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBamTAeko51qi07iX10vg2ZLXYnq94YrC4+IAdT04ze2MogTC9EtPJgBVEwy1w8Kq3BMdgqf6ZMhixFMx51O08ZsU0Lg5G4ei7m4pEonvasvxPj5L1Tx1O3gD4JDtAxUnjBaTtLLDDFBb6SQpNCDF2Xtd9RfZsCVNlpx0XH9rcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=U4C5++Fl; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="U4C5++Fl"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772837942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXW+PM8yqDY784bW0Z2rijGxX96IE7dedIK+Knq6cP4=;
	b=U4C5++FlnudgxxH3NEhVvfvxkyq0M2FFUatT2E8zViPhjDNHhP+devwR8GopRM8TlmHFBX
	tWanYCgOSNtG+Y+4hl1hZbDobZHeKZgJqWhfa8Fn7V3cp61+sZQkJQEVaSFgH2/jw58Gvz
	AYZBFLf5+gSdwnkQEBvyhKqiD2zGlJpba4o/gnavQPh5aqGp/ZkRpt78PANXZkLtXt7TYA
	zy4eqHKmoV+o596U3UuTVoPkwNjZVj4DeZm10OanB4SCSg9ebzvQoKXMx3pkZsV2EwQfvx
	QWpVFRLx7s4Pqh4T2P/MfHRLPdJM3UQZ+4DeLg08NrftnUGo5UhDwHO5iH13gg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v6 3/5] format-patch: add ability to use alt cover format
Date: Fri,  6 Mar 2026 23:58:46 +0100
Message-ID: <316c9e76ee49d73aff75b63299c970e9f55f79b6.1772837832.git.mroik@delayed.space>
In-Reply-To: <cover.1772837832.git.mroik@delayed.space>
References: <cover.1772232373.git.mroik@delayed.space> <cover.1772837832.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7428; i=mroik@delayed.space; h=from:subject:message-id; bh=Ux+hLSwOtIBXFg1U3kgEIaD/YoPkbv0s0f7ueiFpLF4=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq1v9m1FnKLvdbxszJYXtjABfp5h6u0z8/2lmo v33OQ0Pr1KJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatb/QAKCRBIeX6hnBm+ 0XY/EACYWA7ZG/VCgX8B4GCZijispF6J355ZA7DdP370JJwTkA10sErDAdSCO8ekAqk921PalqR WRSYLaq/iojdK2n3l/K40shbD8w/3d6CpF9VHNC5KYHUL6swRlsZDR22Is58y6m6Vf5uOqYGLl6 WSvUE1v7j9SramPJNsoPLUpTH5HQ7yCXjsnPG84yJ5uNkskSyujVzMNTGjjOpjWcfb1nqy3offs UnWPoQL1/vGRkW71JrGLZaXU2U34SAArhzTLnJNG7IyzeXiMvR5ZCA6GLZNuzrxnzZbi5p6DOBN KYQGOc5s0H4LgCmL1Y2BL/gPHQGluuUKZHlRAk/jAeG1VsO2QAPaobZtsqddznljgb2kWrYq1J9 UhK4g2I2FmA5dG/kMhCh1f3of2BDygjPOtefRBd5f7yy9CvWJ44n1zuGqikfJbGi7EWvuHQnFpd 9di9Y+Jb1pneOvvezoZzO2VCHc2IW22QQeX+ejTehuAPw3nd9mSWxvAHOjqdNwUKINLL1Nkyrs7 okQSK24IZBl5QGmrapNTfrTpOPuhT/GMfPc+6AhskkIKj0m9pM9khmDbF2jMDv17i7obb3RE0GK GkFNBNMfxBJhcL4/XwHZQ/x096y9y+2T1TI45+RGSevlEXpBw8kU3Ejl653PlU6MzFuxI8+6W+Q 3RXl6U/eR
 Uupb5w==
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

Give format-patch the ability to specify an alternative format spec
through the "--cover-letter-format" option. This option either takes
"shortlog", which is the current format, or a format spec prefixed with
"log:".

Example:
    git format-patch --cover-letter \
        --cover-letter-format="log:[%(count)/%(total)] %s (%an)" HEAD~3

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
index 0d12272031..95e5d9755f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1343,13 +1343,36 @@ static void generate_shortlog_cover_letter(struct shortlog *log,
 	shortlog_output(log);
 }
 
+static void generate_commit_list_cover(FILE *cover_file, const char *format,
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
2.53.0.5.g1a4ba6dc33

