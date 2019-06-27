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
	by dcvr.yhbt.net (Postfix) with ESMTP id B237B1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF0Nm7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:42:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53317 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0Nm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:42:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so5795620wmj.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLdbW3TYozlRMcoV+XKjnGdQ2WAY3n1nWDtzqCKiqdg=;
        b=LSow6lCzi63P8YRwwfmT/bQM8KD8V6G9AxFIAVNZ4ms4GMB4K534JdgzROAuCtPSWM
         TSFto8lxwl2XXOPYOBtMAdUSy6GRjxoPxzVeLaTeKWyjY6I7lb90g2KsScIHe64sjgWS
         TDIMTW3cVqSak8QP7nz+IiNRF8OrH+DFoPnYTO+M01YIAwCHUgyrtYkNR0GsgMr40GQW
         BBjcdjN7LGoH6rHsfps67bWl9pkJuxHgtBg8k6JiMxfX5wz802Fm+AVq67Pr/wAMEHhq
         mHh5kMmhVPp6trE1klNvXkUceHyW9hZucnl3nuMEYqH81VSI7mddSI9zX5q1/9ff/Qz1
         Ck3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLdbW3TYozlRMcoV+XKjnGdQ2WAY3n1nWDtzqCKiqdg=;
        b=TeV9vgMnO2Dqmf4KURY1Vd0HfYe9T6BMRc5p9cnFC7jumwctH599euNArb8j7Z82CC
         v0tBo47uhQmCxu8SI//6NVyNYYJCzK6epg7JEBmg0Gp9ORrV7qvnA/XtTcuyrYCdDZHm
         maw5xme9ygRHy2TYn0UFmyHF0DWoDRYdDyaE98w23Nxhwi2O7qFRGJgZQysy5fPCPpSB
         Az5GhR6O1prZMEDjqLRlCVFwdfXWLbSgQrzP1BenXKaBZbEg8jhW/NrIC5IsHCH/Xq66
         EuWdFLAwNiwG8sxml0b+gzwXnj+KyS4ySs97x1oG6acAhqfOmeleF4hX22tZNYiSkAPM
         qVBw==
X-Gm-Message-State: APjAAAWg13u/NIAL1dPWqkcA17GXno3Hgarj5/Mk45jupFKonb5rbHd4
        H9pDyM4/aRC4NG/dbptOSPs=
X-Google-Smtp-Source: APXvYqyZCFS/geEgLJU6IkmKEzu4tnTf6a9nRdE42WdMbdgLc3PNqJbr6R3X0c8DaQi8YFPo+MKNIQ==
X-Received: by 2002:a1c:a783:: with SMTP id q125mr3495005wme.94.1561642975863;
        Thu, 27 Jun 2019 06:42:55 -0700 (PDT)
Received: from localhost.localdomain (x4d0c4603.dyn.telefonica.de. [77.12.70.3])
        by smtp.gmail.com with ESMTPSA id v65sm6024968wme.31.2019.06.27.06.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jun 2019 06:42:55 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3.1 4/5] rebase: fix garbled progress display with '-x'
Date:   Thu, 27 Jun 2019 15:42:48 +0200
Message-Id: <20190627134248.28469-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190624181318.17388-5-szeder.dev@gmail.com>
References: <20190624181318.17388-5-szeder.dev@gmail.com>
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
previous patch.  Do so only when not being '--verbose', because in
that case these "Rebasing (N/M)" lines are not printed as progress
(i.e. as lines with '\r' at the end), but as "regular" output (with
'\n' at the end).

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
"Auto-merging <file>" message from within the depths of the merge
machinery might not be long enough to completely cover the last
"Rebasing (N/M)" line.  This patch doesn't do anything about them,
because dealing with them individually would result in way too much
churn, while having a catch-all term_clear_line() call in the common
code path of pick_commits() would hide the "Rebasing (N/M)" line way
too soon, and it would either flicker or be invisible.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

The exact same patch with a slightly updated commit message to address

  https://public-inbox.org/git/xmqqy327kfw1.fsf@gitster-ct.c.googlers.com/

and to fix a typo.

Range-diff:
1:  4372a3cde4 = 1:  4372a3cde4 t3404: modernize here doc style
2:  5444f547c5 = 2:  5444f547c5 t3404: make the 'rebase.missingCommitsCheck=ignore' test more focused
3:  5ebf218cb9 = 3:  5ebf218cb9 pager: add a helper function to clear the last line in the terminal
4:  51cd5ccd46 ! 4:  652b69d0dd rebase: fix garbled progress display with '-x'
    @@ -33,7 +33,10 @@
     
         Make sure that the previously displayed "Rebasing (N/M)" line is
         cleared by using the term_clear_line() helper function added in the
    -    previous patch.
    +    previous patch.  Do so only when not being '--verbose', because in
    +    that case these "Rebasing (N/M)" lines are not printed as progress
    +    (i.e. as lines with '\r' at the end), but as "regular" output (with
    +    '\n' at the end).
     
         A couple of other rebase commands print similar messages, e.g.
         "Stopped at <abbrev-oid>... <subject>" for the 'edit' or 'break'
    @@ -49,7 +52,7 @@
     
         Note that this patch doesn't completely eliminate the possibility of
         similar garbled outputs, e.g. some error messages from rebase or the
    -    "Auto-merging <file>" message from withing the depths of the merge
    +    "Auto-merging <file>" message from within the depths of the merge
         machinery might not be long enough to completely cover the last
         "Rebasing (N/M)" line.  This patch doesn't do anything about them,
         because dealing with them individually would result in way too much
5:  09642a458e = 5:  313ce83d0a progress: use term_clear_line()


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

