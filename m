Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2EB1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbdC0VDw (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 17:03:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56840 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751739AbdC0VDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 17:03:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FD06830A9;
        Mon, 27 Mar 2017 17:03:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cpqls9ebRtlKtyf+Hy4mAZrzCOE=; b=aj9WUz
        lMwbsqY+XAPoW8H4eL1ss6NDWyhuR10mjFeNNdT8eN0HRTk2I+sR8lLklpgHsqtv
        KL07idp9nmWlLGTosJqaDFKflNGfADbpx/Gz46UDJBjedifjN5M79lOCr0r5YRaW
        YlNM5f2tmpvtYG0AwkuLRb+ZwwU8axGzPvQJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpnGBPhNQy+HN37UBSt1etrA2I3UbLMs
        IjIN6HyHXPyDZnjTJNerZhljqF0XOy6hyDzOJa9YRItIdQlIMz+UcWeEwgBqex2j
        Irkuj5gAq5L1UV3VqQYHbosuPIh9LN/lv4KcpZ3RJIlJLbtqHHGWEiY4M3t1pxdl
        QCw02YdH6UY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C7F2830A7;
        Mon, 27 Mar 2017 17:03:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA844830A6;
        Mon, 27 Mar 2017 17:03:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: make commit options more extensible
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <cover.1490285210.git.johannes.schindelin@gmx.de>
        <75e2c4fe839602af19811ed3e251eb583ff6c8ad.1490285210.git.johannes.schindelin@gmx.de>
        <xmqq7f3fa3oz.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703250100340.3767@virtualbox>
        <xmqqwpbb35e3.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 27 Mar 2017 14:03:27 -0700
In-Reply-To: <xmqqwpbb35e3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 26 Mar 2017 17:55:16 -0700")
Message-ID: <xmqqwpbazb34.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D39D7240-1330-11E7-BC4A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As this thing is about fixing a regression visible to end users, I
> may get around to fixing things up myself, but I have other topics
> to attend to, so...

So I ended up with this version before merging it to 'next'.  

I moved 'allow' back on the line it is declared, but left it
uninitialized because it is unconditionally assigned to before its
value is looked at.

Also the updated log message stresses more about the reason why
piling new parameters on top is a bad practice, and it is a good
idea to do this clean-up now.  Compared to that, the reason why this
clean-up was not done before and left as maintenance burden is much
less important to the readers of the log.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 23 Mar 2017 17:07:11 +0100
Subject: [PATCH] sequencer: make commit options more extensible

So far every time we need to tweak the behaviour of run_git_commit()
we have been adding a "int" parameter to it.  As the function gains
parameters and different callsites having different needs, this is
becoming a maintenance burden.  When a new knob needs to be added to
address a specific need for a single callsite, all the other callsites
need to add a "no, I do not want anything special with respect to the
new knob" argument.

Consolidate the existing four parameters into a flag word to make it
more maintainable, as we will be adding a new one to the mix soon.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8183a83c1f..677e6ef764 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -602,6 +602,11 @@ N_("you have staged changes in your working tree\n"
 "\n"
 "  git rebase --continue\n");
 
+#define ALLOW_EMPTY (1<<0)
+#define EDIT_MSG    (1<<1)
+#define AMEND_MSG   (1<<2)
+#define CLEANUP_MSG (1<<3)
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -615,8 +620,7 @@ N_("you have staged changes in your working tree\n"
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend,
-			  int cleanup_commit_message)
+			  unsigned int flags)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	const char *value;
@@ -624,7 +628,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts)) {
-		if (!edit) {
+		if (!(flags & EDIT_MSG)) {
 			cmd.stdout_to_stderr = 1;
 			cmd.err = -1;
 		}
@@ -640,7 +644,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_push(&cmd.args, "commit");
 	argv_array_push(&cmd.args, "-n");
 
-	if (amend)
+	if ((flags & AMEND_MSG))
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
@@ -648,16 +652,16 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&cmd.args, "-s");
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
-	if (cleanup_commit_message)
+	if ((flags & CLEANUP_MSG))
 		argv_array_push(&cmd.args, "--cleanup=strip");
-	if (edit)
+	if ((flags & EDIT_MSG))
 		argv_array_push(&cmd.args, "-e");
-	else if (!cleanup_commit_message &&
+	else if (!(flags & CLEANUP_MSG) &&
 		 !opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
 		argv_array_push(&cmd.args, "--cleanup=verbatim");
 
-	if (allow_empty)
+	if ((flags & ALLOW_EMPTY))
 		argv_array_push(&cmd.args, "--allow-empty");
 
 	if (opts->allow_empty_message)
@@ -926,14 +930,14 @@ static void record_in_rewritten(struct object_id *oid,
 static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts, int final_fixup)
 {
-	int edit = opts->edit, cleanup_commit_message = 0;
-	const char *msg_file = edit ? NULL : git_path_merge_msg();
+	unsigned int flags = opts->edit ? EDIT_MSG : 0;
+	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, amend = 0, allow = 0;
+	int res, unborn = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -991,7 +995,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			opts);
 		if (res || command != TODO_REWORD)
 			goto leave;
-		edit = amend = 1;
+		flags |= EDIT_MSG | AMEND_MSG;
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
@@ -1046,15 +1050,15 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 
 	if (command == TODO_REWORD)
-		edit = 1;
+		flags |= EDIT_MSG;
 	else if (is_fixup(command)) {
 		if (update_squash_messages(command, commit, opts))
 			return -1;
-		amend = 1;
+		flags |= AMEND_MSG;
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
 		else if (file_exists(rebase_path_fixup_msg())) {
-			cleanup_commit_message = 1;
+			flags |= CLEANUP_MSG;
 			msg_file = rebase_path_fixup_msg();
 		} else {
 			const char *dest = git_path("SQUASH_MSG");
@@ -1064,7 +1068,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 					     rebase_path_squash_msg(), dest);
 			unlink(git_path("MERGE_MSG"));
 			msg_file = dest;
-			edit = 1;
+			flags |= EDIT_MSG;
 		}
 	}
 
@@ -1123,11 +1127,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	if (allow < 0) {
 		res = allow;
 		goto leave;
-	}
+	} else if (allow)
+		flags |= ALLOW_EMPTY;
 	if (!opts->no_commit)
 fast_forward_edit:
-		res = run_git_commit(msg_file, opts, allow, edit, amend,
-				     cleanup_commit_message);
+		res = run_git_commit(msg_file, opts, flags);
 
 	if (!res && final_fixup) {
 		unlink(rebase_path_fixup_msg());
@@ -2154,7 +2158,7 @@ static int continue_single_pick(void)
 
 static int commit_staged_changes(struct replay_opts *opts)
 {
-	int amend = 0;
+	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
@@ -2184,10 +2188,10 @@ static int commit_staged_changes(struct replay_opts *opts)
 				       "--continue' again."));
 
 		strbuf_release(&rev);
-		amend = 1;
+		flags |= AMEND_MSG;
 	}
 
-	if (run_git_commit(rebase_path_message(), opts, 1, 1, amend, 0))
+	if (run_git_commit(rebase_path_message(), opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
 	return 0;
-- 
2.12.2-430-ge0ef7fe78c

