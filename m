Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DFF71F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937243AbeE3IE0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:04:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54754 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936033AbeE3IEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:04:15 -0400
Received: by mail-it0-f68.google.com with SMTP id 76-v6so6831428itx.4
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2s5nM9ARRWuBoLEAU5X6dOHRY7GbIpAciNFQNfvv7HQ=;
        b=qw93M3ZVGnscCHbON6QKRCYG69rMfZjcQKFSW6F6sEmMPLbqYaodhB6oN58b5cIxcK
         YfLrlx2elto9mrOM5Hxh4Xi6xTjU2QB1mQHjpdRnWBNHTLyums0pNAnbBofCiRnVheW9
         p3J32/EUzfEYp8o1/THA4iIz+/e4Yx+oRpTyxUbbworzD/vj9JxsuNOAHArza7t80yrH
         SFQaO+/BhPovSQ2AE5jIWHIgzi5qWV/7Zqs9mnRgMDNFz+iI1wGPsLKYDZE6gJczTPOa
         qhV4v5E9moaw+k9cBsgv9d80AU0IgkpDPOldphU3cJEmTdWUxFCW1nCVYL04DL5iSl08
         CTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2s5nM9ARRWuBoLEAU5X6dOHRY7GbIpAciNFQNfvv7HQ=;
        b=LmCqR3uHg57/Zt+/beQsWwOLbiuau9cnsRaAwAUyfoPPAPVf5Cg93g3x9iUBej9g+T
         evtis6A4IGqrEeMhLsoiTuZghVLagnDR8DOns1e9f9D8Q6i21Z4gSUwKfasGfYzQvfDS
         RMMFDcyVzriK1sB1aBp1s6tAAqaasoa6dvUil+3wU7LXniWlLoUtwEM9ds2+IQuKe5f7
         ACnjw4n6JOBRA46jaJUA19n1U/TFKdAXwzD/lIS2ycNUOIReH5rfb8EFX3Cl6LDMEO6w
         kW5y6IZJGdTOtZV9GQbCV/0fzbFpRJMzYilmsukJ6RSBaQeNAimGfmHWtO/lKDd6yuiv
         H7Cg==
X-Gm-Message-State: APt69E2MpX44Kjd3z76kOyGlMrvgyV9fxj+L9So7Sex0C6GbvepKqMxB
        qsPzBbE1mBJrS3uzDaswQ4Rz0Q==
X-Google-Smtp-Source: ADUXVKKXj0Ur4PytbK0A0wy8t+fIH4Vj6VgllLDPyTUx5QN2m8AHx/ocZg+6DJdrru5voU6yL9xcRw==
X-Received: by 2002:a24:cac7:: with SMTP id k190-v6mr661975itg.62.1527667454010;
        Wed, 30 May 2018 01:04:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id t9-v6sm17447561ioa.82.2018.05.30.01.04.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 30 May 2018 01:04:13 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH 2/5] format-patch: add --range-diff option to embed diff in cover letter
Date:   Wed, 30 May 2018 04:03:22 -0400
Message-Id: <20180530080325.37520-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.1.1235.ge295dfb56e
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting a revised version of a patch series, it can be helpful
(to reviewers) to include a summary of changes since the previous
attempt in the form of an interdiff or range-diff, however, doing so
involves manually copy/pasting the diff into the cover letter.

Add a --range-diff option to automate this process for range-diffs. The
argument to --range-diff specifies the tip of the previous attempt
against which to generate the range-diff. For example:

    git format-patch --cover-letter --range-diff=v1 -3 v2

(At this early stage, the previous attempt and the patch series being
formatted must share a common base, however, a subsequent enhancement
will make it possible to specify an explicit revision range for the
previous attempt.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt | 10 ++++++
 builtin/log.c                      | 55 ++++++++++++++++++++++++++++--
 t/t7910-branch-diff.sh             | 15 ++++++++
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6cbe462a77..f4c70e6b64 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--range-diff=<previous>]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -228,6 +229,15 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--range-diff=<previous>::
+	As a reviewer aid, insert a range-diff (see linkgit:git-branch-diff[1])
+	into the cover letter showing the differences between the previous
+	version of the patch series and the series currently being formatted.
+	`previous` is a single revision naming the tip of the previous
+	series which shares a common base with the series being formatted (for
+	example `git format-patch --cover-letter --range-diff=feature/v1 -3
+	feature/v2`).
+
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
diff --git a/builtin/log.c b/builtin/log.c
index e01a256c11..460c31a293 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -28,6 +28,7 @@
 #include "mailmap.h"
 #include "gpg-interface.h"
 #include "progress.h"
