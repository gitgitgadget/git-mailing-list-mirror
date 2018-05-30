Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1AA1F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964896AbeE3IEn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:04:43 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35340 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935429AbeE3IER (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:04:17 -0400
Received: by mail-it0-f68.google.com with SMTP id q72-v6so22313994itc.0
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rkYclDMN+DBjbXiqZyvuyu+PO/4+SUw9+NxwldbFZtA=;
        b=uGWDIf2/l3xMVHJRhAMZNSsNwb1smPizmqouRznFh6vp6fOhlR3En6kg1SHjqzbaI0
         6ZjY9c2YDc0cdlUQKmEzbHa8qq+El4r4XoAaSK65f2TJf+OtRXqm3kKoK6FLyQCMzDpP
         Hyu/IMmUnF7rbWoTl1je11umXo8laczxREcjImcwQo84b+fjApqdJy7tDTxl90GBjjU3
         V2nH0I6D/+Vu3KrWZTTQbssHcx5As3dffbbhhnGcoU7BbhNqPWJvaH0P7uvhGr0h7Llj
         hz6yIfzMzqFrxzilCZj1P9GBbbEgV64k9KXRVhdoYwxh8c133ZBmgJYgV3UFQHtbunHb
         4UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rkYclDMN+DBjbXiqZyvuyu+PO/4+SUw9+NxwldbFZtA=;
        b=mLfxEvQTyfruLOMjR06XuMgry0jzKX1eFYDnD6TW7mar90sh5WAdG5GSYnJR4yyiGN
         Y/ZOBq2MA9L8oApDIgQ+AbPD53KP6+P8sibIGJ9LI9fukUfFhJKxOBlAuGhLQq2+nore
         eQrU9zk/SHwH1+02i2EPmDixSBkgBF2Qt+R4p6dcAsYf+pAtI7jTN2UctWail8XFSzyS
         bMiMqNiqvE0HHPr04L0MkH5hy9/epSsMHjra1gPRLdnn40cEtvWbsw9zaLIqOMCqAJ05
         R46d/PR9HDjiPJhKHjgyMoHuXEAtSipZK5mzzSeeA/Sq+XMg+LHOK24XG8BNrHPsA/8j
         bmDA==
X-Gm-Message-State: APt69E0PmaQjiyr/9nn1j6ebTCRtPDt3jnuKyxysPFCcDvKIt+WRg28/
        lC+AL/WsTpOxqckQNgj0ZJgxIw==
X-Google-Smtp-Source: ADUXVKIc9YehbjT+JMB3uJYQ78rHt36BYOqR8CKEGsOecn27xqkuPciPPXRTwbhfxPlEAXebOPQMig==
X-Received: by 2002:a24:2706:: with SMTP id g6-v6mr742966ita.5.1527667456772;
        Wed, 30 May 2018 01:04:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id t9-v6sm17447561ioa.82.2018.05.30.01.04.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 30 May 2018 01:04:16 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH 5/5] format-patch: add --creation-weight tweak for --range-diff
Date:   Wed, 30 May 2018 04:03:25 -0400
Message-Id: <20180530080325.37520-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.1.1235.ge295dfb56e
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating a range-diff, matching up commits between two version of
a patch series involves heuristics, thus may give unexpected results.
git-branch-diff allows tweaking the heuristic via --creation-weight.
Follow suit by accepting --creation-weight in combination with
--range-diff when generating a range-diff for a cover-letter.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt |  8 +++++++-
 builtin/log.c                      | 19 +++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 25026ae26e..7ed9ec9dae 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -23,7 +23,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
-		   [--range-diff=<previous>]
+		   [--range-diff=<previous> [--creation-weight=<factor>]]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -240,6 +240,12 @@ feeding the result to `git send-email`.
 	disjoint (for example `git format-patch --cover-letter
 	--range-diff=feature/v1~3..feature/v1 -3 feature/v2`).
 
+--creation-weight=<factor>::
+	Used with `--range-diff`, tweak the heuristic which matches up commits
+	between the previous and current series of patches by adjusting the
+	creation/deletion cost fudge factor. See linkgit:git-branch-diff[1])
+	for details.
+
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
diff --git a/builtin/log.c b/builtin/log.c
index 3089d3a50a..2c49011b51 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1012,12 +1012,16 @@ static void infer_diff_ranges(struct argv_array *args,
 }
 
 static int get_range_diff(struct strbuf *sb,
-			  const struct argv_array *ranges)
+			  const struct argv_array *ranges,
+			  const char *creation_weight)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
 	cp.git_cmd = 1;
 	argv_array_pushl(&cp.args, "branch-diff", "--no-color", NULL);
+	if (creation_weight)
+		argv_array_pushf(&cp.args,
+				 "--creation-weight=%s", creation_weight);
 	argv_array_pushv(&cp.args, ranges->argv);
 	return capture_command(&cp, sb, 0);
 }
@@ -1047,7 +1051,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int nr, struct commit **list,
 			      const char *branch_name,
 			      int quiet,
-			      const char *range_diff)
+			      const char *range_diff,
+			      const char *creation_weight)
 {
 	const char *committer;
 	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
@@ -1070,7 +1075,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (range_diff) {
 		struct argv_array ranges = ARGV_ARRAY_INIT;
 		infer_diff_ranges(&ranges, range_diff, origin, head);
-		if (get_range_diff(&diff, &ranges))
+		if (get_range_diff(&diff, &ranges, creation_weight))
 			die(_("failed to generate range-diff"));
 		argv_array_clear(&ranges);
 	}
@@ -1495,6 +1500,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int show_progress = 0;
 	struct progress *progress = NULL;
 	const char *range_diff = NULL;
+	const char *creation_weight = NULL;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1570,6 +1576,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			 N_("show progress while generating patches")),
 		OPT_STRING(0, "range-diff", &range_diff, N_("rev-range"),
 			   N_("show changes against <rev-range> in cover letter")),
+		OPT_STRING(0, "creation-weight", &creation_weight, N_("factor"),
+			   N_("fudge factor by which creation is weighted")),
 		OPT_END()
 	};
 
@@ -1664,6 +1672,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die (_("--subject-prefix/--rfc and -k are mutually exclusive."));
 	rev.preserve_subject = keep_subject;
 
+	if (creation_weight && !range_diff)
+		die(_("--creation-weight requires --range-diff"));
+
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
 		die (_("unrecognized argument: %s"), argv[1]);
@@ -1827,7 +1838,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet,
-				  range_diff);
+				  range_diff, creation_weight);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
-- 
2.17.1.1235.ge295dfb56e

