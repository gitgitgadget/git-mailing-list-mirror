Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0906020248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfBVULW (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:11:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51466 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfBVULW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:11:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so3039788wmi.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MYg+qRPhzgJQ5b9SjZSbZuWQ/CsSGE+0ce2fhPvM/X8=;
        b=BWpsUmTErhMADcEQq93COE0NtRBI3PGgWEuZUtWm9cly8JaRq3jxvF+5najWAKX4TJ
         eyoI+IB8gfC1ylt9Y34qJbvohkMlUlRPo3MTK/jCf+4j0hh4iUilx2+E6kGvj55RUGKY
         8ttQtBARg/HJon6zCYh3mqdlQYLr+Mnr4QIoMu6Wd8nZCKIKIjpGi5jc5Jg2mTRbJGkc
         e/Q38BTq8yGBCrZP6nRJyjGsIpiU2NQM6OK2f4y4NlGZVzkW/nMSX1Vg/Ju/uMpaRdFm
         NMzYSvudt1NoGgcOG7K9qJPdYjJQ4Dl4CJe14BJ60YRg9lrV+hYnCRMjz3ShF52Ag1qW
         KLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MYg+qRPhzgJQ5b9SjZSbZuWQ/CsSGE+0ce2fhPvM/X8=;
        b=WegAi8J04e/sUJN96Cyoi9T1qmjKuUFB0otjqVl+YxWjSQ3+4xtaQ3WojhoAODSYSt
         isL1rm2kR++MrGNfymD0VzUqQKPueaT69h8rEFQCY08tPN+aKwaVdwxnXGebsw2BUHqa
         IGWCmJOu0ly6jKuUsJEqmD4i6AimBjJSBE7+9zzgAOU+1HfSM/alGT0WMu6OYLhTAyRe
         4YCXKYtUfZQJh8ziRgwaTV39Gr0q2AhIs8wyilUn2x05EDCJPImbOVeD015Ap8NgmmPP
         iEY9Cl6oO4sKrnvkxiDbxjPIg/elIFDI7JiOl4/RYUjQ1SL2qHhCarx2UtOmDgkmmKIL
         zuTg==
X-Gm-Message-State: AHQUAuYSqrhHiboMlgTyzuf/UedlkJEKkezKyHyZQgkYbK6es9juJMe3
        l7DpE/LpiDLCE2Vu127pwfJ7jezI
X-Google-Smtp-Source: AHgI3IZmoxyJY90dnCyWWBLppilldHq5rliddjD+qnslBd6KDgd64wWfdNBdwC01w3c6BDIHaWoHQw==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr3464541wmm.103.1550866279644;
        Fri, 22 Feb 2019 12:11:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a1sm3288830wrq.96.2019.02.22.12.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:11:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] format-patch: --no-clobber refrains from overwriting output files
Date:   Fri, 22 Feb 2019 12:11:11 -0800
Message-Id: <20190222201111.98196-4-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-rc2
In-Reply-To: <20190222201111.98196-1-gitster@pobox.com>
References: <20190222201111.98196-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you keep an output for an older iteration of the same topic in
the same directory around and use "git format-patch" to prepare a
newer iteration of the topic, those commits that happen to be at the
same position in the series that have not been retitled will get the
same filename---and the command opens them for writing without any
check.

Existing "-o outdir" and "-v number" options are both good ways to
avoid such name collisions, and in general helps to give good ways
to compare the latest iteration with older iteration(s), but let's
see if "--no-clobber" option that forbids overwrting existing files
would also help people.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt |  8 +++++++-
 builtin/log.c                      | 32 ++++++++++++++++++++++++------
 t/t4014-format-patch.sh            | 16 +++++++++++++++
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..540822b3b4 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -25,7 +25,7 @@ SYNOPSIS
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
-		   [--progress]
+		   [--progress] [--[no-]clobber]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -93,6 +93,12 @@ include::diff-options.txt[]
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
 
