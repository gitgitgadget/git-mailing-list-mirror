Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081BCC4320A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57A9610FF
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhHTPlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhHTPlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:41:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB10C061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n5so2525524wro.12
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EQ8ors4lvko58L9IGsI1EHrAFj18KXtkvxdcPJfgL74=;
        b=GymtVixmxibMv7kyIb0uFhz8ajtXRiKV1BhtE3xHmgM2ZHQGf43yHGwNwQMEOwDerL
         tiIhSHJCkVa9LAQxjyUVrZXcrfuGvnDxSiX3npP1PL732zK+3SMOnnhfPHU3J+8WgO2C
         A02XqCDDfBCGl3bwNd4vYqA1m1HL3eQw1ar6EHoANrOjARj61i14JJQeMnQ/qZPzWsQ0
         iS5dM2aKypQMIKw8r3Oas6Tl3wl81cMtU14F79/480MJbvpiTstwGl9g4gNltyzVgGpq
         VuOwFxNUoG1IyWmVzxxdCVaWnzDQkubrnWT0Hr6IVl47xu+b+c7lMAigy28aP8tKWWTd
         JweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EQ8ors4lvko58L9IGsI1EHrAFj18KXtkvxdcPJfgL74=;
        b=sf1yWCtKJlf+1ZZHWAha2m1tpPh3UxacsIiXS1SFizvkxNG3rKFx96sNTBLBvk7Psp
         HTBBQIKD1zCQiJGScNGCnmIGyLf26D5fN2l87KTmJfHuINdanpPc+9V6Lgutmqod1fvL
         N5tBa2MVO1xWWNNJ/vkLJhLeua66VCeTUKJTOySkJiQz2f9xF/PPeIuHcfNz0wmxsrRi
         S1EE7eL4w3pDeyD7rnTdP4ALJ7pP5c1b/dbEJrAJPy9zj0INacOym39SV0wozWb1IITL
         O/4/bH0oT8k6eJ1hrlDmu8z1rdK7REO3L2XTl7yZmntU8mLnDaHzRMcQEvcppxy69i8m
         aQCA==
X-Gm-Message-State: AOAM530DVt+KfYEXShI8uBozLVxYIB5UTYpeeWREKpZsPSr9QKRPhKu2
        RP38XvXYWTQQiSYHRG0I9l9BHBWCE3c=
X-Google-Smtp-Source: ABdhPJzYdgYQcpdGbBYb2hpPNGqPzBRk9sHA4vcFJ0/KFka6kw8V3/hrRie91j/V+LmOXjeGjF4Y3w==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr11200507wrw.41.1629474040634;
        Fri, 20 Aug 2021 08:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm6183159wrr.94.2021.08.20.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:40:40 -0700 (PDT)
Message-Id: <b514dbdf9287128b8e0fab1d1d5b5107de15764e.1629474038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
        <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Aug 2021 15:40:35 +0000
Subject: [PATCH v2 1/4] rebase -r: make 'merge -c' behave like reword
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user runs git log while rewording a commit it is confusing if
sometimes we're amending the commit that's being reworded and at other
times we're creating a new commit depending on whether we could
fast-forward or not[1]. For this reason the reword command ensures
that there are no uncommitted changes when rewording. The reword
command also allows the user to edit the todo list while the rebase is
paused. As 'merge -c' also rewords commits make it behave like reword
and add a test.

