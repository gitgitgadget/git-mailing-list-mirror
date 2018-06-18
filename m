Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BA51F403
	for <e@80x24.org>; Mon, 18 Jun 2018 13:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933895AbeFRNTV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 09:19:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43474 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeFRNTU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 09:19:20 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so16796253wrm.10
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJSkxahiKZ1UBArFIAVh8oQXcW2VhByouzTjlDN7+KA=;
        b=QK8F9RpcpoKYs8UAJluhPHOqiFwl0sV7SLEnw1UKbuEpIAegBL7yAMYRDEWWDH3oBM
         znXOyMluAaqCcQICup27mi9AcDJXI3+MMYRs8mvEzpFpkWCDNeZ/X9TUKKu0SooSlbJJ
         a5AXqC7RLxmgJ2YH/NFT0QHp9n7dRsM5KP8sd+mLYerkUmEQLylhqj3/w1gankAZ4598
         ls+4TnMFnWJIl9PiPY+9GG0sZmmTQukg0jJoTKvfp43GSqxCgQJH5rt9v00o6mzmqJeE
         zjvabXdu8HpJEH/AgRagM+znKFYMcMSa8VlHK7TaknYJHpCJ/9AD4NwNHpn1OLsL2RHW
         PabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJSkxahiKZ1UBArFIAVh8oQXcW2VhByouzTjlDN7+KA=;
        b=BvKc92Rv49cd6yR5hVUG7o+ZUOle+9uT8q7ryYcDzf9BvPLyTfa6ptsw1igDydjooq
         P8V8Pjt0iLeNbRbFlE5C0X9N0LW6gubEMhFzUu5j3jaIMTPPo45NQh65NaItfAr/R4js
         /ee7teK0LRisLa6nS+TV7wzffdtiMNw5GbS5/WzeSKl+p2uQVWllCoxIyVtJH5f57XwB
         vWJ4IOiLaFt3stSwUIEdWXiNXYhp14fy8JYTahC3BycjGf+NB3kaxOUrivq0I+FhMTIK
         0dezM1jyfmnwqFtB68PpPykYhRgM3WghRxzsB4Jmv31B0V6kqvUR11uWTDqDXAJvXyqp
         zoDg==
X-Gm-Message-State: APt69E05gFTwcKbg7infCMlPWe82TP8hMOmpOHXWpGDWlohNF+xPgDF6
        /CxS+CK4Al/LPDe/40Upot84WgQE
X-Google-Smtp-Source: ADUXVKK/22BTS5JZrs2Xg4aNd5mkEwUUakIUHzdx5lqzLf9YoWasS0BobW//CssjtrQVnx0IQoKhxw==
X-Received: by 2002:adf:9844:: with SMTP id v62-v6mr10575808wrb.100.1529327959335;
        Mon, 18 Jun 2018 06:19:19 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id c10-v6sm14230575wrs.6.2018.06.18.06.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 06:19:18 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 3/3] rebase -i: rewrite checkout_onto() in C
Date:   Mon, 18 Jun 2018 15:18:44 +0200
Message-Id: <20180618131844.13408-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180618131844.13408-1-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
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
index d677fb663..f9fffba96 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -17,7 +17,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, SETUP_REFLOG
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, SETUP_REFLOG,
+		CHECKOUT_ONTO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -53,6 +54,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "setup-reflog", &command,
 			    N_("setup the reflog action"), SETUP_REFLOG),
+		OPT_CMDMODE(0, "checkout-onto", &command,
+			    N_("checkout a commit"), CHECKOUT_ONTO),
 		OPT_END()
 	};
 
@@ -98,5 +101,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == SETUP_REFLOG && argc == 2)
 		return !!setup_reflog_action(&opts, argv[1], verbose);
+	if (command == CHECKOUT_ONTO && argc == 4)
+		return !!checkout_onto(&opts, argv[1], argv[2], argv[3], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 048bbf041..0ae053291 100644
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
index 4bfe29c7b..d149cbf92 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3162,6 +3162,25 @@ int setup_reflog_action(struct replay_opts *opts, const char *commit,
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
+		die(_("%s: not a valid OID"), orig_head);
+
+	if (checkout_base_commit(opts, onto, verbose, action)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		die(_("could not detach HEAD"));
+	}
+
+	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 55e4057d8..9899d90fc 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -102,6 +102,9 @@ void commit_post_rewrite(const struct commit *current_head,
 
 int setup_reflog_action(struct replay_opts *opts, const char *commit,
 			int verbose);
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head, unsigned verbose);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.16.4

