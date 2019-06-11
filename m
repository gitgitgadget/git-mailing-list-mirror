Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244881F609
	for <e@80x24.org>; Tue, 11 Jun 2019 13:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbfFKNDn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 09:03:43 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35803 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfFKNDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:41 -0400
Received: by mail-wr1-f53.google.com with SMTP id m3so12973167wrv.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmPOBb5BAz7NfvXvPTz+M/4cpmZMEgfRqdhhoJcpZG8=;
        b=CStoFavqxdiONR3PvGskLRyPXbUQKHfS0Qc0Rse5z2m5bzZfQDlRx0fqB37PIO61oL
         6fWgnDLu+B3ynnpA84qVAp3i5+cwsHnjGzxkEi2ZEN/hJg4qau6ftOQWm4u/fA4FHfQB
         r2tmIE+bvORCwhFf0H/QPjoaKuGOpT5/fBfHyWnL0XAWOCoqqJpEtadcajVcZ1xmDHQ9
         W3hOXdlqXgWFWtzBweSTHhTDiaJy/CvVzcnU6Ql54k5CXZ67gj9Y6m5hIna88bZ7eCF5
         UGE8ItQ+R60WPCKzGnQuMXIvmWSjWXYLXdmU5R1duIW06BHppfe9EFachnjSrRe6x+mo
         Cp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmPOBb5BAz7NfvXvPTz+M/4cpmZMEgfRqdhhoJcpZG8=;
        b=pEY4tOj0xK+D75hJ46rcRAXKVqLUnPYSmut/tnF0RpPo//GhVmDEcbDAC2nr3DGeL0
         w+nU3dO1VTL1UY3OuMx+JmhY3W6hxBaK99PehMb/a+klaCQPslwpZ/clsTJDOK6gyuQ/
         ra76Q6BFBufPeMD50SIRWNNboCsIuB6H1j4AJFmX4RCC5KSLOJJRlqPWu5qG1NGTqeWi
         X4cqJKGNwJALIQFNoHXnmZmlZg00dXOzCXS8pOh2KdYRJ1NDvpoMFV8AZNYsOnUs5lLZ
         8wB6BIC2RavHHDsmgqXJzb1e8YDwUeIJDTwuvZdstIxPaJQFqgLyNaB/i5TBeANlW58M
         FTEg==
X-Gm-Message-State: APjAAAUXd55NvjIaO50g3nVOtsGR99RzOSeZCffaO9tB0Te8ggAzkbUb
        D4FVmiBeYZkusqGzwgW+ad8=
X-Google-Smtp-Source: APXvYqx4f15xdnasX6up+oA8eo/NfdT5ovvuNn13KESey7I4HTay0R5esfyUSi7uVfXDOHQYdBy0SA==
X-Received: by 2002:adf:b6a9:: with SMTP id j41mr3765273wre.8.1560258220056;
        Tue, 11 Jun 2019 06:03:40 -0700 (PDT)
Received: from localhost.localdomain (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id l190sm2561524wml.16.2019.06.11.06.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 06:03:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Date:   Tue, 11 Jun 2019 15:03:19 +0200
Message-Id: <20190611130320.18499-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.566.g58873a45ff
In-Reply-To: <20190611130320.18499-1-szeder.dev@gmail.com>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
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
that "Rebasing (n/m)" progress line, but let's be prudent, and clear
the last line before printing these, too.

Three tests, one in 't3404-rebase-interactive.sh' and two in
't3420-rebase-autostash.sh' check the full output of 'git rebase' and
thus are affected by this change, so adjust their expectations to
account for the new line clearing.

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
 sequencer.c                   | 17 ++++++++++++++---
 t/t3404-rebase-interactive.sh |  2 +-
 t/t3420-rebase-autostash.sh   |  4 ++--
 3 files changed, 17 insertions(+), 6 deletions(-)

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
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e66e95d453..72ce9d393c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1313,7 +1313,7 @@ To avoid this message, use "drop" to explicitly remove a commit.
 Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 
-Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessfully rebased and updated refs/heads/missing-commit.
+Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
 EOF
 
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
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
2.22.0.566.g58873a45ff