+--clobber::
+--no-clobber::
+	(experimental)
+	Allow overwriting existing files, which is the default.  To
+	make the command refrain from overwriting, use `--no-clobber`.
+
 -n::
 --numbered::
 	Name output in '[PATCH n/m]' format, even with a single patch.
diff --git a/builtin/log.c b/builtin/log.c
index ca86611efe..7421f1cc93 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -867,8 +867,16 @@ static int git_format_config(const char *var, const char *value, void *cb)
 static const char *output_directory = NULL;
 static int outdir_offset;
 
+static FILE *fopen_excl(const char *filename)
+{
+	int fd = open(filename, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	if (fd < 0)
+		return NULL;
+	return fdopen(fd, "w");
+}
+
 static int open_next_file(struct commit *commit, const char *subject,
-			 struct rev_info *rev, int quiet)
+			  struct rev_info *rev, int quiet, int clobber)
 {
 	struct strbuf filename = STRBUF_INIT;
 	int suffix_len = strlen(rev->patch_suffix) + 1;
@@ -893,7 +901,12 @@ static int open_next_file(struct commit *commit, const char *subject,
 	if (!quiet)
 		printf("%s\n", filename.buf + outdir_offset);
 
-	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL) {
+	if (clobber)
+		rev->diffopt.file = fopen(filename.buf, "w");
+	else
+		rev->diffopt.file = fopen_excl(filename.buf);
+
+	if (!rev->diffopt.file) {
 		error_errno(_("cannot open patch file %s"), filename.buf);
 		strbuf_release(&filename);
 		return -1;
@@ -1030,7 +1043,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
-			      int quiet)
+			      int quiet,
+			      int clobber)
 {
 	const char *committer;
 	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
@@ -1049,7 +1063,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	committer = git_committer_info(0);
 
 	if (!use_stdout &&
-	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
+	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter",
+			   rev, quiet, clobber))
 		die(_("failed to create cover-letter file"));
 
 	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte, 0);
@@ -1509,6 +1524,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int use_patch_format = 0;
 	int quiet = 0;
+	int clobber = 1;
 	int reroll_count = -1;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
@@ -1595,6 +1611,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_BOOL(0, "progress", &show_progress,
 			 N_("show progress while generating patches")),
+		OPT_BOOL(0, "clobber", &clobber,
+			 N_("allow overwriting output files")),
 		OPT_CALLBACK(0, "interdiff", &idiff_prev, N_("rev"),
 			     N_("show changes against <rev> in cover letter or single patch"),
 			     parse_opt_object_name),
@@ -1885,7 +1903,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name,
+				  quiet, clobber);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
@@ -1940,7 +1959,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!use_stdout &&
-		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
+		    open_next_file(rev.numbered_files ? NULL : commit, NULL,
+				   &rev, quiet, clobber))
 			die(_("failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
 		free_commit_buffer(the_repository->parsed_objects,
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b6e2fdbc44..384a1fd9e7 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -595,6 +595,22 @@ test_expect_success 'failure to write cover-letter aborts gracefully' '
 	test_must_fail git format-patch --no-renames --cover-letter -1
 '
 
+test_expect_success 'refrain from overwriting a patch with --no-clobber' '
+	rm -f 000[01]-*.patch &&
+	git format-patch --no-clobber --no-renames --cover-letter -1 >filelist &&
+	# empty the files output by the command ...
+	for f in $(cat filelist)
+	do
+		: >"$f" || return 1
+	done &&
+	test_must_fail git format-patch --no-clobber --cover-letter --no-renames -1 &&
+	# ... and make sure they stay empty
+	for f in $(cat filelist)
+	do
+		! test -s "$f" || return 1
+	done
+'
+
 test_expect_success 'cover-letter inherits diff options' '
 	git mv file foo &&
 	git commit -m foo &&
-- 
2.21.0-rc2

