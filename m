Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7B41F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfFXSNd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:13:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33515 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfFXSNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:13:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so14973184wru.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65rO36WSLnylF4hXcIFmcOqhzVCiWoecYPeejmt35hU=;
        b=U0TKHFzuubx48q5xaDxnljajzLuAisP/HJQCYl1nBWZ1EzpQTtGCMNQxcutLNYt3wM
         2Vo9+YJe5d5LKasUZCAoc5nkMdCAbEcAjTy1wH5/BgbKnQ8uHuOEZO7tyHSFcIo4/fcc
         iqiWVQJ5BxKagyRTBMSG/1WdY2rDqhirVNcP/KW46E+61hB065I1E1fFSaJI4bEOcQXP
         PkA43227toK2Vo2ivMrh08qhSfdWOZUkYPp05XjbvMs9MVcOXoBo9eh/xeKGY7Jt2s/u
         iKzXXlqiar1EbPeVoWbI/w1bLil2nvpyhdq2wXknm1IrOiy4cZY5rtGIMgW5+Gf0c8i9
         I9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65rO36WSLnylF4hXcIFmcOqhzVCiWoecYPeejmt35hU=;
        b=IaB5SA44Ra2B4DHVFhYwrIg5addseeFWiBX8MVOy/MJiuSXthY3mBzdkZ1xecuYMjL
         0dwykaV+MDUaTJAGcOi7JhBRSvtlocKUzpw0FXXALhbg87r+6Y4Z2GTIU+3BsRCVDdhU
         4JiW01RBkTsgHhOJwbfRLN7eGQAgOPp7D4muoPq36jaQTBfdZLoAtFkvQ66h80ggn9FT
         vii9+pSUhspsgeDLYkb4LIx1IxhLQCHgc8Pzhf+K0M+zs6n2VqdtXVc622+YKudQrWWC
         DEoh4lgKDS1U6Owk91ouer3H8DV1WBA8rZSJD3We7tuZkLxTOt+9Dr4uUoJ7JlTqjHk9
         2RUA==
X-Gm-Message-State: APjAAAWmKb+YUkZszlvEixz3g4c13luCKUf4nCectJRDOwlk0IhcTiyn
        QqCFfL589I8BFh1SZadDbEVirpAL
X-Google-Smtp-Source: APXvYqxvMiufxCC5/Q3o1ZuMxCzf9X/X9aU6hmoxpsIzaumNaQSZU8u73qAuJX0Cnr8YGQZXpw0Xqg==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr40722154wrt.20.1561400009667;
        Mon, 24 Jun 2019 11:13:29 -0700 (PDT)
Received: from localhost.localdomain (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id v65sm401349wme.31.2019.06.24.11.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 11:13:28 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/5] rebase: fix garbled progress display with '-x'
Date:   Mon, 24 Jun 2019 20:13:17 +0200
Message-Id: <20190624181318.17388-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190624181318.17388-1-szeder.dev@gmail.com>
References: <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190624181318.17388-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a command with the 'exec' instruction during an
interactive rebase session, or for a range of commits using 'git
rebase -x', the output can be a bit garbled when the name of the
command is short enough:

  $ git rebase -x true HEAD~5
  Executing: true
  Executing: true
  Executing: true
  Executing: true
  Executing: true)
  Successfully rebased and updated refs/heads/master.

Note the ')' at the end of the last line.  It gets more garbled as the
range of commits increases:

  $ git rebase -x true HEAD~50
  Executing: true)
  [ repeated 3 more times ]
  Executing: true0)
  [ repeated 44 more times ]
  Executing: true00)
  Successfully rebased and updated refs/heads/master.

Those extra numbers and ')' are remnants of the previously displayed
"Rebasing (N/M)" progress lines that are usually completely
overwritten by the "Executing: <cmd>" lines, unless 'cmd' is short and
the "N/M" part is long.

Make sure that the previously displayed "Rebasing (N/M)" line is
cleared by using the term_clear_line() helper function added in the
previous patch.

A couple of other rebase commands print similar messages, e.g.
"Stopped at <abbrev-oid>... <subject>" for the 'edit' or 'break'
commands, or the "Successfully rebased and updated <full-ref>." at the
very end.  These are so long that they practically always overwrite
that "Rebasing (N/M)" progress line, but let's be prudent, and clear
the last line before printing these, too.

In 't3420-rebase-autostash.sh' two helper functions prepare the
expected output of four tests that check the full output of 'git
rebase' and thus are affected by this change, so adjust their
expectations to account for the new line clearing.

Note that this patch doesn't completely eliminate the possibility of
similar garbled outputs, e.g. some error messages from rebase or the
"Auto-merging <file>" message from withing the depths of the merge
machinery might not be long enough to completely cover the last
"Rebasing (N/M)" line.  This patch doesn't do anything about them,
because dealing with them individually would result in way too much
churn, while having a catch-all term_clear_line() call in the common
code path of pick_commits() would hide the "Rebasing (N/M)" line way
too soon, and it would either flicker or be invisible.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 sequencer.c                 | 17 ++++++++++++++---
 t/t3420-rebase-autostash.sh |  4 ++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..63b09cfceb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3731,8 +3731,11 @@ static int pick_commits(struct repository *r,
 			unlink(git_path_merge_head(the_repository));
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
-			if (item->command == TODO_BREAK)
+			if (item->command == TODO_BREAK) {
+				if (!opts->verbose)
+					term_clear_line();
 				return stopped_at_head(r);
+			}
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
@@ -3754,11 +3757,14 @@ static int pick_commits(struct repository *r,
 			}
 			if (item->command == TODO_EDIT) {
 				struct commit *commit = item->commit;
-				if (!res)
+				if (!res) {
+					if (!opts->verbose)
+						term_clear_line();
 					fprintf(stderr,
 						_("Stopped at %s...  %.*s\n"),
 						short_commit_name(commit),
 						item->arg_len, arg);
+				}
 				return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
 			}
@@ -3796,6 +3802,8 @@ static int pick_commits(struct repository *r,
 			int saved = *end_of_arg;
 			struct stat st;
 
+			if (!opts->verbose)
+				term_clear_line();
 			*end_of_arg = '\0';
 			res = do_exec(r, arg);
 			*end_of_arg = saved;
@@ -3954,10 +3962,13 @@ static int pick_commits(struct repository *r,
 		}
 		apply_autostash(opts);
 
-		if (!opts->quiet)
+		if (!opts->quiet) {
+			if (!opts->verbose)
+				term_clear_line();
 			fprintf(stderr,
 				"Successfully rebased and updated %s.\n",
 				head_ref.buf);
+		}
 
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 2d1094e483..9186e90127 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -49,7 +49,7 @@ create_expected_success_interactive () {
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	HEAD is now at $(git rev-parse --short feature-branch) third commit
 	Rebasing (1/2)QRebasing (2/2)QApplied autostash.
-	Successfully rebased and updated refs/heads/rebased-feature-branch.
+	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
 
@@ -73,7 +73,7 @@ create_expected_failure_interactive () {
 	Rebasing (1/2)QRebasing (2/2)QApplying autostash resulted in conflicts.
 	Your changes are safe in the stash.
 	You can run "git stash pop" or "git stash drop" at any time.
-	Successfully rebased and updated refs/heads/rebased-feature-branch.
+	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
 
-- 
2.22.0.589.g5bd7971b91

