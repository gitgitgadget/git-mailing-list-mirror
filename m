Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4248E1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 15:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936476AbeF2PPQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 11:15:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37082 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934241AbeF2PPM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 11:15:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so9195263wrp.4
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkJrOck0Et3Fc/6x0ktV1JimFoZYUs2uLn55PbrbqIg=;
        b=tH/Zvu+9ptAGLFcbfy8szQaq1nh7qVgTyomVKyKmlHWvNZ71gaQ1i1OSlIE51GeyMx
         V/mBuZ5hQnXvs5R5eDIxr3ZckQIv3u/gkYqDt1YraYOXJNW3kTOxmCrYMUkIeidha8B/
         wWyFygjrU/yMQVqMBf+TLihrKPFyHfiubj7lGSsm/IeCKl5b6Hj/Pe8+YWWXOewF7nxh
         ckW7DSU0nsI3OzzPzf7HWy79YR9CxjK7eTI8olY0LbKENl+KXkPS6YLg9pfnXpFO8FAX
         5C6RS/FVieNQE70EPpu4t1D7LHPCS0CI4hZVkBpuW3i4omoZYV19NNu9Gt1LHJbzu8j1
         t9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkJrOck0Et3Fc/6x0ktV1JimFoZYUs2uLn55PbrbqIg=;
        b=N9LPCv7c9atDuVOY1HYK0rE50ZxeKAwcW/1oOWvYNSkM4Xs64Fl5maY8SrCSawM6R6
         hfweREF67hHZYdwnuHEHpDwROqsyTjLV8QVQiC1hzR1rs5652NhDQye12PQcYBbVWrSg
         i6MtghIfkzSOEIbF9iA0JkeOikkan/KG2vtSDln0fmOXQX7WKBrKtg/LhEE2LHPL+WV0
         1fcY1T8WHKJi2yRqskXknKMjH4bbt6QeH54X01tqXMvMLb7aeDPsYgokZ68Kw85WfmCw
         XhK40gQGgkiXKnBELvBmZK1qsBdvrdO+Uq2y/0geE/SsalCyxLQgkU3vM9Tf5hR00MKu
         4rGw==
X-Gm-Message-State: APt69E0TPKVcdPIJeYNxYVpH0BvjeGQHzhg6orRpTGo2maXJcOnt+Fdj
        4uqDL0DHS3ib2+K023Rr0Cuxt3SE
X-Google-Smtp-Source: AAOMgpc0DLp3WihZoHgd8cgPykeOaMcMJCyUD+xs/9QGbX4cxYXnAf5bJmoEis3PJUh1CoN7ESxndg==
X-Received: by 2002:adf:a3c3:: with SMTP id m3-v6mr11940641wrb.208.1530285311158;
        Fri, 29 Jun 2018 08:15:11 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id l78-v6sm3301601wmb.39.2018.06.29.08.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 08:15:09 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 3/3] rebase -i: rewrite checkout_onto() in C
Date:   Fri, 29 Jun 2018 17:14:35 +0200
Message-Id: <20180629151435.31868-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629151435.31868-1-alban.gruin@gmail.com>
References: <20180625134419.18435-1-alban.gruin@gmail.com>
 <20180629151435.31868-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites checkout_onto() from shell to C.

A new command (“checkout-onto”) is added to rebase--helper.c. The shell
version is then stripped.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 25 ++++---------------------
 sequencer.c                | 19 +++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 6c789e78b..0091e094b 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -18,7 +18,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
+		CHECKOUT_ONTO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -54,6 +55,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "prepare-branch", &command,
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
+		OPT_CMDMODE(0, "checkout-onto", &command,
+			    N_("checkout a commit"), CHECKOUT_ONTO),
 		OPT_END()
 	};
 
@@ -99,5 +102,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1], verbose);
+	if (command == CHECKOUT_ONTO && argc == 4)
+		return !!checkout_onto(&opts, argv[1], argv[2], argv[3], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 77e972bb6..b68f108f2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -28,17 +28,6 @@ case "$comment_char" in
 	;;
 esac
 
-orig_reflog_action="$GIT_REFLOG_ACTION"
-
-comment_for_reflog () {
-	case "$orig_reflog_action" in
-	''|rebase*)
-		GIT_REFLOG_ACTION="rebase -i ($1)"
-		export GIT_REFLOG_ACTION
-		;;
-	esac
-}
-
 die_abort () {
 	apply_autostash
 	rm -rf "$state_dir"
@@ -70,14 +59,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-ids
 }
 
-# Switch to the branch in $into and notify it in the reflog
-checkout_onto () {
-	comment_for_reflog start
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
-	git update-ref ORIG_HEAD $orig_head
-}
-
 get_missing_commit_check_level () {
 	check_level=$(git config --get rebase.missingCommitsCheck)
 	check_level=${check_level:-ignore}
@@ -176,7 +157,8 @@ EOF
 
 	git rebase--helper --check-todo-list || {
 		ret=$?
-		checkout_onto
+		git rebase--helper --checkout-onto "$onto_name" "$onto" \
+		    "$orig_head" ${verbose:+--verbose}
 		exit $ret
 	}
 
@@ -186,7 +168,8 @@ EOF
 	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
 	die "Could not skip unnecessary pick commands"
 
-	checkout_onto
+	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
+	    ${verbose:+--verbose}
 	require_clean_work_tree "rebase"
 	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
 	     --continue
diff --git a/sequencer.c b/sequencer.c
index dd0cf3cb5..ec6de4eda 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3165,6 +3165,25 @@ int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit,
 	return 0;
 }
 
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head, unsigned verbose)
+{
+	struct object_id oid;
+	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
+
+	if (get_oid(orig_head, &oid))
+		return error(_("%s: not a valid OID"), orig_head);
+
+	if (run_git_checkout(opts, onto, verbose, action)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		return error(_("could not detach HEAD"));
+	}
+
+	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 3821420b0..ba5e59f02 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -108,6 +108,9 @@ void commit_post_rewrite(const struct commit *current_head,
 
 int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit,
 				 int verbose);
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head, unsigned verbose);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.18.0