[1] https://lore.kernel.org/git/xmqqlfvu4be3.fsf@gitster-ct.c.googlers.com/T/#m133009cb91cf0917bcf667300f061178be56680a

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c              | 24 +++++++++++--------
 t/lib-rebase.sh          | 50 ++++++++++++++++++++++++++++++++++++++++
 t/t3430-rebase-merges.sh | 20 ++++++++--------
 3 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..cc8a361cceb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3739,10 +3739,9 @@ static struct commit *lookup_label(const char *label, int len,
 static int do_merge(struct repository *r,
 		    struct commit *commit,
 		    const char *arg, int arg_len,
-		    int flags, struct replay_opts *opts)
+		    int flags, int *check_todo, struct replay_opts *opts)
 {
-	int run_commit_flags = (flags & TODO_EDIT_MERGE_MSG) ?
-		EDIT_MSG | VERIFY_MSG : 0;
+	int run_commit_flags = 0;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j, *reversed = NULL;
@@ -3898,10 +3897,9 @@ static int do_merge(struct repository *r,
 		rollback_lock_file(&lock);
 		ret = fast_forward_to(r, &commit->object.oid,
 				      &head_commit->object.oid, 0, opts);
-		if (flags & TODO_EDIT_MERGE_MSG) {
-			run_commit_flags |= AMEND_MSG;
+		if (flags & TODO_EDIT_MERGE_MSG)
 			goto fast_forward_edit;
-		}
+
 		goto leave_merge;
 	}
 
@@ -4035,10 +4033,17 @@ static int do_merge(struct repository *r,
 		 * value (a negative one would indicate that the `merge`
 		 * command needs to be rescheduled).
 		 */
-	fast_forward_edit:
 		ret = !!run_git_commit(git_path_merge_msg(r), opts,
 				       run_commit_flags);
 
+	if (!ret && flags & TODO_EDIT_MERGE_MSG) {
+	fast_forward_edit:
+		*check_todo = 1;
+		run_commit_flags |= AMEND_MSG | EDIT_MSG | VERIFY_MSG;
+		ret = !!run_git_commit(NULL, opts, run_commit_flags);
+	}
+
+
 leave_merge:
 	strbuf_release(&ref_name);
 	rollback_lock_file(&lock);
@@ -4405,9 +4410,8 @@ static int pick_commits(struct repository *r,
 			if ((res = do_reset(r, arg, item->arg_len, opts)))
 				reschedule = 1;
 		} else if (item->command == TODO_MERGE) {
-			if ((res = do_merge(r, item->commit,
-					    arg, item->arg_len,
-					    item->flags, opts)) < 0)
+			if ((res = do_merge(r, item->commit, arg, item->arg_len,
+					    item->flags, &check_todo, opts)) < 0)
 				reschedule = 1;
 			else if (item->commit)
 				record_in_rewritten(&item->commit->object.oid,
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index dc75b834518..99d9e7efd2d 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -151,3 +151,53 @@ test_editor_unchanged () {
 	EOF
 	test_cmp expect actual
 }
+
+# Set up an editor for testing reword commands
+# Checks that there are no uncommitted changes when rewording and that the
+# todo-list is reread after each
+set_reword_editor () {
+	>reword-actual &&
+	>reword-oid &&
+
+	# Check rewording keeps the original authorship
+	GIT_AUTHOR_NAME="Reword Author"
+	GIT_AUTHOR_EMAIL="reword.author@example.com"
+	GIT_AUTHOR_DATE=@123456
+
+	write_script reword-sequence-editor.sh <<-\EOF &&
+	todo="$(cat "$1")" &&
+	echo "exec git log -1 --pretty=format:'%an <%ae> %at%n%B%n' \
+		>>reword-actual" >"$1" &&
+	printf "%s\n" "$todo" >>"$1"
+	EOF
+
+	write_script reword-editor.sh <<-EOF &&
+	# Save the oid of the first reworded commit so we can check rebase
+	# fast-forwards to it
+	if ! test -s reword-oid
+	then
+		git rev-parse HEAD >reword-oid
+	fi &&
+	# There should be no uncommited changes
+	git diff --exit-code HEAD &&
+	# The todo-list should be re-read after a reword
+	GIT_SEQUENCE_EDITOR="\"$PWD/reword-sequence-editor.sh\"" \
+		git rebase --edit-todo &&
+	echo edited >>"\$1"
+	EOF
+
+	test_set_editor "$PWD/reword-editor.sh"
+}
+
+# Check the results of a rebase after calling set_reword_editor
+# Pass the commits that were reworded in the order that they were picked
+# Expects the first pick to be a fast-forward
+check_reworded_commits () {
+	test_cmp_rev "$(cat reword-oid)" "$1^{commit}" &&
+	git log --format="%an <%ae> %at%n%B%nedited%n" --no-walk=unsorted "$@" \
+		>reword-expected &&
+	test_cmp reword-expected reword-actual &&
+	git log --format="%an <%ae> %at%n%B" -n $# --first-parent --reverse \
+		>reword-log &&
+	test_cmp reword-expected reword-log
+}
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 6748070df52..183c3a23838 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -172,17 +172,19 @@ test_expect_success 'failed `merge <branch>` does not crash' '
 	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
 '
 
-test_expect_success 'fast-forward merge -c still rewords' '
-	git checkout -b fast-forward-merge-c H &&
+test_expect_success 'merge -c commits before rewording and reloads todo-list' '
+	cat >script-from-scratch <<-\EOF &&
+	merge -c E B
+	merge -c H G
+	EOF
+
+	git checkout -b merge-c H &&
 	(
-		set_fake_editor &&
-		FAKE_COMMIT_MESSAGE=edited \
-			GIT_SEQUENCE_EDITOR="echo merge -c H G >" \
-			git rebase -ir @^
+		set_reword_editor &&
+		GIT_SEQUENCE_EDITOR="\"$PWD/replace-editor.sh\"" \
+			git rebase -i -r D
 	) &&
-	echo edited >expected &&
-	git log --pretty=format:%B -1 >actual &&
-	test_cmp expected actual
+	check_reworded_commits E H
 '
 
 test_expect_success 'with a branch tip that was cherry-picked already' '
-- 
gitgitgadget