+#include "run-command.h"
 
 #define MAIL_DEFAULT_WRAP 72
 
@@ -992,6 +993,25 @@ static char *find_branch_name(struct rev_info *rev)
 	return branch;
 }
 
+static void infer_diff_ranges(struct argv_array *args,
+			      const char *prev,
+			      struct commit *head)
+{
+	argv_array_pushf(args, "%s...%s", prev,
+			 oid_to_hex(&head->object.oid));
+}
+
+static int get_range_diff(struct strbuf *sb,
+			  const struct argv_array *ranges)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "branch-diff", "--no-color", NULL);
+	argv_array_pushv(&cp.args, ranges->argv);
+	return capture_command(&cp, sb, 0);
+}
+
 static void emit_diffstat(struct rev_info *rev,
 			  struct commit *origin, struct commit *head)
 {
@@ -1016,7 +1036,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
-			      int quiet)
+			      int quiet,
+			      const char *range_diff)
 {
 	const char *committer;
 	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
@@ -1028,15 +1049,25 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	int need_8bit_cte = 0;
 	struct pretty_print_context pp = {0};
 	struct commit *head = list[0];
+	struct strbuf diff = STRBUF_INIT;
 
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("Cover letter needs email format"));
 
 	committer = git_committer_info(0);
 
+	/* might die from bad user input so try before creating cover letter */
+	if (range_diff) {
+		struct argv_array ranges = ARGV_ARRAY_INIT;
+		infer_diff_ranges(&ranges, range_diff, head);
+		if (get_range_diff(&diff, &ranges))
+			die(_("failed to generate range-diff"));
+		argv_array_clear(&ranges);
+	}
+
 	if (!use_stdout &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
-		return;
+		goto done;
 
 	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte);
 
@@ -1077,6 +1108,17 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
 		emit_diffstat(rev, origin, head);
+
+	if (diff.len) {
+		FILE *fp = rev->diffopt.file;
+		fputs(_("Changes since previous version:"), fp);
+		fputs("\n\n", fp);
+		fputs(diff.buf, fp);
+		fputc('\n', fp);
+	}
+
+done:
+	strbuf_release(&diff);
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1438,6 +1480,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct base_tree_info bases;
 	int show_progress = 0;
 	struct progress *progress = NULL;
+	const char *range_diff = NULL;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1511,6 +1554,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_BOOL(0, "progress", &show_progress,
 			 N_("show progress while generating patches")),
+		OPT_STRING(0, "range-diff", &range_diff, N_("rev-range"),
+			   N_("show changes against <rev-range> in cover letter")),
 		OPT_END()
 	};
 
@@ -1733,6 +1778,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (numbered)
 		rev.total = total + start_number - 1;
 
+	if (range_diff && !cover_letter)
+		die(_("--range-diff requires --cover-letter"));
+
 	if (!signature) {
 		; /* --no-signature inhibits all signatures */
 	} else if (signature && signature != git_version_string) {
@@ -1764,7 +1812,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, quiet,
+				  range_diff);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
diff --git a/t/t7910-branch-diff.sh b/t/t7910-branch-diff.sh
index a7fece8804..edbd69b6f8 100755
--- a/t/t7910-branch-diff.sh
+++ b/t/t7910-branch-diff.sh
@@ -141,4 +141,19 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+format_patch () {
+	title=$1 &&
+	range=$2 &&
+	test_expect_success "format-patch --range-diff ($title)" '
+		git format-patch --stdout --cover-letter --range-diff=$range \
+			master..unmodified >actual &&
+		grep "= 1: .* s/5/A" actual &&
+		grep "= 2: .* s/4/A" actual &&
+		grep "= 3: .* s/11/B" actual &&
+		grep "= 4: .* s/12/B" actual
+	'
+}
+
+format_patch 'B...C' topic
+
 test_done
-- 
2.17.1.1235.ge295dfb56e

